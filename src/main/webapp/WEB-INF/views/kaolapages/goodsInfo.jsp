<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/goodsInfo/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if> --%>
<c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/goodsInfo/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/goodsInfo/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/goodsInfo/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
--%>
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
			url : '${ctx}' + '/kaola/goodsInfo/dataGrid',
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
				width : '70',
				title : '品牌国',
				field : 'brandCountryName',
				sortable : true
			},{
				width : '120',
				title : '品牌',
				field : 'brandName'
			}, {
				width : '300',
				title : '商品名称',
				field : 'title'
			}, {
				width : '300',
				title : '商品分类',
				field : 'category'
			},{
				width : '70',
				title : '类型',
				field : 'importType',
				formatter : function(value, row, index) {
					switch(value){
						case 0:
							return '直邮';
						case 1:
							return '保税';
						case 2:
							return '海淘';
						case 3:
							return '国内售卖';
						default:
							return value;
					}
				}
			},{
				width : '70',
				title : '上/下架',
				field : 'onlineStatus',
				formatter : function(value, row, index) {
					switch(value){
						case 0:
							return '下架';
						case 1:
							return '上架';
						default:
								return value;
					}
				}
			}, {
				width : '70',
				title : '库存',
				field : 'store',
				styler: cellStyler
			}, {
				width : '70',
				title : '考拉价',
				field : 'suggestPrice'
			}, {
				width : '70',
				title : '市场指导价',
				field : 'marketPrice'
			}, {
				width : '70',
				title : '供货价',
				field : 'price'
			}, {
				width : '130',
				title : '更新时间',
				field : 'updatetime'
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
               // var tableTd = $('div.datagrid-body td[field="title"]'); //title是列名 鼠标滑过title列时显示
               var tableTd = $('div.datagrid-body td'); // 鼠标滑过该row时显示
               tableTd.each(function () {
                    var $this = $(this);
                    var index = $this.parent('tr').attr('datagrid-row-index');
                    var rows = dataGrid.datagrid('getRows');
                    var currentRow = rows[index];
                   // var content = '<div style=" max-width:700px;word-break: break-all; word-wrap: break-word;">' + currentRow.imageUrl + '</div>'; //productname是列名
                    var content = '<div style=" max-width:300px;word-break: break-all; word-wrap: break-word;"><img style="width:100%" src="' + currentRow.imageUrl + '"/></div>'; //productname是列名
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
				$.post('${ctx}/kaola/goodsInfo/delete', {
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
	$(function(){//默认关闭弹出框
		$("#show_contain").html('');//先清空
		$("#orderNumber").numberbox('textbox').attr('maxlength', 24); 
		$('#dlg').dialog('close');
		var num=Math.floor(Math.random()*10000000000);
		var orderNumber=new Date().format("yyyyMMddhhmmss")+num+generateMixed(10-num.toString().length);
		$("#orderNumber").textbox('setValue',orderNumber);
	});
	function createRQ(){
		var orderNumber=$('#orderNumber').textbox('getValue');
		var name=$('#name').textbox('getValue');
		var totalAmount=$('#totalAmount').textbox('getValue');
		var tell2=$('#tell2').textbox('getValue');
		if(orderNumber==null||""==orderNumber||orderNumber.length<16){
			  $('#orderNumber').focus();
			  parent.$.messager.alert('提示信息', '订单号不能为空或订单号小于16位', 'info');
			  return;
		}
		if(name==null||""==name){
			  $('#name').focus();
			  parent.$.messager.alert('提示信息', '买家姓名不能为空', 'info');
			  return;
		}
		if(totalAmount==null||""==totalAmount){
			  $('#totalAmount').focus();
			  parent.$.messager.alert('提示信息', '支付金额不能为空', 'info');
			  return;
		}
		if(tell2==null||""==tell2){
			  $('#tell2').focus();
			  parent.$.messager.alert('提示信息', '电话号码不能为空', 'info');
			  return;
		}
   	    var s = getQRcodeStr(name,totalAmount,"0","AIRHUB01",tell2,orderNumber);//这里自己输入固定的参数值  buyername  price count ,, tele
		$("#show_contain").html('').qrcode({width:360,height:360,text:toUtf8(s)});
	}
	function createOrderNumber(){
		var num=Math.floor(Math.random()*10000000000);
		var orderNumber=new Date().format("yyyyMMddhhmmss")+num+generateMixed(10-num.toString().length);
		$("#orderNumber").textbox('setValue',orderNumber);
		$("#show_contain").html('');//先清空
	}
	function clearQR(){
		$("#orderNumber").textbox('setValue','');
		$("#name").textbox('setValue','');
		$("#totalAmount").textbox('setValue','');
		$("#tell2").textbox('setValue','');
		$("#show_contain").html('');//先清空
	}
	function closeQR(){
    	$('#dlg').dialog('close');
    	clearQR();
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
			href : '${ctx}//kaola/goodsInfo/viewPage?id=' + id
		});
	}
	function exportFun(){
		  var begintime=$('#begintime').val();
		  var endtime=$('#endtime').val();
		 /*  if(begintime==null||""==begintime){
			  $('#begintime').focus();
			  parent.$.messager.alert('提示信息', '开始时间不能为空', 'success');
			  return;
		  }
		  if(endtime==null||""==endtime){
			  $('#endtime').focus();
			  parent.$.messager.alert('提示信息', '至时间不能为空', 'success');
			  return;
		  } */
		  if(begintime!=null&&endtime!=null){
			  var start = new Date(begintime.replace("-", "/").replace("-", "/"));
		      var end = new Date(endtime.replace("-", "/").replace("-", "/"));
		      if (end < start) {
		          parent.$.messager.alert('提示信息', '结束日期不能小于开始日期！', 'success');
		          return;
		      }else{
		    	  var diff = parseInt((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24)); //天数
		    	  if(diff>31){
		    		  parent.$.messager.alert('提示信息', '请选择一个月以内数据！', 'success');
		              return;
		    	  }
		      }
		  }
	     var urlDownload = '${ctx}/kaola/goodsInfo/export';//请求生成excel地址
		 $('#searchForm').attr("action", urlDownload).submit();
	}
	function flushFun(){
		progressLoad();
		$.post('${ctx}/kaola/goodsInfo/flush', {
		}, function(result) {
			if (result.success) {
				dataGrid.datagrid('reload');
				parent.$.messager.alert('提示', result.msg, 'info');
			}else{
				parent.$.messager.alert('提示', result.msg, 'error');
			}
			progressClose();
		}, 'JSON');
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
			<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/goodsInfo/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/kaola/goodsInfo/informationCart')}">
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
						<th>商品编号(精确):</th>
						<td><input name="goodsId" id="goodsId" placeholder="请输入商品编号"/></td>
						<th>商品SKUID:</th>
						<td><input name="skuId" id="skuId" placeholder="请输入商品SKUID"/></td>
						<th>类型:</th>
						<td>
						     <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='importType' id='importType'>
					   			<option value="">全部</option>
								<option value="0">直邮</option>                          	
								<option value="1">保税</option>                        	
								<option value="2">海淘</option>                        	
								<option value="3">国内售卖</option>                          	
				       		</select>
				       	</td>
				       	<th>上/下架:</th>
						<td>
						     <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='onlineStatus' id='onlineStatus'>
					   			<option value="">全部</option>
								<option value="0">下架</option>                          	
								<option value="1">上架</option>                        	
				       		</select>
				       	</td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
						  <a href="javascript:void(0)" class="easyui-linkbutton" onclick="exportFun()" style="height: 20px;color: #76C27A"  >导出</a>
						  <a href="javascript:void(0)" class="easyui-linkbutton" onclick="flushFun()" style="height: 20px;color: #76C27A"  >更新数据</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>