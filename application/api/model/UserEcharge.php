<?php 

namespace app\api\model;
use think\Model;
use think\Db;
use think\Hook;

class UserEcharge extends Model{
	protected $autoWriteTimestamp = true;
	protected $createTime = 'add_time';
    protected $updateTime = 'paid_time';


    // 调用当前模型对应的User验证器类进行数据验证

    //插入记录
    public function insert_option($data){
    	$result = $this->insertGetId($data);
    	if(false == $result){
    	    // 验证失败 输出错误信息
    	    return false;
    	}

    	return $result;
    }
    /**
     * 修改支付状态
     */
    public function setPaid($id, $trade_no){
        $info = $this->getInfo($id);
        if($info['process_type'] === 0){
            $this->where('id',$id)->update([
                'is_paid' => 1,
                'trade_no'=>$trade_no,
                'user_note' => "充值,编号:{$trade_no}",
                'day' => date('Ymd', time()),
                'paid_time' => time()
            ]);
            return true;
        }else{
            return false;
        }
    }
    /**
     * 获取信息
     */
    public function getInfo($id){
        $res=$this->where('id',$id)->field("amount, user_id, id, prepay_id, process_type")->find();
        if($res){
            return $res;
        }else{
            return false;
        }
    }

    public function exist($type, $f_id, $user_id){
        $exist = $this->where('type', $type)
            ->where('f_id', $f_id)
            ->where('user_id', $user_id)
            ->where('is_paid', 1)
            ->find();
        return $exist;
    }
}

 ?>