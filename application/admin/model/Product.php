<?php

namespace app\admin\model;

use think\Model;

class Product extends Model
{
    // 表名
    protected $name = 'product';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    // 定义时间戳字段名
    protected $createTime = "create_time";
    protected $updateTime = 'update_time';
    
    // 追加属性
    protected $append = [];

    public function getCreateTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['create_time']) ? $data['create_time'] : '');
        return is_numeric($value)&&!empty($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getUpdateTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['update_time']) ? $data['update_time'] : '');
        return is_numeric($value)&&!empty($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getDeleteTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['delete_time']) ? $data['delete_time'] : '');
        return is_numeric($value)&&!empty($value) ? date("Y-m-d H:i:s", $value) : $value;
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


    public function foreign(){
        return $this->hasManyThrough('app\admin\model\product\Company', 'app\admin\model\product\Type', 'company_id', 'type_id', 'id');
    }

    public function company()
    {
        return $this->belongsTo('app\admin\model\product\Company', 'company_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }


    public function type()
    {
        return $this->belongsTo('app\admin\model\product\Type', 'type_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }

    public function user()
    {
        return $this->belongsTo('app\admin\model\User', 'user_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
