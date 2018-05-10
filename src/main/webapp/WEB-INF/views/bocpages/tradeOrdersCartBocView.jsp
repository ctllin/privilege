<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	
</script>
<!-- <div class="easyui-layout" data-options="fit:true,border:false"> -->
<div class="easyui-layout" data-options="fit:false,border:false"
	style="height:800px">
	<!-- 支持滚动条 -->
	<div data-options="region:'center',border:false" title=""
		style="overflow: auto;padding: 3px;">
		<table class="grid">
			<tr>
				<td>订单号</td>
				<td>${beanData.orderNumber}</td>
			</tr>
			<tr>
				<td>证件号码</td>
				<td>${beanData.IDNumber}</td>
			</tr>
			<tr>
				<td>flyBless</td>
				<td>${beanData.flyBless}</td>
			</tr>
			<tr>
				<td>sysUniqueID</td>
				<td>${beanData.sysUniqueID}</td>
			</tr>
			<tr>
				<td>cardNOMask</td>
				<td>${beanData.cardNOMask}</td>
			</tr>
			<tr>
				<td>expDate</td>
				<td>${beanData.expDate}</td>
			</tr>
			<tr>
				<td>offTransDate</td>
				<td>${beanData.offTransDate}</td>
			</tr>
			<tr>
				<td>offTransTime</td>
				<td>${beanData.offTransTime}</td>
			</tr>
			<tr>
				<td>terminalID</td>
				<td>${beanData.terminalID}</td>
			</tr>
			<tr>
				<td>responseCode</td>
				<td>${beanData.responseCode}</td>
			</tr>
			<tr>
				<td>amount</td>
				<td>${beanData.amount}</td>
			</tr>
			<tr>
				<td>responseDesc</td>
				<td>${beanData.responseDesc}</td>
			</tr>
			<tr>
				<td>乐豆数量</td>
				<td>${beanData.beanCount}</td>
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
				<td>${beanData.logisticsMemo}</td>
			</tr>
			<tr>
				<td>物流发货日期</td>
				<td>${beanData.logisticsSendtime}</td>
			</tr>
		</table>
	</div>
</div>
