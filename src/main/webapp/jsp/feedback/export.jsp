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
function exportFun(){
      var urlDownload = 'http://api.xilehang.cn/feedback/feedback/exportnew';//请求生成excel地址
      	  //urlDownload = 'http://122.14.61.21:9088/paymanager/feedback/exportnew';//请求生成excel地址
          //urlDownload='http://localhost:8080/Feedback/feedback/exportnew';
	  var exportType=$('#exportType').combobox('getValue');//easyui 获取选中值 报表类型： 座选 、商城
	  var airCompany=$('#airCompany').combobox('getValue');//easyui 获取选中值  航空公司：HU、Y8
	  //var dataType=$('#dataType').combobox('getValue');//easyui 获取选中值 数据类型：  正式、测试、全部
	  //var payType=$('#payType').combobox('getValue');//easyui 获取选中值  支付方式：支付宝、代扣
	  var begintime=$('#begintime').val();
	  var endtime=$('#endtime').val();
	  if(begintime==null||""==begintime){
		  $('#begintime').focus();
		  parent.$.messager.alert('提示信息', '开始时间不能为空', 'success');
		  return;
	  }
	  if(endtime==null||""==endtime){
		  $('#endtime').focus();
		  parent.$.messager.alert('提示信息', '至时间不能为空', 'success');
		  return;
	  }
	  if(airCompany==null||""==airCompany){
		  $('#airCompany').focus();
		  parent.$.messager.alert('提示信息', '航空公司不能为空,请选中并点击航空公司', 'success');
		  return;
	  }
	  if(exportType==null||""==exportType){
		  $('#exportType').focus();
		  parent.$.messager.alert('提示信息', '报表类型不能为空,请选中并点击报表类型', 'success');
		  return;
	  }
	  var start = new Date(begintime.replace("-", "/").replace("-", "/"));
      var end = new Date(endtime.replace("-", "/").replace("-", "/"));
      if (end < start) {
          parent.$.messager.alert('提示信息', '结束日期不能小于开始日期！', 'success');
          return;
      }else{
    	  var diff = parseInt((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24)); //天数
    	  if(diff>31){
    		  parent.$.messager.alert('提示信息', '请选择一个月以内数据！', 'success');
              return;
    	  }
      }
      begintime+=' 00:00:00';
      endtime+=' 23:59:59';
	  //var datas = '?exportType='+exportType+'&begintime='+begintime+'&endtime='+endtime+'&airCompany='+airCompany+'&dataType='+dataType+"&payType="+payType;
	  // window.open(urlDownload+datas,'','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
	  //window.navigate(urlDownload+datas);
	 // window.open(urlDownload+datas);
	 /*  document.getElementById("queryform").action=urlDownload+datas;
	  alert(document.getElementById("queryform").action);
	  document.getElementById("queryform").submit();
	  document.getElementById("queryform").disabled=true; */
     //URLDecoder.decode(request.getQueryString(),"utf-8");才能获取参数
	 // $("#export").attr('disabled',true);  
	  //$('#queryform').attr("action", urlDownload+datas).submit();
	  $('#queryform').attr("action", urlDownload).submit();

}

function initDateTime(){
	var date = new Date(); 
    var seperator1 = "-"; 
   // var seperator2 = ":"; 
    var month = date.getMonth() + 1; 
    var strDate = date.getDate(); 
    if (month >= 1 && month <= 9) { 
        month = "0" + month; 
    } 
    if (strDate >= 0 && strDate <= 9) { 
        strDate = "0" + strDate; 
    } 
    /* var getHours=date.getHours();
    if(getHours<10){
    	getHours = "0" + getHours; 
    }
    var getMinutes=date.getMinutes() ;
    if(getMinutes<10){
    	getMinutes = "0" + getMinutes; 
    }
    var getSeconds=date.getSeconds();
    if(getSeconds<10){
    	getSeconds = "0" + getSeconds; 
    } */
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate ;
          /*   + " " + getHours + seperator2 + getMinutes 
            + seperator2 + getSeconds;  */
	document.getElementById("endtime").value=currentdate;
    date.setMonth(date.getMonth()-1); 
    strMonth = date.getMonth()+1;
	if (strMonth >= 0 && strMonth <= 9) { 
		strMonth = "0" + strMonth; 
	} 
	strDate = date.getDate();
	if (strDate >= 0 && strDate <= 9) { 
	        strDate = "0" + strDate; 
	} 
	currentdate = date.getFullYear() + seperator1 + strMonth + seperator1 + strDate; 
    /*  + " " + getHours + seperator2 + getMinutes 
     + seperator2 + getSeconds;  */
	document.getElementById("begintime").value=currentdate;
}

</script>
</head>
<body onload="initDateTime()">
<form id="queryform" name="queryform" method="post" action="http://125.97.241.20:9088/paymanager/feedback/export">
				<table>
					<tr>
						<th>开始时间:</th>
						<td>
						<input name="begintime" id="begintime"   placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  readonly="readonly" />至
						<input  name="endtime"  id="endtime"   placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"   readonly="readonly" />
						<c:choose>
					        <c:when test="${fn:contains(sessionInfo.resourceList, '/jsp/feedback/airCompany')}">
							 	&nbsp;&nbsp;航空公司:<select id="airCompany" name="airCompany" class="easyui-combobox" data-options="editable:false,panelHeight:'auto'">
								<option value="ALL" selected="selected">全部</option>
								<option value="HU">HU</option>
								<option value="IU">IU</option>
								<option value="SU">SU</option>
								<option value="JD">JD</option>
								<option value="JP">JP</option>
								<option value="GS">GS</option>
								<option value="Y8">Y8</option>
								<option value="GT">GT</option>
								<option value="HD">HD</option>
								<option value="9H">9H</option>
								<option value="BK">8L</option>
								<option value="8L">8L</option>
								</select>
								<!-- 电商用户 -->
								<input type="hidden" id="userType" name="userType" value="dsuser"/>
							</c:when>
							<c:otherwise>
								&nbsp;&nbsp;航空公司:<select id="airCompany" name="airCompany" class="easyui-combobox" data-options="editable:false,panelHeight:'auto'">
									<option value="${sessionInfo.airCompany}" selected="selected">${sessionInfo.airCompany}</option>
								</select>
								<!-- 航司用户 -->
								<input type="hidden" id="userType" name="userType" value="airuser"/>
							</c:otherwise>
						</c:choose>
						 <c:choose>
						 <c:when test="${fn:contains(sessionInfo.resourceList, '/jsp/feedback/exportType')}">
						 	 &nbsp;&nbsp;报表类型:<select class="easyui-combobox" id="exportType" name='exportType'  label="State:" labelPosition="top" style="width:150px;" >
						   		<option value="zx">座选升舱财务对账表</option>
	                      		<option value="cw" selected="selected">商城财务对账表</option>
					       </select>
						 </c:when>
						 <c:otherwise>
							&nbsp;&nbsp;报表类型:<select class="easyui-combobox" id="exportType" name='exportType'  label="State:" labelPosition="top" style="width:150px;" >
	                      		<option value="cw" selected="selected">商城财务对账表</option>
					       </select>
							</c:otherwise>
						 </c:choose>
						&nbsp;&nbsp;支付方式:
					   <select class="easyui-combobox" id="payType" name='payType'  label="State:" labelPosition="top" style="width:150px;" >
					   			 <option value="0" selected="selected">全部</option>
                      			 <option value="1">新生支付</option>
                      			 <option value="2">微信支付</option>
                      			 <option value="3">POS机刷卡</option>
                      			 <option value="4">支付宝支付</option>
				       </select>
						&nbsp;&nbsp;数据:
					   <select class="easyui-combobox" id="dataType" name='dataType'  label="State:" labelPosition="top" style="width:150px;" >
					   			 <option value="0">全部数据</option>
                      			 <option value="1" selected="selected">正式数据</option>
                      			 <option value="2">测试数据</option>
				       </select>
						<a href="javascript:void(0);" id='export' name='export' class="easyui-linkbutton" data-options="iconCls:'icon-export',plain:true" onclick="exportFun()">导出</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
						</td>
					</tr>
				</table>
			</form>
</body>
</html>