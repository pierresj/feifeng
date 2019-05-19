<?php

namespace app\admin\model;

use think\Model;

class Ad extends Model
{
    // 表名
    protected $name = 'ad';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    
    // 追加属性
    protected $append = [

    ];

    protected function setIsDeleteAttr($value){
        return $value && !empty($value) ? $value : 0;
    }

    protected function setUrlAttr($value) {
        return $value && !empty($value) ? $value : "javascript:void(0);";
    }

    protected function setTitleAttr($value) {
        return $value && !empty($value) ? $value : "0";
    }
}
