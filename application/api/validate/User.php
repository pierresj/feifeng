<?php

namespace app\api\validate;

use think\Validate;

class User extends Validate
{
    /**
     * 验证规则
     */
    protected $regex = [ 'mobile' => '^(1[3-9][0-9])\\d{8}$','role'=>'[1-9]'];
    protected $rule = [
        'username' => 'require',
        'mobile' => 'require|length:11|regex:mobile',
        'role' => 'require|regex:role',
    ];
    /**
     * 提示消息
     */
    protected $message = [
        'username.require' => '请输入名字',
        'mobile.require' => '请输入手机号',
        'mobile.length' => '请输入正确的手机号',
        'mobile.regex' => '请输入正确的手机号',
        'role.require' => '请选择角色',
        'role.regex' => '请选择角色'
    ];
    /**
     * 验证场景
     */
    protected $scene = [
        'improve'  => ['username','mobile','role'],
    ];
    
}
