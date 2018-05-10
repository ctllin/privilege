<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
</script>
<!-- <div class="easyui-layout" data-options="fit:true,border:false"> -->
<div class="easyui-layout" data-options="fit:false,border:false" style="height:800px"><!-- 支持滚动条 -->
	<div data-options="region:'center',border:false" title="" style="overflow: auto;padding: 3px;">
		<table class="grid">
			<tr>
				<td>订单号</td>
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
			<%-- <tr>
				<td>支付结果</td>
				<td><payStatus:payStatus name="${beanData.paystatus}" type="json" jsonName="alipayStatus"/></td>
			</tr> --%>
			<tr>
				<td>支付结果</td>
				<td><payStatus:payStatus name="${beanData.paystatus}" type="map" mapName="portalpay.status"/></td>
			</tr>
			<tr>
				<td>乐豆数量</td>
				<td>${beanData.beanCount}</td>
			</tr>
			<tr>
				<td>买家姓名</td>
				<td>${beanData.buyername}</td>
			</tr>
			<tr>
				<td>买家电话</td>
				<td>${beanData.tele}</td>
			</tr>
			<tr>
				<td>收货人姓名</td>
				<td>${beanData.consigneeName}</td>
			</tr>
			<tr>
				<td>收货人电话</td>
				<td>${beanData.consigneeTelephone}</td>
			</tr>
			<tr>
				<td>收货人地址</td>
				<td>${beanData.address}</td>
			</tr>
			<tr>
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
			</tr>
			<tr>
				<td>异步结果</td>
				<td>${beanData.trade_status}</td>
			</tr>
			<tr>
				<td>支付宝交易号</td>
				<td>${beanData.trade_no}</td>
			</tr>
			<tr>
				<td>物流单号</td>
				<td>${beanData.logisticsId}</td>
			</tr>
			<tr>
				<td>物流公司</td>
				<td>${beanData.logisticsCompany}</td>
			</tr> 
			<tr>
				<td>物流状态</td>
				<td>${beanData.logisticsType}</td>
			</tr>
			<tr>
				<td>物流备注</td>
				<td>${beanData.memo}</td>
			</tr>
			<tr>
				<td>物流发货日期</td>
				<td>${beanData.sendtime}</td>
			</tr>
		</table>
	</div>
</div>
