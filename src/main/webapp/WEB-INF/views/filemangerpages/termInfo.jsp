<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jslib/echarts.min.js"></script>
 <c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/upload')}">
	<script type="text/javascript">
		$.canUpload = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/filemanager/termInfo/dataGrid',
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
				width : '100',
				title : '序列号',
				field : 'serial',
				sortable : true
			}, {
				width : '150',
				title : '设备编号',
				field : 'termId'
			}, {
				width : '130',
				title : 'mac地址',
				field : 'mac'
			}, {
				width : '100',
				title : '派发日期',
				field : 'sendtimeStr'
			}, {
				width : '90',
				title : '基地名称',
				field : 'cityName'
			}, {
				width : '80',
				title : '程序版本',
				field : 'apkVersionName'
			}, {
				width : '60',
				title : '航渠版本',
				field : 'airVersionName'
			}, {
				width : '100',
				title : 'mpos编号',
				field : 'mposId'
			}, {
				width : '80',
				title : 'mpos版本',
				field : 'mposVersion'
			}, {
				width : '200',
				title : '派发原因',
				field : 'sendReason'
			}, {
				width : '200',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 120,
				formatter : function(value, row, index) {
					var str = '&nbsp;';
					if ($.canView) {
						str += $.formatString('<a href="javascript:void(0)" onclick="viewFun(\'{0}\');" >查看</a>', row.id);
					}
					if ($.canEdit) {
				   		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					}
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
		
		
		
	});
	
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 450,
			height : 450,
			href : '${ctx}/filemanager/termInfo/addPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#addFormId');//对应tradeSeatorderZfbAdd.jsp的from  id
					f.submit();
				}
			} ]
		});
	}
	
	function addMacFun() {//添加mac地址
		parent.$.modalDialog({
			title : '添加',
			width : 450,
			height : 300,
			href : '${ctx}/filemanager/termInfo/addMacPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#addFormId');//对应tradeSeatorderZfbAdd.jsp的from  id
					f.submit();
				}
			} ]
		});
	}
	
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
				$.post('${ctx}/filemanager/termInfo/delete', {
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
	
	function editFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '编辑',
			width : 450,
			height : 450,
			href : '${ctx}/filemanager/termInfo/editPage?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#editForm');//对应tradeSeatorderZfbEdit.jsp的from  id
					f.submit();
				}
			} ]
		});
	}
	
	function viewFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		
		parent.$.modalDialog({
			title : '詳情',
			width : 800,//详情也面宽度
			height : 400,//详情页面高度
			href : '${ctx}/filemanager/termInfo/viewPage?id=' + id
		});
	}
	
	function uploadFun() {
		parent.$.modalDialog({
			title : '上传文件',
			width : 600,
			height : 300,
			href : '${ctx}/filemanager/termInfo/managerDo',
			buttons : [ {
				text : '上传',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#uploadForm');//对应.jsp的from  id
					f.submit();
				}
			} ]
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
	    var urlDownload = '${ctx}/filemanager/termInfo/export';//请求生成excel地址
		  var airVersionName=$('#airVersionName').combobox('getValue');//easyui 获取选中值
		  var termId=$('#termId').val();
		  var cityName=$('#cityName').val();
		  var mac=$('#mac').val();
		  var datas = '?termId='+termId+'&airVersionName='+airVersionName+'&cityName='+cityName+'&mac='+mac;
		  window.open(urlDownload+datas);
		/* $.ajax({
			url : urlDownload,
			data : datas,
			type : "post",
			async : "true",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			success : function(result) {
				window.open(result);//弹框下载 excel   后台通过response.getOutputStream() 写入excel
			},
			error : function() {
				alert("无法生成excel");
			}
		}); */
	}
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
 
	<div data-options="region:'center',fit:true,border:false">
	<!-- <div id="mainPie" style="width: 300px;height:200px;"></div> -->
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
			<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/export')}">
				<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px">导出</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/addMac')}">
				<a onclick="addMacFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px">添加mac</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/managerDo')}">
				<a onclick="uploadFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">上传</a>
			</c:if>
			
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>基地名称:</th>
						<td><input name="cityName" id="cityName" placeholder="请输入基地名称"/></td>
						<th>航渠:</th>
						<td>
						<!-- <input name="air_version" id="buyerName" placeholder="请输入航渠"/> -->
						    <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='airVersionName' id='airVersionName'>
					   			<option value="">全部</option>
								<option value="TEST">测试使用</option>	
								<option value="TK">天科</option>        
				                <option value ="HU">股份</option>                                         	
								<option value ="Y8">扬子江</option>                       	
								<option value="JD">首航</option>                          	
								<option value="9H">长安航</option>                        	
								<option value="GT">桂林航</option>                        	
								<option value="8L">祥鹏</option>                          	
				       		</select>
						</td>
						<th>设备编号:</th>
						<td><input name="termId" id="termId" placeholder="请输入设备编号"/></td>
						<th>mac地址:</th>
						<td><input name="mac" id="mac" placeholder="请输入mac地址"/></td>
						<td>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();" style="height: 20px;color: #76C27A">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();" style="height: 20px;color: #76C27A">清空</a>
						<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/termInfo/upload')}">
							<a onclick="uploadFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'">上传</a>
						</c:if> --%>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>