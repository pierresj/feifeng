<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\Config;
use app\common\model\Experience;
use think\Db;

/**
 * 首页接口
 */
class Index extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    /**
     * 首页
     * 
     */
    public function index()
    {
        $config = Config::where('group', 'weapp')->column('value', 'name');
        $ads = Db::name('ad')->field('id,image')->where('is_delete', 0)->order('id DESC')->select();
        $data['config'] = $config;
        $data['ads'] = $ads;
        return $this->success('ok', $data);
    }

    public function experience()
    {
        $type = input('type', 1, 'intval');

        $experience = \app\admin\model\Experience::field('id, experience')->where('type', $type)->select();

        return $this->success('ok', $experience);
    }
    /**
     * 通用搜索
     */
    public function common_search(){
        $key = input('key', '', 'trim');
        if(empty($key)) {
            return $this->error('请输入关键字');
        }
        //查询team
        $team_list = Db::query("SELECT * FROM `gc_team` WHERE `status` = 1 AND (`leader_name` LIKE '{$key}%' OR `experience_desc` LIKE '%{$key}%')");
        //查询designer
        $designer_list = Db::query("SELECT * FROM `gc_designer` WHERE `status` = 1 AND (`designer_name` LIKE '{$key}%' OR `experience_desc` LIKE '%{$key}%' OR `card_name` LIKE '{$key}%')");
        //查询bid
        $bid_list = Db::query("SELECT * FROM `gc_bid` WHERE `status` = 1 AND (`name` LIKE '%{$key}%')");
        //查询product
        $sql = "SELECT * FROM `gc_product_company` AS `pc`"
            ." INNER JOIN `gc_product` AS `p` ON `pc`.`id` = `p`.`company_id`"
            ." INNER JOIN `gc_product_type` AS `pt` ON `pt`.`id` = `p`.`type_id`"
            ." WHERE `status` = 1 AND ( `p`.`product_name` LIKE '{$key}%')";
        $product_list = Db::query($sql);
        $list = [
            'team' => $team_list,
            'designer' => $designer_list,
            'bid' => $bid_list,
            'product' => $product_list
        ];
        return $this->success('ok', $list);
    }

}
