Date.prototype.Format = function(fmt)   
{ //author: meizz   
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}; 
function initDateTime(){
	var date = new Date(); 
    var seperator1 = "-"; 
   // var seperator2 = ":"; 
    var month = date.getMonth() + 1; 
    var strDate = date.getDate(); 
    if (month >= 1 && month <= 9) { 
        month = "0" + month; 
    } 
    if (strDate >= 0 && strDate <= 9) { 
        strDate = "0" + strDate; 
    } 
    /* var getHours=date.getHours();
    if(getHours<10){
    	getHours = "0" + getHours; 
    }
    var getMinutes=date.getMinutes() ;
    if(getMinutes<10){
    	getMinutes = "0" + getMinutes; 
    }
    var getSeconds=date.getSeconds();
    if(getSeconds<10){
    	getSeconds = "0" + getSeconds; 
    } */
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate ;
          /*   + " " + getHours + seperator2 + getMinutes 
            + seperator2 + getSeconds;  */
	document.getElementById("endtime").value=currentdate;
    date.setMonth(date.getMonth()-1); 
    strMonth = date.getMonth()+1;
	if (strMonth >= 0 && strMonth <= 9) { 
		strMonth = "0" + strMonth; 
	} 
	strDate = date.getDate();
	if (strDate >= 0 && strDate <= 9) { 
	        strDate = "0" + strDate; 
	} 
	currentdate = date.getFullYear() + seperator1 + strMonth + seperator1 + strDate; 
    /*  + " " + getHours + seperator2 + getMinutes 
     + seperator2 + getSeconds;  */
	document.getElementById("begintime").value=currentdate;
}