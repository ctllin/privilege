<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="edge" />
<title></title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="shortcut icon" href="${ctx}/style/images/index/favicon.png" />

<!-- [my97日期时间控件] -->
<script type="text/javascript" src="${ctx}/jslib/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<!-- [jQuery] -->
<script src="${ctx}/jslib/easyui1.4.2/jquery.min.js" type="text/javascript" charset="utf-8"></script>

<!-- [EasyUI] -->
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4.2/themes/<c:out value="${cookie.easyuiThemeName.value}" default="gray"/>/easyui.css" type="text/css">
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4.2/themes/icon.css" type="text/css">
<script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<!-- [扩展JS] -->
<script type="text/javascript" src="${ctx}/jslib/extJs.js" charset="utf-8"></script>

<!-- [扩展lightmvc样式] -->
<link rel="stylesheet" href="${ctx}/style/css/lightmvc.css" type="text/css">
<script type="text/javascript">
function cleanFun() {
	$('#searchForm input').val('');
}
function searchFun(){
	  var orderNumber=$('#orderNumber').val();//订单号
	  var type=$('#type').combobox('getValue');//easyui 获取选中值
	  if(orderNumber==null||""==orderNumber){
		  $('#orderNumber').focus();
		  parent.$.messager.alert('提示信息', '订单号不能为空', 'success');
		  return;
	  }
	  if(type==null||""==type){
		  $('#refundAmount').focus();
		  parent.$.messager.alert('提示信息', '查询类型不能为空', 'success');
		  return;
	  }
	  var datas = '/'+orderNumber+'/'+type;
	   $.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/portalpay/portalpayOrderQuery/do'+datas,
			success:function(result){//返回json结果
				result = $.parseJSON(result);
				if (result.success) {
					//parent.$.messager.alert('提示信息', result.msg, 'info');
					var array=new Array();
				    array=result.msg.split("&");
				    var htmlResult='';
				    for (var i=0;i<array.length ;i++ ) 
				    { 
				    	   var array2=new Array();
				    	   array2=array[i].split("=");
				    	   if(array2.length>=2){
				    		   htmlResult+="<tr><td style='width: 100px'>"+array2[0]+"</td><td>"+array2[1]+"</td></tr>";
				    		   
				    	   }else{
				    		   htmlResult+="<tr><td>"+array2[0]+"</td><td></td></tr>";
				    	   }  
				    }
				    $("#datalist").html(htmlResult);
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
}
</script>
</head>
<body>
<form id="searchForm" name="searchForm" method="post" action="">
	<table>
		<tr>
			<th>商户订单号:</th>
			<td><input name="remark" type="hidden"  value="退款">
			<input name="orderNumber" id="orderNumber" style="width:250px" type="text" placeholder="请输入商品订单号" class="easyui-validatebox span2" data-options="required:true"  >
			<select class="easyui-combobox" id="type" name='type'  label="State:" labelPosition="top" style="width:150px;" >
	   			 <option value="1">支付</option>
                 <option value="2">退款</option>
			</select>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
			</td>
		</tr>
	</table>
	<div>
       	<span style="color:red;"> resultCode:{0000:请求成功}queryDetails(最后一位数字含义):queryDetails(最后一位数字含义){0:已接受,1:处理中,2:交易成功,3:交易失败}</span>
       	<table class="grid" id="datalist" data-options="fit:true,border:false">
		<tr><td style="width: 100px">serialID</td><td></td></tr>
		<tr><td>mode</td><td></td></tr>
		<tr><td>type</td><td></td></tr>
		<tr><td>resultCode</td><td></td></tr>
		<tr><td>queryDetailsSize</td><td></td></tr>
		<tr><td>queryDetails</td><td></td></tr>
		<tr><td>partnerID</td><td></td></tr>
		<tr><td>remark</td><td></td></tr>
		<tr><td>charset</td><td></td></tr>
		<tr><td>signType</td><td></td></tr>
		<tr><td>signMsg</td><td></td></tr>
       	</table>
       	<br/>
       	<span style="color:red;">代码说明(resultCode)</span>
       	<br/>
       	<table class="grid" id="datalist2" data-options="fit:true,border:false">
			<tr><td style="width: 100px">0301</td><td>退款历史记录失败</td></tr>
			<tr><td>0302</td><td>退款商户不存在</td></tr>
			<tr><td>0303</td><td>报文必填参数为空</td></tr>
			<tr><td>0304</td><td>商户退款订单时间不正确,以YYYYMMDDHHMMSS格式的时间字符串</td></tr>
			<tr><td>0306</td><td>退款交易对应的原订单不存在</td></tr>
			<tr><td>0307</td><td>即时交易：订单状态不为已成功，不能进行退款</td></tr>
			<tr><td>0308</td><td>商户退款订单处理完成，请勿重复退款</td></tr>
			<tr><td>0309</td><td>商户退款订单金额不正确,以分为单位的金额,最大长度不超过10</td></tr>
			<tr><td>0310</td><td>全额退款类型：退款金额不符</td></tr>
			<tr><td>0311</td><td>退款失败,退款金额大于支付余额</td></tr>
			<tr><td>0312</td><td>退款请求序列号已经存在</td></tr>
			<tr><td>0313</td><td>商户退款订单号已经存在</td></tr>
			<tr><td>0314</td><td>报文验签失败</td></tr>
			<tr><td>0315</td><td>付款方帐户止入</td></tr>
			<tr><td>0316</td><td>商户止入或者止出</td></tr>
			<tr><td>0317</td><td>退款逻辑验证失败</td></tr>
			<tr><td>0318</td><td>更新余额异常</td></tr>
			<tr><td>0319</td><td>手续费用计算失败</td></tr>
			<tr><td>0320</td><td>退款订单创建失败</td></tr>
			<tr><td>0321</td><td>帐务退款失败</td></tr>
			<tr><td>0322</td><td>网关订单异常</td></tr>
			<tr><td>0323</td><td>充退异常</td></tr>
			<tr><td>0324</td><td>构建退款订单异常</td></tr>
			<tr><td>0325</td><td>网关订单记帐成功修改退款订单失败</td></tr>
			<tr><td>0326</td><td>报文参数错误</td></tr>
			<tr><td>0327</td><td>退款失败,退款金额大于商户可用余额</td></tr>
			<tr><td>0328</td><td>退款金额小于等于0新生支付平台网关支付商户接入规范2016/10/27</td></tr>
			<tr><td>0329</td><td>商户退款订单处理完成，请勿重复退款</td></tr>
			<tr><td>0330</td><td>网关订单非交易完成状态,不可以进行退款</td></tr>
			<tr><td>0331</td><td>易卡退付款方手续费失败</td></tr>
			<tr><td>0332</td><td>请求版本不正确</td></tr>
       	</table>
	</div>
</form>
</body>
</html>