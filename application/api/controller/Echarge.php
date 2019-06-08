<?php
/**
 * 充值提现
 */
namespace app\api\controller;

use think\Controller;
use my\wxpay;
use app\common\controller\Api;
use app\api\model\UserEcharge;
use think\Db;
use think\Cache;
class Echarge extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];
	/**小程序充值接口*/
    public function little_program_recharge(){
        $user_id = input('user_id');
        $prepay_id = input('prepay_id',0);
        $openid = input('openid', '', 'trim');
        $type = input('type', '', 'trim');
        $f_id = input('f_id', 0, 'int');
        if(empty($type) || empty($f_id)) {
            $this->error('缺少参数');
            exit;
        }

        $data=[
            'user_id'=>$user_id,
            'amount'=>$this->request->param('amount'),
            'process_type'=>0,
            'user_note'=>'充值',
            'prepay_id' => $prepay_id,
            'add_time' => time(),
            'type' => $type,
			'f_id' => $f_id
        ];
//        if($data['amount'] < 1){
//            return ['error'=>400,"message"=>"充值金额不能小于1元"];
//        }
//        $result = $this->validate($data,'UserEcharge');
//        if(true !== $result){
//            // 验证失败 输出错误信息
//            return ['code'=>400,'message'=>$result];
//        }
        $UserEchargeModel=model('UserEcharge');
        $id = $UserEchargeModel->insert_option($data);

        $code = model("LittleProgram")->getPayCode($openid,$id);

        $return['pay_code'] = $code;
        $return['openid'] = $openid;
        $this->success('ok',$return);
    }

    public function check_paid(){
        $type = input('type', '', 'trim');
        $f_id = input('f_id', 0, 'int');
        $user_id = input('user_id', 0, 'int');
        $exist = model('UserEcharge')
            ->where('type', $type)
            ->where('f_id', $f_id)
            ->where('user_id', $user_id)
            ->where('is_paid', 1)
            ->find();
        if($exist) {
            $this->success('ok', 'has_paid');
        } else {
            $this->error('fail', 'no_paid');
        }
    }


}
?>