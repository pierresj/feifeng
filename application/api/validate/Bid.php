<?php


namespace app\api\validate;
use think\Validate;

class Bid extends Validate
{
    /**
     * 验证规则
     */
    protected $regex = [ 'phone' => '^(1[3-9][0-9])\\d{8}$'];
    protected $rule = [
        'name' => 'require',
        'pay_way' => 'require',
        'phone' => 'require|length:11|regex:phone',
    ];
    /**
     * 提示消息
     */
    protected $message = [
        'name.require' => '请输入名称',
        'phone.require' => '请输入手机号',
        'phone.length' => '请输入正确的手机号',
        'phone.regex' => '请输入正确的手机号',
        'pay_way.require' => '请输入付款类型'
    ];
    /**
     * 验证场景
     */
    protected $scene = [
        'create'  => ['name','phone','pay_way'],
        'modify'  => ['name','phone','pay_way'],
    ];
}