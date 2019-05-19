<?php

namespace app\admin\controller\product;

use addons\alisms\library\Alisms;
use app\common\controller\Backend;

/**
 * 
 *
 * @icon fa fa-circle-o
 */
class Company extends Backend
{
    
    /**
     * Company模型对象
     * @var \app\admin\model\product\Company
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\product\Company;

    }
    public function check($ids)
    {
        $this->model->where('id', $ids)->update(['status' => 1]);
        $this->success('操作成功');
    }

    public function uncheck($ids)
    {
        $this->model->where('id', $ids)->update(['status' => 0]);
        $this->success('操作成功');
    }
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
    /**
     * 批量更新
     */
    public function multi($ids = "")
    {
        $ids = $ids ? $ids : $this->request->param("ids");
        if ($ids) {
            if ($this->request->has('params')) {
                parse_str($this->request->post("params"), $values);
                $values = array_intersect_key($values, array_flip(is_array($this->multiFields) ? $this->multiFields : explode(',', $this->multiFields)));
                if ($values) {
                    $adminIds = $this->getDataLimitAdminIds();
                    if (is_array($adminIds)) {
                        $this->model->where($this->dataLimitField, 'in', $adminIds);
                    }
                    $count = 0;
                    $list = $this->model->where($this->model->getPk(), 'in', $ids)->select();
                    foreach ($list as $index => $item) {
                        $count += $item->allowField(true)->isUpdate(true)->save($values);
                    }
                    if ($count) {
                        //status状态更改成1的发送短信
                        if(isset($values['status']) && $values['status'] == 1) {
                            $info = $this->model->where('id', $ids)->find();
                            $phone = $info['phone'];
                            $name = $info['company_name'];
                            $role = '材料商加盟';
                            $alisms = Alisms::instance();
                            $alisms->mobile($phone)
                                ->template('SMS_165412146')
                                ->param(['name' => $name, 'role' => $role])
                                ->send();
                        }
                        $this->success();
                    } else {
                        $this->error(__('No rows were updated'));
                    }
                } else {
                    $this->error(__('You have no permission'));
                }
            }
        }
        $this->error(__('Parameter %s can not be empty', 'ids'));
    }

}
