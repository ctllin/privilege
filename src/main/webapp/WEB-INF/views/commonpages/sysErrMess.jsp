<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<!-- 该js的作用是鼠标滑过，显示内容-->
<script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/Jquery.easyui.tooltip.js"></script>
<!-- 如果此页面无法加载，看看是否是数据的问题 错误数据不能有html页面-->
<meta http-equiv="X-UA-Compatible" content="edge" />

 <%--
  <c:if test="${fn:contains(sessionInfo.resourceList, '/common/sysErrMess/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/sysErrMess/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/common/sysErrMess/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if> --%>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/common/sysErrMess/dataGrid',
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
				width : '100',
				title : 'project',
				field : 'project',
				/* formatter : function(value, row, index) {
					return '<a href="${ctx}/alipay/tradeCallbackSuccessZfb/manager?outTradeNo='+value+'&currow=0&rows=30&page=1&sort=savetime">'+value+'</a>';
				}, */
				sortable : true
			}, {
				width : '350',
				title : 'method',
				field : 'method'
			}, {
				width : '470',
				title : 'errMess',
				field : 'errMess'
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
					}
					if ($.canEdit) {
					   str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					}
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					*/
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			//鼠标滑过显示商品图片
			onLoadSuccess: function () {
               // var tableTd = $('div.datagrid-body td[field="title"]'); //title是列名 鼠标滑过title列时显示
               var tableTd = $('div.datagrid-body td'); // 鼠标滑过该row时显示
               tableTd.each(function () {
                    var $this = $(this);
                    var index = $this.parent('tr').attr('datagrid-row-index');
                    var rows = dataGrid.datagrid('getRows');
                    var currentRow = rows[index];
                   // var content = '<div style=" max-width:700px;word-break: break-all; word-wrap: break-word;">' + currentRow.imageUrl + '</div>'; //productname是列名
                    var content = '<div style=" max-width:600px;word-break: break-all; word-wrap: break-word;">'+currentRow.errMess+'</div>'; //productname是列名
                    $this.tips({ content: content, wrapColor: 'black' });
               });
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
				$.post('${ctx}/common/sysErrMess/delete', {
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
	function flushFun(){
		progressLoad();
		$.post('${ctx}/common/sysErrMess/flush', {
		}, function(result) {
			if (result.success) {
				parent.$.messager.alert('提示', result.msg, 'info');
				dataGrid.datagrid('reload');
			}else{
				parent.$.messager.alert('提示', result.msg, 'error');
			}
			progressClose();
		}, 'JSON');
	}
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 600,
			height : 400,
			href : '${ctx}/common/sysErrMess/addPage',
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
			href : '${ctx}/common/sysErrMess/editPage?id=' + id,
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
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
/* 	$(function(){//默认关闭弹出框
		$('#dlg').dialog('close');
	});
	function telephoneClose(){
    	$('#dlg').dialog('close');
    	$('#dlgContent').val('');
	}
	function telephoneHandle(){
	      var urlExport = '${ctx}/common/telephone/export';//请求生成excel地址
		  $('#telephoneForm').attr("action", urlExport).submit();

	} */
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false" onload="initDateTime()">
	<div data-options="region:'center',fit:true,border:false">
		<!--  此种写法当列过多时,无横向滚动条	
		<table id="dataGrid" data-options="fit:true,border:false"></table>
		 -->	
        <table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>
	<div id="toolbar" style="display: none;">
	   <div>
<!-- 			<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" title="key和value1:1时flag选0 当key和value为1:n时flag为10">添加</a>
			<a onclick="flushFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" title="只对当前登录的服务器生效,其他负载服务器需要定时任务跟新后才会生效">刷新缓存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('open')" style="height: 20px;color: #76C27A" >处理手机号码</a> -->
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>项目:</th>
						<td>
						    <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='project' id='project'>
					   			<option value="">全部</option>
				                <option value="1">paymanager</option>
				                <option value="2">alipay</option>
				                <option value="3">airshopapi</option>
				                <option value="4">commonapi</option>
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