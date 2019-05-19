<?php
// +----------------------------------------------------------------------
// |微信支付
// +----------------------------------------------------------------------
// | Author: 山歌好听 <39597536@qq.com>
// +----------------------------------------------------------------------
namespace my;
use think\Log;
class wxpay{
    private $pay_type = 'wx';    // wx 为微信官方，bank 为兴业银行
    private $appid;
    private $appsecret;
    private $mchid;
    private $key;
    private $notify_url; //支付成功回调地址
    public $result;
    private $param;
    private $url;
    public $data;
    public $parameters;

    function __construct($appid,$secret,$mchid,$key){
        $this->appid     = $appid;
        $this->appsecret = $secret;
        $this->mchid     = $mchid;
        $this->key       = $key;
        if($this->pay_type == 'wx'){
            $this->url = "https://api.mch.weixin.qq.com/pay/unifiedorder";
        }
        if($this->pay_type == 'bank'){
            $this->url = "https://pay.swiftpass.cn/pay/gateway";
        }

    }
    /*
     * 获取JS的支付参数
     * $order['order_sn'];
     * $order['order_amount']; 单位 ：元
     */
    function getJsParameters($order,$openid){
        $time = time();
        $time = $time + 100;
        $out_trade_no = $time .$order['out_trade_no'];
        $total_fee = intval(round($order['total_fee'] * 100,0));
        $this->param['openid']        = $openid;
        $this->param['body']          = trim($out_trade_no);
        $this->param['attach']        = $time;
        $this->param['out_trade_no']  = trim($out_trade_no);
        $this->param['total_fee']     = $total_fee;
        return $this->getParameters();

    }
    /**
     * 	作用：设置jsapi的参数
     */
    public function getParameters(){
        $this->integrationData();
        $jsApiObj["appId"] = $this->appid;
        $timeStamp = time();
        $jsApiObj["timeStamp"] = "$timeStamp";
        $jsApiObj["nonceStr"] = $this->createNoncestr();
        if($this->pay_type == 'wx' && isset($this->result['prepay_id'])){
            $prepay_id = $this->result['prepay_id'];
        }
        if($this->pay_type == 'bank' && isset($this->result['pay_info'])){
            $prepay_id = $this->result['pay_info'];
        }
        if(!isset($prepay_id)){
            $prepay_id = "";
        }
        $jsApiObj["package"] = "prepay_id=".$prepay_id;
        $jsApiObj["signType"] = "MD5";
        $jsApiObj["paySign"] = $this->getSign($jsApiObj);
        $this->parameters = $jsApiObj;
        return $this->parameters;
    }
    public function setNotifyUrl($notify_url){
        $this->notify_url= $notify_url;
    }
    //wx 为微信官方支付  bank 为兴业银行 威富通支付
    public function setPayType($type = 'wx'){
        $this->pay_type= $type;
    }

    private function integrationData(){
        $this->param['appid'] = $this->appid;
        $this->param['mch_id'] = $this->mchid;
        $this->param['nonce_str'] = $this->createNoncestr();
        $this->param["spbill_create_ip"] = $_SERVER['REMOTE_ADDR'];
        $this->param["notify_url"] = $this->notify_url;
        $this->param["trade_type"] = 'JSAPI';
        $this->param['sign'] = $this->getSign($this->param);
        $result = $this->requrstXml();

        Log::log('pay_result:'.date("YmdHis", time()) . var_export($result, true));
        Log::log('pay_result:'.date("YmdHis", time()) . var_export($this->param, true));
        return $this->result = $result;
    }
    private function requrstXml(){
        $xml = $this->arrayToXml($this->param);
        $url = $this->url;    //微信官方接口
        $result_xml = $this->postXmlCurl($xml,$url);
        return $this->xmlToArray($result_xml);
    }
    function checkSign()
    {
        $tmpData = $this->data;
        unset($tmpData['sign']);
        $sign = $this->getSign($tmpData);//本地签名
        if ($this->data['sign'] == $sign) {
            return TRUE;
        }
        return FALSE;
    }
    /**
     * 验证金额是否合法
     * $price 要验证的金额 单位：元
     */
    public function checkAmount($price){
        $price = $price * 100;
        $check_price = abs($price - $this->data['total_fee']);
        if($check_price > 0.1){
            return FALSE;
        }
        return TRUE;
    }
    /**
     * 将微信的请求xml转换成关联数组，以方便数据处理
     */
    function saveData($xml)
    {
        $this->data = $this->xmlToArray($xml);
    }
    public function arrayToXml($arr) {
        $xml = "<xml>";
        foreach ($arr as $key=>$val)
        {
            if (is_numeric($val))
            {
                $xml.="<".$key.">".$val."</".$key.">";

            }
            else
                $xml.="<".$key."><![CDATA[".$val."]]></".$key.">";
        }
        $xml.="</xml>";
        return $xml;
    }
    /**
     * 	作用：以post方式提交xml到对应的接口url
     */
    public function postXmlCurl($xml,$url,$second=30,$cert = array())
    {
        //初始化curl
        $ch = curl_init();
        //设置超时
        @curl_setopt($ch, CURLOP_TIMEOUT, $second);
        //这里设置代理，如果有的话
        //curl_setopt($ch,CURLOPT_PROXY, '8.8.8.8');
        //curl_setopt($ch,CURLOPT_PROXYPORT, 8080);
        curl_setopt($ch,CURLOPT_URL, $url);
        curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,FALSE);
        curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,FALSE);
        if (isset($cert['SSLCERT'])) {
            curl_setopt($ch, CURLOPT_SSLCERT, $cert['SSLCERT']);
        }
        if (isset($cert['SSLKEY'])) {
            curl_setopt($ch, CURLOPT_SSLKEY, $cert['SSLKEY']);
        }
        if (isset($cert['CAINFO'])) {
            curl_setopt($ch, CURLOPT_CAINFO, $cert['CAINFO']);
        }

        //设置header
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        //要求结果为字符串且输出到屏幕上
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        //post提交方式
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);
        //运行curl
        $data = curl_exec($ch);
        curl_close($ch);
        //返回结果
        if($data)
        {
            @curl_close($ch);
            return $data;
        }
        else
        {
            $error = curl_errno($ch);
            echo "curl出错，错误码:$error"."<br>";
            echo "<a href='http://curl.haxx.se/libcurl/c/libcurl-errors.html'>错误原因查询</a></br>";
            curl_close($ch);
            return false;
        }
    }
    /**
     * 	作用：产生随机字符串，不长于32位
     */
    public function createNoncestr( $length = 32 )
    {
        $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
        $str ="";
        for ( $i = 0; $i < $length; $i++ )  {
            $str.= substr($chars, mt_rand(0, strlen($chars)-1), 1);
        }
        return $str;
    }
    /**
     * 	作用：生成签名
     */
    public function getSign($Obj)
    {
        foreach ($Obj as $k => $v)
        {
            $Parameters[$k] = $v;
        }
        //签名步骤一：按字典序排序参数
        ksort($Parameters);
        $String = $this->formatBizQueryParaMap($Parameters, false);
        //echo '【string1】'.$String.'</br>';
        //签名步骤二：在string后加入KEY
        $String = $String."&key=".$this->key;
        //echo "【string2】".$String."</br>";
        //签名步骤三：MD5加密
        $String = md5($String);
        //echo "【string3】 ".$String."</br>";
        //签名步骤四：所有字符转为大写
        $result_ = strtoupper($String);
        //echo "【result】 ".$result_."</br>";
        return $result_;
    }
    /**
     * 	作用：格式化参数，签名过程需要使用
     */
    private function formatBizQueryParaMap($paraMap, $urlencode)
    {
        $buff = "";
        ksort($paraMap);
        foreach ($paraMap as $k => $v)
        {
            if($urlencode)
            {
                $v = urlencode($v);
            }
            $buff .= $k . "=" . $v . "&";
        }
        $reqPar = '';
        if (strlen($buff) > 0)
        {
            $reqPar = substr($buff, 0, strlen($buff)-1);
        }
        return $reqPar;
    }
    public function xmlToArray($xml)
    {
        //将XML转为array
        $array_data = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
        return $array_data;
    }
}
