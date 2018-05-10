<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/tradeFeedback/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/boc/tradeFeedback/dataGrid',
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
				title : '订单号',
				field : 'sOrderNo'
			}, {
				width : '80',
				title : '反馈码',
				field : 'sResponseCode'
			}, {
				width : '150',
				title : '反馈信息',
				field : 'sResponseDesc'
			}, {
				width : '150',
				title : 'sSysUniqueID',
				field : 'sSysUniqueID'
			}, {
				width : '120',
				title : '交易卡号',
				field : 'sCardNOMask'
			}, {
				width : '130',
				title : 'sMerchantID',
				field : 'sMerchantID'
			}, {
				width : '90',
				title : 'sTerminalID',
				field : 'sTerminalID'
			}, {
				width : '90',
				title : 'sMerchantNameCH',
				field : 'sMerchantNameCH'
			}, {
				width : '70',
				title : 'sCardType',
				field : 'sCardType'
			}, {
				width : '50',
				title : 'sTransType',
				field : 'sTransType'
			}, {
				width : '60',
				title : 'sBatchNO',
				field : 'sBatchNO'
			}, {
				width : '60',
				title : 'sTraceNO',
				field : 'sTraceNO'
			}, {
				width : '50',
				title : 'sInvoiceNO',
				field : 'sInvoiceNO'
			}, {
				width : '70',
				title : 'sAuthCode',
				field : 'sAuthCode'
			}, {
				width : '80',
				title : 'sTransDate',
				field : 'sTransDate'
			}, {
				width : '80',
				title : 'sTransTime',
				field : 'sTransTime'
			}, {
				width : '70',
				title : 'sAmountLoc',
				field : 'sAmountLoc'
			}, {
				width : '70',
				title : 'sEntryMode',
				field : 'sEntryMode'
			}, {
				width : '70',
				title : 'sEntryModeChar',
				field : 'sEntryModeChar'
			}, {
				width : '100',
				title : 'sRefNO',
				field : 'sRefNO'
			}, {
				width : '80',
				title : 'sRemark',
				field : 'sRemark'
			}, {
				width : '80',
				title : 'state',
				field : 'state'
			}, {
				width : '60',
				title : 'matc',
				field : 'matc'
			}, {
				width : '150',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '&nbsp;';
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');">删除</a>', row.id);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			rowStyler: function(index,row){
				if (row.sResponseCode!='0000'){
					//return 'background-color:#DF0700;color:#fff;font-weight:bold;';
					return 'background-color:#F0E5CC;';
				}
			}
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
				$.post('${ctx}/boc/tradeFeedback/delete', {
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
			<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/tradeFeedback/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/tradeFeedback/export')}">
				<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-export'">导出</a>
			</c:if>
		</div>
		<div data-options="region:'north',border:false" style="height: 60px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="sOrderNo" id="sOrderNo" placeholder="请输入订单号" style="width: 220px"/></td>
						
						<th>终端号:</th>
						<td><input name="sTerminalID" id="sTerminalID" placeholder="请输入终端号"/></td>
						
						<th>交易卡号:</th>
						<td><input name="sCardNOMask" id="sCardNOMask" placeholder="请输入交易卡号"/></td>
						
					</tr>
					<tr>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>
					    <th>交易日期:</th>
						<td><input name="sTransDate" id="sTransDate"  placeholder="请输入交易日期"  onclick="WdatePicker({readOnly:true,dateFmt:'yyyyMMdd'})" readonly="readonly"  /></td>
					    <td  colspan="2">
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