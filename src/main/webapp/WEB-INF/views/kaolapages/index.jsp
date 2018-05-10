<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>支付宝免短信验证支付接口</title>
<script type="text/javascript" src="./js/jquery-1.4.4.min.js"></script>
<script type="text/javascript">
var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
function generateMixed(n) {
     var res = "";
     for(var i = 0; i < n ; i ++) {
         var id = Math.ceil(Math.random()*35);
         res += chars[id];
     }
     return res;
}
Date.prototype.format = function (format) {
    var args = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
    };
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var i in args) {
        var n = args[i];
        if (new RegExp("(" + i + ")").test(format))
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? n : ("00" + n).substr(("" + n).length));
    }
    return format;
};
//上传订单信息及  座选  pc
function orderConfirm(){
	$('#resultStr').html("");
	var num=Math.floor(Math.random()*10000000000);
	var orderNumber=new Date().format("yyyyMMddhhmmss")+num+generateMixed(10-num.toString().length);
	$.ajax({
		type:'post',
		url:'http://localhost:8080/AlipayWithoutMessage/kaola/goodsInfo/orderConfirm',//开发自测试地址
	    //url:'https://gateway.shareco.cn/unmessalipay/alipaySendOrderGoodsCart2', //该地址为生产地址暂未启用
   	    contentType:'application/json;charset=UTF-8',
		data:'{"orderNumber":"'+orderNumber+'","userInfo":{"accountId":"guolinit@163.com","address":"测试订单","identityPicFront":"","cityName":"北京市","districtName":"测试订单","identityId":"422201199306135919","mobile":"15927199306","name":"胡天科","identityPicBack":"","provinceName":"北京","email":"1083539025@qq.com"},"orderItemList":[{"buyAmount":3,"warehouseId":7,"goodsId":"26432","channelSalePrice":37,"skuId":"23738-68a3e5516d7a7dc21fbe0e7ee13bfc1c"}]}',
		//data:'{"userInfo":{"accountId":"guolinit@163.com","address":"测试订单","identityPicFront":"","cityName":"北京市","districtName":"海淀区","identityId":"422201199306135919","mobile":"15927199306","name":"胡天科","identityPicBack":"","provinceName":"北京","email":"1083539025@qq.com"},"orderItemList":[{"buyAmount":1,"warehouseId":160,"goodsId":"743569","channelSalePrice":379,"skuId":"743569-68a3e5516d7a7dc21fbe0e7ee13bfc1c"}]}',	
		success:function(result){//返回支付页面
			$('#resultStr').html(JSON.stringify(result));
			$('#orderNumber').val(result.orderNumber);
		}
	});
}
function orderCancel(){
	var orderNumber=$('#orderNumber').val();
    $.ajax({
	type:'post',
	url:'http://localhost:8080/AlipayWithoutMessage/kaola/goodsInfo/cancelOrder',//开发自测试地址
    //url:'https://gateway.shareco.cn/unmessalipay/alipaySendOrderGoodsCart2', //该地址为生产地址暂未启用
	//contentType:'application/json;charset=UTF-8',
	data:'thirdPartOrderId='+orderNumber,
	//data:'{"userInfo":{"accountId":"guolinit@163.com","address":"测试订单","identityPicFront":"","cityName":"北京市","districtName":"海淀区","identityId":"422201199306135919","mobile":"15927199306","name":"胡天科","identityPicBack":"","provinceName":"北京","email":"1083539025@qq.com"},"orderItemList":[{"buyAmount":1,"warehouseId":160,"goodsId":"743569","channelSalePrice":379,"skuId":"743569-68a3e5516d7a7dc21fbe0e7ee13bfc1c"}]}',	
	success:function(result){//返回支付页面
		$('#orderCancel').html(JSON.stringify(result));
	}
});
}
function bookpayorder(){
	var orderNumber=$('#orderNumber').val();
    $.ajax({
	type:'post',
	url:'http://localhost:8080/AlipayWithoutMessage/kaola/goodsInfo/bookpayorder',//开发自测试地址
    //url:'https://gateway.shareco.cn/unmessalipay/alipaySendOrderGoodsCart2', //该地址为生产地址暂未启用
	//contentType:'application/json;charset=UTF-8',
	data:'thirdPartOrderId='+orderNumber,
	//data:'{"userInfo":{"accountId":"guolinit@163.com","address":"测试订单","identityPicFront":"","cityName":"北京市","districtName":"海淀区","identityId":"422201199306135919","mobile":"15927199306","name":"胡天科","identityPicBack":"","provinceName":"北京","email":"1083539025@qq.com"},"orderItemList":[{"buyAmount":1,"warehouseId":160,"goodsId":"743569","channelSalePrice":379,"skuId":"743569-68a3e5516d7a7dc21fbe0e7ee13bfc1c"}]}',	
	success:function(result){//返回支付页面
		$('#bookpayorder').html(JSON.stringify(result));
	}
});
}


</script>
</head>
<body>

<input type="button" onclick="orderConfirm()" value="锁定商品" /><br>
<input type="text" id="orderNumber" value="" /><br>
<input type="button" onclick="bookpayorder()" value="下单" /><br>
<input type="button" onclick="orderCancel()" value="取消" /><br>

<div id="resultStr"></div><br/><br/>
<div id="bookpayorder"></div><br/><br/>
<div id="orderCancel"></div><br/><br/>
</body>
</html>