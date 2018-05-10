<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dlg" class="easyui-panel" title="" style="width:100%;max-width:795px;padding:30px 60px;">
<form id="telephoneForm" method="post">
	 <table>
		<tr>
			<td>手机号码</td>
			<td colspan="3"><textarea style="width: 400px;" id="dlgContent"  name="content" rows="6" cols="" placeholder="请输入手机号码每个手机号码需要换行" class="easyui-validatebox span2"></textarea></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="telephoneHandle()" style="height: 20px">导出</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="telephoneClose()" style="height: 23px">关闭</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="telephoneCheck()" style="height: 23px">电话号码校验</a>
			</td>
		</tr>
	</table>
</form>
</div>