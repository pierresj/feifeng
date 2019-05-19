<?php

namespace app\admin\validate;

use think\Validate;

class Ad extends Validate
{
    /**
     * 验证规则
     */
    protected $rule = [
        'image' => 'require'
    ];
    /**
     * 提示消息
     */
    protected $message = [
        'image.require' => '必须上传图片',
    ];
    /**
     * 验证场景
     */
    protected $scene = [
        'add'  => ['image'],
        'edit' => ['image'],
    ];
    
}
