<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeCallbackSuccessZfb/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeCallbackSuccessZfb/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeCallbackSuccessZfb/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/alipay/tradeCallbackSuccessZfb/dataGrid',
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
				field : 'out_trade_no',
				sortable : true
			}, {
				width : '200',
				title : '描述',
				field : 'subject'
			}, {
				width : '100',
				title : '金额 ',
				field : 'total_fee'
			}, {
				width : '200',
				title : '支付结果',
				field : 'trade_status',
				formatter : function(value, row, index) {
				  switch (value) {
						case 'TRADE_SUCCESS':
							return '支付成功';
						case 'TRADE_FINISHED':
							return '支付成功';
					}   
				}
			}, {
				width : '250',
				title : '支付宝交易号',
				field : 'trade_no'
			}, {
				width : '200',
				title : '用户ID',
				field : 'buyer_id'
			}, {
				width : '60',
				title : '收款账户',
				field : 'seller_id',
				formatter : function(value, row, index) {
				  switch (value) {
						case '2088521539908280':
							return 'xlhshop';
						case '2088511721955154':
							return 'airshop';
					}   
				}
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
			width : 350,
			height : 600,
			href : '${ctx}/alipay/tradeCallbackSuccessZfb/addPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#addFormId');//对应tradeCallbackSuccessZfbAdd.jsp的from  id
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
				$.post('${ctx}/alipay/tradeCallbackSuccessZfb/delete', {
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
			href : '${ctx}/alipay/tradeCallbackSuccessZfb/editPage?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#editForm');//对应tradeCallbackSuccessZfbEdit.jsp的from  id
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
			href : '${ctx}/alipay/tradeCallbackSuccessZfb/viewPage?id=' + id
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
		$.post('${ctx}/alipay/tradeCallbackSuccessZfb/export', {
			//id : id
			out_trade_no:$('#out_trade_no').val(),
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
<body class="easyui-layout" data-options="fit:true,border:false"  onload="initDateTime()">

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
			<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeCallbackSuccessZfb/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/alipay/tradeCallbackSuccessZfb/export')}">
				<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'">导出</a>
			</c:if>
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="out_trade_no" id="out_trade_no" placeholder="请输入订单号"/></td>
						<th>交易号:</th>
						<td><input name="trade_no" id="trade_no" placeholder="支付宝交易号"/></td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
						<!--   支付结果:
					   <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='paystatus' id='paystatus'>
					   			<option value="">全部</option>
				                <option value="0">未支付</option>
				                <option value="1">支付成功</option>
				                <option value="2">支付失败</option>
				                <option value="3">已经退款</option>
				                <option value="4">订单作废</option>
				       </select> -->
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