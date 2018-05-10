<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/common/operateLog/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/operateLog/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/operateLog/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/common/operateLog/dataGrid',
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'id',
			sortName : 'savetime',
			sortOrder : 'desc',
			pageSize : 30,
			pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			columns : [ [ /* {
				width : '300',
				title : 'id',
				field : 'id',
				sortable : true
			}, */{
				width : '80',
				title : '登录名',
				field : 'loginName',
				/* formatter : function(value, row, index) {
					return '<a href="${ctx}/alipay/tradeCallbackSuccessZfb/manager?outTradeNo='+value+'&currow=0&rows=30&page=1&sort=savetime">'+value+'</a>';
				}, */
				sortable : true
			}, {
				width : '100',
				title : '姓名',
				field : 'name'
			}, {
				width : '100',
				title : '登录IP',
				field : 'loginIp'
			}, {
				width : '250',
				title : '操作地址',
				field : 'url'
			}, {
				width : '150',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 80,
				formatter : function(value, row, index) {
					var str = '&nbsp;';
				/* 	if ($.canView) {
						str += $.formatString('<a href="javascript:void(0)" onclick="viewFun(\'{0}\');" >查看</a>', row.id);
					}
					if ($.canEdit) {
				   		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					} */
					if ($.canDelete) {
						//str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	
	function deleteFun(id) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前记录？', function(b) {
			if (b) {
				progressLoad();
				$.post('${ctx}/common/operateLog/delete', {
					id : id
				}, function(result) {
					if (result.success) {
						parent.$.messager.alert('提示', result.msg, 'info');
						dataGrid.datagrid('reload');
					}
					progressClose();
				}, 'JSON');
			}
		});
	}
	
	
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	function exportFun(){
		//progressLoad();
		$.post('${ctx}/common/operateLog/export', {
			//id : id
			outTradeNo:$('#outTradeNo').val(),
			begintime:$('#begintime').val(),
			endtime:$('#endtime').val()
		}, function(result) {
			if (result.success) {
				parent.$.messager.alert('提示', result.msg, 'info');
				dataGrid.datagrid('reload');
			}
			progressClose();
		}, 'JSON');
	}
	function ftpServer(command){
		//progressLoad();
		$.post('${ctx}/common/ftpserver/manager', {
			//id : id
			command:command
		}, function(result) {
			if (result.success) {
				parent.$.messager.alert('提示', result.msg, 'info');
			}else{
				parent.$.messager.alert('提示', result.msg, 'error');
			}
			progressClose();
		}, 'JSON');
	}
	function commonQuartz(flag){
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath }/common/commonQuartz/update',
			//请求是key/value这里不需要指定contentType，因为默认就 是key/value类型
			//contentType:'application/json;charset=utf-8',
			//数据格式是json串，商品信息
			data:'flag='+flag,
			success:function(result){//返回json结果
				result = $.parseJSON(result);
				if(result.success){
					parent.$.messager.alert('提示', result.msg, 'info');
				}else{
					parent.$.messager.alert('提示', result.msg, 'error');

				}
			}
			
		});
		
	}
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false" onload="initDatetime()">

	<div data-options="region:'center',fit:true,border:false">
		<!--  此种写法当列过多时,无横向滚动条	
		<table id="dataGrid" data-options="fit:true,border:false"></table>
		 -->	
		 <!--  此种写法当列过多时,有横向滚动条	
       	<table id="dataGrid" data-options="fit:false,border:false" style="width: 2000px;"></table>
		 -->		
		<table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>
	<div id="toolbar" style="display: none;">
		<div>
			 <a onclick="ftpServer('start');" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A">启动ftp服务</a>
			 <a onclick="ftpServer('stop');" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A">关闭ftp服务</a>
 			 <a onclick="commonQuartz(0);" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A">启动sh</a>
 			 <a onclick="commonQuartz(1);" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A">关闭sh</a>
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>登录帐号:</th>
						<td><input name="loginName" id="loginName" placeholder="请输入登录帐号"/></td>
						<th>操作地址:</th>
						<td><input name="url" id="url" placeholder="请输入操作地址"/></td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>