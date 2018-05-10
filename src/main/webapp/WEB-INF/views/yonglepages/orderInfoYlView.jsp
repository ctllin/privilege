<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmtjsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
</script>
<!-- <div class="easyui-layout" data-options="fit:true,border:false"> -->
<div class="easyui-layout" data-options="fit:false,border:false" style="height:500px"><!-- 支持滚动条 -->
	<div data-options="region:'center',border:false" title="" style="overflow: auto;padding: 3px;">
		<table class="grid">
			<tr>
				<td>订单号</td>
				<td>${beanData.orderNumber}</td>
			</tr>
			<tr>
				<td>收货人姓名</td>
				<td>${beanData.userName}</td>
			</tr>
			<tr>
				<td>收货人手机</td>
				<td>${beanData.phone}</td>
			</tr>
			<tr>
				<td>类型</td>
				<td>${beanData.type}</td>
			</tr>
			<%-- <tr>
				<td>支付结果</td>
				<td><payStatus:payStatus name="${beanData.paystatus}" type="json" jsonName="alipayStatus"/></td>
			</tr> --%>
			<tr>
				<td>收货地址</td>
				<td>${beanData.orderAddress}</td>
			</tr>
			<tr>
				<td>备注</td>
				<td>${beanData.note}</td>
			</tr>
			<tr>
				<td>发票类型</td>
				<td>${beanData.lnvoiceType}</td>
			</tr>
			<tr>
				<td>发票抬头</td>
				<td>${beanData.lnvoice}</td>
			</tr>
			<tr>
				<td>配送方式</td>
				<td>${beanData.dispatchWay}</td>
			</tr>
			<tr>
				<td>商品编号</td>
				<td>${beanData.productId}</td>
			</tr>
			<tr>
				<td>快递费</td>
				<td>${beanData.expressPrice}</td>
			</tr>
		    <tr>
				<td>总金额</td>
				<td>${beanData.totalFee}</td>
			</tr>
			<tr>
				<td>演出场次时间</td>
				<td>${beanData.ticketTime}</td>
			</tr>
			<tr>
				<td>订单创建时间</td>
				<td><fmtjsp:formatDate value="${beanData.savetime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			
			<%-- <tr>
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
			</tr> --%>
		</table>
	</div>
</div>
