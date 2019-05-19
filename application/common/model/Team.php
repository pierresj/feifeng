<?php

namespace app\common\model;

use think\Model;

class Team extends Model
{
    // 表名
    protected $name = 'team';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    public function experience()
    {
        return $this->hasOne(Experience::class, 'experience_id', 'id');
    }
}
