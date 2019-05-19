<?php

namespace app\api\controller;

use addons\alisms\library\Alisms;
use app\common\controller\Api;
use app\common\library\Sms as Smslib;
use app\common\model\Config;

class Bid extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    public function index()
    {
    	$where = [
    	    'is_delete' => 0,
            'status' => 1
        ];

	    if(request()->has('province') && request()->param('province')) {
		    $where['province'] = request()->param('province');
	    }
	    if(request()->has('city') && request()->param('city')) {
		    $where['city'] = request()->param('city');
	    }
	    if(request()->has('type') && request()->param('type')) {
	        $where['type'] = request()->param('type');
        }
	    
	    $list = \app\admin\model\Bid::where($where)->order('id DESC')->paginate(10);
    	return $this->success('ok', $list);
    }
	
	public function create()
	{
		$data = request()->param();
        $result = $this->validate($data,'Bid.create');
        if(true !== $result){
            // 验证失败 输出错误信息
            return $this->error($result);
        }
		$model = new \app\admin\model\Bid();
		if($model->allowField(true)->create($data)){
			$phone = Config::where('group','weapp')->where('name', 'contact_phone')->value('value');
			$alisms = Alisms::instance();
			$res = $alisms->mobile($phone)
				->template('SMS_165418975')
				->param(['phone' => $data['phone'], 'name' => $data['name']])
				->send();
//			halt($res);
			$this->success('提交成功');
		}else{
			$this->error('提交失败');
		}
    }
	
	public function show($id, $user_id=null)
	{
		$info = \app\admin\model\Bid::where('is_delete', 0)->find($id);
        if($info['see_pay']*100) {
            if(empty($user_id)) {
                $info['phone'] = 0;
            } elseif ($user_id) {
                $exist = model('UserEcharge')->exist('bid', $id, $user_id);
                if(empty($exist)) {
                    $info['phone'] = 0;
                }
            }
        }
        $info['money'] = $info['see_pay'];
		$this->success('ok',$info);
    }
}
