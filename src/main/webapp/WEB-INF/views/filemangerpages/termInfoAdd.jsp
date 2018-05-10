<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		$('#addFormId').form({
			url : '${pageContext.request.contextPath}/filemanager/termInfo/add',
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
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
		<form id="addFormId" method="post"><!-- id 不可以为addFrom   -->
			<table class="grid">
				<tr>
					<td>序列号</td>
					<td><input name="serial" type="text" placeholder="请输入序列号" class="easyui-validatebox span2" data-options="required:true" value=""  style="width: 70%;height: 100%" ></td>
				</tr>	<tr>
					<td>设备编号</td>
					<td><input name="termId" type="text" placeholder="请输入设备编号" class="easyui-validatebox span2" data-options="required:true" value=""  style="width: 70%;height: 100%" ></td>
				</tr>
				<tr>
					<td>mac地址</td>
					<td><input name="mac" type="text" placeholder="请输入mac地址" class="easyui-validatebox span2" data-options="required:true" value=""  style="width: 70%;height: 100%" ></td>
				</tr>	<tr>
					<td>mpos编号</td>
					<td><input name="mposId" type="text" placeholder="请输入mpos编号" class="easyui-validatebox span2" data-options="required:true" value=""  style="width: 70%;height: 100%" ></td>
				</tr>
				<tr>
					<td>基地名称</td>
					<td><input name="cityName" type="text" placeholder="请输入基地名称" class="easyui-validatebox span2" data-options="required:true" value=""  style="width: 70%;height: 100%" ></td>
				</tr>	<tr>
					<td>程序版本</td>
					<td><input name="apkVersionName" type="text" placeholder="请输入程序版本" class="easyui-validatebox span2" data-options="required:true" value=""  style="width: 70%;height: 100%" ></td>
				</tr>
				<tr>
					<td>航渠版本</td>
					<td><select name="airVersionName" >
							   <option value ="HU">股份</option>
							   <option value ="Y8">扬子江</option>
							   <option value="JD">首航</option>
							   <option value="9H">长安航</option>
							   <option value="GT">桂林航</option>
							   <option value="8L">祥鹏</option>
							   <option value="TEST" selected="selected">测试使用</option>
						   </select></td>
				</tr>	<tr>
					<td>mpos版本</td>
					<td><input name="mposVersion" type="text" placeholder="请输入mpos版本" class="easyui-validatebox span2" data-options="required:true" value=""  style="width: 70%;height: 100%" ></td>
				</tr>
				<tr>
					<td>派发原因</td>
					<td><input name="sendReason" type="text" placeholder="请输入派发原因" class="easyui-validatebox span2" data-options="required:true" value=""  style="width: 70%;height: 100%" ></td>
				</tr>	<tr>
					<td>派发日期</td>
					<td><input name="sendtimeStr" id="sendtimeStr" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" /></td>
				</tr>
			</table>
		</form>
	</div>
</div>