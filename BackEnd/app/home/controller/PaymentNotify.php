<?php
/**
 * @author: helei
 * @createTime: 2016-07-20 18:31
 * @description:
 */

/**
 * 客户端需要继承该接口，并实现这个方法，在其中实现对应的业务逻辑
 * Class TestNotify
 * anthor helei
 */
namespace app\home\controller;

class PaymentNotify implements \Payment\Notify\PayNotifyInterface
{

    public function notifyProcess(array $data)
    {
        // 执行业务逻辑，成功后返回true
        //var_dump($data);
        return true;
    }
}