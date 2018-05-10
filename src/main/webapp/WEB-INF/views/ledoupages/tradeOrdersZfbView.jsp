<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<table class="grid">
			<tr>
				<td>订单号</td>
				<td>${beanData.outTradeNo}</td>
			</tr>
			<tr>
				<td>金额</td>
				<td>${beanData.totalAmount}</td>
			</tr>
			<tr>
				<td>描述</td>
				<td>${beanData.subject}</td>
			</tr>
			<tr>
				<td>支付结果</td>
				<td><payStatus:payStatus name="${beanData.paystatus}" type="json" jsonName="alipayStatus"/></td>
			</tr>
			<tr>
				<td>邮箱地址</td>
				<td>${beanData.email}</td>
			</tr>
		</table>
	</div>
</div>
