<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dlg" class="easyui-panel" title="" style="width:100%;max-width:1200px;min-height:700px;padding:30px 60px;">
<form id="dialogForm" method="post">
	 <table>
		<tr>
			<td>待解密订单</td>
			<td colspan="3"><textarea style="width: 450px;" id="dlgContent"  name="content" rows="50" cols="" placeholder="请输入待解密订单每个待解密订单需要换行" class="easyui-validatebox span2"></textarea></td>
			<td>解密后订单</td>
				<td colspan="3"><textarea style="width: 450px;" id="dlgContentD"  name="contentD" rows="50" cols=""  class="easyui-validatebox span2"></textarea></td>
			</tr>
		<tr>
			<td></td>
			<td>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="dialogHandle()" style="height: 20px">解密</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="dialogClose()" style="height: 23px">关闭</a>
			</td>
		</tr>
	</table>
</form>
</div>