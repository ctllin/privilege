<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <c:if test="${fn:contains(sessionInfo.resourceList, '/boc/tradeOrdersSeatBoc/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/tradeOrdersSeatBoc/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/tradeOrdersSeatBoc/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/tradeOrdersSeatBoc/payStatusQuery')}">
	<script type="text/javascript">
		$.canQuery = true;
	</script>
</c:if>
<c:if test="${sessionInfo.loginname=='admin'}">
	<script type="text/javascript">
		$.userAdmin = true;
	</script>
</c:if>
<title>DEMO管理</title>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/boc/tradeOrdersSeatBoc/dataGrid',
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
				width : '230',
				title : '订单号',
				field : 'orderNumber',
				/* formatter : function(value, row, index) {
					return '<a href="${ctx}/alipay/tradeCallbackSuccessZfb/manager?outTradeNo='+value+'&currow=0&rows=30&page=1&sort=savetime">'+value+'</a>';
				}, */
				sortable : true
			}, {
				width : '80',
				title : '用户名',
				field : 'passengerName'
			}, {
				width : '90',
				title : '用户电话 ',
				field : 'passengerPhone'
			}, {
				width : '110',
				title : '卡号',
				field : 'cardNOMask'
			}, {
				width : '140',
				title : '证件号',
				field : 'IDcard'
			}, {
				width : '40',
				title : '航渠',
				field : 'orderFrom',
				formatter : function(value, row, index) {
					if(row.flightNumber!=null&&row.flightNumber.length>=2){
						return row.flightNumber.substring(0,2);
					}else{
						return '';
					}
				}
			}, {
				width : '120',
				title : '刷卡状态',
				field : 'orderStatus'
			}, {
				width : '80',
				title : '总金额',
				field : 'totalMoney'
			}, {
				width : '60',
				title : '航班号',
				field : 'flightNumber'
			}, {
				width : '60',
				title : '航段',
				field : 'flightPhase'
			}, {
				width : '40',
				title : '类型',
				field : 'type'
			}, {
				width : '100',
				title : '始发地',
				field : 'original'
			}, {
				width : '100',
				title : '目的地',
				field : 'destination'
			}, {
				width : '80',
				title : '支付结果',
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
					    default:
					    	return	'请查询';
					}   
				}
			}, {
				width : '130',
				title : '订单日期',
				field : 'date'
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
						str += $.formatString('<a href="javascript:void(0)" onclick="viewFun(\'{0}\');" >详情</a>', row.id);
					}
					//if ($.canEdit) {
				   		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');">编辑</a>', row.id);
					//}
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');">删除</a>', row.id);
					}
					if ($.canQuery) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="queryFun(\'{0}\');">支付结果</a>', row.id);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			//处理行颜色
			rowStyler: function(index,row){
				if (row.responseCode=='0000'){
					//return 'background-color:#DF0700;color:#fff;font-weight:bold;';
					//return 'background-color:#F0E5CC;';
					if($.userAdmin){
						//return 'background-color:#F0E5CC;';
					}else{
						return 'background-color:#797D7C;';
					}
				}
				if(row.cardNOMask==null||""==cardNOMask){
					//return 'background-color:#93DA5E;';
					if($.userAdmin){
						return 'background-color:#93DA5E;';
					}else{
						return 'background-color:#EEEEEE;';
					}
				}
				if (row.responseCode!='0000'){
					//return 'background-color:#DF0700;color:#fff;font-weight:bold;';
					//return 'background-color:#F0E5CC;';
					if($.userAdmin){
						return 'background-color:#F0E5CC;';
					}else{
						return 'background-color:#BC2538;';
					}
				}
			}
		});
	});
	
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 350,
			height : 600,
			href : '${ctx}/boc/tradeOrdersSeatBoc/addPage',
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
				$.post('${ctx}/boc/tradeOrdersSeatBoc/delete', {
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
	//查询支付结果
	function queryFun(id) {
				$.post('${ctx}/boc/tradeOrdersSeatBoc/payStatusQuery', {
					id : id
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
	
	function viewFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		
		parent.$.modalDialog({
			title : '詳情',
			width : 800, //详情也面宽度
			height : 600, //详情页面高度
			href : '${ctx}/boc/tradeOrdersSeatBoc/viewPage?id=' + id
		});
	}
	
	function searchFun() {
		/*  var paystatus=$('#paystatus').combobox('getValue').trim();//easyui 获取选中值  航空公司：HU、Y8
		 if(paystatus==null||""==paystatus){
			  $('#paystatus').focus();
			  parent.$.messager.alert('提示信息', '支付方式不能为空,请选中并点击支付方式', 'success');
			  return;
		 }
		 var dataType=$('#dataType').combobox('getValue').trim();//easyui 获取选中值  航空公司：HU、Y8
		 if(dataType==null||""==dataType){
			  $('#dataType').focus();
			  parent.$.messager.alert('提示信息', '数据不能为空,请选中并点击数据类型', 'success');
			  return;
		 }
		  */
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	function uploadRgdFun(){
		  var begintime=$('#begintime').val();
		  var orderNumber=$('#orderNumber').val();
		  var endtime=$('#endtime').val();
		  var airCompany=$('#airCompany').combobox('getValue').trim();//easyui 获取选中值  航空公司：HU、Y8
		  if(begintime==null||""==begintime){
			  $('#begintime').focus();
			  parent.$.messager.alert('提示信息', '开始时间不能为空', 'success');
			  return;
		  }
		  if(endtime==null||""==endtime){
			  $('#endtime').focus();
			  parent.$.messager.alert('提示信息', '至时间不能为空', 'success');
			  return;
		  }
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
	      $.post('${ctx}/boc/tradeOrdersSeatBoc/rgdUpload', {
		    	begintime : begintime,
		    	endtime:endtime,
		    	airCompany:airCompany,
		    	orderNumber:orderNumber
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
	function exportRgdFun(){
		  var begintime=$('#begintime').val();
		  var endtime=$('#endtime').val();
		  if(begintime==null||""==begintime){
			  $('#begintime').focus();
			  parent.$.messager.alert('提示信息', '开始时间不能为空', 'success');
			  return;
		  }
		  if(endtime==null||""==endtime){
			  $('#endtime').focus();
			  parent.$.messager.alert('提示信息', '至时间不能为空', 'success');
			  return;
		  }
		  var start = new Date(begintime.replace("-", "/").replace("-", "/"));
	      var end = new Date(endtime.replace("-", "/").replace("-", "/"));
	      if (end < start) {
	          parent.$.messager.alert('提示信息', '结束日期不能小于开始日期！', 'success');
	          return;
	      }else{
	    	  var diff = parseInt((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24)); //天数
	    	  if(diff>93){
	    		  parent.$.messager.alert('提示信息', '请选择三个月以内数据！', 'success');
	              return;
	    	  }
	      }
	     var urlDownload = '${ctx}/boc/tradeOrdersSeatBoc/rgdExport';//请求生成excel地址
		 $('#searchForm').attr("action", urlDownload).submit();
	}
	function exportFun(){
 		  var begintime=$('#begintime').val();
		  var endtime=$('#endtime').val();
		  if(begintime==null||""==begintime){
			  $('#begintime').focus();
			  parent.$.messager.alert('提示信息', '开始时间不能为空', 'success');
			  return;
		  }
		  if(endtime==null||""==endtime){
			  $('#endtime').focus();
			  parent.$.messager.alert('提示信息', '至时间不能为空', 'success');
			  return;
		  }
		  var start = new Date(begintime.replace("-", "/").replace("-", "/"));
	      var end = new Date(endtime.replace("-", "/").replace("-", "/"));
	      if (end < start) {
	          parent.$.messager.alert('提示信息', '结束日期不能小于开始日期！', 'success');
	          return;
	      }else{
	    	  var diff = parseInt((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24)); //天数
	    	  if(diff>365){
	    		  parent.$.messager.alert('提示信息', '请选择三个月以内数据！', 'success');
	              return;
	    	  }
	      }
	     var urlDownload = '${ctx}/boc/tradeOrdersSeatBoc/export';//请求生成excel地址
	     $('#exportType').val('3');
		 $('#searchForm').attr("action", urlDownload).submit();
	}
	function uploadFun(){
 		  var begintime=$('#begintime').val();
		  var endtime=$('#endtime').val();
		  var airCompany=$('#airCompany').combobox('getValue').trim();//easyui 获取选中值  航空公司：HU、Y8
		  if(begintime==null||""==begintime){
			  $('#begintime').focus();
			  parent.$.messager.alert('提示信息', '开始时间不能为空', 'success');
			  return;
		  }
		  if(endtime==null||""==endtime){
			  $('#endtime').focus();
			  parent.$.messager.alert('提示信息', '至时间不能为空', 'success');
			  return;
		  }
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
	    $.post('${ctx}/boc/tradeOrdersSeatBoc/upload', {
	    	begintime : begintime,
	    	endtime:endtime,
	    	airCompany:airCompany,
	    	exportType:3
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
	
	function exportJournalFun(){
	  var begintime=$('#begintime').val();
	  var endtime=$('#endtime').val();
	  if(begintime==null||""==begintime){
		  $('#begintime').focus();
		  parent.$.messager.alert('提示信息', '开始时间不能为空', 'success');
		  return;
	  }
	  if(endtime==null||""==endtime){
		  $('#endtime').focus();
		  parent.$.messager.alert('提示信息', '至时间不能为空', 'success');
		  return;
	  }
	  var start = new Date(begintime.replace("-", "/").replace("-", "/"));
      var end = new Date(endtime.replace("-", "/").replace("-", "/"));
      if (end < start) {
          parent.$.messager.alert('提示信息', '结束日期不能小于开始日期！', 'success');
          return;
      }else{
    	  var diff = parseInt((end.getTime() - start.getTime()) / (1000 * 60 * 60 * 24)); //天数
    	  if(diff>183){
    		  //parent.$.messager.alert('提示信息', '请选择一个月以内数据！', 'success');
    		  parent.$.messager.alert('提示信息', '请选择六个月以内数据！', 'success');
              return;
    	  }
      }
     var urlDownload = '${ctx}/boc/tradeOrdersSeatBoc/export';//请求生成excel地址
     $('#exportType').val('1');
	 $('#searchForm').attr("action", urlDownload).submit();
	}
	function uploadJournalFun(){
		  var begintime=$('#begintime').val();
		  var endtime=$('#endtime').val();
		  var airCompany=$('#airCompany').combobox('getValue').trim();//easyui 获取选中值  航空公司：HU、Y8
		  if(begintime==null||""==begintime){
			  $('#begintime').focus();
			  parent.$.messager.alert('提示信息', '开始时间不能为空', 'success');
			  return;
		  }
		  if(endtime==null||""==endtime){
			  $('#endtime').focus();
			  parent.$.messager.alert('提示信息', '至时间不能为空', 'success');
			  return;
		  }
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
	    $.post('${ctx}/boc/tradeOrdersSeatBoc/upload', {
	    	begintime : begintime,
	    	endtime:endtime,
	    	airCompany:airCompany,
	    	exportType:1
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
	
	function initDateTime(){
		var date = new Date(); 
	    var seperator1 = "-"; 
	   // var seperator2 = ":"; 
	    var month = date.getMonth() + 1; 
	    var strDate = date.getDate(); 
	    if (month >= 1 && month <= 9) { 
	        month = "0" + month; 
	    } 
	    if (strDate >= 0 && strDate <= 9) { 
	        strDate = "0" + strDate; 
	    } 
	    /* var getHours=date.getHours();
	    if(getHours<10){
	    	getHours = "0" + getHours; 
	    }
	    var getMinutes=date.getMinutes() ;
	    if(getMinutes<10){
	    	getMinutes = "0" + getMinutes; 
	    }
	    var getSeconds=date.getSeconds();
	    if(getSeconds<10){
	    	getSeconds = "0" + getSeconds; 
	    } */
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate ;
	          /*   + " " + getHours + seperator2 + getMinutes 
	            + seperator2 + getSeconds;  */
		document.getElementById("endtime").value=currentdate;
	    date.setMonth(date.getMonth()-1); 
	    strMonth = date.getMonth()+1;
		if (strMonth >= 0 && strMonth <= 9) { 
			strMonth = "0" + strMonth; 
		} 
		strDate = date.getDate();
		if (strDate >= 0 && strDate <= 9) { 
		        strDate = "0" + strDate; 
		} 
		currentdate = date.getFullYear() + seperator1 + strMonth + seperator1 + strDate; 
	    /*  + " " + getHours + seperator2 + getMinutes 
	     + seperator2 + getSeconds;  */
		document.getElementById("begintime").value=currentdate;
		$('#dlg').dialog('close');
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
			height : 600,
			href : '${ctx}/boc/tradeOrdersSeatBoc/editPage?id=' + id,
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
	
	function closeQR(){
    	$('#dlg').dialog('close');
    	clearQR();
	}
	//新增订单补填信息
	function makeOrderSeat(){
		var orderNumber=$('#orderNumber2').textbox('getValue').trim();
		if(orderNumber==null||""==orderNumber||orderNumber.length<16){
			  $('#orderNumber2').focus();
			  parent.$.messager.alert('提示信息', '订单号不能为空或订单号小于16位', 'info');
			  return;
		}
		$.ajax({
			type:'post',
		    url:'${ctx}/boc/tradeOrdersSeatBoc/getPayinfo', //该地址为生产地址暂未启用
	     	contentType:'application/json;charset=UTF-8',
	     	dataType:'json', 
			data:'{"orderNumber":"'+orderNumber+'"}',
			success:function(result){
				$("#totalMoney").textbox('setValue',result.sAmountLoc/100);
				$("#cardNOMask2").textbox('setValue',result.sCardNOMask);
				$("#terminalID").textbox('setValue',result.sTerminalID);
				$("#responseDesc").textbox('setValue',result.sResponseDesc);
				$("#responseCode").textbox('setValue',result.sResponseCode);
				$("#sysUniqueID").textbox('setValue',result.sSysUniqueID);
				$("#offTransDate").textbox('setValue',result.sTransDate);
				$("#offTransTime").textbox('setValue',result.sTransTime);
				$("#uniqueCode").textbox('setValue',result.uniqueCode);
				$("#savetime").val(result.savetime);
			}
		});
	}
	var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
	function generateMixed(n) {
	     var res = "";
	     for(var i = 0; i < n ; i ++) {
	         var id = Math.ceil(Math.random()*35);
	         res += chars[id];
	     }
	     return res;
	}
	Date.prototype.format = function (format) {
	      var args = {
	          "M+": this.getMonth() + 1,
	          "d+": this.getDate(),
	          "h+": this.getHours(),
	          "m+": this.getMinutes(),
	          "s+": this.getSeconds(),
	      };
	      if (/(y+)/.test(format))
	          format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	      for (var i in args) {
	          var n = args[i];
	          if (new RegExp("(" + i + ")").test(format))
	              format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? n : ("00" + n).substr(("" + n).length));
	      }
	      return format;
	};
	function clearAdd() {
		$('#addForm input').val('');
		var num=Math.floor(Math.random()*10000000000);
		var orderNumber=new Date().format("yyyyMMddhhmmss")+num+generateMixed(10-num.toString().length);
		$('#orderNumber2').textbox('setValue',orderNumber);
		$('#orderStatus').textbox('setValue',"交易成功");
	}
	function orderSeatAdd(){
		var orderNumber=$('#orderNumber2').textbox('getValue').trim().trim();
		var passengerName=$('#passengerName2').textbox('getValue').trim().trim();
		var passengerPhone=$('#passengerPhone').numberbox('getValue').trim();
		var totalMoney=$('#totalMoney').numberbox('getValue').trim();
		var cardNOMask=$('#cardNOMask2').textbox('getValue').trim();
		var idCard=$('#idCard').textbox('getValue').trim();
		var responseCode=$('#responseCode').textbox('getValue').trim();
		var responseDesc=$('#responseDesc').textbox('getValue').trim();
		var flightNumber=$('#flightNumber').textbox('getValue').trim();
		var flightPhase=$('#flightPhase').textbox('getValue').trim();
		var original=$('#original').textbox('getValue').trim();
		var destination=$('#destination').textbox('getValue').trim();
		var oldSeat=$('#oldSeat').textbox('getValue').trim();
		var newSeat=$('#newSeat').textbox('getValue').trim();
		var address=$('#address').textbox('getValue').trim();
		var sysUniqueID=$('#sysUniqueID').textbox('getValue').trim();
		var passengerTicketName=$('#passengerTicketName').textbox('getValue').trim();
		var uniqueCode=$('#uniqueCode').textbox('getValue').trim();
		var terminalID=$('#terminalID').textbox('getValue').trim();
		var orderFrom=$('#orderFrom').combobox('getValue').trim();
		var payStatus=$('#payStatus').combobox('getValue').trim();
		var type=$('#type').combobox('getValue').trim();
		var date=$('#date').val();
		var savetime=$('#savetime').val();
		if(payStatus==null||""==payStatus){
			  $('#payStatus').focus();
			  parent.$.messager.alert('提示信息', '支付状态不能为空', 'info');
			  return;
		}
		if(date==null||""==date){
			  $('#date').focus();
			  parent.$.messager.alert('提示信息', '订单时间不能为空', 'info');
			  return;
		}
		if(savetime==null||""==savetime){
			  $('#savetime').focus();
			  parent.$.messager.alert('提示信息', '交易时间不能为空', 'info');
			  return;
		} 
		var offTransDate=$('#offTransDate').textbox('getValue').trim();
		var otherPhone=$('#otherPhone').numberbox('getValue').trim();
		var invoiceAddress=$('#invoiceAddress').textbox('getValue').trim();
		var invoiceCell=$('#invoiceCell').textbox('getValue').trim();
		var invoiceName=$('#invoiceName').textbox('getValue').trim();
		var invoiceTitle=$('#invoiceTitle').textbox('getValue').trim();
		var orderDescript=$('#orderDescript').textbox('getValue').trim();
		var status=$('#status').textbox('getValue').trim();
		var offTransTime=$('#offTransTime').textbox('getValue').trim();
		var purserName=$('#purserName').textbox('getValue').trim();
		var purserCellphone=$('#purserCellphone').numberbox('getValue').trim();
		var orderStatus=$('#orderStatus').textbox('getValue').trim();
		var moneyType=$('#moneyType').textbox('getValue').trim();
		$.post('${ctx}/boc/tradeOrdersSeatBoc/add', {
			orderNumber : orderNumber,
			purserName : purserName,
			type : type,
			orderStatus : orderStatus,
			purserCellphone : purserCellphone,
			passengerName:passengerName,
			passengerPhone:passengerPhone,
			totalMoney:totalMoney,
			idCard: idCard,
			responseCode: responseCode,
			responseDesc: responseDesc,
			flightNumber: flightNumber,
			flightPhase: flightPhase,
			cardNOMask: cardNOMask,
			oldSeat: oldSeat,
			original: original,
			destination: destination,
			newSeat: newSeat,
			address: address,
			sysUniqueID: sysUniqueID,
			passengerTicketName: passengerTicketName,
			uniqueCode: uniqueCode,
			terminalID: terminalID,
			orderFrom: orderFrom,
			offTransDate: offTransDate,
			moneyType: moneyType,
			invoiceAddress: invoiceAddress,
			invoiceCell: invoiceCell,
			invoiceName: invoiceName,
			invoiceTitle: invoiceTitle,
			status: status,
			orderDescript: orderDescript,
			offTransTime: offTransTime,
			payStatus:payStatus,
			date: date,
			otherPhone: otherPhone,
			savetime: new Date(savetime)
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
	$(function(){//默认关闭弹出框
	    initDateTime();
		//$("#show_contain").html('');//先清空
		$("#orderNumber").numberbox('textbox').attr('maxlength', 24); 
		$('#dlg').dialog('close');
		var num=Math.floor(Math.random()*10000000000);
		var orderNumber=new Date().format("yyyyMMddhhmmss")+num+generateMixed(10-num.toString().length);
		$("#orderNumber").textbox('setValue',orderNumber);
		
	});
	function matchingSeatOrder(){
		var begintime=$('#begintime').val();
		var endtime=$('#endtime').val();
		$.ajax({
			type:'post',
		    url:'${ctx}/boc/tradeOrdersSeatBoc/matchSeatOrder', //该地址为生产地址暂未启用
	     	//contentType:'application/json;charset=UTF-8',
	     	//dataType:'json', 
		    data:'begintime='+begintime+'&endtime='+endtime,
			success:function(result){
				result=$.parseJSON(result);
				if(result.success){
				   parent.$.messager.alert('提示信息', result.msg, 'info');
				}else{
				   parent.$.messager.alert('提示信息', result.msg, 'error');
				}
			}
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
			<a onclick="exportRgdFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A" >导出认购单</a>
			<a onclick="uploadRgdFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A" >上传认购单</a>
			<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A" >下载座选升舱</a>
			<a onclick="uploadFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A" >上传座选升舱</a>
			<a onclick="exportJournalFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A" >下载座选升舱日流水</a>
			<a onclick="uploadJournalFun();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A" >上传座选升舱日流水</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('open')" style="height: 20px;color: #76C27A"  >创建订单</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeQR()" style="height: 20px;color: #76C27A" >关闭</a>
            <a onclick="matchingSeatOrder();" href="javascript:void(0);" class="easyui-linkbutton" style="height: 20px;color: #76C27A" >检索缺失订单</a>
		</div>
		<!-- 添加订单页面 start -->
		<jsp:include page="addOrderSeat.jsp"></jsp:include>
		<!-- 添加订单页面 end -->
		<div data-options="region:'north',border:false" style="height: 60px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="orderNumber" id="orderNumber" placeholder="请输入订单号"  style="width: 220px"/></td>
						<th>姓名:</th>
						<td><input name="passengerName" id="passengerName" placeholder="输入姓名" style="width: 50px" /></td>
						<th>卡号:</th>
						<td><input name="cardNOMask" id="cardNOMask" placeholder="输入卡号" style="width: 110px" /></td>
						<th>证件号:</th>
						<td><input name="idCard" id="idCard" placeholder="请输入证件号"/></td>
						<!-- <th>金额:</th>
						<td><input name="totalAmount" id="totalAmount" placeholder="请输入订单金额"/></td> -->
						
					</tr>
					<tr>
					<th>交易日期:</th>
						<td>
						<input name="begintime" id="begintime" style="width: 80px" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime"  style="width: 80px" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					     </td>
						<th>  支付结果:</th>
						<td>
					   <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='payStatus' id='payStatus'>
					   			<option value="">全部</option>
				                <option value="0">未支付</option>
				                <option value="1">支付成功</option>
				                <option value="2">支付失败</option>
				                <option value="3">已经退款</option>
				                <option value="4">订单作废</option>
				       </select>
				       </td>
				      <!--  &nbsp;&nbsp;数据:
					   <select class="easyui-combobox" id="dataType" name='dataType'  label="State:" labelPosition="top" style="width:150px;" >
					   			 <option value="0">全部</option>
                      			 <option value="1">正式数据</option>
                      			 <option value="2">测试数据</option>
				       </select> 
				       &nbsp;&nbsp;航空公司:<select id="airCompany" name="airCompany" class="easyui-combobox" data-options="editable:false,panelHeight:'auto'">
								<option value="">全部</option>
								<option value="HU">HU</option>
								<option value="IU">IU</option>
								<option value="SU">SU</option>
								<option value="JD">JD</option>
								<option value="JP">JP</option>
								<option value="GS">GS</option>
								<option value="Y8">Y8</option>
								<option value="GT">GT</option>
								<option value="HD">HD</option>
								<option value="9H">9H</option>
								<option value="BK">8L</option>
								<option value="8L">8L</option>
								</select>-->
								<td colspan="2">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
						</td>
					</tr>
				</table>
				<input type='hidden' name='exportType' id='exportType' value=''/><!-- 1导出一张报表  3导出三张报表 -->
				<input type='hidden' name='ftpFlag' id='ftpFlag' value=''/><!-- 1上传 2下载 -->
			</form>
		</div>
	</div>
</body>
</html>