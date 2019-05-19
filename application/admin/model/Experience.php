<?php

namespace app\admin\model;

use think\Model;

class Experience extends Model
{
    // 表名
    protected $name = 'experience';
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

    public function experience_arr($condition=null)
    {
        if($condition) {
            $list = $this->where($condition)->select();
        } else {
            $list = $this->select();
        }
        $experience_arr = [];
        foreach ($list as $l) {
            $experience_arr[$l['id']] = $l['experience'];
        }
        return $experience_arr;
    }
}
