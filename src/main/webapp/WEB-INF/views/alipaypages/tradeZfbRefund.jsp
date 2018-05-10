<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>DEMO管理</title>
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
	$('#queryform input').val('');
	dataGrid.datagrid('load', {});
}
function showResult(form) {
 	if(trimStr(form.begintime.value)=='') {
        form.begintime.focus();
        return false;
    }
	if(trimStr(form.endtime.value)=='') {
        form.endtime.focus();
        return false;
    }
	var rex= /^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/;//2017-03-13 00:00:00
	if(rex.test(form.begintime.value)&&rex.test(form.endtime.value)){
	}else{
		alert("日期格式不对");
		return false;
	}
    document.getElementById("queryform").submit();
}
function refundFun(){
	  setWIDbatch_no();//每次点击退款更新批次号
	  var urlDownload="";
	  var messageType=$('#messageType').combobox('getValue');//easyui 获取选中值
	  var bussinessType=$('#bussinessType').combobox('getValue');//easyui 获取选中值
	  var WIDbatch_no=$('#WIDbatch_no').val();
	  var WIDbatch_num=$('#WIDbatch_num').val();
	  var tradeNo=$('#tradeNo').val();
	  var totalMoney=$('#totalMoney').val();
	  var refundReason=$('#refundReason').val();
	  var WIDdetail_data=tradeNo+'^'+totalMoney+'^'+refundReason;//'^'需要转义  %5e
	  if(tradeNo==null||""==tradeNo){
		  $('#tradeNo').focus();
		  parent.$.messager.alert('提示信息', '交易号不能为空', 'success');
		  return;
	  }
	  if(totalMoney==null||""==totalMoney){
		  $('#totalMoney').focus();
		  parent.$.messager.alert('提示信息', '金额不能为空', 'success');
		  return;
	  }
	  if(refundReason==null||""==refundReason){
		  $('#refundReason').focus();
		  parent.$.messager.alert('提示信息', '退款原因不能为空', 'success');
		  return;
	  }
	  if(messageType==null||""==messageType){
		  $('#messageType').focus();
		  parent.$.messager.alert('提示信息', '短信类型不能为空', 'success');
		  return;
	  }
	  if(bussinessType==null||""==bussinessType){
		  $('#bussinessType').focus();
		  parent.$.messager.alert('提示信息', '业务类型不能为空', 'success');
		  return;
	  }
	  var datas ='?WIDbatch_no='+WIDbatch_no+'&WIDbatch_num='+WIDbatch_num+'&WIDdetail_data='+WIDdetail_data;
	  if(messageType=="unmessage"&&bussinessType=="sc"){
		  urlDownload = '${ctx}/jsp/refund/alipayapiUnmessageCart.jsp';//请求生成
	  }else if(messageType=="unmessage"&&bussinessType=="zx"){
		  urlDownload = '${ctx}/jsp/refund/alipayapiUnmessageSeat.jsp';//请求生成
	  }else if(messageType=="withmessage"&&bussinessType=="sc"){
		  urlDownload = '${ctx}/jsp/refund/alipayapiWithmessageCart.jsp';//请求生成
	  }else if(messageType=="withmessage"&&bussinessType=="zx"){
		  urlDownload = '${ctx}/jsp/refund/alipayapiWithmessageSeat.jsp';//请求生成
	  }
	  window.open(encodeURI(urlDownload+datas));
}
function setWIDbatch_no(){
var WIDbatch_no = document.getElementById("WIDbatch_no");
//设定时间格式化函数
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
  WIDbatch_no.value = new Date().format("yyyyMMddhhmmss")+Math.floor((Math.random()*100000));
}
</script>
</head>
<body onload="setWIDbatch_no()">
<form id="queryform" name="queryform" method="post" action="http://125.97.241.20:9088/paymanager/feedback/export">
				<table>
					<tr>
						<td>
						  短信类型:
					   <select class="easyui-combobox" id="messageType" name='messageType'  label="State:" labelPosition="top" style="width:150px;" >
					   			 <option value="unmessage" selected="selected">无短信</option>
                      			 <!-- <option value="withmessage">有短信</option> 不支退款-->
				       </select>
						  业务类型:
					   <select class="easyui-combobox" id="bussinessType" name='bussinessType'  label="State:" labelPosition="top" style="width:150px;" >
					   			 <option value="zx" >座选升舱</option>
                      			 <option value="sc" selected="selected">商城</option>
				       </select>
						<a href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px" onclick="refundFun()" style="height: 20px;color: #76C27A" >退款</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
						</td>
					</tr>
				</table>
				<table class="grid" id="datalist2" data-options="fit:true,border:false">
					<tr>
					  <td style="width: 150px">支付宝交易号</td><td>
					  <input type="hidden"   name="WIDbatch_no" id="WIDbatch_no"/>
					   <input type="hidden"   name="WIDbatch_num" id="WIDbatch_num" value="1"/>
					  <input name="tradeNo" value="" id="tradeNo" style="width: 230px;height: 100%"   type="text" placeholder="请输入支付宝交易号" class="easyui-validatebox span2" data-options="required:true" >
					  </td>
					</tr>
					<tr>
					  <td style="width: 150px">退款金额</td><td><input name="totalMoney" id="totalMoney" value="" style="width: 230px;height: 100%"   type="text" placeholder="请输入退款金额 例如：0.01" class="easyui-validatebox span2" data-options="required:true" value=""></td>
					</tr>
					<tr>
					  <td style="width: 150px">退款原因</td><td><input name="refundReason" id="refundReason" value="" style="width: 230px;height: 100%"   type="text" placeholder="退款原因 例如：协商退款" class="easyui-validatebox span2" data-options="required:true" value=""></td>
					</tr>
				</table>
				
			</form>
</body>
</html>