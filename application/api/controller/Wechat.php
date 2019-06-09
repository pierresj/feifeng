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
        $appId = config('appId');
        $secret = config('appSecret');
        $code = $this->request->param('code');
        $url = "https://api.weixin.qq.com/sns/jscode2session?appid=" . $appId . "&secret=" . $secret . "&js_code=" . $code . "&grant_type=authorization_code";
        $re = https_request($url);
        $re = json_decode($re, true);

        $this->success('ok', $re);
    }

}


 ?>