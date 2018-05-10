<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/common/message/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/message/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/message/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/common/message/dataGrid',
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
				field : 'orderNumber',
				/* formatter : function(value, row, index) {
					return '<a href="${ctx}/alipay/tradeCallbackSuccessZfb/manager?outTradeNo='+value+'&currow=0&rows=30&page=1&sort=savetime">'+value+'</a>';
				}, */
				sortable : true
			}, {
				width : '90',
				title : '手机号码',
				field : 'mobile'
			}, {
				width : '80',
				title : '发送状态',
				field : 'status',
				formatter : function(value, row, index) {
				  switch (value) {
						case '0':
							return '数据提交成功';
						case '-2001' :
							return '内容中存在黑字典';
						case '-2002' :
							return '号码中存在黑名单';
						case '-2004' :
							return '用户名错误';
						case '-2005' :
							return '密码错误';
						case '-2006' :
							return '内容长度错';
						case '-2007' :
							return '号码长度超出范围';
						case '-2008' :
							return '余额为零';
						case '-2009' :
							return '余额不足';
						case '-2010' :
							return '用户名为空';
						case '-2011' :
							return '时间戳错误';
						case '-2012' :
							return 'Key为空';
						case '-2013' :
							return '内容为空';
						case '-2014' :
							return '字符集错误';
						case '-2015' :
							return '号码不能为空';
						case '-2016' :
							return '定时时间错误';
						case '-2017' :
							return '优先级超出范围';
						case '-2018' :
							return '包ID超出范围0～50';
						case '-2019' :
							return '包sID超出范围0～50';
						case '-2020' :
							return '通信异常';
						case '-2021' :
							return '模式错误0-1';
						case '-2022' :
							return '回调地址错误';
						case '-3001' :
							return '通道信息错误';
						case '-3002' :
							return '通道扩展码超长';
						case '-3003' :
							return '通信包错误';
						case '-3004' :
							return '状态报告比对不存在';
						case '-3005' :
							return 'Key队列满';
						case '-3006' :
							return 'MT_RespKey重复';
						case '-3007' :
							return 'MT超时,或状态报告ID重复';
						case '-3008' :
							return '用户策略失败';
						case '-3009' :
							return '查无订单记录';
						case '-3010' :
							return '没有找到匹配的订单';
						case '-3011' :
							return '路由不存在';
						case '-3012' :
							return '无当前业务路由';
						case '-3013' :
							return '未知号码';
						case '-3015' :
							return '用户调用频率过高';
						case '-3016' :
							return '内容不包含回，退订';
						case '-4001' :
							return '签名过长';
						case '-4002' :
							return '签名不匹配';
						case '-4003' :
							return '签名错误';
						case '-4099' :
							return '号码发送超限';
						case '-502' :
							return '审核失败（或-5002）';
						case '-5002' :
							return '审核失败（或-502）';
						default:
							return value;
					}   
				}
			}, {
				width : '400',
				title : '发送内容',
				field : 'content'
			}, {
				width : '150',
				title : '发送时间',
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
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 600,
			height : 300,
			href : '${ctx}/common/message/addPage',
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
				$.post('${ctx}/common/message/delete', {
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
			href : '${ctx}/common/message/editPage?id=' + id,
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
	function sendMessFun() {
		parent.$.modalDialog({
			title : '编辑短信内容',
			width : 800,
			height : 400,
			href : '${ctx}/common/message/sendMessPage',
			buttons : [ {
				text : '发送',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#editForm');//对应tradeOrdersZfbEdit.jsp的from  id
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
			href : '${ctx}/common/message/viewPage?id=' + id
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
		$.post('${ctx}/common/message/export', {
			//id : id
			outTradeNo:$('#outTradeNo').val(),
			begintime:$('#begintime').val(),
			endtime:$('#endtime').val()
		}, function(result) {
			if (result.success) {
				parent.$.messager.alert('提示', result.msg, 'info');
				dataGrid.datagrid('reload');
			}else{
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
			<c:if test="${fn:contains(sessionInfo.resourceList, '/common/message/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/common/message/export')}">
				<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'">导出</a>
			</c:if>
			<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/common/message/sendMessPage')}">
				<a onclick="sendMessFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A">发送短信</a>
			</c:if> --%>
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="orderNumber" id="orderNumber" placeholder="请输入订单号"/></td>
						<th>手机号码:</th>
						<td><input name="mobile" id="mobile" placeholder="请输入手机号码"/></td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
						<c:if test="${fn:contains(sessionInfo.resourceList, '/common/message/sendMessPage')}">
							<a onclick="sendMessFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A">发送短信</a>
						</c:if>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>