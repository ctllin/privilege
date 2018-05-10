<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeOrdersZfb/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeOrdersZfb/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeOrdersZfb/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeOrdersZfb/viewGoods')}"><!-- 商品按钮  点击显示商品详情 -->
	<script type="text/javascript">
		$.canGoodsView = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeOrdersZfb/logisticsEdit')}"><!-- 物流按钮  点击显示物流详情 -->
	<script type="text/javascript">
		$.canEditLogistics = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/alipay/tradeOrdersZfb/dataGrid',
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
				width : '180',
				title : '商品订单号',
				field : 'outTradeNo',
				/* formatter : function(value, row, index) {
					return '<a href="${ctx}/alipay/tradeCallbackSuccessZfb/manager?outTradeNo='+value+'&currow=0&rows=30&page=1&sort=savetime">'+value+'</a>';
				}, */
				sortable : true
			}, {
				width : '200',
				title : '描述',
				field : 'subject'
			}, {
				width : '80',
				title : '金额 ',
				field : 'totalAmount'
			}, {
				width : '80',
				title : '支付结果',
				field : 'paystatus',
				formatter : function(value, row, index) {
				  switch (value) {
						case '0':
							return '未支付';
						case '1':
							return '支付成功';
						case '2':
							return '支付失败';
						case '3':
							return '已经退款';
						case '4':
							return '订单作废';
					}   
				}
			}, {
				width : '100',
				title : '买家姓名',
				field : 'buyername'
			}, {
				width : '90',
				title : '买家电话',
				field : 'tele'
			}, {
				width : '200',
				title : '收货地址',
				field : 'address'
			}, {
				width : '80',
				title : '航渠',
				field : 'airCompany'
			}, {
				width : '80',
				title : '支付方式',
				field : 'version',
				formatter : function(value, row, index) {
					switch (value) {
						case '0':
							return 'pc无短信';
						case '1':
							return 'pc有短信';
						case '2':
							return 'app无短信';
						case '3':
							return 'app有短信';
					}
				}
			}/* , {
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
			} */, {
				width : '150',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 200,
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
					if ($.canGoodsView) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="viewGoodsFun(\'{0}\');" >商品</a>', row.outTradeNo);
					}
					if ($.canEditLogistics) {
					/* 	str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editLogisticsFun(\'{0}\',\'{1}\');" >物流</a>',row.id, row.outTradeNo);
					 */
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="viewLogisticsFun(\'{0}\');" >物流</a>', row.outTradeNo); 
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	function viewLogisticsFun(outTradeNo) {
		if (outTradeNo == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			outTradeNo = rows[0].outTradeNo;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '物流詳情',
			width : 1024,//详情也面宽度
			height : 400,//详情页面高度
			href : '${ctx}/portalpay/tradeOrders/viewLogisticsPage?orderNumber=' + outTradeNo
		});
	}
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 350,
			height : 600,
			href : '${ctx}/alipay/tradeOrdersZfb/addPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#addFormId');//对应tradeOrdersZfbAdd.jsp的from  id
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
				$.post('${ctx}/alipay/tradeOrdersZfb/delete', {
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
			width : 800,
			height : 400,
			href : '${ctx}/alipay/tradeOrdersZfb/editPage?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#editForm');//对应tradeOrdersZfbEdit.jsp的from  id
					f.submit();
				}
			} ]
		});
	}
	
	function editLogisticsFun(id,orderNumber) {
		if (orderNumber == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			orderNumber = rows[0].outTradeNo;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '编辑',
			width : 800,
			height : 400,
			href : '${ctx}/alipay/tradeOrdersZfb/editLogisticsPage?orderNumber=' + orderNumber,
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
			height : 600,//详情页面高度
			href : '${ctx}/alipay/tradeOrdersZfb/viewPage?id=' + id
		});
	}
	
	function viewGoodsFun(outTradeNo) {
		if (outTradeNo == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			outTradeNo = rows[0].outTradeNo;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		
		parent.$.modalDialog({
			title : '商品詳情',
			width : 950,//详情也面宽度
			height : 400,//详情页面高度
			href : '${ctx}/alipay/tradeOrdersZfb/viewGoodsPage?outTradeNo=' + outTradeNo
		});
	}
	
	function searchFun() {
		 var paystatus=$('#paystatus').combobox('getValue');//easyui 获取选中值  航空公司：HU、Y8
		 if(paystatus==null||""==paystatus){
			  $('#paystatus').focus();
			  parent.$.messager.alert('提示信息', '支付方式不能为空,请选中并点击支付方式', 'success');
			  return;
		 }
		 var dataType=$('#dataType').combobox('getValue');//easyui 获取选中值  航空公司：HU、Y8
		 if(dataType==null||""==dataType){
			  $('#dataType').focus();
			  parent.$.messager.alert('提示信息', '数据不能为空,请选中并点击数据类型', 'success');
			  return;
		 }
		 
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	function exportFun(){
		//progressLoad();
		$.post('${ctx}/alipay/tradeOrdersZfb/export', {
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
	<div id="toolbar" style="display: none;">
		<div>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeOrdersZfb/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
		</div>
	</div>
	<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
		<form id="searchForm">
			<table>
				<tr>
					<th>订单号:</th>
					<td><input name="outTradeNo" id="outTradeNo" placeholder="请输入订单号"/></td>
					<!-- <th>金额:</th>
					<td><input name="totalAmount" id="totalAmount" placeholder="请输入订单金额"/></td> -->
					<th>创建时间:</th>
					<td>
					<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
				        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					  支付结果:
				   <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='paystatus' id='paystatus'>
				   			<option value="all">全部</option>
			                <option value="0">未支付</option>
			                <option value="1" selected="selected">支付成功</option>
			                <option value="2">支付失败</option>
			                <option value="3">已经退款</option>
			                <option value="4">订单作废</option>
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
	<div data-options="region:'center',fit:true,border:false">
		<table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>