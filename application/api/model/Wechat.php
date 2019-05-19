<?php

namespace app\api\model;
use think\Model;
use my\wxpay;
use think\Db;
/**
 * 分类模型
 */
class Wechat  Extends Model{
    public $appid;
    public $appsecret;
    public $mchid;
    public $key;
    public $access_token;
    public  $errCode;
    public  $errMsg;
    public  $password = '123698745';

    public function initialize(){
        //小程序相关信息
        $this->appid = config('appId');
        $this->appsecret = config('appSecret');
        $this->mchid = config('mchid');
        $this->key = config('key');
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
//        $data['spbill_create_ip'] = $_SERVER['HTTP_X_REAL_IP'];  //服务器的ip
        $data['spbill_create_ip'] = '123.57.174.28';  //服务器的ip
        $data['sign'] = $wxpay->getSign($data);
//        print_r($data);
        $cart_path = ROOT_PATH."file/wxpaycert/";

        $CART_SSLCERT['SSLCERT'] = $cart_path."apiclient_cert.pem";
        $CART_SSLCERT['SSLKEY'] = $cart_path."apiclient_key.pem";
//        $CART_SSLCERT['SSLCERT'] = "/cert/apiclient_cert.pem";
//        $CART_SSLCERT['SSLKEY'] = "/cert/apiclient_key.pem";
//        $CART_SSLCERT['CAINFO'] = $cart_path."rootca.pem";
//        $CART_SSLCERT['CAINFO'] = $cart_path."apiclient_cert.p12";
        $result_xml = $wxpay->postXmlCurl($wxpay->arrayToXml($data),$url,30,$CART_SSLCERT);
//        var_dump($result_xml);
        $result = $wxpay->xmlToArray($result_xml);
//        $result = https_request($url, $wxpay->arrayToXml($data), $CART_SSLCERT, $data['mchid']);
//        var_dump($result);
//        $result = $wxpay->xmlToArray($result);
//        var_dump($result);
        return $result;


    }
    public function getWxConfig(){
        $data['appid'] = $this->appid;
        return $data;
    }
    //获取ticket
    function getTicket(){
        $wx_ticket = cache('wx_ticket');
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
            cache('wx_ticket',$wx_ticket,$expires_in);
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
        $access_token = cache('cyq_wx_access_token');
//        $access_token = null;
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
            cache('cyq_wx_access_token',$this->access_token,$expire);
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

    public function getPayCode($openid,$echarge_id){
        $echarge_info = model('UserEcharge')->getInfo($echarge_id);
        $order['total_fee'] = $echarge_info['amount'];
        $order['out_trade_no'] = $echarge_id;
        $wxpay = new wxpay($this->appid,$this->appsecret,$this->mchid,$this->key); //请求的是太原淘鲜生的微信标记
        $wxpay->setNotifyUrl("http://api.moments.taoxiansheng.com/payment/notify_url"); //异步回调地址
        return $wxpay->getJsParameters($order,$openid);
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
    public function getUserInfoByCode($code){
        $info = cache($code);
        if(!$info) {
            $url = "https://api.weixin.qq.com/sns/jscode2session?appid={$this->appid}&secret={$this->appsecret}&js_code={$code}&grant_type=authorization_code";
            $re = https_request($url);
            cache($code,$re,300);
        }
        return $re;
    }

}
