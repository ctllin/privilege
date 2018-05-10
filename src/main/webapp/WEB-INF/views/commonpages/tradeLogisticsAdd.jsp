<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {
		$('#addFormId').form({
			url : '${pageContext.request.contextPath}/common/tradeLogistics/add',
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
					<td>商品订单号</td>
					<td><input name="orderNumber" style="width: 70%;height: 100%"   type="text" placeholder="请输入商品订单号" class="easyui-textbox" data-options="required:true" value=""></td>
				</tr>
				
				<tr>
					<td>规格编号</td>
					<td>
						<input type="text" class="easyui-numberbox" max="999999" id="goodsId" name="goodsId" style="width:150px;text-align:right;" data-options="required:true">
					</td>
				</tr>
				<tr>
					<td>供应商编号</td>
					<td>
						<input type="text" class="easyui-numberbox" max="999999" id=supplierId name="supplierId" style="width:150px;text-align:right;" data-options="required:true">
					</td>				
				<tr>
					<td>物流单号</td>
					<td><input name="logisticsId" style="width: 70%;height: 100%"   type="text" placeholder="请输入物流单号" class="easyui-textbox" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>物流公司</td>
					<td><input name="logisticsCompany" style="width: 70%;height: 100%"   type="text"   class="easyui-textbox" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<td>发货日期</td>
					<td><input name="sendtime" id="sendtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"  /></td>
				</tr>
				<tr>
					<td>物流状态</td>
					<td>
						<select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='logisticsType' id='logisticsType'>
				                <option value="0" selected="selected">未发货</option>
				                <option value="1">已发货</option>
				                <option value="2">已收货</option>
				       </select>
					</td>
				</tr>
				<tr>
					<td>备注</td>
					<td colspan="3"><textarea name="memo" rows="" cols="" ></textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>