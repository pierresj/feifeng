<?php
namespace app\api\controller;
use think\Controller;

class Test extends Controller
{
    public function index(){
        $model = model("LittleProgram");
        $re = $model->getWxUserInfo();
        print_r($re);
    }
}