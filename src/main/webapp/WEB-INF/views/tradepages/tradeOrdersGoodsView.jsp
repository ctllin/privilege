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
				<td width="50px">商品ID</td>
				<td width="150px">商品名称</td>
				<td width="150px">商品规格</td>
				<td width="60px">数量</td>
				<td width="60px">商品价格</td>
				<td width="60px">额外费用</td>
				<td width="70px">供应商ID</td>
				<td width="70px">退货标识</td>
				<td width="150px">创建时间</td>
			</tr>
			<c:forEach items="${dataList }" var="data" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${data.orderNumber}</td>
					<td>${data.goodsId }</td>
					<td>${data.goodsName }</td>
					<td>${data.goodsSize }</td>
					<td>${data.quantity}</td>
					<td>${data.price  }</td>
					<td><c:if test="${empty data.extraPayAmount}">${data.extraPayAmount}</c:if>
                    <c:if test="${not empty data.extraPayAmount}">${data.extraPayAmount/100.0}</c:if>
                    </td>
				    <td>${data.supplierguid }</td> 
				    <td>${data.isDelete }</td> 
					<td><fmtjsp:formatDate value="${data.savetime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
