<?php

namespace app\api\controller;

use addons\alisms\library\Alisms;
use app\admin\model\product\Type;
use app\common\controller\Api;
use app\common\library\Sms as Smslib;
use app\common\model\Config;
use think\Db;
use think\Request;

class Product extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    public function index()
    {
    	$where = [
    	    'company.status' => 1
        ];
    	if(request()->has('type') && request()->param('type')) {
    	    $where['product.type_id'] = request()->param('type');
        }
	    if(request()->has('province') && request()->param('province')){
		    $where['company.province'] = request()->param('province');
	    }
	    if(request()->has('city') && request()->param('city')){
		    $where['company.city'] = request()->param('city');
	    }
	    
	    $list = \app\admin\model\Product::with(['company', 'type'])->where($where)->order('id DESC')->paginate(10);
    	return $this->success('ok', $list);
    }
	
	public function create()
	{
		$data = request()->param();
		$productCompanyModel = new \app\admin\model\product\Company();
		$productModel = new \app\admin\model\Product();
        //添加公司
        $company_data = [
            'company_name' => $data['company_name'],
            'phone' => $data['phone'],
            'province' => $data['province'],
            'city' => $data['city'],
            'district' => $data['district'],
            'address' => $data['address'],
        ];
        $productCompanyModel->allowField(true)->save($company_data);
        $company_id = $productCompanyModel->id;
        if($company_id) {
            //添加产品
            /*$data['product'] = [
                ['company_id' => $company_id, 'product_name' => '螺纹钢', 'type_id' => 1, 'product_standard' => '规格1', 'product_price' => '1000', 'product_images' => '/uploads/20181112/746c56e5f8bf0b8c1e3eaedabb86a19f.jpg', 'content' => '商品描述1'],
                ['company_id' => $company_id, 'product_name' => '槽钢', 'type_id' => 1, 'product_standard' => '规格2', 'product_price' => '1000', 'product_images' => '/uploads/20181112/746c56e5f8bf0b8c1e3eaedabb86a19f.jpg', 'content' => '商品描述2'],
                ['company_id' => $company_id, 'product_name' => '不锈钢', 'type_id' => 1, 'product_standard' => '规格3', 'product_price' => '1000', 'product_images' => '/uploads/20181112/746c56e5f8bf0b8c1e3eaedabb86a19f.jpg', 'content' => '商品描述3'],
            ];*/
            $product = json_decode($data['product'], true);
            foreach ($product as &$p) {
                $p['company_id'] = $company_id;
                $p['create_time'] = time();
            }
            unset($p);
            $data['product'] = $product;
            $re = $productModel->allowField(true)->saveAll($data['product']);
            if($re) {
                $phone = Config::where('group','weapp')->where('name', 'contact_phone')->value('value');
                $alisms = Alisms::instance();
                $alisms->mobile($phone)
                    ->template('SMS_164513795')
                    ->param(['phone' => $company_data['phone'], 'name' => $company_data['company_name']])
                    ->send();
                $this->success('提交成功');
            } else {
                $this->error('提交失败');
            }
        } else {
            $this->error('提交失败');
        }
    }
	
	public function show($id)
	{
		$info = \app\admin\model\Product::with(['company', 'type'])->where('company.status', 1)->find($id);
		$this->success('',$info);
    }

    public function producttype() {
        $type = Type::where('is_delete', 0)->field('id, type_name')->select();
        return $this->success('ok', $type);
    }

    public function test(){
        $data['product'] = [
            ['company_id' => 1, 'product_name' => '螺纹钢', 'type_id' => 1, 'product_standard' => '规格1', 'product_price' => '1000', 'product_images' => '/uploads/20181112/746c56e5f8bf0b8c1e3eaedabb86a19f.jpg', 'content' => '商品描述1'],
            ['company_id' => 2, 'product_name' => '槽钢', 'type_id' => 1, 'product_standard' => '规格2', 'product_price' => '1000', 'product_images' => '/uploads/20181112/746c56e5f8bf0b8c1e3eaedabb86a19f.jpg', 'content' => '商品描述2'],
            ['company_id' => 3, 'product_name' => '不锈钢', 'type_id' => 1, 'product_standard' => '规格3', 'product_price' => '1000', 'product_images' => '/uploads/20181112/746c56e5f8bf0b8c1e3eaedabb86a19f.jpg', 'content' => '商品描述3'],
        ];
        echo json_encode($data['product']);
    }
}