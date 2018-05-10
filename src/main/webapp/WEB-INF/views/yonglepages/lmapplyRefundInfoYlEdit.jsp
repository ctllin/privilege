<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(function() {
		
		$('#editForm').form({
			url : '${ctx}/yongle/lmapplyRefundInfoYl/edit',//编辑后保存地址
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
	$("#status").val('${beanData.status}');//select option回显
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<form id="editForm" method="post">
			<table class="grid">
				<tr>
					<td style="width: 30%">退款标志</td>
					<td><input name="id" type="hidden"  value="${beanData.id}">
					 <select class="easyui-combobox" value="${beanData.status}"  label="State:" labelPosition="top" style="width:100px;" name='status' id='status'>
					   			<option value=""></option>
				                <option value="0">未退款</option>
				                <option value="1">退款已经提交</option>
				                <option value="2">退款成功</option>
				                <option value="3">退款失败</option>
				       </select>
				</tr>
			</table>
		</form>
	</div>
</div>