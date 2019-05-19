<?php

namespace app\api\model;
use think\Model;
use my\wxpay;
/**
 * 分类模型
 */
class LittleProgram Extends Model{
    public $appid;
    public $appsecret;
    public $mchid;
    public $key;
    public $access_token;
    public $errCode;
    public $errMsg;
    public $password = '123698745';

    public function initialize(){
        //小程序相关信息
        $this->appid = config('appId');
        $this->appsecret = config('appSecret');
        $this->mchid = config('mchid');
        $this->key = config('key');
    }
    public function getPayCode($openid,$echarge_id){
        $echarge_info = model('UserEcharge')->getInfo($echarge_id);
        $order['total_fee'] = $echarge_info['amount'];
        $order['out_trade_no'] = $echarge_id;
        $wxpay = new wxpay($this->appid,$this->appsecret,$this->mchid,$this->key); //请求的是小程序的微信标记
        $wxpay->setNotifyUrl("http://bee.lezhier.com/public/api/payment/little_program_notify_url"); //异步回调地址
        return $wxpay->getJsParameters($order,$openid);
    }

    public function transfers($number,$openid,$amount,$desc){
        $wxpay = new wxpay($this->appid,$this->appsecret,$this->mchid,$this->key);
        $url = "https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";
        $data['mch_appid'] = $this->appid;
        $data['mchid'] = $this->mchid;
        $data['nonce_str'] = $wxpay->createNoncestr();
        $data['partner_trade_no'] = $number;
        $data['openid'] = $openid;
        $data['check_name'] = 'NO_CHECK';  // NO_CHECK：不校验真实姓名   FORCE_CHECK：强校验真实姓名
        $data['amount'] = intval($amount*100);
        $data['desc'] = $desc;  //付款说明
        $data['spbill_create_ip'] = '39.100.68.219';  //服务器的ip
        $data['sign'] = $wxpay->getSign($data);
        $cart_path = ROOT_PATH."file/wxpaycert/";

        $CART_SSLCERT['SSLCERT'] = $cart_path."apiclient_cert.pem";
        $CART_SSLCERT['SSLKEY'] = $cart_path."apiclient_key.pem";

        $result_xml = $wxpay->postXmlCurl($wxpay->arrayToXml($data),$url,30,$CART_SSLCERT);
        $result = $wxpay->xmlToArray($result_xml);

        return $result;
    }
    public function getWxConfig(){
        $data['appid'] = $this->appid;
        return $data;
    }
    //获取ticket
    function getTicket(){
        $wx_ticket = cache('little_wx_ticket');
        $time = time();
        if(strtotime( $wx_ticket['lasttime'] ) < $time - $wx_ticket['expires_in']){
            $break = false;
            $a = 0;
            do{
                $access_token = $this->getAccessToken($break);

                $url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=".$access_token."&type=jsapi";
                $result = https_request($url);
                $data = json_decode($result, true);

                if($data['errcode'] != 0 || $a > 10){
                    $break = true;
                }
                $a ++;
            }while(!$break);

            $ticket = $data['ticket'];
            $expires_in = $data['expires_in'];

            $wx_ticket['value'] = $access_token;
            $wx_ticket['lasttime'] = date('Y-m-d H:i:s');
            $wx_ticket['ticket'] = $ticket;
            $wx_ticket['expires_in'] = $expires_in;
            cache('little_wx_ticket',$wx_ticket,$expires_in);
        }

        return $wx_ticket;
    }
    //获取JS签名
    public function getJsSignature($url = ""){
        $ticket = $this->getTicket();
        $wxpay = new wxpay($this->appid,$this->appsecret,$this->mchid,$this->key);
        $noncestr = $wxpay->createNoncestr();
        $time = time();
        if(empty($url)){
            $url = get_url();
        }
        $data['signature'] = sha1("jsapi_ticket=".$ticket['ticket']."&noncestr=".$noncestr ."&timestamp=".$time."&url=".$url);
        $data['noncestr'] =  $noncestr;
        $data['time'] =  $time;
        $data['appid'] =  $this->appid;
        return $data;
    }
    //获取accesstoken
    public function getAccessToken($refresh = false){ //$status =1 为使用默认access_token   $status =其他为获取新的access_token
        $access_token = cache('little_wx_access_token');
        if ($access_token && $refresh == false)  {
            $this->access_token = $access_token;
            return $access_token;
        }
        $url = 'https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid='. $this->appid.'&secret='.$this->appsecret;
        $result = https_request($url);
        if ($result){
            $json = json_decode($result,true);

            if (!$json || isset($json['errcode'])) {
                $this->errCode = $json['errcode'];
                $this->errMsg = $json['errmsg'];
                return false;
            }
            $this->access_token = $json['access_token'];
            $expire = $json['expires_in'] ? intval($json['expires_in']) : 3600;
            cache('little_wx_access_token',$this->access_token,$expire);
            return $this->access_token;
        }
        return false;
    }
    //获取用户openid
    public function getOpenId() {
        if (isset($_REQUEST['code'])) {
            $code = $_REQUEST['code'];
            $user_access_token_json = https_request("https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$this->appid."&secret=".$this->appsecret."&code=".$code."&grant_type=authorization_code");
            $user_access_token = json_decode($user_access_token_json,true);
            return $user_access_token['openid'];
        } else {
            $back_url = get_url();
            header("Location: https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$this->appid."&redirect_uri="
                . urlencode($back_url)."&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect" );
            exit;
        }
    }
    //获取用户详细信息
    //$lexer 原样返回的数据
    public function getUserInfo($lexer = 'STATE',$password = "") {
        if (isset($_REQUEST['code'])) {
            $code = input('code','','trim');
            $state = input('state','','trim');
            $user_access_token_json = https_request("https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$this->appid."&secret=".$this->appsecret."&code=".$code."&grant_type=authorization_code");
            $user_access_token = json_decode($user_access_token_json,true);

            $user_info_json = https_request("https://api.weixin.qq.com/sns/userinfo?access_token=".$user_access_token['access_token']."&openid=".$user_access_token['openid']."&lang=zh_CN ");
            $resuult = json_decode($user_info_json,true);
            cache($code,$resuult,300);

            //更新user表的openid
            $wx_info = [
                'openid' => $resuult['openid'],
                'nickname' => $resuult['nickname'],
                'head_img' => $resuult['headimgurl'],
                'reg_step' => 2,
                'credit_line' => 5
            ];
//            model('Users')->save(['openid' => $resuult['openid']], ['unionid' => $resuult['unionid']]);
            model('Users')->where('unionid', $resuult['unionid'])->update($wx_info);

            $return['lexer'] = $state == 'STATE' ?  "" : base_decodes($state);
            $return['code'] = $code;

            return $return;
        } else {
            if($password != $this->password){
                exit("请求密码错误");
            }
            $back_url = get_url();

            header("Location: https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$this->appid."&redirect_uri="
                . urlencode($back_url)."&response_type=code&scope=snsapi_userinfo&state=".base_encodes($lexer)."#wechat_redirect" );
//            header("Location: https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$this->appid."&redirect_uri="
//                . urlencode($back_url)."&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect" );
            exit;
        }
    }
    //获取用户详细信息
    //$lexer 原样返回的数据
    public function testGetUserInfo($lexer = 'STATE',$password = "") {
        if (isset($_REQUEST['code'])) {
            $code = input('code','','trim');
            $state = input('state','','trim');
            $user_access_token_json = https_request("https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$this->appid."&secret=".$this->appsecret."&code=".$code."&grant_type=authorization_code");
            $user_access_token = json_decode($user_access_token_json,true);

            $user_info_json = https_request("https://api.weixin.qq.com/sns/userinfo?access_token=".$user_access_token['access_token']."&openid=".$user_access_token['openid']."&lang=zh_CN ");
            $resuult = json_decode($user_info_json,true);
            cache($code,$resuult,300);
            $return['lexer'] = $state == 'STATE' ?  "" : base_decodes($state);
            $return['code'] = $code;

            return $return;
        } else {
            if($password != $this->password){
                exit("请求密码错误");
            }
            $back_url = get_url();

            header("Location: https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$this->appid."&redirect_uri="
                . urlencode($back_url)."&response_type=code&scope=snsapi_userinfo&state=".base_encodes($lexer)."#wechat_redirect" );
            exit;
        }
    }
    //过滤昵称中的特殊字符
    private function nickname_filter($str) {
        if($str){
            $name = $str;
            $name = preg_replace('/\xEE[\x80-\xBF][\x80-\xBF]|\xEF[\x81-\x83][\x80-\xBF]/', '', $name);
            $name = preg_replace('/xE0[x80-x9F][x80-xBF]‘.‘|xED[xA0-xBF][x80-xBF]/S','?', $name);
            $return = json_decode(preg_replace("#(\\\ud[0-9a-f]{3})#ie","",json_encode($name)));
            if(!$return){
                return $str;
            }
        }else{
            $return = '';
        }
        return $return;
    }

    public function getPayCodeTest($id){
        $info = db('TestPay')->where('id',$id)->find();
        $order['total_fee'] = $info['amount'];
        $order['out_trade_no'] = $info['out_trade_no'];
        $wxpay = new wxpay($this->appid,$this->appsecret,$this->mchid,$this->key);
        $wxpay->setNotifyUrl("http://api.moments.taoxiansheng.com/payment/little_program_notify_text"); //异步回调地址
        return  $wxpay->getJsParameters($order,$info['openid']);
    }
    /**
     * 发送模板消息
     */
    public function send_notice($uel,$tenpalate_id){
        //获取access_token
        $access_token=$this->getAccessToken();

        $openid='o3J-Q0vPPWzJJf9v9vMuAIMoAaBo';//$this->getOpenId();

        //模板消息
        $json_template = $this->json_tempaltes($openid,$uel,$tenpalate_id);
        $url='https://api.weixin.qq.com/cgi-bin/message/template/send?access_token='.$access_token;
        $res=$this->request_post($url,urldecode($json_template));

        if ($res['errcode']==0){
            return '发送成功';
        }else{
            return '发送失败';
        }
    }
    /**
     * 将模板消息json格式化
     */
    public function json_tempalte($openid,$uel,$tenpalate_id,$money=1){
        //模板消息
        $template=array(
            'touser'=>$openid,  //用户openid
            'template_id'=>'i6fy33wgUcqURp9gaPkavmceKLGz2wmj-1LzBp-_Wds', //在公众号下配置的模板id
            'url'=>$uel, //点击模板消息会跳转的链接
            'topcolor'=>"#7B68EE",
            'data'=>array(
                'first'=>array('value'=>urlencode("恭喜您，余额已到帐"),'color'=>"#FF0000"),
                'keyword1'=>array('value'=>urlencode(date("Y-m-d H:i:s")),'color'=>'#FF0000'),
                'keyword2'=>array('value'=>urlencode($money.'元'),'color'=>'#FF0000'),
                'keyword3'=>array('value'=>urlencode('查看简历'),'color'=>'#FF0000'),  //keyword需要与配置的模板消息对应
                'remark' =>array('value'=>urlencode('备注：有人查看您的简历了，快去收钱吧'),'color'=>'#FF0000'), )
        );
        $json_template=json_encode($template);
        return $json_template;
    }
    /**
     * @param $url
     * @param array $data
     * @return mixed
     * curl请求
     */
    function request_post($url, $data)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        if (!empty($data)){
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        }
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($ch);
        curl_close($ch);
        return $output;
    }
    //查询是否关注
    public function getSubscribe($openid){
        $access_token = $this->getAccessToken(false);
        $url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=".$access_token."&openid=".$openid."&lang=zh_CN";
        $result = https_request($url);
        return $result;
    }
    //获取accesstoken
    public function getAccessTokens($refresh = false){ //$status =1 为使用默认access_token   $status =其他为获取新的access_token
        $access_token = cache('wx_access_tokens') ;
        if ($access_token && $refresh == false)  {
            $this->access_token = $access_token;
            return $access_token;
        }
        $url = 'https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid='. $this->appid.'&secret='.$this->appsecret;
        $result = https_request($url);
        if ($result){
            $json = json_decode($result,true);

            if (!$json || isset($json['errcode'])) {
                $this->errCode = $json['errcode'];
                $this->errMsg = $json['errmsg'];
                return false;
            }
            $this->access_token = $json['access_token'];
            $expire = $json['expires_in'] ? intval($json['expires_in']) : 3600;
            cache('wx_access_tokens',$this->access_token,$expire);
            return $this->access_token;
        }
        return false;
    }

}
