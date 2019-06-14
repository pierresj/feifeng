<?php

namespace app\admin\model;

use think\Model;

class Bid extends Model
{
    // 表名
    protected $name = 'bid';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    // 定义时间戳字段名
    protected $createTime = "create_time";
    protected $updateTime = "update_time";
    protected $bidStartTime = "bid_start_time";
    protected $bidEndTime = "bid_end_time";

    // 追加属性
    protected $append = [

    ];

    public function getStartTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['start_time']) ? $data['start_time'] : '');
        return is_numeric($value) ? date("Y-m-d", $value) : $value;
    }

    public function getEndTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['end_time']) ? $data['end_time'] : '');
        return is_numeric($value) ? date("Y-m-d", $value) : $value;
    }

    public function getBidStartTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['bid_start_time']) ? $data['bid_start_time'] : '');
        return is_numeric($value)&&!empty($value) ? date("Y-m-d", $value) : $value;
    }

    public function getBidEndTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['bid_end_time']) ? $data['bid_end_time'] : '');
        return is_numeric($value)&&!empty($value) ? date("Y-m-d", $value) : $value;
    }

    public function getCreateTimeAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['create_time']) ? $data['create_time'] : '');
        return is_numeric($value)&&!empty($value) ? date("Y-m-d", $value) : $value;
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

    protected function setStartTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setEndTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setBidStartTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setBidEndTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
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
}
