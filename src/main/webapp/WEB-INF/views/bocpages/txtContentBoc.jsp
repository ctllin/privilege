<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath}/jslib/echarts.min.js"></script>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtContentBoc/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/boc/txtContentBoc/dataGrid',
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'id',
			sortName : 'id',
			sortOrder : 'desc',
			pageSize : 15,
			pageList : [ 10, 15, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			columns : [ [ /* {
				width : '300',
				title : 'id',
				field : 'id',
				sortable : true
			}, */{
				width : '80',
				title : '文件日期',
				field : 'relativeTime',
				/* formatter : function(value, row, index) {
					return '<a href="${ctx}/alipay/tradeCallbackSuccessZfb/manager?outTradeNo='+value+'&currow=0&rows=30&page=1&sort=savetime">'+value+'</a>';
				}, */
				sortable : true
			}, {
				width : '80',
				title : '设备编号',
				field : 'terminalNum'
			}, {
				width : '60',
				title : 'batch',
				field : 'batch'
			}, {
				width : '150',
				title : '交易卡号',
				field : 'cardNumber'
			}, {
				width : '70',
				title : '交易日期',
				field : 'transDate'
			}, {
				width : '70',
				title : '交易时间',
				field : 'transTime'
			}, {
				width : '80',
				title : '总金额',
				field : 'tranAmount'
			}, {
				width : '80',
				title : '手续费',
				field : 'tranFee'
			}, {
				width : '80',
				title : '入账金额',
				field : 'balance'
			}, {
				width : '90',
				title : 'empowerNum',
				field : 'empowerNum'
			}, {
				width : '60',
				title : 'tranCode',
				field : 'tranCode'
			}, {
				width : '50',
				title : 'byStages',
				field : 'byStages'
			}, {
				width : '50',
				title : '卡类别',
				field : 'cbin'
			}, {
				width : '100',
				title : '参考号',
				field : 'referenceNum'
			}, {
				width : '30',
				title : 'fileId',
				field : 'fileId'
			}, {
				width : '150',
				title : '上传日期',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 60,
				formatter : function(value, row, index) {
				    initdata();//刷新日历
					var str = '&nbsp;';
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');">删除</a>', row.id);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
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
				$.post('${ctx}/boc/txtContentBoc/delete', {
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
	}
	function exportFun(){
		  var begintime=$('#begintime').val();
		  var endtime=$('#endtime').val();
		  if(begintime==null||""==begintime){
			  $('#begintime').focus();
			  parent.$.messager.alert('提示信息', '交易时间起始不能为空', 'success');
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
	     var urlDownload = '${ctx}/boc/txtContentBoc/export';//请求生成excel地址
		 $('#searchForm').attr("action", urlDownload).submit();
	}
	function initdata(){
	    $.post('${ctx}/boc/txtUploadBoc/transNumByDay', {
			
		}, function(result) {
				var currentYear=new Date().getFullYear();
		        //线性图表格
		        var myChart = echarts.init(document.getElementById('mainC'));
				 // 模拟数据
		        function getVirtulData(year) {
		            year = year ||currentYear;
		            var date = +echarts.number.parseDate(year + '-01-01');
		            var end = +echarts.number.parseDate(year + '-12-31');
		            var dayTime = 3600 * 24 * 1000;
		            var data = [];
		            for (var time = date; time <= end; time += dayTime) {//全部填充未上传
		                data.push([
		                    echarts.format.formatTime('yyyy-MM-dd', time),
		                    0
		                ]);
		            }
		            for(var i=1;i<result.length;i++){  //已经上传的
		                  console.log(result[i].transDate+"###"+ result[i].num);
		                    data.push([
		                    echarts.format.formatTime('yyyy-MM-dd',result[i].transDate),
		                    result[i].num
		                ]);
					}  
		            return data;
		        }
		        var option = {
		            tooltip: {
      				  position: 'top'
   				    },
		            visualMap: {
		                min: 0,
		                max: result[0].maxNum,
		                calculable: true,
			       	    orient: 'horizontal',
				        left: 'center',
				        top: 'top'
		            },
					 calendar: [
					    {
					        range: currentYear,
					        cellSize: ['auto', 20]
					    },
					    {
					        top: 260,
					        range: currentYear-1,
					        cellSize: ['auto', 20]
					    }/* ,
					    {
					        top: 450,
					        range: currentYear-2,
					        cellSize: ['auto', 20],
					        right: 5
					    } */],
					
					    series: [{
					        type: 'heatmap',
					        coordinateSystem: 'calendar',
					        calendarIndex: 0,
					        label: {
						            normal: {
						                show: true,
						                formatter: function (params) {
						                    var d = echarts.number.parseDate(params.value[0]);
                    						return d.getDate() ;
						                },
						                textStyle: {
						                     color: '#006edd'
						                }
						            }
						      },					     
					        data: getVirtulData(currentYear)
					    }, {
					        type: 'heatmap',
					        coordinateSystem: 'calendar',
					        calendarIndex: 1,
					        label: {
						            normal: {
						                show: true,
						                formatter: function (params) {
						                    var d = echarts.number.parseDate(params.value[0]);
                    						return d.getDate() ;
						                },
						                textStyle: {
						                     color: '#006edd'
						                }
						            }
						      },		
					        data: getVirtulData(currentYear-1)
					    }/* , {
					        type: 'heatmap',
					        coordinateSystem: 'calendar',
					        calendarIndex: 2,
					        data: getVirtulData(currentYear-2)
					    } */]
		
		        };
		        myChart.setOption(option);
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
		<div id="mainC" style="width:1200px;height:400px;" ></div>
		<div>
			<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtContentBoc/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtContentBoc/export')}">
				<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-export'">导出</a>
			</c:if> --%>
		</div>
		<div data-options="region:'north',border:false" style="height: 60px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>文件日期:</th>
						<td><input name="relativeTime" id="relativeTime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>
						
						<th>交易卡号:</th>
						<td><input name="cardNumber" id="cardNumber" placeholder="请输入交易卡号"/></td>
						<th>交易参考号:</th>
						<td><input name="referenceNum" id="referenceNum" placeholder="请输入交易参考号"/></td>
						
						<!-- <th>交易日期:</th>
						<td><input name="transDate" id="transDate"  placeholder="请输入交易日期"  onclick="WdatePicker({readOnly:true,dateFmt:'yyyyMMdd'})" readonly="readonly"  /></td>
						 -->
					
					</tr>
					<tr>
						<th>交易日期:</th>
						<td colspan="3">
						<input name="begintime" id="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        至<input  name="endtime"  id="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
					        </td><td colspan="2">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFun();">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="exportFun();" data-options="plain:true,iconCls:'icon-export'" style="height: 20px;color: #76C27A" >导出</a>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>