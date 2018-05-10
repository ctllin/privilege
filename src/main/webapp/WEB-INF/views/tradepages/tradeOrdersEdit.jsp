<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	$(function() {

		$('#editForm').form({
			url : '${ctx}/portalpay/tradeOrders/edit',//编辑后保存地址
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
		$("#payStatus").val('${beanData.payStatus}');//select option回显
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title=""
		style="overflow: hidden;padding: 3px;">
		<form id="editForm" method="post">
			<table class="grid">
			<tr>
					<td style="width: 30%;">退款金额(分)</td>
					<td>
						<input name="refundAmount" type="text" placeholder="请输入退款金额单位是分" style="width: 70%;height: 100%"  class="easyui-validatebox"  value="${beanData.refundAmount}">
					</td>
					<!-- <td colspan="3"><textarea id="description" name="description" rows="" cols="" ></textarea></td> -->
				</tr>
				<tr>
					<td>支付结果</td>
					<td><input name="id" type="hidden" value="${beanData.id}"> <select class="easyui-combobox" value="${beanData.payStatus}" label="State:" labelPosition="top" style="width:100px;" name='payStatus' id='payStatus'>
							<option value="">全部</option>
							<option value="0">未支付</option>
							<option value="1">支付成功</option>
							<option value="2">支付失败</option>
							<option value="3">已经退款</option>
							<option value="4">订单作废</option>
					</select></td>
					<!-- <td colspan="3"><textarea id="description" name="description" rows="" cols="" ></textarea></td> -->
				</tr>
				<tr>
					<td>备注</td>
					<td><textarea  name="memo" id="memo" rows="5" cols="40" placeholder="请输备注内容" class="easyui-validatebox"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>