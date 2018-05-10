<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/statusTran.tld" prefix="payStatus"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmtjsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
</script>
<!-- <div class="easyui-layout" data-options="fit:true,border:false"> -->
<div class="easyui-layout" data-options="fit:true,border:false">
<!-- <div class="easyui-layout" data-options="fit:false,border:false" style="height:800px">支持滚动条
 -->	<div data-options="region:'center',border:false" title="" style="overflow: auto;padding: 3px;">
		<table class="grid">
		    <tr>
				<td style="width: 15%">产品简介</td>
				<td><div>${beanData.brief}</div></td>
			</tr>
			<tr>
				<td >产品详情</td>
				<td>${beanData.description}</td>
			</tr>
			<tr>
				<td >预订须知</td>
				<td>${beanData.notice}</td>
			</tr>
			<%-- 
			<tr>
				<td >产品信息最近更新时间</td>
				<td>${beanData.modify_time}</td>
			</tr>
			<tr>
				<td style="width: 10%">票品编号</td>
				<td>${beanData.productId}</td>
			</tr>
			<tr>
				<td>票品名称</td>
				<td>${beanData.playName}</td>
			</tr>
			<tr>
				<td>演出时间</td>
				<td>${beanData.productStartTime}至${beanData.productEndTime}</td>
			</tr>
			<tr>
				<td>票品状态</td>
				<td><payStatus:payStatus name="${beanData.status}" type="json" jsonName="yongle.product.status"/></td>
			</tr>
			<tr>
				<td>上下架状态</td>
				<td><payStatus:payStatus name="${beanData.shelfStatus}" type="json" jsonName="yongle.product.shelfStatus"/></td>
			</tr>
			<%-- <tr>
				<td>支付结果</td>
				<td><payStatus:payStatus name="${beanData.paystatus}" type="json" jsonName="alipayStatus"/></td>
			</tr> --%>
		<%-- 	<tr>
				<td>演出城市</td>
				<td>${beanData.playCity}</td>
			</tr>
			<tr>
				<td>演出地址</td>
				<td>${beanData.playAddress}</td>
			</tr>
			<tr>
				<td>演出类型A</td>
				<td>${beanData.playTypeA}</td>
			</tr>
			<tr>
				<td>演出类型B</td>
				<td>${beanData.playTypeB}</td>
			</tr>
			<tr>
				<td>票品剧照</td>
				<td><img src="${beanData.productPicture}"/></td>
			</tr>
			<tr>
				<td>乘车路线</td>
				<td>${beanData.venueMap}</td>
			</tr>
			<tr>
				<td>票品缩略简介</td>
				<td>${beanData.sharedescribe}</td>
			</tr>
			<tr>
				<td>票品简介</td>
				<td>${beanData.productProfile}</td>
			</tr>
			<tr>
				<td>场馆介绍</td>
				<td>${beanData.venueIntroduction}</td>
			</tr>
			<tr>
				<td>票品更新时间</td>
				<td><fmtjsp:formatDate value="${beanData.updatetime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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
			</tr> --%> 
		</table>
	</div>
</div>
