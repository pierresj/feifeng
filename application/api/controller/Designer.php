<?php

namespace app\api\controller;

use addons\alisms\library\Alisms;
use app\common\controller\Api;
use app\common\library\Sms as Smslib;
use app\common\model\Config;
use think\Db;

class Designer extends Api
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
	    
//	    $list = \app\admin\model\Designer::with('experience')->where($where)->paginate(10);
	    $list = \app\admin\model\Designer::where($where)->paginate(10);
	    foreach ($list as &$l) {
	        $l['experience'] = \app\admin\model\Experience::where('id', 'in', $l['experience_id'])->select();
	        $l['avatar'] = config('host_url') . $l['avatar'];
        }
    	return $this->success('ok', $list);
    }
	
	public function create()
	{
		$data = request()->param();
        $result = $this->validate($data,'Designer.create');
        if(true !== $result){
            // 验证失败 输出错误信息
            return $this->error($result);
        }
		$model = new \app\admin\model\Designer();
		if($model->allowField(true)->create($data)){
			$phone = Config::where('group','weapp')->where('name', 'contact_phone')->value('value');
			$alisms = Alisms::instance();
			$res = $alisms->mobile($phone)
				->template('SMS_164508758')
				->param(['phone' => $data['phone'], 'name' => $data['designer_name']])
				->send();
//			halt($res);
			$this->success('提交成功');
		}else{
			$this->error('提交失败');
		}
    }
	
	public function show($id, $user_id=null)
	{
		$info = \app\admin\model\Designer::with('experience')->where('status', 1)->find($id);
        $info['experience'] = \app\admin\model\Experience::where('id', 'in', $info['experience_id'])->select();
        $info['avatar'] = config('host_url') . $info['avatar'];
        if($info['see_pay'] == 1) {
            if(empty($user_id)) {
                $info['phone'] = 0;
            } elseif ($user_id) {
                $exist = model('UserEcharge')->exist('designer', $id, $user_id);
                if(empty($exist)) {
                    $info['phone'] = 0;
                }
            }
        }
        //查看电话费用
        $money = Config::where('group','basic')->where('name', 'see_pay')->value('value');
        $money = json_decode($money, true);
        $info['money'] = $money['设计师'];

		$this->success('ok',$info);
    }
}
