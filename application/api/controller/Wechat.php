<?php 
namespace app\api\controller;
use app\common\controller\Api;
class Wechat extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];
    //微信浏览器，用户自动登录,并重新定向 附带code参数
    // back_url 经过urlencode的回跳地址
    public function get_user_code(){
        $back_url = input("redirect_uri","","urldecode");
        $password = input("password","","trim");

        $WxUsersModel = model('Wechat');
        $result = $WxUsersModel->getUserInfo($back_url,$password);
        if(isset($result['code']) && isset($result['lexer'])){
            $url = $result['lexer'];
            $url_replace=preg_replace('/(.*)(?|&)code=[^&]+?(&)(.*)/i','$1$2$4',$url.'&');
            $url_substr=substr($url_replace,0,-1);
            if(strpos($url_substr,'?') === false){
                $redirect_url = $url_substr.'?code='.$result['code'];
            } else {
                $redirect_url = $url_substr.'&code='.$result['code'];
            }

            return redirect($redirect_url);
        }
    }
    //使用code 查询用户信息
    public function get_user_info(){
        $code = input("code","","trim");
        $info = model('Wechat')->getUserInfoByCode($code);
        if($info) {
            $this->success('ok', $info);
            exit;
        }
        $this->error('fail', '无效code');
        exit;
    }
    public function get_wx_config(){
        $url = input("url","","trim");
        $wechatModel = model("LittleProgram");
        $config = $wechatModel->getJsSignature($url);
        $this->success('ok', $config);
    }
    /**小程序获取微信信息*/
    public function get_little_program_wxinfo(){
//        $appId = config('appId');
//        $secret = config('appSecret');
//        $code = $this->request->param('code');
//        $url = "https://api.weixin.qq.com/sns/jscode2session?appid=" . $appId . "&secret=" . $secret . "&js_code=" . $code . "&grant_type=authorization_code";
//        $re = https_request($url);
//        $re = json_decode($re, true);
        $encryptedData = input('encryptedData', '');
        $iv = input('iv', '');
        $code = input('code', '');
//        custom_log('wx',var_export(['code'=>$code,'iv'=>$iv,'encryptedData'=>$encryptedData], true));

//        $this->sessionKey = "tiihtNczf5v6AKRyjwEUhQ==";
//        $encryptedData = "CiyLU1Aw2KjvrjMdj8YKliAjtP4gsMZMQmRzooG2xrDcvSnxIMXFufNstNGTyaGS9uT5geRa0W4oTOb1WT7fJlAC+oNPdbB+3hVbJSRgv+4lGOETKUQz6OYStslQ142dNCuabNPGBzlooOmB231qMM85d2/fV6ChevvXvQP8Hkue1poOFtnEtpyxVLW1zAo6/1Xx1COxFvrc2d7UL/lmHInNlxuacJXwu0fjpXfz/YqYzBIBzD6WUfTIF9GRHpOn/Hz7saL8xz+W//FRAUid1OksQaQx4CMs8LOddcQhULW4ucetDf96JcR3g0gfRK4PC7E/r7Z6xNrXd2UIeorGj5Ef7b1pJAYB6Y5anaHqZ9J6nKEBvB4DnNLIVWSgARns/8wR2SiRS7MNACwTyrGvt9ts8p12PKFdlqYTopNHR1Vf7XjfhQlVsAJdNiKdYmYVoKlaRv85IfVunYzO0IKXsyl7JCUjCpoG20f0a04COwfneQAGGwd5oa+T8yO5hzuyDb/XcxxmK01EpqOyuxINew==";
//        $iv = 'r7BXXKkLb8qrSNn05n0qiA==';

        if(empty($encryptedData) || empty($iv) || empty($code)) {
            return $this->error('缺少参数');
        }
        $wx = model('LittleProgram')->getWxUserInfo($encryptedData, $iv, $code);
//        print_r($wx);
        if($wx['code'] != 0) {
            return $this->error('微信授权失败');
        }
        $exist = model('User')->where('openid', $wx['openId'])->find();

        if(empty($exist)) {
            $input = [
                'openid' => $wx['openId'],
                'nickname' => removeEmoji($wx['nickName']),
                'head_img' => $wx['avatarUrl']
            ];
            $re = model('User')->insert($input);
            if(!$re) {
                return $this->error('用户注册失败');
            }
        } else {
            $input = [
                'nickname' => removeEmoji($wx['nickName']),
                'head_img' => $wx['avatarUrl']
            ];
            $re = model('User')->where('openid', $wx['openId'])->update($input);
            if($re === false) {
                return $this->error('更新用户信息失败');
            }
        }

        $user_info = model('User')->where('openid', $wx['openId'])->find();
//        echo model('User')->getLastSql();
        return $this->success('ok', $user_info);
    }

}


 ?>