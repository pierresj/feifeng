<?php

namespace app\common\model;

use think\Model;
use traits\model\SoftDelete;

class Experience extends Model
{
    use SoftDelete;
    // 表名
    protected $name = 'experience';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;
}
