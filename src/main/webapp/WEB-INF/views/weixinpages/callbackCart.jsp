<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/callbackCart/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/callbackCart/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/common/getOrderNumber')}">
	<script type="text/javascript">
		$.canGetOrderNumber = true;
	</script>
</c:if>


<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/weixin/callbackCart/dataGrid',
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
				field : 'out_trade_no',
				sortable : true
			},{
				width : '230',
				title : 'transaction_id',
				field : 'transaction_id',
				sortable : true
			}/* , {
				width : '90',
				title : '航班号',
				field : 'flightNumber'
			} */, {
				width : '90',
				title : 'return_code',
				field : 'return_code'
			}, {
				width : '90',
				title : 'return_msg',
				field : 'return_msg'
			}, {
				width : '90',
				title : 'result_code',
				field : 'result_code'
			}, {
				width : '90',
				title : '金额 (分)',
				field : 'total_fee'
			}, {
				width : '70',
				title : 'err_code',
				field : 'err_code'
			}, {
				width : '100',
				title : 'err_code_des',
				field : 'err_code_des'
			}, {
				width : '90',
				title : 'total_fee',
				field : 'total_fee'
			}/* , {
				width : '90',
				title : 'trade_type',
				field : 'trade_type'
			}, {
				width : '90',
				title : 'bank_type',
				field : 'bank_type'
			}, {
				width : '90',
				title : 'fee_type',
				field : 'fee_type'
			} */, {
				width : '90',
				title : 'cash_fee',
				field : 'cash_fee'
			}/* , {
				width : '90',
				title : 'cash_fee_type',
				field : 'cash_fee_type'
			} */, {
				width : '270',
				title : 'attach',
				field : 'attach'
			}, {
				width : '130',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 180,
				formatter : function(value, row, index) {
					var str = '&nbsp;';
					if ($.canGetOrderNumber) {
						str += $.formatString('<a href="javascript:void(0)" onclick="getOrderNumber(\'{0}\',\'{1}\');" >获取订单号</a>', row.out_trade_no,row.attach);
					}
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
					str += $.formatString('<a href="javascript:void(0)" onclick="viewGoodsFun(\'{0}\');" >商品</a>', row.out_trade_no);
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	function viewGoodsFun(orderNumber) {
		if (orderNumber == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			orderNumber = rows[0].out_trade_no;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		
		parent.$.modalDialog({
			title : '商品詳情',
			width : 950,//详情也面宽度
			height : 400,//详情页面高度
			href : '${ctx}/portalpay/tradeOrders/viewGoodsPage?orderNumber=' + orderNumber
		});
	}
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 350,
			height : 600,
			href : '${ctx}/weixin/callbackCart/addPage',
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
				$.post('${ctx}/weixin/callbackCart/delete', {
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
		
	function getOrderNumber(orderNumber,attach) {
		$.post('${ctx}/weixin/common/getOrdreNumber', {
			orderNumber : orderNumber,
			productId:attach
		}, function(result) {
			if (result.success) {
				parent.$.messager.alert('提示', result.msg, 'info');
			}else{
				parent.$.messager.alert('提示', result.msg, 'info');
			}
			progressClose();
		}, 'JSON');
	}
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	function callbackCartFun(){
		parent.$.modalDialog({
			title : '退款申请',
			width : 600,
			height : 300,
			href : '${ctx}/weixin/callbackCart/callbackCartPage',
			buttons : [ {
				text : '退款',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#callbackCartForm');//对应.jsp的from  id
					f.submit();
				}
			} ]
		});
	}
	function callbackCartSearchFun(){
		var out_trade_no=$("#out_trade_no").val();
		if(null==out_trade_no||out_trade_no.trim()==""){
			parent.$.messager.alert('提示信息', '请输入订单号', 'success');
		}else{
			  $.ajax({
		            //提交数据的类型 POST GET
		            type:"POST",
		            //提交的网址
		            //url:"http://localhost:8080/lightmanger/filemanager/fileDownload/fileDownloadPie",
		            url:"${ctx}/weixin/callbackCart/querycallbackCart?orderNumber="+out_trade_no,
		            //提交的数据
		            data:{},
		            //返回数据的格式
		            datatype: "html",//"xml", "html", "script", "json", "jsonp", "text".
		            //在请求之前调用的函数
		            //成功返回之后调用的函数             
		            success:function(result){
		            	result = $.parseJSON(result);
		            	if(result.success){
		            		//var msg= $.parseJSON(result.msg);
		            		parent.$.messager.alert('提示信息',result.msg, 'info');
		            	}else{
		            		parent.$.messager.alert('提示信息', result.msg, 'error');
		            	}
		            }
			  });
		}
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
			<c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/callbackCart/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/callbackCart/callbackCart')}">
				<a onclick="callbackCartFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'" style="height: 20px;color: #76C27A" >退款</a>
			</c:if>
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="out_trade_no" id="out_trade_no" placeholder="请输入订单号"/></td>
						<th>商户订单号:</th>
						<td><input name="transaction_id" id="transaction_id" placeholder="请输入商户订单号"/></td>
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