<?php

namespace app\admin\model;

use think\Model;

class Recruit extends Model
{
    // 表名
    protected $name = 'recruit';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';
    
    // 追加属性
    protected $append = [];

    public function getCreateTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['create_time']) ? $data['create_time'] : '');
        return is_numeric($value)&&!empty($value) ? date("Y-m-d H:i", $value) : $value;
    }


    public function getUpdateTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['update_time']) ? $data['update_time'] : '');
        return is_numeric($value)&&!empty($value) ? date("Y-m-d H:i", $value) : $value;
    }

    protected function setCreateTimeAttr($value)
    {
        return $value && !is_numeric($value) ? $value : time();
    }

    protected function setUpdateTimeAttr($value)
    {
        return $value && !is_numeric($value) ? $value : time();
    }

    public function user()
    {
        return $this->belongsTo('User', 'user_id', 'id', [], 'Left')->setEagerlyType(0);
    }
}
