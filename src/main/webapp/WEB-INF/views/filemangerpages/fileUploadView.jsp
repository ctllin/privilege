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
				<td>上传文件名</td>
				<td>${beanData.upfilename}</td>
			</tr>
			<tr>
				<td>上传后新文件名</td>
				<td>${beanData.upsuccessfilename}</td>
			</tr>
			<tr>
				<td>版本</td>
				<td>${beanData.version}</td>
			</tr>
			
			<tr>
				<td>下载地址</td>
				<td>${beanData.url}</td>
			</tr>
			
			<tr>
				<td>版本描述</td>
				<td>${beanData.description}</td>
			</tr>
			<tr>
				<td>版本检测地址</td>
				<td>${beanData.url_server}</td>
			</tr>
			
			<tr>
				<td>航渠</td>
				<td>${beanData.air_version}</td>
			</tr>
			<tr>
				<td>创建时间</td>
				<td><fmtjsp:formatDate value="${beanData.uploadtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		</table>
	</div>
</div>
