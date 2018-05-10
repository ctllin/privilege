<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
 <%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/informationCart/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if> --%>
<c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/informationCart/payStatusQuery')}">
	<script type="text/javascript">
		$.canPayStatusQuery = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/informationCart/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/informationCart/view')}">
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
	<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}' + '/weixin/informationCart/dataGrid',
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
				width : '200',
				title : '商品订单号',
				field : 'out_trade_no',
				sortable : true
			},{
				width : '70',
				title : 'return_code',
				field : 'return_code'
			}, {
				width : '70',
				title : 'return_msg',
				field : 'return_msg'
			} ,{
				width : '70',
				title : 'result_code',
				field : 'result_code'
			}, {
				width : '70',
				title : 'return_msg',
				field : 'return_msg'
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
				title : '买家姓名',
				field : 'username'
			}, {
				width : '90',
				title : 'tele',
				field : 'tele'
			}, {
				width : '400',
				title : 'mess',
				field : 'mess'
			}, {
				width : '120',
				title : '创建时间',
				field : 'savetime'
			}, {
				field : 'action',
				title : '操作',
				width : 150,
				formatter : function(value, row, index) {
					var str = '&nbsp;';
					/* if ($.canView) {
						str += $.formatString('<a href="javascript:void(0)" onclick="viewFun(\'{0}\');" >详情</a>', row.orderNumber);
					}
					if ($.canEdit) {
				   		str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
					} */
					if ($.canPayStatusQuery) {
						str += $.formatString('<a href="javascript:void(0)" onclick="payStatusQuery(\'{0}\',\'{1}\');" >查询支付结果</a>', row.out_trade_no,1);
					}
					if ($.canDelete) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
					}
					/* if ($.canGoodsView) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="viewGoodsFun(\'{0}\');" >商品</a>', row.orderNumber);
					}
					if ($.canEditLogistics) {
						str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
						str += $.formatString('<a href="javascript:void(0)" onclick="editLogisticsFun(\'{0}\',\'{1}\');" >物流</a>',row.id, row.orderNumber);
					} */
					return str;
				}
			} ] ],
			toolbar : '#toolbar'
		});
	});
	function payStatusQuery(orderNumber,paytype) {
		$.post('${ctx}/weixin/informationCart/payStatusQuery', {
			orderNumber : orderNumber,
			paytype:paytype
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
				$.post('${ctx}/weixin/informationCart/delete', {
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
	
	
	var toUtf8 = function(str) {
        var out, i, len, c;
        out = "";
        len = str.length;
        for(i = 0; i < len; i++) {
            c = str.charCodeAt(i);
            if ((c >= 0x0001) && (c <= 0x007F)) {
                out += str.charAt(i);
            } else if (c > 0x07FF) {
                out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
                out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));
                out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));
            } else {
                out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));
                out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));
            }
        }
        return out;
    };
    var getQRcodeStr=function(userName,price,count,deviceId,telePhone,orderNumber){
        var product_id="";
        userName = userName.substring(0,4);
        var l = 4-userName.length;
        if(l<4){//小于四位数时补零
            for(var i=0;i<l;i++){
                userName=userName+"0";
            }
        }
        price =price.substring(0,5);
        l=5-price.length;
        if(l<5){//大于等于四位数时前边减零
            for(var i=0;i<l;i++){
                price="0"+price;
            }
        }
        count = "00";
        deviceId="AIRHUB"+generateMixed(2);
        l=11-telePhone.length;
        for(var i=0;i<l;i++){
            telePhone="0"+telePhone;
        }
        product_id +=userName;//username
        product_id +=price;//价格
        product_id +=count;//一个
        product_id +=deviceId;//deviceID
        product_id +=telePhone;//手机号
        product_id = userName+price+count+deviceId+telePhone+'|'+orderNumber;
        var timestamp = new Date().getTime();
        var textaa = "weixin://wxpay/bizpayurl?";
        var text2 = "appid=wxc901594935e102f6&mch_id=1372861802&nonce_str=e7c0eac67b78495bb63c516bdc0eb31d&product_id="+product_id+ "&time_stamp="+timestamp;
        var text3 = md5(text2+"&key=xile99hang5893ysshjsharecocn9029").toUpperCase();
        return textaa+text2+"&sign="+text3;
    };
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
			<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/informationCart/add')}">
				 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
			</c:if>
			<c:if test="${fn:contains(sessionInfo.resourceList, '/weixin/informationCart/informationCart')}">
				<a onclick="informationCartFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-btn'">退款</a>
			</c:if> --%>
			    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('open')" style="height: 20px;color: #76C27A"  >二维码</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeQR()" style="height: 20px;color: #76C27A" >关闭</a>
		</div>
		<!-- 	
		     <div id="dlg" class="easyui-dialog" title="Basic Dialog" style="width:400px;height:200px;padding:10px;">
	      	  The dialog content.
	   		 </div> 
	   	-->
	   		 
<!-- 	   	<div id="dlg" class="easyui-dialog" title="New Topic" style="width:100%;max-width:400px;padding:30px 60px;">
 -->	      
 	   	<div id="dlg" class="easyui-panel" title="" style="width:100%;max-width:1520px;padding:30px 60px;">
 			      <table>
 			      	<tr>
						<td>
							<div style="margin-bottom:20px">
				           	         订单编号：<input name="orderNumber" id="orderNumber" class="easyui-textbox"  style="width:250px" data-options="required:true" placeholder="请输入订单号">
				            </div>
				            <div style="margin-bottom:20px">
				           	         买家姓名：<input class="easyui-textbox" id="name" name="name" style="width:150px" data-options="required:true">
				            </div>
				            <!-- 例如：金额输入框 最大值为“99999.99” 精确到两位小数。 <input name="money" id="money" type="text" class="easyui-numberbox" precision="2" max="99999.99" size="8" maxlength="8"  style="text-align:right;"/>
				             -->
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
   		</div>
	   		 
		<div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
			<form id="searchForm">
				<table>
					<tr>
						<th>订单号:</th>
						<td><input name="out_trade_no" id="out_trade_no" placeholder="请输入订单号"/></td>
						<th>电话号码(精确):</th>
						<td><input name="tele" id="tele" placeholder="请输入电话号码"/></td>
						<th>买家姓名:</th>
						<td><input name="username" id="username" placeholder="请输入买家姓名"/></td>
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