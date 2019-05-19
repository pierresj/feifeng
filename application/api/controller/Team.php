<?php

namespace app\api\controller;

use addons\alisms\library\Alisms;
use app\common\controller\Api;
use app\common\library\Sms as Smslib;
use app\common\model\Config;

class Team extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    public function index()
    {
    	$where = [
    	    'status' => 1
        ];
    	if(request()->has('experience_id') && request()->param('experience_id')){
            $where['experience_id'] = ['like', "%" . request()->param('experience_id') . "%"];
	    }
	    if(request()->has('province') && request()->param('province')){
		    $where['province'] = request()->param('province');
	    }
	    if(request()->has('city') && request()->param('city')){
		    $where['city'] = request()->param('city');
	    }
	    
//	    $list = \app\admin\model\Team::with('experience')->where($where)->paginate(10);
	    $list = \app\admin\model\Team::where($where)->paginate(10);
        foreach ($list as &$l) {
            $l['experience'] = \app\admin\model\Experience::where('id', 'in', $l['experience_id'])->select();
        }
    	return $this->success('ok', $list);
    }
	
	public function create()
	{
		$data = request()->param();
        $result = $this->validate($data,'Team.create');
        if(true !== $result){
            // 验证失败 输出错误信息
            return $this->error($result);
        }
		$model = new \app\admin\model\Team();
		if($model->allowField(true)->create($data)){
			$phone = Config::where('group','weapp')->where('name', 'contact_phone')->value('value');
			$alisms = Alisms::instance();
			$res = $alisms->mobile($phone)
				->template('SMS_146610419')
				->param(['phone' => $data['phone'], 'name' => $data['leader_name']])
				->send();
//			halt($res);
			$this->success('提交成功');
		}else{
			$this->error('提交失败');
		}
    }
	
	public function show($id, $user_id=null)
	{
	    $info = \app\admin\model\Team::where('status', 1)->find($id);
	    $info['experience'] = \app\admin\model\Experience::where('id', 'in', $info['experience_id'])->select();
        if($info['see_pay'] == 1) {
            if(empty($user_id)) {
                $info['phone'] = 0;
            } elseif ($user_id) {
                $exist = model('UserEcharge')->exist('team', $id, $user_id);
                if(empty($exist)) {
                    $info['phone'] = 0;
                }
            }
        }
        //查看电话费用
        $money = Config::where('group','basic')->where('name', 'see_pay')->value('value');
        $money = json_decode($money, true);
        $info['money'] = $money['劳务队'];

        $this->success('ok',$info);
    }
}
