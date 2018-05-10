<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(function() {
		
		$('#editForm').form({
			url : '${ctx}/portalpay/tradeOrders/editLogistics',//编辑后保存地址
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
					<td>商品订单号</td>
					<td><input name="orderId" type="hidden"  value="${beanData.orderId}">
					<input name="orderNumber" style="width: 70%;height: 100%"   type="text" placeholder="请输入商品订单号" class="easyui-validatebox span2" data-options="required:true" value="${beanData.orderNumber}"  readOnly="true" ></td>
				</tr>
				<tr>
					<td>物流单号</td>
					<td><input name="logisticsId" style="width: 70%;height: 100%"   type="text" placeholder="请输入物流单号" class="easyui-validatebox span2" data-options="required:true" value="${beanData.logisticsId}"></td>
				</tr>
				<tr>
					<td>物流公司</td>
					<td><input name="logisticsCompany" style="width: 70%;height: 100%"   type="text" placeholder="请输入物流公司" class="easyui-validatebox span2" data-options="required:true" value="${beanData.logisticsCompany}"></td>
				</tr>
				<tr>
					<td>发货日期</td>
					<td><input name="sendtime" id="sendtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" value="${beanData.sendtime}" /></td>
				</tr>
				<tr>
					<td>物流状态</td>
					<td>
						<select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='logisticsType' id='logisticsType'>
						<c:choose>
							<c:when test="${beanData.logisticsType eq '0'}">
								<option value="0" selected="selected">未发货</option>
							</c:when>
							<c:otherwise>
								<option value="0">未发货</option>
							</c:otherwise>
						</c:choose>
				 		<c:choose>
							<c:when test="${beanData.logisticsType == '1'}">
								<option value="1" selected="selected">已发货</option>
							</c:when>
							<c:otherwise>
								<option value="1">已发货</option>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${beanData.logisticsType == '2'}">
								<option value="2" selected="selected">已收货</option>
							</c:when>
							<c:otherwise>
								<option value="2">已收货</option>
							</c:otherwise>
						</c:choose>
							
					</select>
					</td>
				</tr>
				<tr>
					<td>备注</td>
					<td colspan="3"><textarea name="memo" rows="" cols="">${beanData.memo}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>