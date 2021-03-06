<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(function() {
		
		$('#editForm').form({
			url : '${ctx}/portalpay/portalpayOrder/edit',//编辑后保存地址
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
		$("#paystatus").val('${beanData.payStatus}');//select option回显
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<form id="editForm" method="post">
			<table class="grid">
				<tr>
					<td style="width: 30%">订单号</td>
					<td><input name="id" type="hidden"  value="${beanData.id}">
					<input name="orderNumber" style="width: 70%;height: 100%"   type="text" placeholder="请输入商品订单号" class="easyui-validatebox span2" data-options="required:true" value="${beanData.orderNumber}"  readOnly="true" ></td>
				</tr>
				<tr>
					<td style="width: 30%">物流单号</td>
					<td>
						<input name="logisticsId" style="width: 70%;height: 100%"   type="text" placeholder="请输入物流单号" class="easyui-validatebox span2"  value="${beanData.logisticsId}"  readOnly="true" >
					</td>
				</tr>
				<%-- <tr>
					<td>邮箱地址</td>
					<td colspan="3"><input id="email" name="email"  value='${beanData.purserEmail}' style="width: 70%;height: 100%"></input></td> 
					<!-- <td colspan="3"><textarea id="description" name="description" rows="" cols="" ></textarea></td> -->
				</tr> --%>
				<tr>
				<td>支付结果</td>
					<td colspan="3">
					   <select class="easyui-combobox" value="${beanData.payStatus}" label="State:" labelPosition="top" style="width:100px;" name='paystatus' id='paystatus'>
					   			<option value="">全部</option>
				                <option value="0">已经接受</option>
				                <option value="1">处理中</option>
				                <option value="2">支付成功</option>
				                <option value="3">支付失败</option>
				                <option value="4">已经退款</option>
				       </select>
				    </td> 
					<!-- <td colspan="3"><textarea id="description" name="description" rows="" cols="" ></textarea></td> -->
				</tr>
			</table>
		</form>
	</div>
</div>