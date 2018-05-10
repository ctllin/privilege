<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/tradeOrdersSdy/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/tradeOrdersSdy/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/tradeOrdersSdy/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if> --%>
<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/tradeOrdersSdy/payStatusQuery')}">
	<script type="text/javascript">
		$.canPayStatusQuery = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/tradeOrdersSdy/viewGoods')}"><!-- 商品按钮  点击显示商品详情 -->
	<script type="text/javascript">
		$.canGoodsView = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/portalpay/tradeOrdersSdy/dataGrid',
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
				width : '90',
				title : '金额',
				field : 'totalAmount'
			}, {
				width : '90',
				title : '买家姓名',
				field : 'buyerName'
			}, {
				width : '90',
				title : '买家电话',
				field : 'buyerTelephone'
			}, {
				width : '80',
				title : '订单来源',
				field : 'orderFrom'
			}, {
				width : '90',
				title : '收货人姓名',
				field : 'consigneeName'
			}, {
				width : '90',
				title : '收货人电话',
				field : 'consigneeTelephone'
			}, {
				width : '300',
				title : '收货地址',
				field : 'address'
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
				width : '150',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 180,
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
					}if ($.canPayStatusQuery) {
						//str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="payStatusQuery(\'{0}\',\'{1}\');" >查询支付结果</a>', row.orderNumber,row.paytype);
					}
					if ($.canGoodsView) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="viewGoodsFun(\'{0}\');" >商品</a>', row.orderNumber);
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
			href : '${ctx}/portalpay/tradeOrdersSdy/addPage',
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
				$.post('${ctx}/portalpay/tradeOrdersSdy/delete', {
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
	function payStatusQuery(orderNumber,paytype) {
		if (orderNumber == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			orderNumber = rows[0].orderNumber;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		progressLoad();
		$.post('${ctx}/portalpay/tradeOrders/payStatusQuery', {
			orderNumber : orderNumber,
			paytype:paytype
		}, function(result) {
			if (result.success) {
				parent.$.messager.alert('提示', result.msg, 'info');
				dataGrid.datagrid('reload');
			}else{
				parent.$.messager.alert('提示', result.msg, 'error');
				dataGrid.datagrid('reload');
			}
			progressClose();
		}, 'JSON');;
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
			href : '${ctx}/portalpay/tradeOrdersSdy/editPage?id=' + id,
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
			href : '${ctx}/portalpay/tradeOrdersSdy/viewPage?id=' + id
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
		$.post('${ctx}/portalpay/tradeOrdersSdy/export', {
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
	
	function viewGoodsFun(orderNumber) {
		if (orderNumber == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			orderNumber = rows[0].orderNumber;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		
		parent.$.modalDialog({
			title : '商品詳情',
			width : 950,//详情也面宽度
			height : 400,//详情页面高度
			href : '${ctx}/portalpay/tradeOrdersSdy/viewGoodsPage?orderNumber=' + orderNumber
		});
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
			<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/tradeOrdersSdy/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/portalpay/tradeOrdersSdy/export')}">
				<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'">导出</a>
			</c:if>
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="orderNumber" id="orderNumber" placeholder="请输入订单号"/></td>
						<th>买家姓名:</th>
						<td><input name="buyerName" id="buyerName" placeholder="请输入买家姓名"/></td>
						<th>买家电话:</th>
						<td><input name="buyerTelephone" id="buyerTelephone" placeholder="请输入买家电话"/></td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
						  支付方式:
					   <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='paytype' id='paytype'>
					   			<option value="">全部</option>
				                <option value="1">新生支付</option>
				                <option value="2">微信支付</option>
				                <option value="3">机上刷卡</option>
				                <option value="4">支付宝</option>
				       </select>
				        &nbsp;&nbsp;数据:
					   <select class="easyui-combobox" id="dataType" name='dataType'  label="State:" labelPosition="top" style="width:150px;" >
					   			 <option value="0">全部数据</option>
                      			 <option value="1" selected="selected">正式数据</option>
                      			 <option value="2">测试数据</option>
				       </select>
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