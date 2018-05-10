<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/common/souhuVideo/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/souhuVideo/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/souhuVideo/query')}">
	<script type="text/javascript">
		$.canQuery = true;
	</script>
</c:if>
 <%--
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/souhuVideo/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if> --%>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/common/souhuVideo/dataGrid',
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
				field : 'orderNumber',
				/* formatter : function(value, row, index) {
					return '<a href="${ctx}/alipay/tradeCallbackSuccessZfb/manager?outTradeNo='+value+'&currow=0&rows=30&page=1&sort=savetime">'+value+'</a>';
				}, */
				sortable : true
			}, {
				width : '80',
				title : '姓名',
				field : 'userName'
			}, {
				width : '90',
				title : '电话',
				field : 'telePhone'
			}, {
				width : '160',
				title : '卡密',
				field : 'cardNo'
			}, {
				width : '150',
				title : 'statusText',
				field : 'statusText'
			}, {
				width : '70',
				title : '状态',
				field : 'status'
			}, {
				width : '150',
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
				width : '40',
				title : 'flag',
				field : 'flag'
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
					}*/
					if ($.canEdit) {
					   str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					}
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					if ($.canQuery) {
						str += '&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="queryFun(\'{0}\');" >查询卡密</a>', row.orderNumber);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	
	function queryFun(orderNumber) {
		if (orderNumber == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			orderNumber = rows[0].orderNumber;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要查询卡密？', function(b) {
			if (b) {
				progressLoad();
				$.post('${ctx}/common/souhuVideo/query', {
					orderNumber : orderNumber
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
	function addFun() {
		parent.$.modalDialog({
			title : '生成卡密',
			width : 600,
			height : 200,
			href : '${ctx}/common/souhuVideo/addPage',
			buttons : [ {
				text : '生成',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#addFormId');//对应tradeOrdersZfbAdd.jsp的from  id
					f.submit();
				}
			} ]
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
		<table id="dataGrid" data-options="fit:true,border:false"></table>
		 -->		
       	<table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>
	<div id="toolbar" style="display: none;">
	   <div>
<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" title="生成卡密">生成卡密</a>
<!-- 			
			<a onclick="flushFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" title="只对当前登录的服务器生效,其他负载服务器需要定时任务跟新后才会生效">刷新缓存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('open')" style="height: 20px;color: #76C27A" >处理手机号码</a> -->
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
					    <th>订单号:</th>
						<td><input name="orderNumber" id="orderNumber" placeholder="请输入订单号" maxlength="32"/></td>
						<th>姓名:</th>
						<td><input name="userName" id="userName" placeholder="请输入姓名" style="width: 150px"/></td>
						<th>电话:</th>
						<td><input name="telePhone" id="telePhone" placeholder="请输入电话" style="width: 100px"/></td>
						<th>支付方式:</th>
						<td>
						    <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='paytype' id='paytype'>
					   			<option value="">全部</option>
				                <option value="1">新生支付</option>
				                <option value="2">微信支付</option>
				                <option value="3">刷卡支付</option>
				                <option value="4">支付宝支付</option>
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