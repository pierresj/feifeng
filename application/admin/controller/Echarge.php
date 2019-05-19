<?php

namespace app\admin\controller;

use app\admin\model\User;
use app\common\controller\Backend;

/**
 * 用户充值提现明细管理
 *
 * @icon fa fa-circle-o
 */
class Echarge extends Backend
{
    
    /**
     * Echarge模型对象
     * @var \app\admin\model\user\Echarge
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\user\Echarge;

    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $total = $this->model
                ->where($where)
                ->where('is_paid', 1)
                ->order($sort, $order)
                ->count();

            $list = $this->model
                ->where($where)
                ->where('is_paid', 1)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
            foreach ($list as &$l) {
                $l['user_id'] = model('User')->where('id', $l['user_id'])->value('username');
                if($l['type'] == 'team') {
                    $l['type'] = '劳务队';
                    $l['f_id'] = model('Team')->where('id', $l['f_id'])->value(['leader_name']);
                } else if($l['type'] == 'designer') {
                    $l['type'] = '设计师';
                    $l['f_id'] = model('Designer')->where('id', $l['f_id'])->value(['designer_name']);
                } else if($l['type'] == 'bid') {
                    $l['type'] = '招标';
                    $l['f_id'] = model('Bid')->where('id', $l['f_id'])->value(['name']);
                }
            }
            unset($l);

            $list = collection($list)->toArray();
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }
    

}
