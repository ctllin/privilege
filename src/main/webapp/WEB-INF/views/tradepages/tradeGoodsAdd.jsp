<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		$('#addFormId').form({
			url : '${pageContext.request.contextPath}/portalpay/tradeGoods/add',
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
					<td><input name="orderNumber" type="text" style="width: 90%" placeholder="请输入订单号" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>规格编号</td>
					<td><input name="goodsId" type="text" style="width: 90%"  placeholder="请输入规格编号" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>商品名称</td>
					<td><input name="goodsName" type="text" style="width: 90%"  placeholder="请输入订单号" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>商品规格</td>
					<td><input name="goodsSize" type="text" style="width: 90%"  placeholder="请输入商品规格" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>商品价格</td>
					<td><input name="price" type="text" style="width: 90%"  placeholder="请输入商品价格单位元0.01代表一分钱" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>购买数量</td>
					<td><input name="quantity" type="text" style="width: 90%"  placeholder="请输入购买数量" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>优惠金额</td>
					<td><input name="discountAmount" type="text" style="width: 90%"  placeholder="请输入优惠金额单位元0.01代表一分钱" class="easyui-validatebox span2"  value=""></td>
				</tr>
				<tr>
					<td>供应商编号</td>
					<td><input name="supplierguid" type="text" style="width: 90%"  placeholder="请输入供应商编号" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
			</table>
		</form>
	</div>
</div>