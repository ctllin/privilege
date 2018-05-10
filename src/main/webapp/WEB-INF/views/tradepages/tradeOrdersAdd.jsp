<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		$('#addFormId').form({
			url : '${pageContext.request.contextPath}/portalpay/tradeOrders/add',
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
<div class="easyui-layout" data-options="fit:true,border:false" >
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
		<form id="addFormId" method="post"><!-- id 不可以为addFrom   -->
			<table class="grid">
				<tr>
					<td>订单号</td>
					<td colspan="3">
					 <input name="orderNumber"  style="width: 300px;" type="text" placeholder="请输入订单号" class="easyui-validatebox span2" data-options="required:true" value='000000'>
					 <input name="refundAmount"  style="width: 300px;" type="hidden" value="0"/>
					 <input name="ip" type="hidden" value="103.235.230.216"/>
					</td>
				</tr>
				<tr>
					<td>买家姓名</td>
					<td><input name="buyerName" type="text" placeholder="请输入姓名" class="easyui-validatebox span2" data-options="required:true" ></td>
					<td>买家电话</td>
					<td><input name="buyerTelephone" type="text" placeholder="请输入电话" class="easyui-validatebox span2" data-options="required:true" ></td>
				</tr>
				<tr>
					<td>买家邮箱</td>
					<td><input name="buyerEmail" type="text" placeholder="请输入订购邮箱" class="easyui-validatebox span2"  ></td>
					<td>收货地址</td>
					<td><input name="address" type="text" placeholder="请输入收货地址" class="easyui-validatebox span2" data-options="required:true" ></td>
				</tr>
				<tr>
					<td>身份证号</td>
					<td colspan="3"><input name="idCard" style="width: 300px;"  type="text" placeholder="请输入身份证号" class="easyui-validatebox span2"  ></td>
				</tr>
				<tr>
					<td>支付方式</td>
					<td>
						 <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='paytype' id='paytype'>
				                <option value="4">支付宝</option>
				                <option value="1">新生支付</option>
				                <option value="2">微信支付</option>
				                <option value="3">机上刷卡</option>
				       </select>
					</td>
					<td>支付结果</td>
					<td>
					   <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='payStatus' id='payStatus'>
				                <option value="0">未支付</option>
				                <option value="1">支付成功</option>
				                <option value="2">支付失败</option>
				                <option value="3">已经退款</option>
				                <option value="4">订单作废</option>
				       </select>
					</td>
				</tr>
				<tr>
					<td>航空公司</td>
					<td>
						<select id="orderFrom" name="orderFrom" class="easyui-combobox" data-options="editable:false,panelHeight:'auto'">
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
					<td>支付金额</td>
					<td><input name="totalAmount" type="text" placeholder="请输入支付金额(支付金额=优惠前金额-优惠金额)优惠金额包含乐豆等" class="easyui-validatebox span2" data-options="required:true" ></td>
				</tr>
				<tr>
					<td>优惠金额</td>
					<td><input name="discountAmount" type="text" placeholder="请输入优惠金额" class="easyui-validatebox span2" data-options="required:true" ></td>
					<td>优惠前金额</td>
					<td><input name="undiscountableAmount" type="text" placeholder="请输入优惠前金额" class="easyui-validatebox span2" data-options="required:true" ></td>
				</tr>
				<tr>
					<td>收货人姓名</td>
					<td><input name="consigneeName" type="text" placeholder="请输入收货人姓名" class="easyui-validatebox span2"></td>
					<td>收货人电话</td>
					<td><input name="consigneeTelephone" type="text" placeholder="请输入收货人电话" class="easyui-validatebox span2"></td>
				</tr>
				<tr>
					<td>航班号</td>
					<td><input name="flightNumber" type="text" placeholder="请输入航班号" class="easyui-validatebox span2" data-options="required:true" ></td>
					<td>航段</td>
					<td><input name="flightPhase" type="text" placeholder="请输入航段" class="easyui-validatebox span2" data-options="required:true" ></td>
				</tr>
				<tr>
					<td>备注</td>
					<td colspan="3"><textarea style="width: 400px;"  name="memo" rows="6" cols="" placeholder="最多两百个汉字" class="easyui-validatebox span2"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>