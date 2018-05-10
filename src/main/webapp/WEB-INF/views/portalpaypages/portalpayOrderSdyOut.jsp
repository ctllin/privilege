<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
	<script type="text/javascript">
		$.canView = true;
	</script>

	<script type="text/javascript">
		$.canGoodsView = true;
	</script>

<title>圣地亚</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/portalpay/portalpayOrderSdy/dataGrid?type=cart',
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
			}/* , {
				width : '90',
				title : '航班号',
				field : 'flightNumber'
			} */, {
				width : '90',
				title : '乘客姓名',
				field : 'passengerName'
			}, {
				width : '90',
				title : '乘客电话',
				field : 'passengerPhone'
			}, {
				width : '200',
				title : '收货地址',
				field : 'customerAddress'
			}, {
				width : '90',
				title : '金额 (分)',
				field : 'totalMoney'
			}, {
				width : '70',
				title : '支付结果',
				field : 'payStatus',
				formatter : function(value, row, index) {
				  switch (value) {
						case '0':
							return '已经接受';
						case '1':
							return '处理中';
						case '2':
							return '支付成功';
						case '3':
							return '支付失败';
						case '4':
							return '已经退款';
					}   
				}
			}, {
				width : '70',
				title : '异步结果',
				field : 'stateCode',
				formatter : function(value, row, index) {
				  switch (value) {
						case '0000':
							return '成功';
						case '0001':
							return '失败';
					}   
				}
			}, {
				width : '70',
				title : '网络模式',
				field : 'payflag',
				formatter : function(value, row, index) {
					switch (value) {
						case '0':
							return '有网';
						case '1':
							return '无网';
					}
				}
			}, {
				width : '90',
				title : '航渠',
				field : 'orderFrom'
			}, {
				width : '80',
				title : '发货状态',
				field : 'logisticsType',
				formatter : function(value, row, index) {
					switch (value) {
						case '0':
							return '未发货';
						case '1':
							return '已发货';
						case '2':
							return '已收货';
						default:
							return '未发货';
					}
				}
			}, {
				width : '130',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 200,
				formatter : function(value, row, index) {
					var str = '&nbsp;';
					if ($.canView) {
						str += $.formatString('<a href="javascript:void(0)" onclick="viewFun(\'{0}\');" >详情</a>', row.orderNumber);
					}
					if ($.canEdit) {
				   		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					}
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					if ($.canGoodsView) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="viewGoodsFun(\'{0}\');" >商品</a>', row.orderNumber);
					}
					if ($.canEditLogistics) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editLogisticsFun(\'{0}\',\'{1}\');" >物流</a>',row.id, row.orderNumber);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	
	function viewFun(orderNumber) {
		if (orderNumber == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			orderNumber = rows[0].orderNumber;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		
		parent.$.modalDialog({
			title : '订单詳情',
			width : 800,//详情也面宽度
			height : 600,//详情页面高度
			href : '${ctx}/portalpay/portalpayOrderSdy/viewPage?orderNumber=' + orderNumber
		});
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
			href : '${ctx}/portalpay/portalpayOrderSdy/viewGoodsPage?orderNumber=' + orderNumber
		});
	}
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
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
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="orderNumber" id="orderNumber" placeholder="请输入订单号"/></td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
						  支付结果:
					   <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='payStatus' id='payStatus'>
					   			<option value="">全部</option>
				                 <option value="0">已经接受</option>
				                <option value="1">处理中</option>
				                <option value="2">支付成功</option>
				                <option value="3">支付失败</option>
				                <option value="4">已经退款</option>
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