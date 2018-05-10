<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/orderInfo/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if> --%>
<c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/orderInfo/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/orderInfo/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/orderInfo/cancelOrder')}">
	<script type="text/javascript">
		$.canCancelOrder = true;
	</script>
</c:if>

<title>二维码扫描</title>
<style>
     #show_contain{width:360px;height:360px;margin: 0 auto;}
</style>
<script src="${ctx}/jslib/MD5.js"></script>
<script src="${ctx}/jslib/jquery.qrcode.min.js"></script>
<!-- 该js的作用是鼠标滑过，显示内容 -->
<script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/Jquery.easyui.tooltip.js"></script>
<script type="text/javascript">
	//设置单个td的颜色
	function cellStyler(value,row,index){
		if (row.store <=0){
			return 'background-color:#F0E5CC;';
			//return 'background-color:#7A89A6;';
			//return 'background-color:#C7EDCC;color:red;';
		}
	}
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/kaola/orderInfo/dataGrid',
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
				sortable : true
			},{
				width : '70',
				title : '买家姓名',
				field : 'name'
			}, {
				width : '90',
				title : '买家电话',
				field : 'mobile'
			},{
				width : '70',
				title : '订单金额',
				field : 'orderAmount'
			}, {
				width : '70',
				title : '支付金额',
				field : 'payAmount'
			}, {
				width : '70',
				title : '税',
				field : 'taxPayAmount'
			}, {
				width : '150',
				title : '买家地址',
				field : 'address'
			},{
				width : '55',
				title : '类型',
				field : 'needVerifyLevel',
				formatter : function(value, row, index) {
					switch(value){
						case 0:
							return '无需实名';
						case 1:
							return '真实姓名+证件号';
						case 2:
							return '真实姓名+证件号+证件正反照片';
						default:
							return value;
					}
				}
			},{
				width : '70',
				title : '我司支付状态',
				field : 'payStatus',
				formatter : function(value, row, index) {
					switch (value) {
						case 0:
							return '未支付';
						case 1:
							return '支付成功';
						case 2:
							return '支付失败';
						case 3:
							return '已经退款';
						case 4:
							return '订单作废';
					}   
				}
			},{
				width : '70',
				title : '考拉支付状态',
				field : 'flag',
				formatter : function(value, row, index) {
					switch (value) {
						case 0:
							return '未支付';
						case 1:
							return '支付成功';
						case 2:
							return '支付失败';
						case 3:
							return '订单取消';
						case 4:
							return '订单作废';
					}   
				}
			}, {
				width : '150',
				title : '邮箱',
				field : 'accountId'
			}, {
				width : '150',
				title : '证件号',
				field : 'identityId'
			}, {
				width : '130',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 150,
				formatter : function(value, row, index) {
					var str = '&nbsp;';
					/* if ($.canView) {
						str += $.formatString('<a href="javascript:void(0)" onclick="viewFun(\'{0}\');" >详情</a>', row.id);
					} */
					if ($.canCancelOrder) {
				   		str += '&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="cancelOrder(\'{0}\',\'{1}\');" >取消订单</a>', row.orderNumber,row.id);
					} 
					if ($.canEdit) {
				   		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					} 
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
					str += $.formatString('<a href="javascript:void(0)" onclick="viewGoodsFun(\'{0}\');" >商品</a>', row.orderNumber);
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			//处理行颜色
			rowStyler: function(index,row){
				if (row.store <=0){
					//return 'background-color:#DF0700;color:#fff;font-weight:bold;';
					return 'background-color:#F0E5CC;';
				}
			},
			//鼠标滑过显示商品图片
			onLoadSuccess: function () {
               // var tableTd = $('div.datagrid-body td[field="title"]'); //title是列名 鼠标滑过title列时显示 address
               var tableTd = $('div.datagrid-body td[field="address"]'); // 鼠标滑过该row时显示
               tableTd.each(function () {
                    var $this = $(this);
                    var index = $this.parent('tr').attr('datagrid-row-index');
                    var rows = dataGrid.datagrid('getRows');
                    var currentRow = rows[index];
                   // var content = '<div style=" max-width:700px;word-break: break-all; word-wrap: break-word;">' + currentRow.imageUrl + '</div>'; //productname是列名
                    var content = '<div style=" max-width:300px;word-break: break-all; word-wrap: break-word;">' + currentRow.address + '</div>'; //productname是列名
                    $this.tips({ content: content, wrapColor: 'black' });
               });
               var tableTd = $('div.datagrid-body td[field="needVerifyLevel"]'); // 鼠标滑过该row时显示
               tableTd.each(function () {
                    var $this = $(this);
                    var index = $this.parent('tr').attr('datagrid-row-index');
                    var rows = dataGrid.datagrid('getRows');
                    var currentRow = rows[index];
                   // var content = '<div style=" max-width:700px;word-break: break-all; word-wrap: break-word;">' + currentRow.imageUrl + '</div>'; //productname是列名
                    var content = '<div style=" max-width:300px;word-break: break-all; word-wrap: break-word;">' + needVerifyLevelSwitch(currentRow.needVerifyLevel) + '</div>'; //productname是列名
                    $this.tips({ content: content, wrapColor: 'black' });
               });
	         }
		});
	});
	function needVerifyLevelSwitch(level){
		switch(level){
			case 0:
				return "无需实名";
			case 1:
				return "真实姓名+证件号";
			case 2:
				return "真实姓名+证件号+证件正反照片";
			default:
				return level;
		}
	}
	function cancelOrder(orderNumber,id){
		if (orderNumber == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			orderNumber = rows[0].orderNumber;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要取消订单？', function(b) {
			if (b) {
				progressLoad();
				$.post('${ctx}/kaola/orderInfo/cancelOrder', {
					orderNumber : orderNumber,
					id:id
				}, function(result) {
					if (result.success) {
						parent.$.messager.alert('提示', result.msg, 'info');
						dataGrid.datagrid('reload');
					}else{
						parent.$.messager.alert('提示', result.msg, 'error');
						dataGrid.datagrid('reload');
					}
					progressClose();
				}, 'JSON');
			}
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
				$.post('${ctx}/kaola/orderInfo/delete', {
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
	function viewFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '詳情',
			width : 900,//详情也面宽度
			height : 600,//详情页面高度
			href : '${ctx}//kaola/orderInfo/viewPage?id=' + id
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
			href : '${ctx}/kaola/orderInfo/viewGoodsPage?orderNumber=' + orderNumber
		});
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
		<div>
			<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/orderInfo/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/orderInfo/informationCart')}">
				<a onclick="informationCartFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'">退款</a>
			</c:if> --%>
			  
<!--                 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeQR()" style="height: 20px">关闭</a>
 -->		</div>
		<!-- 	
		     <div id="dlg" class="easyui-dialog" title="Basic Dialog" style="width:400px;height:200px;padding:10px;">
	      	  The dialog content.
	   		 </div> 
	   	-->
	   		 
<!-- 	   	<div id="dlg" class="easyui-dialog" title="New Topic" style="width:100%;max-width:400px;padding:30px 60px;">
 --><!-- 	      
 	   	<div id="dlg" class="easyui-panel" title="" style="width:100%;max-width:1590px;padding:30px 60px;">
 			      <table>
 			      	<tr>
						<td>
							<div style="margin-bottom:20px">
				           	         订单编号：<input name="orderNumber" id="orderNumber" class="easyui-textbox"  style="width:250px" data-options="required:true" placeholder="请输入订单号">
				            </div>
				            <div style="margin-bottom:20px">
				           	         买家姓名：<input class="easyui-textbox" id="name" name="name" style="width:150px" data-options="required:true">
				            </div>
				            例如：金额输入框 最大值为“99999.99” 精确到两位小数。 <input name="money" id="money" type="text" class="easyui-numberbox" precision="2" max="99999.99" size="8" maxlength="8"  style="text-align:right;"/>
				            
				            <div style="margin-bottom:20px">
				              	支付金额：<input type="text" class="easyui-numberbox"  max="99999"   id="totalAmount" name="totalAmount" style="width:150px;text-align:right;" data-options="required:true">
				            </div>
				            <div style="margin-bottom:20px">
				                                         手机号码：<input class="easyui-numberbox" id="tell2"  max="19999999999" name="tell2" style="width:200px" data-options="required:true">
				            </div>
				             <a href="javascript:void(0)" class="easyui-linkbutton" onclick="createOrderNumber()" style="height: 20px">生成订单号</a>
				             <a href="javascript:void(0)" class="easyui-linkbutton" onclick="createRQ()" style="height: 20px">生成二维码</a>
				             <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearQR()" style="height: 20px">清空</a>
				             
						</td>
					<td><div id="show_contain"></div></td>
				</tr>
 			      </table>
   		</div> -->
	   		 
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单编号:</th>
						<td><input name="orderNumber" id="orderNumber" placeholder="请输入订单编号"/></td>
						<th>买家姓名:</th>
						<td><input name="name" id="name" placeholder="请输入买家姓名"/></td>
						<th>买家电话:</th>
						<td><input name="mobile" id="mobile" placeholder="请输入买家电话"/></td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
<!-- 						  <a href="javascript:void(0)" class="easyui-linkbutton" onclick="exportFun()" style="height: 20px" >导出</a>
 -->						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>