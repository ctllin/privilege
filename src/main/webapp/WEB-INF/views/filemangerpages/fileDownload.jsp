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
 <c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/fileDownload/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/fileDownload/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/fileDownload/view')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<title>DEMO管理</title>
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/filemanager/fileDownload/dataGrid',
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
				title : '序列号',
				field : 'serialNumber',
				sortable : true
			}, {
				width : '130',
				title : 'macId',
				field : 'macId'
			}, {
				width : '60',
				title : '版本',
				field : 'apkVersionName'
			}, {
				width : '80',
				title : '状态',
				field : 'status'
			}, {
				width : '80',
				title : '时间差',
				field : 'timediff'
			}, {
				width : '90',
				title : '航渠',
				field : 'airCompany'
			}, {
				width : '90',
				title : '基地名称',
				field : 'cityName'
			}, {
				width : '90',
				title : '终端编号',
				field : 'termId'
			}, {
				width : '90',
				title : 'mpos编号',
				field : 'mposId'
			}, {
				width : '150',
				title : '上送时间',
				field : 'downflag'
			}, {
				width : '150',
				title : 'apkInstallTime',
				field : 'firstOpenTime'
			}, {
				width : '150',
				title : '更新时间',
				field : 'updatetime'
			}, {
				width : '150',
				title : '创建时间',
				field : 'savetime'
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
	
	//加载图表 start
	$(function(){
		   $.ajax({
	            //提交数据的类型 POST GET
	            type:"POST",
	            //提交的网址
	            //url:"http://localhost:8080/lightmanger/filemanager/fileDownload/fileDownloadPie",
	            url:"<%=request.getContextPath()%>/filemanager/fileDownload/fileDownloadPie",
	            //提交的数据
	            data:{},
	            //返回数据的格式
	            datatype: "html",//"xml", "html", "script", "json", "jsonp", "text".
	            //在请求之前调用的函数
	            beforeSend:function(){$("#msg").html("lodding");},
	            //成功返回之后调用的函数             
	            success:function(result){
	            	//alert(result.key);
	            	result = $.parseJSON(result);
	                var keys=[];    //类别数组（实际用来盛放X轴坐标值）
	                var values=[];    //销量数组（实际用来盛放Y坐标值
	                var keysArray= new Array(); 
	                keysArray=result.key.split("#"); //字符分割 
	                for (var i=0;i<keysArray.length ;i++ ) {
	            	  keys.push(keysArray[i]); 
	                }
	  			    var valuesArray= new Array(); 
	  				valuesArray=result.value.split("#"); //字符分割 
	  				for (var i=0;i<valuesArray.length ;i++ ) {
	  				 values.push(eval('(' + valuesArray[i] + ')')); 
	              	}
	                var myChart = echarts.init(document.getElementById('mainPie'));
	     		    option = {
		     		    title : {
		     		        text: '自升级用户访下载量',
		     		        subtext: 'apk下载量',
		     		        x:'center'
		     		    },
		     		    tooltip : {
		     		        trigger: 'item',
		     		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		     		    },
		     		    legend: {
		     		        orient: 'vertical',
		     		        left: 'left',
		     		        //data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
		     		        data:keys
		     		    },
		     		    series : [
		     		        {
		     		            name: '下载次数',
		     		            type: 'pie',
		     		            radius : '55%',
		     		            center: ['50%', '60%'],
		     		           data:values,
		     		                 /*  [ 
		     		                  {value:10,name:'8L'},{value:35,name:'9H'},{value:12,name:'GT'},{value:335,name:'HU'},{value:18,name:'JD'},{value:4,name:'TEST'},{value:6,name:'TK'},{value:13,name:'Y8'}
		     		                  ], */
		     		           itemStyle: {
		     		                emphasis: {
		     		                    shadowBlur: 10,
		     		                    shadowOffsetX: 0,
		     		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		     				                }
		     				            }
		     				        }
		     				    ]
		     				};
	     		        myChart.setOption(option);
	     		        //线性图表格
	     		       var myChart2 = echarts.init(document.getElementById('mainPie2'));
	     				option2 = {
	     				    color: ['#3398DB'],
	     				    tooltip : {
	     				        trigger: 'axis',
	     				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	     				            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	     				        }
	     				    },
	     				    grid: {
	     				        left: '3%',
	     				        right: '4%',
	     				        bottom: '3%',
	     				        containLabel: true
	     				    },
	     				    xAxis : [
	     				        {
	     				            type : 'category',
	     				            data:keys,
	     				            axisTick: {
	     				                alignWithLabel: true
	     				            }
	     				        }
	     				    ],
	     				    yAxis : [
	     				        {
	     				            type : 'value'
	     				        }
	     				    ],
	     				    series : [
	     				        {
	     				            name:'下载次数',
	     				            type:'bar',
	     				            barWidth: '60%',
	     				            data:values
	     				        }
	     				    ]
	     				};
	     	        // 使用刚指定的配置项和数据显示图表。
	     	        myChart2.setOption(option2);
	            }   ,
	            //调用执行后调用的函数
	            complete: function(XMLHttpRequest, textStatus){
	               //alert(XMLHttpRequest.responseText);
	               //alert(textStatus);
	            },
	            //调用出错执行的函数
	            error: function(){
	                //请求出错处理
	            }         
	         });
	});
	//加载图表 end
	
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 350,
			height : 600,
			href : '${ctx}/filemanager/fileDownload/addPage',
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
				$.post('${ctx}/filemanager/fileDownload/delete', {
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
			href : '${ctx}/filemanager/fileDownload/editPage?id=' + id,
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
			href : '${ctx}/filemanager/fileDownload/viewPage?id=' + id
		});
	}
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
		var apkVersionNameStr=document.getElementById("apkVersionName").value;
		var begintimeStr=document.getElementById("begintime").value;
		var endtimeStr=document.getElementById("endtime").value;
		  $.ajax({
	            //提交数据的类型 POST GET
	            type:"POST",
	            //提交的网址
	            //url:"http://localhost:8080/lightmanger/filemanager/fileDownload/fileDownloadPie",
	            url:"<%=request.getContextPath()%>/filemanager/fileDownload/fileDownloadPie",
	            //提交的数据
	            data:{apkVersionName:apkVersionNameStr,begintime:begintimeStr,endtime:endtimeStr},
	            //返回数据的格式
	            datatype: "html",//"xml", "html", "script", "json", "jsonp", "text".
	            //在请求之前调用的函数
	            beforeSend:function(){$("#msg").html("lodding");},
	            //成功返回之后调用的函数             
	            success:function(result){
	            	result = $.parseJSON(result);
	                var keys=[];    //类别数组（实际用来盛放X轴坐标值）
	                var values=[];    //销量数组（实际用来盛放Y坐标值
	                var keysArray= new Array(); 
	                keysArray=result.key.split("#"); //字符分割 
	                for (var i=0;i<keysArray.length ;i++ ) {
	            	  keys.push(keysArray[i]); 
	                }
	  			    var valuesArray= new Array(); 
	  				valuesArray=result.value.split("#"); //字符分割 
	  				for (var i=0;i<valuesArray.length ;i++ ) {
	  				 values.push(eval('(' + valuesArray[i] + ')')); 
	              	}
	  				$("#mainPie").empty();//清空div内容
	  				$("#mainPie2").empty();//清空div内容
	                var myChart = echarts.init(document.getElementById('mainPie'));
	     		    option = {
		     		    title : {
		     		        text: '自升级用户访下载量',
		     		        subtext: 'apk下载量',
		     		        x:'center'
		     		    },
		     		    tooltip : {
		     		        trigger: 'item',
		     		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		     		    },
		     		    legend: {
		     		        orient: 'vertical',
		     		        left: 'left',
		     		        //data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
		     		        data:keys
		     		    },
		     		    series : [
		     		        {
		     		            name: '下载次数',
		     		            type: 'pie',
		     		            radius : '55%',
		     		            center: ['50%', '60%'],
		     		           data:values,
		     		                 /*  [ 
		     		                  {value:10,name:'8L'},{value:35,name:'9H'},{value:12,name:'GT'},{value:335,name:'HU'},{value:18,name:'JD'},{value:4,name:'TEST'},{value:6,name:'TK'},{value:13,name:'Y8'}
		     		                  ], */
		     		           itemStyle: {
		     		                emphasis: {
		     		                    shadowBlur: 10,
		     		                    shadowOffsetX: 0,
		     		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		     				                }
		     				            }
		     				        }
		     				    ]
		     				};
	     		        myChart.setOption(option);
	     		        
	     		     //线性图表格
	     		       var myChart2 = echarts.init(document.getElementById('mainPie2'));
	     				option2 = {
	     				    color: ['#3398DB'],
	     				    tooltip : {
	     				        trigger: 'axis',
	     				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	     				            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	     				        }
	     				    },
	     				    grid: {
	     				        left: '3%',
	     				        right: '4%',
	     				        bottom: '3%',
	     				        containLabel: true
	     				    },
	     				    xAxis : [
	     				        {
	     				            type : 'category',
	     				            
	     				            /* data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'], */
	     				             data:keys,
	     				            axisTick: {
	     				                alignWithLabel: true
	     				            }
	     				        }
	     				    ],
	     				    yAxis : [
	     				        {
	     				            type : 'value'
	     				        }
	     				    ],
	     				    series : [
	     				        {
	     				            name:'下载次数',
	     				            type:'bar',
	     				            barWidth: '60%',
	     				           /*  data:[10, 52, 200, 334, 390, 330, 220] */
	     				             data:values
	     				        }
	     				    ]
	     				};

	     	        // 使用刚指定的配置项和数据显示图表。
	     	        myChart2.setOption(option2);
	            }   ,
	            //调用执行后调用的函数
	            complete: function(XMLHttpRequest, textStatus){
	               //alert(XMLHttpRequest.responseText);
	               //alert(textStatus);
	            },
	            //调用出错执行的函数
	            error: function(){
	                //请求出错处理
	            }         
	         });
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	function exportFun(){
		//progressLoad();
		$.post('${ctx}/filemanager/fileDownload/export', {
			//id : id
			outTradeNo:$('#outTradeNo').val(),
			begintime:$('#begintime').val(),
			endtime:$('#endtime').val()
		}, function(result) {
			if (result.success) {
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
<!-- 		<div id="mainPie" style="width: 300px;height:200px;"></div>
		<div id="mainPie2" style="width: 300px;height:200px;"></div> -->
		<!--  此种写法当列过多时,无横向滚动条	
		<table id="dataGrid" data-options="fit:true,border:false"></table>
		 -->	
		 <!--  此种写法当列过多时,有横向滚动条	
       	<table id="dataGrid" data-options="fit:false,border:false" style="width: 2000px;"></table>
		 -->		
		<table id="dataGrid" data-options="fit:true,border:false"></table>
		
	</div>
	<div id="toolbar" style="display: none;">
			 <table id="pieData" data-options="fit:true,border:false">
		  <tr>
			  <td><div id="mainPie" style="width: 300px;height:200px;"></div><td>
			  <td><div id="mainPie2" style="width: 300px;height:200px;"></div><td>
		  </tr>
		 </table>
		<div>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/fileDownload/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/filemanager/fileDownload/export')}">
				<a onclick="exportFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'">导出</a>
			</c:if>
		</div>
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>版本号:</th>
						<td><input name="apkVersionName" id="apkVersionName" placeholder="请输入版本号"/></td>
						<th>航渠:</th>
						<td>
						<!-- <input name="air_version" id="buyerName" placeholder="请输入航渠"/> -->
						    <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='airCompany' id='airCompany'>
					   			<option value="">全部</option>
								<option value="TEST">测试使用</option>	
								<option value="TK">天科</option>        
				                <option value ="HU">股份</option>                                         	
								<option value ="Y8">扬子江</option>                       	
								<option value="JD">首航</option>                          	
								<option value="9H">长安航</option>                        	
								<option value="GT">桂林航</option>                        	
								<option value="8L">祥鹏</option>                          	
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