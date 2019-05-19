<?php

namespace app\api\controller;

use addons\alisms\library\Alisms;
use app\common\controller\Api;
use app\common\model\Config;
use think\Db;
use think\Request;

class Quote extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    public function teamquote(){
        $quote = Config::where('group','weapp')->where('name','can_kao_bao_jia')->value('value');
        $quote = config('host_url') . $quote;
        if($quote) {
            $this->success('获取报价成功', $quote );
        } else {
            $this->error('获取报价失败');
        }
    }

    public function productquote(){
        $row = \app\admin\model\product\Quote::order('id','DESC')->find();
        $this->success('ok', $row);
    }

}
