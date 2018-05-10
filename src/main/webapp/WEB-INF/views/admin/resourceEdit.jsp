<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	

	$(function() {
		
		$('#pid').combotree({
			url : '${ctx}/resource/tree',
			parentField : 'pid',
			lines : true,
			panelHeight : 'auto',
			value : '${resource.pid}'
		});
		
		$('#resourceEditForm').form({
			url : '${pageContext.request.contextPath}/resource/edit',
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
					parent.$.messager.alert('提示信息', result.msg, 'info');
					parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为resource.jsp页面预定义好了
					parent.layout_west_tree.tree('reload');
					parent.$.modalDialog.handler.dialog('close');
				}else{
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
		
		$("#cstate").val('${resource.cstate}');
		$("#resourcetype").val('${resource.resourcetype}');
		$("#hasChild").val('${resource.hasChild}');
		$("#icon").val('${resource.icon}');
	});
</script>
<div style="padding: 3px;">
	<form id="resourceEditForm" method="post">
		<table  class="grid">
			<tr>
				<td>资源名称</td>
				<td><input name="id" type="hidden"  value="${resource.id}" >
				<input name="name" type="text" placeholder="请输入资源名称" value="${resource.name}" class="easyui-validatebox span2" data-options="required:true" ></td>
				<td>资源类型</td>
				<td><select id="resourcetype" name="resourcetype" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
							<option value="0">菜单</option>
							<option value="1">按钮</option>
				</select></td>
			</tr>
			<tr>
				<td>资源路径</td>
				<td><input name="url" type="text" value="${resource.url}" placeholder="请输入资源路径" class="easyui-validatebox span2" ></td>
				<td>排序</td>
				<td><input name="seq" value="${resource.seq}"  class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false"></td>
			</tr>
			<tr>
				<td>菜单图标</td>
				<td ><%-- <input  name="icon" value="${resource.icon}"/> --%>
				<select id="icon" name="icon" value='${resource.icon}' class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
							<option value="icon-company">icon-company</option>
							<option value="icon-folder">icon-folder</option>
							<option value="icon-btn">icon-btn</option>
				</select>
				
				</td>
				<td>状态</td>
				<td ><select id="cstate" name="cstate" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
							<option value="0">正常</option>
							<option value="1">停用</option>
				</select></td>
			</tr>
			<tr>
				<td>上级资源</td>
				<td colspan="3"><select id="pid" name="pid" style="width: 200px; height: 29px;"></select>
				<a class="easyui-linkbutton" href="javascript:void(0)" onclick="$('#pid').combotree('clear');" >清空</a></td>
			</tr>
			<tr>
				<td>描述</td>
				<td><input name="description" type="text" value="${resource.description}" placeholder="请输入描述" class="easyui-validatebox span2" data-options="width:140,height:29" ></td>
				<td>是否有子节点</td>
				<td ><select id="hasChild" name="hasChild" value="${resource.hasChild}"  class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
							<option value="0">关闭</option>
							<option value="1">展开</option>
				</select></td>
			</tr>
		</table>
	</form>
</div>
