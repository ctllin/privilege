<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		$('#addFormId').form({
			url : '${pageContext.request.contextPath}/common/souhuVideo/add',
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
					<td>订单号</td>
					<td><input name="orderNumber" style="width: 80%;height: 100%"   type="text" placeholder="请输入订单号" class="easyui-textbox" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>用户姓名</td>
					<td><input name="userName" style="width: 80%;height: 100%"   type="text" placeholder="请输入用户姓名" class="easyui-textbox" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>手机号码</td>
					<td><input name="telePhone" style="width: 80%;height: 100%"   placeholder="请输入手机号码" class="easyui-numberbox" max="19999999999" data-options="required:true" value=""></td>
				</tr>
			</table>
		</form>
	</div>
</div>