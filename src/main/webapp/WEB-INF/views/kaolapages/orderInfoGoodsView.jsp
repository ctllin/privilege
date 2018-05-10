<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="jspfmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmtjsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title=""
		style="overflow: hidden;padding: 3px;">
		<table class="grid">
			<tr>
			    <td width="50px">序号</td>
			    <td width="150px">订单号</td>
				<td width="50px">支付 金额</td>
				<td width="150px">税费</td>
				<td width="150px">SKUID</td>
				<td width="60px">needVerifyLevel</td>
				<td width="60px">购该数量</td>
				<td width="70px">退货标识</td>
				<td width="150px">创建时间</td>
			</tr>
			<c:forEach items="${beanData }" var="data" varStatus="status">
				<tr>
				    <td>${status.index+1}</td>
				    <td>${data.orderNumber}</td>
				    <td>${data.payAmount}</td>
				    <td>${data.taxPayAmount}</td>
				    <td>${data.skuId}</td>
				    <td>${data.needVerifyLevel}</td>
				    <td>${data.buyAmount}</td>
				    <td>${data.flag}</td>
				    <td>${data.savetime}</td>
					<%-- <td>${data.goodsId }</td>
					<td>${data.goodsName }</td>
					<td>${data.goodsSize }</td>
					<td>${data.quantity}</td>
					<td>${data.price  }</td>
				    <td>${data.supplierguid }</td> 
				    <td>${data.isDelete }</td> 
					<td><fmtjsp:formatDate value="${data.savetime}" pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
