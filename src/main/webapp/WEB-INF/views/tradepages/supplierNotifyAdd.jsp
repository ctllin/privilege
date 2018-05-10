<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dlg" class="easyui-panel" title="" style="width:100%;max-width:900px;padding:30px 60px;">
<form id="refundForm" method="post">
	 <table>
	    <tr>
			<td style="width: 10%">供应商编号 </td><td><input class="easyui-numberbox" id="supplierguid" name="supplierguid" style="width:80px" data-options="required:true">
			</td>
			<!-- <td style="width: 5%">证件号 </td><td style="width: 20%"><input    class="easyui-textbox" id="idCard" name="idCard" style="width:150px" data-options="required:true">
			</td>
			<td style="width: 5%">支付反馈码</td><td style="width: 20%"><input name="responseCode" id="responseCode" class="easyui-textbox" style="width:150px" data-options="required:true">
			</td>
			<td style="width: 5%">支付反馈信息</td><td style="width: 20%"><input class="easyui-textbox" id="responseDesc" name="responseDesc" style="width:150px" data-options="required:true">
			</td> -->
		</tr>
		  <tr>
			<td>商品规格编号</td>
			<td colspan="5"><textarea data-options="required:true" id="goodsId" style="width: 400px" name="goodsId" rows="6" cols="" placeholder="商品规格编号,多个之间用英文','隔开" class="easyui-validatebox span2" ></textarea></td>
		 </tr>
		<tr>
			<td></td>
			<td>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="caiwuRefund()" style="height: 20px">更新订单</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="dialogClose()" style="height: 23px">关闭</a>
			</td>
		</tr>
	</table>
</form>
</div>