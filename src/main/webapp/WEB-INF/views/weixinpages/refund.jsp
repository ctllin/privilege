<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(function() {
		
		$('#refundForm').form({
			url : '${ctx}/weixin/refund/refundDo',//编辑后保存地址
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
					parent.$.messager.alert('提示信息', result.msg, 'info');
					parent.$.modalDialog.handler.dialog('close');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<form id="refundForm" method="post">
			<table class="grid">
				<tr>
					<td style="width: 30%">订单号</td>
					<td><%-- <input name="id" type="hidden"  value="${beanData.id}"> --%>
						<input value="" name="orderNumber" id="orderNumber"  type="text" placeholder="请输入订单号" class="easyui-validatebox span2" data-options="required:true" style="width: 70%;height: 100%" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">规格编号</td>
					<td><%-- <input name="id" type="hidden"  value="${beanData.id}"> --%>
						<input value="" name="goodsId" id="goodsId"  type="text" placeholder="请输入规格编号" class="easyui-validatebox span2"  data-options="required:true">
					</td>
				</tr>
				<tr>
					<td style="width: 30%">支付金额<label style="color: red">(分)</label>:</td>
					<td>
						<input  value="" name="total_fee" id="total_fee"   type="text" placeholder="请输入支付金额" class="easyui-validatebox span2" data-options="required:true">
					</td>
				</tr>
				<tr>
					<td style="width: 30%">退款金额<label style="color: red">(分)</label>:</td>
					<td>
					    <input  value=""  name="refund_fee" id="refund_fee"  type="text" placeholder="请输入退款金额" class="easyui-validatebox span2" data-options="required:true">
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>