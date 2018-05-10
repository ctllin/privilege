<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dlg" class="easyui-panel" title="" style="width:100%;max-width:1795px;padding:30px 60px;">
<form id="addForm" method="post">
	 <table>
		<tr>
			<td style="width: 5%">订单编号</td><td style="width: 20%"><input value="" name="orderNumber" id="orderNumber2" class="easyui-textbox" style="width:250px" data-options="required:true">
			</td>
			<td style="width: 5%">买家姓名</td><td style="width: 20%"><input class="easyui-textbox" id="passengerName2" name="passengerName" style="width:150px" data-options="required:true" >
			</td>
			<td style="width: 5%">手机号码</td><td style="width: 20%"><input   class="easyui-textbox" id="passengerPhone" max="199999999999999" name="passengerPhone" style="width:200px" data-options="required:true">
			</td>
			<td style="width: 5%"><!-- 例如：金额输入框 最大值为“99999.99” 精确到两位小数。 <input name="money" id="money" type="text" class="easyui-numberbox" precision="2" max="99999.99" size="8" maxlength="8"  style="text-align:right;"/> -->
								   支付金额</td><td style="width: 20%"><input type="text" class="easyui-numberbox" max="999999" id="totalMoney" name="totalMoney" style="width:150px;text-align:right;" data-options="required:true">
			</td>
		</tr>
		<tr>
			<td style="width: 5%">卡号</td><td style="width: 20%"><input name="cardNOMask" id="cardNOMask2" class="easyui-textbox" style="width:250px" data-options="required:true">
			</td>
			<td style="width: 5%">证件号 </td><td style="width: 20%"><input    class="easyui-textbox" id="idCard" name="idCard" style="width:150px" data-options="required:true">
			</td>
			<td style="width: 5%">支付反馈码</td><td style="width: 20%"><input name="responseCode" id="responseCode" class="easyui-textbox" style="width:150px" data-options="required:true">
			</td>
			<td style="width: 5%">支付反馈信息</td><td style="width: 20%"><input class="easyui-textbox" id="responseDesc" name="responseDesc" style="width:150px" data-options="required:true">
			</td>
		</tr>
		<tr>
			<td style="width: 5%">航班号</td><td style="width: 20%"><input    class="easyui-textbox" id="flightNumber" name="flightNumber"  style="width:250px" data-options="required:true">
			</td>
			<td style="width: 5%">航段   </td><td style="width: 20%"><input    class="easyui-textbox" id="flightPhase"  name="flightPhase" style="width:150px" data-options="required:true">
			</td>
			<td style="width: 5%">始发地</td><td style="width: 20%"><input    class="easyui-textbox" id="original"     name="original" style="width:200px" data-options="required:true">
			</td>
			<td style="width: 5%">目的地</td><td style="width: 20%"><input    class="easyui-textbox" id="destination"  name="destination" style="width:200px" data-options="required:true">
			</td>
		</tr>
		<tr>
			<td style="width: 5%">旧座位</td><td style="width: 20%"><input    class="easyui-textbox" id="oldSeat" name="oldSeat"  style="width:250px" data-options="required:true">
			</td>
			<td style="width: 5%">新座位 </td><td style="width: 20%"><input    class="easyui-textbox" id="newSeat"  name="newSeat" style="width:150px" data-options="required:true">
			</td>
			<td style="width: 5%">地址</td><td style="width: 20%"><input    class="easyui-textbox" id="address"     name="address" style="width:200px" data-options="required:true">
			</td>
			<td style="width: 5%">唯一SYS码</td><td style="width: 20%"><input class="easyui-textbox" id="sysUniqueID"  name="sysUniqueID" style="width:200px" data-options="required:true">
			</td>
		</tr>
		<tr>
			<td style="width: 7%">关联机票票号</td><td style="width: 18%"><input    class="easyui-textbox" id="passengerTicketName" name="passengerTicketName"  style="width:200px">
			</td>
			<td style="width: 5%">唯一码 </td><td style="width: 20%"><input class="easyui-textbox" id="uniqueCode"  name="uniqueCode" style="width:150px" data-options="required:true">
			</td>
			<td style="width: 5%">终端编号</td><td style="width: 20%"><input class="easyui-textbox" id="terminalID"     name="terminalID" style="width:200px" data-options="required:true">
			</td>
			<!-- <td style="width: 5%">唯一SYS码</td><td style="width: 20%"><input class="easyui-textbox" id="sysUniqueID"  name="sysUniqueID" style="width:200px" data-options="required:true">
			</td> -->
			<td style="width: 5%">航渠</td><td style="width: 20%">
				<select id="orderFrom" name="orderFrom" class="easyui-combobox" data-options="editable:false,panelHeight:'auto'">
					<option value="HU" selected="selected">HU</option>
					<option value="IU">IU</option>
					<option value="SU">SU</option>
					<option value="JD">JD</option>
					<option value="JP">JP</option>
					<option value="GS">GS</option>
					<option value="Y8">Y8</option>
					<option value="GT">GT</option>
					<option value="HD">HD</option>
					<option value="9H">9H</option>
					<option value="BK">8L</option>
					<option value="8L">8L</option>
				</select>
			</td>
		</tr>
		<tr>
			<td style="width: 5%">交易日期</td><td style="width: 20%"><input class="easyui-textbox" id="offTransDate" name="offTransDate"  style="width:250px" data-options="required:true">
			</td>
			<td style="width: 5%">交易时间</td><td style="width: 20%"><input class="easyui-textbox" id="offTransTime"  name="offTransTime" style="width:150px" data-options="required:true">
			</td>
			<td>订单时间</td>
			<td>
				<input name="date" id="date" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
			</td>
			<td>交易时间</td>
			<td>
			    <input name="savetime" id="savetime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td style="width: 5%">支付状态</td><td style="width: 20%">
					 <select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='payStatus' id='payStatus'>
				                <option value="0">未支付</option>
				                <option value="1" selected="selected">支付成功</option>
				                <option value="2">支付失败</option>
				                <option value="3">已经退款</option>
				                <option value="4">订单作废</option>
				       </select>
			</td>
			<td style="width: 5%">乘务长姓名</td><td style="width: 20%"><input    class="easyui-textbox" id="purserName" name="purserName"  style="width:250px" data-options="required:true">
			</td>
			<td style="width: 5%">乘务长电话 </td><td style="width: 20%"><input    class="easyui-numberbox" id="purserCellphone"  name="purserCellphone" max="19999999999" style="width:150px" data-options="required:true">
			</td>
			<td style="width: 5%">币种 </td><td style="width: 20%"><input   value="CNY" class="easyui-textbox" id="moneyType"  name="moneyType" style="width:150px" data-options="required:true">
			</td>
			<!-- <td style="width: 5%">终端编号</td><td style="width: 20%"><input class="easyui-textbox" id="terminalID"     name="terminalID" style="width:200px" data-options="required:true">
			</td>
			<td style="width: 5%">sysUniqueID</td><td style="width: 20%"><input class="easyui-textbox" id="sysUniqueID"  name="sysUniqueID" style="width:200px" data-options="required:true">
			</td> -->
		</tr>
		<tr>
			<td style="width: 5%">发票抬头</td><td style="width: 20%"><input    class="easyui-textbox" id="invoiceTitle" name="invoiceTitle"  style="width:250px">
			</td>
			<td style="width: 5%">发票名称   </td><td style="width: 20%"><input    class="easyui-textbox" id="invoiceName"  name="invoiceName" style="width:150px">
			</td>
			<td style="width: 5%">发票电话</td><td style="width: 20%"><input    class="easyui-numberbox" id="invoiceCell"  name="invoiceCell" max="19999999999" style="width:200px">
			</td>
			<td style="width: 5%">发票地址</td><td style="width: 20%"><input    class="easyui-textbox" id="invoiceAddress"  name="invoiceAddress" style="width:200px">
			</td>
		</tr>
		<tr>
			<td style="width: 5%">订单状态</td><td style="width: 20%"><input  value="交易成功"  class="easyui-textbox" id="orderStatus" name="orderStatus"  style="width:250px" data-options="required:true">
			</td>
			<td style="width: 5%">状态</td><td style="width: 20%"><input    class="easyui-textbox" id="status" name="status"  style="width:250px" >
			</td>
			<td style="width: 5%">订单描述  </td><td style="width: 20%"><input    class="easyui-textbox" id="orderDescript"  name="orderDescript" style="width:150px" >
			</td>
			<td style="width: 5%">业务类型</td><td style="width: 20%">
 						<select class="easyui-combobox"  label="State:" labelPosition="top" style="width:100px;" name='type' id='type'>
				                <option value="座选" selected="selected">座选</option>
				                <option value="升舱">升舱</option>
				       </select>
			</td>
		</tr>
		<tr>
			<td style="width: 5%">其他联系电话</td><td style="width: 20%"><input  value=""  class="easyui-numberbox" id="otherPhone" name="otherPhone"  max="19999999999" style="width:250px">
			</td>
		</tr>
	</table>
		  <a href="javascript:void(0)" class="easyui-linkbutton" onclick="makeOrderSeat()" style="height: 20px">信息补填</a>
          <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearAdd()" style="height: 20px">清空</a>
          <a href="javascript:void(0)" class="easyui-linkbutton" onclick="orderSeatAdd()" style="height: 20px">添加</a>
           
</form>
</div>