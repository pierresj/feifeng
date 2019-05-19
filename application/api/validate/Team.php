<?php

namespace app\api\validate;

use think\Validate;

class Team extends Validate
{
    /**
     * 验证规则
     */
    protected $regex = [ 'phone' => '^(1[3-9][0-9])\\d{8}$'];
    protected $rule = [
        'leader_name' => 'require',
        'phone' => 'require|length:11|regex:phone',
        'member_num' => 'require',
        'experience_id' => 'require'
    ];
    /**
     * 提示消息
     */
    protected $message = [
        'leader_name.require' => '请输入名字',
        'phone.require' => '请输入手机号',
        'phone.length' => '请输入正确的手机号',
        'phone.regex' => '请输入正确的手机号',
        'member_num.require' => '请输入劳务队人数',
        'experience_id.require' => '请选择经验类型'
    ];
    /**
     * 验证场景
     */
    protected $scene = [
        'create'  => ['leader_name','phone','member_num','experience_id'],
    ];
    
}
