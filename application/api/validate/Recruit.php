<?php


namespace app\api\validate;
use think\Validate;

class Recruit extends Validate
{
    /**
     * 验证规则
     */
    protected $regex = [ 'phone' => '^(1[3-9][0-9])\\d{8}$'];
    protected $rule = [
        'position' => 'require',
        'tel' => 'require',
    ];
    /**
     * 提示消息
     */
    protected $message = [
        'position.require' => '请输入职位',
        'tel.require' => '请输入联系方式'
    ];
    /**
     * 验证场景
     */
    protected $scene = [
        'create'  => ['position','tel'],
        'modify'  => ['position','tel'],
    ];
}