<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(function() {
		$('#refundForm').form({
			url : '${ctx}/alipay/refundRecordZfb/refundDo',//编辑后保存地址
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
						<input name="out_trade_no" id="out_trade_no"  type="text" placeholder="请输入订单号" style="width: 70%;height: 100%"   class="easyui-validatebox" data-options="required:true" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">退款金额</td>
					<td>
						<input name="refund_fee" id="refund_fee" type="text" placeholder="请输入退款金额 例如:0.01" style="width: 50%;height: 100%" class="easyui-validatebox" data-options="required:true" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">退款原因</td>
					<td>
						<input name="refund_reason" id="refund_reason" type="text" placeholder="请输入退款原因 例如:协商退款" style="width: 50%;height: 100%" class="easyui-validatebox" data-options="required:true" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">规格编号</td>
					<td>
						<input name="goodsId" id="goodsId" type="text" placeholder="请输入退款商品规格编号" style="width: 50%;height: 100%" class="easyui-validatebox" data-options="required:true" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">公司</td>
					<td>
						<input name="company" id="company" type="text" placeholder="请输入公司代码" style="width: 70%;height: 100%" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">短信类型</td>
					<td>
 						<select class="easyui-combobox" id="messageType" name='messageType'  label="State:" labelPosition="top" style="width:150px;" >
                      			 <option value="1" selected="selected">无短信</option>
                      			 <!-- <option value="2">有短信</option> -->
				       </select>					
				     </td>
				</tr>
				<tr>
					<td style="width: 30%">业务类型</td>
					<td>
 						<select class="easyui-combobox" id="bussinessType" name='bussinessType'  label="State:" labelPosition="top" style="width:150px;" >
                      			 <option value="1" selected="selected">商城</option>
                      			 <option value="2">座选升舱</option>
				       </select>					
				     </td>
				</tr>
			</table>
		</form>
	</div>
</div>