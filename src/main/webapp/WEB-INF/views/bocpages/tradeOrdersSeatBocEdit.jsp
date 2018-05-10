<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(function() {
		
		$('#editForm').form({
			url : '${ctx}/boc/tradeOrdersSeatBoc/edit',//编辑后保存地址
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
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<form id="editForm" method="post">
			<table class="grid">
				<tr>
					<td style="width: 30%">地址</td>
					<td><input name="id" type="hidden"  value="${beanData.id}">
					    <input name="address" style="width: 70%;height: 100%"   type="text" placeholder="请输入address" class="easyui-validatebox span2" data-options="required:true" value="${beanData.address}"  >
					 </td>
				</tr>
				<tr>
					<td style="width: 30%">乘客姓名</td>
					<td>
					    <input name="passengerName" style="width: 70%;height: 100%"   type="text" placeholder="请输入乘客姓名" class="easyui-validatebox span2" data-options="required:true" value="${beanData.passengerName}" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">类型</td>
					<td>
					    <input name="type" style="width: 70%;height: 100%"   type="text" placeholder="请输入类型" class="easyui-validatebox span2" data-options="required:true" value="${beanData.type}" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">出发地</td>
					<td>
					    <input name="original" style="width: 70%;height: 100%"   type="text" placeholder="请输入出发地" class="easyui-validatebox span2" data-options="required:true" value="${beanData.original}" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">目的地</td>
					<td>
					    <input name="destination" style="width: 70%;height: 100%"   type="text" placeholder="请输入目的地" class="easyui-validatebox span2" data-options="required:true" value="${beanData.destination}" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">发票抬头</td>
					<td>
					    <input name="invoiceTitle" style="width: 70%;height: 100%"   type="text" placeholder="请输入发票抬头" class="easyui-validatebox span2"  value="${beanData.invoiceTitle}" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">发票名称</td>
					<td>
					    <input name="invoiceName" style="width: 70%;height: 100%"   type="text" placeholder="请输入发票名称" class="easyui-validatebox span2"  value="${beanData.invoiceName}" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">发票地址</td>
					<td>
					    <input name="invoiceAddress" style="width: 70%;height: 100%"   type="text" placeholder="请输入发票地址" class="easyui-validatebox span2"  value="${beanData.invoiceAddress}" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">乘务长姓名</td>
					<td>
					    <input name="purserName" style="width: 70%;height: 100%"   type="text" placeholder="请输入乘务长姓名" class="easyui-validatebox span2" data-options="required:true" value="${beanData.purserName}" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">乘务长电话</td>
					<td>
					    <input name="purserCellphone" style="width: 70%;height: 100%"   type="text" placeholder="请输入乘务长电话 " class="easyui-validatebox span2" data-options="required:true" value="${beanData.purserCellphone}" >
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>