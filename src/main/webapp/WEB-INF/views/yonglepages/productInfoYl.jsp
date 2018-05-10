<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/yongle/productInfoYl/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/yongle/productInfoYl/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/yongle/productInfoYl/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/yongle/productInfoYl/viewTicketPage')}">
	<script type="text/javascript">
		$.canViewTicketPage = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/yongle/productInfoYl/dataGrid',
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
				title : '票品编号',
				field : 'productId',
				sortable : true
			}, {
				width : '300',
				title : '票品名称',
				field : 'playName'
			}, {
				/* 票品状态
				0.热卖；1.预售；2.无效；3.待定；4.售完；5.延期；6.取消；7.已结束
				联盟展示及可卖状态为：0.热卖、1.预售；其他状态商品不展示；  */
				width : '70',
				title : '票品状态',
				field : 'status',
				formatter : function(value, row, index) {
					  switch (value) {
							case 0:
								return '热卖';
							case 1:
								return '预售';
							case 2:
								return '无效';
							case 3:
								return '待定';
							case 4:
								return '售完';
							case 5:
								return '延期';
							case 6:
								return '取消';
							case 7:
								return '已结束';
						}   
					}
			}, {
				/* 票品上下架状态(0.下架；1.上架)  */
				width : '70',
				title : '上下架状态',
				field : 'shelfStatus',
				formatter : function(value, row, index) {
					  switch (value) {
							case 0:
								return '下架';
							case 1:
								return '上架';
						}   
					}
			}, {
				width : '100',
				title : '演出城市',
				field : 'playCity'
			}, {
				width : '200',
				title : '演出地址',
				field : 'playAddress'
			}, {
				width : '70',
				title : '演出类型A',
				field : 'playTypeA'
			}, {
				width : '70',
				title : '演出类型B',
				field : 'playTypeB'
			}, {
				width : '180',
				title : '演出时间',
				field : 'timese',
				formatter : function(value, row, index) {
					return row.productStartTime+'至'+row.productEndTime;
				}
			}, {
				width : '150',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 120,
				formatter : function(value, row, index) {
					var str = '&nbsp;';
					if ($.canView) {
						str += $.formatString('<a href="javascript:void(0)" onclick="viewFun(\'{0}\');" >详情</a>', row.id);
					}
					if ($.canEdit) {
				   		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					}
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					if ($.canViewTicketPage) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="viewGoodsFun(\'{0}\');" >票次</a>', row.orderNumber);
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
			width : 350,
			height : 600,
			href : '${ctx}/yongle/productInfoYl/addPage',
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
				$.post('${ctx}/yongle/productInfoYl/delete', {
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
			width : 250,
			height : 200,
			href : '${ctx}/yongle/productInfoYl/editPage?id=' + id,
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
			width : 1000,//详情也面宽度
			height : 800,//详情页面高度
			href : '${ctx}/yongle/productInfoYl/viewPage?id=' + id
		});
	}
	//票次
	function viewGoodsFun(orderNumber) {
		if (orderNumber == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			orderNumber = rows[0].outTradeNo;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		
		parent.$.modalDialog({
			title : '商品詳情',
			width : 950,//详情也面宽度
			height : 400,//详情页面高度
			href : '${ctx}/yongle/productInfoYl/viewTicketPage?orderNumber=' + orderNumber
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
		$.post('${ctx}/yongle/productInfoYl/export', {
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
	function exportFun2(){
		//$("#export").hide();
		 var productId=$('#productId').val();
		 if(productId!=null){
			 productId=productId.trim();
		 }
		 window.open('${ctx}/yongle/productInfoYl/export2?productId='+productId);
		//$("#export").show();
	}
	function downloadFun() {
		parent.$.modalDialog({
			title : '下载票品编号',
			width : 800,
			height : 400,
			href : '${ctx}/yongle/productInfoYl/downloadPage',
			buttons : [ {
				text : '下载',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#downloadForm');//对应tradeOrdersZfbEdit.jsp的from  id
					f.submit();
				}
			} ]
		});
	}
	
	function filterFun() {
		parent.$.modalDialog({
			title : '票品过滤条件(删除,强制删除已下架票品)',
			width : 800,
			height : 400,
			href : '${ctx}/yongle/productInfoYl/filterPage',
			buttons : [ {
				text : '过滤',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#filterForm');//对应tradeOrdersZfbEdit.jsp的from  id
					f.submit();
				}
			} ]
		});
	}
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">

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
			<c:if test="${fn:contains(sessionInfo.resourceList, '/yongle/productInfoYl/download')}">
				 <a onclick="downloadFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px">票品下载</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/yongle/productInfoYl/filter')}">
				 <a onclick="filterFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px">票品过滤</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/yongle/productInfoYl/export')}">
				<a onclick="exportFun2();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px">导出</a>
			</c:if>
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>票品编号(精确):</th>
						<td><input name="productId" id="productId" placeholder="请输入票品编号"/></td>
						<th>城市区码(精确):</th>
						<td><input name="playCityCode" id="playCityCode" placeholder="请输入城市区码"/></td>
						<th>演出类型A(精确):</th>
						<td><input name="playTypeA" id="playTypeA" placeholder="请输入演出类型"/></td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
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