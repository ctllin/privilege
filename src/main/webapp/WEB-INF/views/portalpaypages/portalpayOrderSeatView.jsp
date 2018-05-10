<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmtjsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<table class="grid">
			<tr>
				<td>订单号</td>
				<td>${beanData.orderNumber}</td>
			</tr>
			<tr>
				<td>金额</td>
				<td>${beanData.totalMoney}</td>
			</tr>
			<tr>
				<td>乘客姓名</td>
				<td>${beanData.passengerName}</td>
			</tr>
			
			<tr>
				<td>乘客电话</td>
				<td>${beanData.passengerPhone}</td>
			</tr>
			
			<tr>
				<td>收货地址</td>
				<td>${beanData.customerAddress}</td>
			</tr>
			
			<tr>
				<td>支付结果</td>
				<td><payStatus:payStatus name="${beanData.payStatus}" type="json" jsonName="portalpayStatus"/></td>
			</tr>
			<tr>
				<td>异步结果</td>
				<td><payStatus:payStatus name="${beanData.stateCode}" type="json" jsonName="portalpayCallbackStatus"/></td>
			</tr>
			<tr>
				<td>网络模式</td>
				<td><payStatus:payStatus name="${beanData.payflag}" type="json" jsonName="portalpayLineStatus"/></td>
			</tr>
			<tr>
				<td>订单状态</td>
				<td>${beanData.orderStatus}</td>
			</tr>
			<tr>
				<td>订单来源</td>
				<td>${beanData.orderFrom}</td>
			</tr>
			<tr>
				<td>祝福语</td>
				<td>${beanData.flyBless}</td>
			</tr>
			<tr>
				<td>收货人姓名</td>
				<td>${beanData.secondaryContact}</td>
			</tr>
			<tr>
				<td>收货人电话</td>
				<td>${beanData.secondaryPhone}</td>
			</tr>
			<tr>
				<td>物流单号</td>
				<td>${beanData.logisticsId}</td>
			</tr>
			<tr>
				<td>创建时间</td>
				<td><fmtjsp:formatDate value="${beanData.savetime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		</table>
	</div>
</div>
