<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmtjsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${ctx}/jslib/easyui1.4.2/themes/default/filebox.css">
<script src="${pageContext.request.contextPath}/jslib/jquery.form.js"></script> 
<script type="text/javascript">
$(function() {
	$('#uploadForm').form({
		url : '${pageContext.request.contextPath}/boc/txtUploadBoc/uploadDo',
		onSubmit : function() {
			progressLoad();
			var isValid = $(this).form('validate');
			if (!isValid) {
				progressClose();
			}
			return isValid;
		},
		success : function(result) {
			progressClose();
			result = $.parseJSON(result);
			if (result.success) {
				parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
				parent.$.modalDialog.handler.dialog('close');
				parent.$.messager.alert('提示信息', result.msg, 'info');
			} else {
				parent.$.messager.alert('错误', result.msg, 'error');
			}
		}
	});
});


function doUpload() {  
	$("#uploadForm").ajaxSubmit({  
	    type:"post",  //提交方式  
	    url:"${pageContext.request.contextPath}/filemanager/fileUpload/uploadFiles2", //请求url  
	    success:function(result){ //提交成功的回调函数  
	    	result = $.parseJSON(result);
			if (result.success) {
				//parent.$.modalDialog.openner_dataGrid.datagrid('reload');
				//parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
				parent.$.modalDialog.handler.dialog('close');
				parent.$.messager.alert('提示信息', result.msg, 'info');
			} else {
				//parent.$.messager.alert('错误', result.msg, 'error');
			}
	    }  
	});  
}
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
	<form  method="post" enctype="multipart/form-data" id="uploadForm" name="uploadForm">
		<table class="grid">
			<tr>
				<td style="width: 30%">交易日期:</td>
				<td ><input name="relativeTime" id="relativeTime" placeholder="点击选择交易日期" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly"   class="easyui-validatebox" data-options="required:true"/></td>
			</tr>
	        <tr>
				<td style="width: 30%">文件</td>
				<td>
					<input name="file"  class="easyui-filebox"  style="width: 70%;height: 100%"    data-options="required:true">
				</td>
			</tr>
		</table>
		</form>
	</div>
</div>
