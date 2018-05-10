<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
</script>
<!-- <div class="easyui-layout" data-options="fit:true,border:false"> -->
<div class="easyui-layout" data-options="fit:false,border:false" style="height:700px"><!-- 支持滚动条 -->
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<table class="grid">
						<tr>
				<td style="width: 30%">订单号</td>
				<td>${beanData.outTradeNo}</td>
			</tr>
			<tr>
				<td>描述</td>
				<td>${beanData.subject}</td>
			</tr>
			<tr>
				<td>金额</td>
				<td>${beanData.totalAmount}</td>
			</tr>
			<tr>
				<td>业务类型</td>
				<td>${beanData.businessType}</td>
			</tr>
			<tr>
				<td>支付结果</td>
				<td><payStatus:payStatus name="${beanData.paystatus}" type="json" jsonName="alipayStatus"/></td>
			</tr>
			<tr>
				<td>支付方式</td>
				<td><payStatus:payStatus name="${beanData.version}" type="json" jsonName="alipayVersion"/></td>
			</tr>
			<%-- <tr>
				<td>乐豆数量</td>
				<td>${beanData.beanCount}</td>
			</tr> --%>
			<tr>
				<td>买家姓名</td>
				<td>${beanData.passengerName}</td>
			</tr>
			<tr>
				<td>买家电话</td>
				<td>${beanData.passengerPhone}</td>
			</tr>
			<%-- <tr>
				<td>收货人姓名</td>
				<td>${beanData.consigneeName}</td>
			</tr>
			<tr>
				<td>收货人电话</td>
				<td>${beanData.consigneeTelephone}</td>
			</tr> --%>
			<tr>
				<td>航班号</td>
				<td>${beanData.flightNumber}</td>
			</tr>
			<tr>
				<td>原舱位</td>
				<td>${beanData.oldSeat}</td>
			</tr>
			<tr>
				<td>新舱位</td>
				<td>${beanData.newSeat}</td>
			</tr>
			<tr>
				<td>出发地</td>
				<td>${beanData.original}</td>
			</tr>
			<tr>
				<td>目的地</td>
				<td>${beanData.destination}</td>
			</tr>
			<tr>
				<td>invoiceTitle</td>
				<td>${beanData.invoiceTitle}</td>
			</tr>
			<tr>
				<td>invoiceName</td>
				<td>${beanData.invoiceName}</td>
			</tr>
			<tr>
				<td>invoiceCell</td>
				<td>${beanData.invoiceCell}</td>
			</tr>
			<tr>
				<td>invoiceAddress</td>
				<td>${beanData.invoiceAddress}</td>
			</tr>
	<%-- 		<tr>
				<td>收货人电话</td>
				<td>${beanData.beanCount}</td>
			</tr>
			<tr>
				<td>邮箱地址</td>
				<td>${beanData.email}</td>
			</tr>
			<tr>
				<td>用户ID</td>
				<td>${beanData.userId}</td>
			</tr> --%>
			<tr>
				<td>异步结果</td>
				<td>${beanData.trade_status}</td>
			</tr>
			<tr>
				<td>支付宝交易号</td>
				<td>${beanData.trade_no}</td>
			</tr>
		</table>
	</div>
</div>
