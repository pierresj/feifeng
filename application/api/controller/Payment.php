<?php 
namespace app\api\controller;
use think\Controller;
use my\wxpay;
use think\Db;
use think\Log;
class Payment extends Controller
{
    public function little_program_notify_url(){
        $wxpay = new wxpay(config('appId'),config('appSecret'),config('mchid'),config('key'));
//        Log::log('pay_return:'.date("YmdHis", time()) . var_export($GLOBALS, true));

//        $xml = $GLOBALS['HTTP_RAW_POST_DATA'];
        $xml = file_get_contents('php://input');
        $wxpay->saveData($xml);
        //验证签名
        if ($wxpay->checkSign() == FALSE) {
            echo 'FAIL';exit();
        }
        //验证金额
        $attach = $wxpay->data["attach"];

        $id = str_replace($attach, '', $wxpay->data["out_trade_no"]);
        Log::log('pay_return:'.date("YmdHis", time()) . var_export($wxpay->data, true));
        Log::log('pay_return:'.date("YmdHis", time()) . var_export($id, true));

        $order_info = model('UserEcharge')->getInfo($id);
        if($wxpay->checkAmount($order_info['amount']) == FALSE){
            echo 'FAIL';exit();
        }
        if($wxpay->data["return_code"] == "FAIL") {
            echo 'FAIL';exit();
        } elseif ($wxpay->data["result_code"] == "FAIL") {
            echo 'FAIL';exit();
        } else {
            model('UserEcharge')->setPaid($id, $wxpay->data['out_trade_no']);	/* 改变订单状态 */
            echo "SUCCESS";
        }
    }
    public function little_program_notify_text(){
        $wxpay = new wxpay(config('appId'),config('appSecret'),config('mchid'),config('key'));
//        $xml = $GLOBALS['HTTP_RAW_POST_DATA'];
        $xml = file_get_contents('php://input');;
        $wxpay->saveData($xml);
        //验证签名
        if ($wxpay->checkSign() == FALSE) {
            echo 'FAIL';exit();
        }
        //验证金额
        $attach = trim($wxpay->data["attach"]);

        $id = str_replace($attach, '', trim($wxpay->data["out_trade_no"]));
        $order_info = Db('TestPay')->where('out_trade_no',$id)->find();
        $str = "id:".$id." attach:".$attach." out_trade_no:".$wxpay->data["out_trade_no"];
        file_put_contents("pay_log.txt",$str." \r\n",FILE_APPEND);
        if($wxpay->checkAmount($order_info['amount']) == FALSE){
            file_put_contents("pay_log.txt",$id." 金额不符\r\n",FILE_APPEND);
            echo 'FAIL';exit();
        }
        if($wxpay->data["return_code"] == "FAIL") {
            file_put_contents("pay_log.txt",$id." 通信出错\r\n",FILE_APPEND);
            echo 'FAIL';exit();
        } elseif ($wxpay->data["result_code"] == "FAIL") {
            file_put_contents("pay_log.txt",$id." 业务出错\r\n",FILE_APPEND);
            echo 'FAIL';exit();
        } else {
            file_put_contents("pay_log.txt",$id." 支付成功\r\n",FILE_APPEND);
            $time = strtotime($wxpay->data['time_end']);
            $data= date("Y-m-d H:i:s",$time);
            Db('TestPay')->where('out_trade_no',$id)->update(['pay_time'=>$data,'transaction_id'=>$wxpay->data['transaction_id']]);
            echo "SUCCESS";
        }
    }
}


 ?>