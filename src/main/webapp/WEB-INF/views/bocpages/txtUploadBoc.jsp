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
 <c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtUploadBoc/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtUploadBoc/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtUploadBoc/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
 <c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtUploadBoc/download')}">
	<script type="text/javascript">
		$.canDownload = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/boc/txtUploadBoc/dataGrid',
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'id',
			sortName : 'savetime',
			sortOrder : 'desc',
			pageSize : 15,
			pageList : [ 10, 15, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			frozenColumns : [ [ /* {
				width : '300',
				title : 'id',
				field : 'id',
				sortable : true
			}, */{
				width : '80',
				title : '上传用户名',
				field : 'loginname'
			}, {
				width : '200',
				title : '文件名',
				field : 'fileName'
			}, {
				width : '400',
				title : '文件存放路径 ',
				field : 'fileUrl'
			}, {
				width : '60',
				title : '解析结果',
				field : 'status',
				formatter : function(value, row, index) {
					switch(value){
						case '0':
							return '初始化';
							break;
						case '1':
							return '解析成功';
							break;
						case '2':
							return '解析失败';
							break;
					}
				}
			}, {
				width : '80',
				title : '交易日期',
				field : 'relativeTime'
			}, {
				width : '150',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 120,
				formatter : function(value, row, index) {
				    initdata();//刷新日历删除增加后刷新
					var str = '&nbsp;';
					if ($.canView) {
						str += $.formatString('<a href="javascript:void(0)" onclick="viewFun(\'{0}\');" >查看</a>', row.id);
					}
					if ($.canEdit) {
				   		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					}
					if ($.canDelete) {
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					if($.canDownload){///boc/txtUploadBoc/download
						var indexStr=row.fileUrl.indexOf('boc');
						var path='${ctx}/boctxt'+row.fileUrl.substr(indexStr+3);
					    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="downloadFun(\'{0}\');" >下载</a>', path);
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	function downloadFun(url){
		  window.open(url);
	}
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 350,
			height : 600,
			href : '${ctx}/boc/txtUploadBoc/addPage',
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
				$.post('${ctx}/boc/txtUploadBoc/delete', {
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
			href : '${ctx}/boc/txtUploadBoc/editPage?id=' + id,
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
			href : '${ctx}/boc/txtUploadBoc/viewPage?id=' + id
		});
	}
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	function searchUnuploadFun(){
		$.post('${ctx}/boc/txtUploadBoc/searchUnupload', {
		}, function(result) {
			if (result.success) {
				parent.$.messager.alert('提示', result.msg, 'info');
			}else{
				parent.$.messager.alert('提示', result.msg, 'error');
			}
			progressClose();
		}, 'JSON');
	}
	function uploadFun() {
		parent.$.modalDialog({
			title : '上传文件',
			width : 600,
			height : 300,
			href : '${ctx}/boc/txtUploadBoc/upload',
			buttons : [ {
				text : '上传',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#uploadForm');//对应.jsp的from  id
					f.submit();
				}
			} ]
		});
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
	    	  if(diff>31){
	    		  parent.$.messager.alert('提示信息', '请选择一个月以内数据！', 'success');
	              return;
	    	  }
	      }
	     var urlDownload = '${ctx}/boc/txtUploadBoc/exportCwTxt';//请求生成excel地址
		 $('#searchForm').attr("action", urlDownload).submit();
	}
	function initdata(){
	    $.post('${ctx}/boc/txtUploadBoc/unUploadCheck', {
			
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
		            for(var i=0;i<result.length;i++){  //已经上传的
		                    data.push([
		                    echarts.format.formatTime('yyyy-MM-dd',result[i]),
		                    1
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
		                max: 1,
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
		<div id="mainC" style="width:1200px;height:400px;"></div>
	
		<div>
			<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtUploadBoc/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if> --%>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/boc/txtUploadBoc/upload')}">
				<a onclick="uploadFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">上传</a>
			</c:if>
			<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-save'">财务导出</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchUnuploadFun();">检查未上传</a>
		</div>
	
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<!-- <th>订单号:</th>
						<td><input name="orderNumber" id="orderNumber" placeholder="请输入订单号"/></td> -->
						<th>交易日期:</th>
						<td><input name="relativeTime" id="relativeTime" placeholder="点击选择日期" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80px"/></td>
						<th>创建时间:</th>
						<td>
						<input name="begintime" id="begintime" placeholder="点击选择日期" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80px"/>
					        至<input  name="endtime"  id="endtime" placeholder="点击选择日期" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80px"/>
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