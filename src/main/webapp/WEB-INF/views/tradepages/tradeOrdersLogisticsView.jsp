<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<td width="70px">规格编号</td>
				<td width="80px">供应商编号</td>
				<td width="150px">物流单号</td>
				<td width="60px">物流公司</td>
				<td width="60px">物流状态</td>
				<td width="90px">发送时间 </td>
				<td width="70px">备注 </td>
				<td width="150px">创建时间</td>
			</tr>
			<c:forEach items="${dataList }" var="data" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${data.orderNumber}</td>
					<td>${data.goodsId }</td>
					<td>${data.supplierId }</td>
					<td>${data.logisticsId }</td>
					<td>${data.logisticsCompany}</td>
					<%-- <td>${data.logisticsType  }</td> --%>
					<td><payStatus:payStatus name="${data.logisticsType}" type="map" mapName="logistics.type"></payStatus:payStatus></td>
				    <td>${data.sendtime }</td> 
				    <td>${data.memo }</td> 
					<td><fmtjsp:formatDate value="${data.savetime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
