<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/orderNotify/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/orderNotify/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/orderNotify/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/portalpay/orderNotify/dataGrid',
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
				width : '250',
				title : '商品订单号',
				field : 'orderNumber',
				sortable : true
			}, {
				width : '70',
				title : '支付方式',
				field : 'paytype',
				formatter : function(value, row, index) {
				  switch (value) {
						/* case '0':
							return '货到付款'; */
						case '1':
							return '新生支付';
						case '2':
							return '微信支付';
						case '3':
							return '刷卡支付';
						case '4':
							return '支付宝支付';
						default:
							return value;
					}   
				}
			}, {
				width : '70',
				title : '支付结果',
				field : 'payStatus',
				formatter : function(value, row, index) {
				  switch (value) {
						 case 0:
							return ''; //支付状态0初始化1支付成功2支付失败3已经退款
						case 1:
							return '支付成功';
						case 2:
							return '支付失败';
						case 3:
							return '已经退款';
					/* 	case '4':
							return '支付宝支付'; */
						default:
							return value;
					}   
				}
			}, {
				width : '90',
				title : '供应商编号',
				field : 'supplierId',
				sortable : true
			}, {
				width : '80',
				title : '订单通知状态',
				field : 'orderSendStatus',
				formatter : function(value, row, index) {
					  switch (value) {
							/* case '0':
								return '货到付款'; */
							case 1:
								return '成功';
							case 2:
								return '失败';
							default:
								return value;
						}   
				}
			}, {
				width : '120',
				title : '订单通知时间',
				field : 'orderSendSavetime'
			}, {
				width : '80',
				title : '成功通知状态',
				field : 'paySuccessSendStatus',
				formatter : function(value, row, index) {
					  switch (value) {
							/* case '0':
								return '货到付款'; */
							case 1:
								return '成功';
							case 2:
								return '失败';
							default:
								return value;
						}   
				}
			}, {
				width : '120',
				title : '成功通知时间',
				field : 'paySuccessSavetime'
			}, {
				width : '80',
				title : '失败通知状态',
				field : 'payFailSendStatus',
				formatter : function(value, row, index) {
					  switch (value) {
							/* case '0':
								return '货到付款'; */
							case 1:
								return '成功';
							case 2:
								return '失败';
							default:
								return value;
						}   
				}
			}, {
				width : '120',
				title : '失败通知时间',
				field : 'payFailSendSavetime'
			}, {
				width : '80',
				title : '退款通知状态',
				field : 'payRefundSendStatus',
				formatter : function(value, row, index) {
					  switch (value) {
							/* case '0':
								return '货到付款'; */
							case 1:
								return '成功';
							case 2:
								return '失败';
							default:
								return value;
						}   
				}
			}, {
				width : '120',
				title : '退款通知时间',
				field : 'payRefundSavetime'
			}, {
				width : '200',
				title : '创建时间',
				field : 'savetime',
				sortable : true
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
					str += $.formatString('<a href="javascript:void(0)" onclick="viewGoodsFun(\'{0}\',\'{1}\');" >商品</a>', row.orderNumber,row.supplierId);
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	function viewGoodsFun(orderNumber,supplierId) {
		parent.$.modalDialog({
			title : '商品詳情',
			width : 950,//详情也面宽度
			height : 400,//详情页面高度
			href : '${ctx}/portalpay/tradeOrders/viewGoodsPage?orderNumber=' + orderNumber+'&supplierguid='+supplierId
		});
	}
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 350,
			height : 400,
			href : '${ctx}/portalpay/orderNotify/addPage',
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
				$.post('${ctx}/portalpay/orderNotify/delete', {
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
			href : '${ctx}/portalpay/orderNotify/editPage?id=' + id,
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
			href : '${ctx}/portalpay/orderNotify/viewPage?id=' + id
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
		$.post('${ctx}/portalpay/orderNotify/export', {
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
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false" onload="initDateTime()">

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
			<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/orderNotify/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/orderNotify/export')}">
				<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'">导出</a>
			</c:if>
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="orderNumber" id="orderNumber" placeholder="请输入订单号"/></td>
						<th>供应商编号:</th>
						<td><input name="supplierId" id="supplierId" placeholder="请输入供应商编号"/></td>
						<th>支付方式:</th>
						<td>
							 <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='paytype' id='paytype'>
					   			<option value="">全部</option>
				                <option value="1">新生支付</option>
				                <option value="2">微信支付</option>
				                <option value="3">机上刷卡</option>
				                <option value="4">支付宝</option>
				     		  </select>
						</td>
						<th>支付结果:</th>
						<td>
							<select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='payStatus' id='payStatus'>
					   			<option value="">全部</option>
				                <option value="0">未支付</option>
				                <option value="1">支付成功</option>
				                <option value="2">支付失败</option>
				                <option value="3">已经退款</option>
				                <option value="4">订单作废</option>
				      		 </select>
						</td>
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