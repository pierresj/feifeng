<?php

namespace app\admin\model;

use think\Model;

class Team extends Model
{
    // 表名
    protected $name = 'team';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    // 定义时间戳字段名
    protected $createTime = "create_time";
    protected $updateTime = "update_time";
    
    // 追加属性
    protected $append = [
        'is_insurance_text',
        'create_time_text',
        'update_time_text',
        'delete_time_text'
    ];
    

    
    public function getIsInsuranceList()
    {
        return ['0' => __('Is_insurance 0'),'1' => __('Is_insurance 1')];
    }     


    public function getIsInsuranceTextAttr($value, $data)
    {        
        $value = $value ? $value : (isset($data['is_insurance']) ? $data['is_insurance'] : '');
        $list = $this->getIsInsuranceList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getCreateTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['create_time']) ? $data['create_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    public function getCreateTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['create_time']) ? $data['create_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i", $value) : $value;
    }


    public function getUpdateTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['update_time']) ? $data['update_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getDeleteTimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['delete_time']) ? $data['delete_time'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setCreateTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setUpdateTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setDeleteTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }
	
    public function experience()
    {
        return $this->hasMany('Experience', 'id', 'experience_id');
    }
}
