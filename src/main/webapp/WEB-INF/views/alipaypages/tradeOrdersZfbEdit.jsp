<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(function() {
		
		$('#editForm').form({
			url : '${ctx}/alipay/tradeOrdersZfb/edit',//编辑后保存地址
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
		$("#airCompany").val('${beanData.airCompany}');//select option回显
		$("#paystatus").val('${beanData.paystatus}');//select option回显
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<form id="editForm" method="post">
			<table class="grid">
				<tr>
					<td style="width: 30%">订单号</td>
					<td><input name="id" type="hidden"  value="${beanData.id}">
					<input name="outTradeNo" type="text" placeholder="请输入名称" style="width: 70%;height: 100%"  disabled="true"　readOnly="true" class="easyui-validatebox" data-options="required:true" value="${beanData.outTradeNo}"></td>
				</tr>
				<tr>
					<td>邮箱地址</td>
					<td colspan="3"><input id="email" name="email"  value='${beanData.email}' style="width: 70%;height: 100%"></input></td> 
					<!-- <td colspan="3"><textarea id="description" name="description" rows="" cols="" ></textarea></td> -->
				</tr>
				<tr>
				<td>支付结果</td>
					<td colspan="3">
					   <select class="easyui-combobox" value="${beanData.paystatus}"  label="State:" labelPosition="top" style="width:100px;" name='paystatus' id='paystatus'>
					   			<option value="">全部</option>
				                <option value="0">未支付</option>
				                <option value="1">支付成功</option>
				                <option value="2">支付失败</option>
				                <option value="3">已经退款</option>
				                <option value="4">订单作废</option>
				       </select>
				    </td> 
					<!-- <td colspan="3"><textarea id="description" name="description" rows="" cols="" ></textarea></td> -->
				</tr>
				<tr><td>航渠</td>
					<td><select name="airCompany" id="airCompany" value="${beanData.airCompany}" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
							<option value="HU">HU</option>
							<option value="IU">IU</option>
							<option value="SU">SU</option>
							<option value="JD">JD</option>
							<option value="JP">JP</option>
							<option value="GS">GS</option>
							<option value="Y8">Y8</option>
							<option value="GT">GT</option>
							<option value="HD">HD</option>
							<option value="9H">9H</option>
							<option value="BK">8L</option>
							<option value="8L">8L</option>
					</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>