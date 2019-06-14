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
    public $sessionKey;

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

    public function getWxUserInfo($encryptedData=null, $iv=null, $code=null){
        $url = "https://api.weixin.qq.com/sns/jscode2session?appid=" . $this->appid . "&secret=" . $this->appsecret . "&js_code=" . $code . "&grant_type=authorization_code";
        $wx_info = https_request($url);
        $wx_info = json_decode($wx_info, true);
//        custom_log('wx','info:'.var_export($wx_info, true));
//        $this->sessionKey = $wx_info['session_key'];
        $sessionKey = $wx_info['session_key'];

//        $this->appid = "wx4f4bc4dec97d474b";
//        $this->sessionKey = "tiihtNczf5v6AKRyjwEUhQ==";
//        $encryptedData = "CiyLU1Aw2KjvrjMdj8YKliAjtP4gsMZM
//                QmRzooG2xrDcvSnxIMXFufNstNGTyaGS
//                9uT5geRa0W4oTOb1WT7fJlAC+oNPdbB+
//                3hVbJSRgv+4lGOETKUQz6OYStslQ142d
//                NCuabNPGBzlooOmB231qMM85d2/fV6Ch
//                evvXvQP8Hkue1poOFtnEtpyxVLW1zAo6
//                /1Xx1COxFvrc2d7UL/lmHInNlxuacJXw
//                u0fjpXfz/YqYzBIBzD6WUfTIF9GRHpOn
//                /Hz7saL8xz+W//FRAUid1OksQaQx4CMs
//                8LOddcQhULW4ucetDf96JcR3g0gfRK4P
//                C7E/r7Z6xNrXd2UIeorGj5Ef7b1pJAYB
//                6Y5anaHqZ9J6nKEBvB4DnNLIVWSgARns
//                /8wR2SiRS7MNACwTyrGvt9ts8p12PKFd
//                lqYTopNHR1Vf7XjfhQlVsAJdNiKdYmYV
//                oKlaRv85IfVunYzO0IKXsyl7JCUjCpoG
//                20f0a04COwfneQAGGwd5oa+T8yO5hzuy
//                Db/XcxxmK01EpqOyuxINew==";
//        $iv = 'r7BXXKkLb8qrSNn05n0qiA==';
        $errCode = $this->decryptData($encryptedData, $iv, $sessionKey, $data);

        if ($errCode == 0) {
            $data = json_decode($data, true);
            $data['code'] = 0;
//            custom_log('wx', 'user:'.var_export($data, true));
            return $data;
        } else {
            custom_log('wx', 'error:'.$errCode);
//            custom_log('wx', 'error:'.$errCode);
            return ['code' => $errCode];
        }
    }
    /**
     * 检验数据的真实性，并且获取解密后的明文.
     * @param $encryptedData string 加密的用户数据
     * @param $iv string 与用户数据一同返回的初始向量
     * @param $sessionKey string 与用户数据一同返回的初始向量
     * @param $data string 解密后的原文
     *
     * @return int 成功0，失败返回对应的错误码
     */
    public function decryptData($encryptedData, $iv, $sessionKey, &$data ){
//        if (strlen($this->sessionKey) != 24) {
//            return "-41001";
//        }
        if (strlen($sessionKey) != 24) {
            return "-41001";
        }
//        $aesKey=base64_decode($this->sessionKey);
        $aesKey=base64_decode($sessionKey);

        if (strlen($iv) != 24) {
            return "-41002";
        }
        $aesIV=base64_decode($iv);

        $aesCipher=base64_decode($encryptedData);
        $result=openssl_decrypt( $aesCipher, "AES-128-CBC", $aesKey, 1, $aesIV);

        $dataObj=json_decode( $result );

        if( $dataObj  == NULL ) {
            custom_log('wx',var_export(['encryptedData'=>$encryptedData,'iv'=>$iv,'sessionKey'=>$sessionKey],true));
            return "-41003";
        }
        if( $dataObj->watermark->appid != $this->appid ) {
            return "-41003";
        }
        $data = $result;
        return "0";
    }

    //以下是旧的
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
            print_r($user_access_token);
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
//            header("Location: https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$this->appid."&redirect_uri="
//                . urlencode($back_url)."&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect" );
            exit;
        }
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
