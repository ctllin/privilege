<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(function() {
		
		$('#editForm').form({
			url : '${ctx}/common/message/sendMess',//编辑后保存地址
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
		<form id="editForm" method="post">
			<table class="grid">
				<tr>
					<td style="width: 30%">订单号</td>
					<td><%-- <input name="id" type="hidden"  value="${beanData.id}"> --%>
						<input name="orderNumber" id="orderNumber"  type="text" placeholder="请输入订单号" style="width: 70%;height: 100%" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">手机号码</td>
					<td>
						<input name="mobile" id="mobile" type="text" placeholder="请输入手机号码,多个之间用英文','隔开" style="width: 70%;height: 100%"    class="easyui-validatebox" data-options="required:true" >
					</td>
				</tr>
				<tr>
					<td style="width: 30%">短信内容</td>
					<!-- <td colspan="3">
						<textarea name="content" id="content" rows="15" cols="60"  placeholder="请输短信内容" style="width: 70%;height: 100%" class="easyui-validatebox" data-options="required:true" />
					</td> -->
										<td colspan="3"><textarea  name="content" id="content" rows="15" cols="60" placeholder="请输短信内容" class="easyui-validatebox" data-options="required:true" ></textarea></td>
					
				</tr>
			</table>
		</form>
	</div>
</div>