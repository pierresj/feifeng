<?php

namespace app\api\controller;

use addons\alisms\library\Alisms;
use app\common\controller\Api;
use app\common\model\Config;

class Recruit extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    public function index()
    {
    	$where = [
    	    'recruit.is_delete' => 0,
            'recruit.status' => 1
        ];

//    	if(request()->has('experience_id') && request()->param('experience_id')){
//    		$where['experience_id'] = ['like', "%" . request()->param('experience_id') . "%"];
//	    }
	    if(request()->has('province') && request()->param('province')){
		    $where['province'] = request()->param('province');
	    }
	    if(request()->has('city') && request()->param('city')){
		    $where['city'] = request()->param('city');
	    }
	    
	    $list = \app\admin\model\Recruit::with('user')->where($where)->paginate(10);
//	    $list = \app\admin\model\Designer::where($where)->paginate(10);
//	    foreach ($list as &$l) {
//	        $l['experience'] = \app\admin\model\Experience::where('id', 'in', $l['experience_id'])->select();
//	        $l['avatar'] = config('host_url') . $l['avatar'];
//        }
    	return $this->success('ok', $list);
    }

    public function my_list($user_id=null){
        if(empty($user_id)) {
            return $this->error('缺少参数');
        }
        $where =[
            'user_id' => $user_id
        ];

        $list = \app\admin\model\Recruit::where($where)->paginate(10);

        return $this->success('ok', $list);
    }
	
	public function create()
	{
		$data = request()->param();
        $result = $this->validate($data,'Recruit.create');
        if(true !== $result){
            // 验证失败 输出错误信息
            return $this->error($result);
        }
		$model = new \app\admin\model\Recruit();
		if($model->allowField(true)->create($data)){
//			$phone = Config::where('group','weapp')->where('name', 'contact_phone')->value('value');
//			$alisms = Alisms::instance();
//			$res = $alisms->mobile($phone)
//				->template('SMS_164508758')
//				->param(['phone' => $data['phone'], 'name' => $data['designer_name']])
//				->send();
//			halt($res);
            return $this->success('提交成功');
		}else{
			return $this->error('提交失败');
		}
    }

    public function modify($id, $user_id){
        $info = \app\admin\model\Recruit::where('id', $id)->where('user_id', $user_id)->find();
        if(empty($info)) {
            return $this->error("你没有修改权限");
        }

        $data = request()->param();
        $result = $this->validate($data,'Recruit.create');
        if(true !== $result){
            // 验证失败 输出错误信息
            return $this->error($result);
        }
        $model = new \app\admin\model\Recruit();
        if($model->allowField(true)->where('id', $id)->update($data) !== false){
//			$phone = Config::where('group','weapp')->where('name', 'contact_phone')->value('value');
//			$alisms = Alisms::instance();
//			$res = $alisms->mobile($phone)
//				->template('SMS_164508758')
//				->param(['phone' => $data['phone'], 'name' => $data['designer_name']])
//				->send();
//			halt($res);
            return $this->success('提交成功');
        }else{
            return $this->error('提交失败');
        }

    }
	
	public function show($id)
	{
		$info = \app\admin\model\Recruit::with('user')
            ->where('recruit.status', 1)
            ->where('recruit.is_delete', 0)
            ->find($id);

		return $this->success('ok',$info);
    }

    public function modify_display($id,  $user_id, $is_delete){
        $info = \app\admin\model\Recruit::where('id', $id)->where('user_id', $user_id)->find();
        if(empty($info)) {
            return $this->error("你没有修改权限");
        }
        $model = new \app\admin\model\Recruit();
        if($model->allowField(true)->where('id', $id)->setField('is_delete', $is_delete) !== false){
            return $this->success('提交成功');
        }else{
            return $this->error('提交失败');
        }
    }

    public function get_wage(){
        $wage = [
            "2k-3k",
            "3k-4k",
            "4k-5k",
            "5k-6k",
            "6k-7k",
            "7k以上",
        ];
        $this->success('ok', $wage);
    }
}
