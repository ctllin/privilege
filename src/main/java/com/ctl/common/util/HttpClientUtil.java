package com.ctl.common.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.GZIPInputStream;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.File;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.ParseException;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.ctl.sys.manger.utils.ConfigUtils;
/**
 * 
 * @author Nan 2015-11
 */
@SuppressWarnings("deprecation")
public class HttpClientUtil {
	public static Logger logger = LoggerFactory.getLogger(HttpClientUtil.class);
	private static PoolingHttpClientConnectionManager cm;
	private static String EMPTY_STR = "";
	private static String UTF_8 = "UTF-8";

	private static void init() {
		if (cm == null) {
			cm = new PoolingHttpClientConnectionManager();
			cm.setMaxTotal(50);// 整个连接池最大连接数
			cm.setDefaultMaxPerRoute(5);// 每路由最大连接数，默认值是2
		}
	}
	public static void main(String[] args) throws JSONException {
		   // sendMessage();
		   // sendMessage(new HashMap<String, Object>());
		//jsonSend("http://localhost:8080/lightmanger/boc/receiveOrderSeat", "{\"cabin\":\"N\",\"commission\":0,\"count\":1,\"date\":\"2017-05-25 05:17:27\",\"destination\":\"北京(PEK)\",\"evidenceNo\":\"0004\",\"flightNumber\":\"HU482\",\"flightPhase\":\"BOSPEK\",\"invoiceAddress\":\"北京市丰台区方庄南路58号5单元2门601\",\"invoiceCell\":\"13691263625\",\"invoiceName\":\"孙阳\",\"invoiceTitle\":\"个人\",\"moneyType\":\"CNY\",\"newSeat\":\"17H\",\"oldSeat\":\"43C\",\"orderNumber\":\"D2C558F95BBCEE6620170525051622\",\"orderStatus\":\"刷卡成功\",\"orderType\":0,\"original\":\"波士顿(BOS)\",\"passengerName\":\"孙阳\",\"passengerPhone\":\"13691263625\",\"passengerTicketName\":\"\",\"payType\":\"card\",\"printFlightPhase\":\"波士顿(BOS)-北京(PEK)\",\"purserCellphone\":\"18600020887\",\"purserName\":\"俞维娜\",\"resultOfflineDto\":{\"cardNOMask\":\"440066******9652\",\"expDate\":\"**/**\",\"offTransDate\":\"20170525\",\"offTransTime\":\"051742\",\"orderNo\":\"D2C558F95BBCEE6620170525051622\",\"readDeviceID\":\"04774551\",\"responseCode\":\"P00\",\"terminalID\":\"31541288\"},\"serialNumber\":\"D2C558F95BBCEE6620170525051622\",\"totalAmount\":0,\"totalMoney\":11100.99,\"type\":\"升舱\",\"uniqueCode\":\"D2C558F95BBCEE6604PAPUPPmp20170602152028\",\"unitPrice\":0,\"upload\":false}");
		//jsonSend("http://localhost:8080/lightmanger/boc/receiveOrderCart","{\"IDNumber\":\" \",\"activePartition\":\" \",\"commission\":0.0,\"count\":0,\"customerAddress\":\"安徽省  安庆市  枞阳县fjk\",\"customerCellphone\":\"15927199306\",\"customerEmail\":\" \",\"customerName\":\"xilehang\",\"date\":\"2017-06-06 10:55:58\",\"destination\":\"北京(PEK)\",\"deviceType\":\" \",\"evidenceNo\":\"0003\",\"flightNumber\":\"HU1122\",\"flightPhase\":\"ALAPEK\",\"flyBless\":\" $ $ \",\"indroduction\":\"  \",\"isUpload\":false,\"orderFrom\":\"Y8\",\"orderNumber\":\"6EFBD72C602CE95420170606105139\",\"orderStatus\":\"交易成功\",\"orderType\":0,\"original\":\"阿拉木图(ALA)\",\"payDeviceID\":\"31541288\",\"payType\":\"card\",\"printFlightPhase\":\"阿拉木图(ALA)-北京(PEK)\",\"purserCellphone\":\"15927199306\",\"purserName\":\"xilehang\",\"resultOfflineDto\":{\"amount\":\"1\",\"cardNOMask\":\"622253******4256\",\"expDate\":\"2112\",\"offTransDate\":\"20170606\",\"offTransTime\":\"105944\",\"orderNo\":\"6EFBD72C602CE95420170606105139\",\"terminalID\":\"31541288\",\"responseCode\":\"0000\",\"responseDesc\":\"交易成功\",\"sysUniqueID\":\"17060610593045617411\",\"transStatus\":\"1\"},\"secondaryContact\":\" \",\"secondaryPhone\":\" \",\"secretMonth\":\" \",\"serialNumber\":\"6EFBD72C602CE95420170606105139\",\"subOrderList\":[{\"goodsCount\":1,\"goodsId\":\"3615\",\"goodsMoney\":70.0,\"goodsName\":\"红心木瓜（10斤装）\",\"goodsSize\":\"凤凰机场自提\"}],\"totalAmount\":0.0,\"totalMoney\":0.01,\"unitPrice\":0.0}");
		//jsonSend("http://localhost:8080/lightmanger/boc/receiveOrderCart","{\"IDNumber\":\" \",\"activePartition\":\" \",\"commission\":0.0,\"count\":0,\"customerAddress\":\"安徽省  安庆市  枞阳县hjkk\",\"customerCellphone\":\"15927199306\",\"customerEmail\":\" \",\"customerName\":\"xilehang\",\"date\":\"2017-06-02 17:18:41\",\"destination\":\"阿拉木图(ALA)\",\"deviceType\":\" \",\"flightNumber\":\"HU412\",\"flightPhase\":\"PEKALA\",\"flyBless\":\" $ $ \",\"indroduction\":\"  \",\"isUpload\":false,\"orderFrom\":\"9H\",\"orderNumber\":\"101C1324F688476720170602171714\",\"orderStatus\":\"不批准交易-Do Not Honour\",\"orderType\":0,\"original\":\"北京(PEK)\",\"payType\":\"card\",\"printFlightPhase\":\"北京(PEK)-阿拉木图(ALA)\",\"purserCellphone\":\"15927199306\",\"purserName\":\"xilehang\",\"resultOfflineDto\":{\"amount\":\"6900\",\"cardNOMask\":\"622253******4256\",\"expDate\":\"2112\",\"offTransDate\":\"20170602\",\"offTransTime\":\"172220\",\"orderNo\":\"101C1324F688476720170602171714\",\"responseCode\":\"9905\",\"responseDesc\":\"不批准交易-Do Not Honour\",\"sysUniqueID\":\"17060217221170672464\",\"terminalID\":\"31541288\"},\"secondaryContact\":\" \",\"secondaryPhone\":\" \",\"secretMonth\":\" \",\"serialNumber\":\"101C1324F688476720170602171714\",\"subOrderList\":[{\"goodsCount\":1,\"goodsId\":\"3791\",\"goodsMoney\":69.0,\"goodsName\":\"普麗猫趣味绘画蜡笔6色套装\",\"goodsSize\":\"6色套装\"}],\"totalAmount\":0.0,\"totalMoney\":69.0,\"unitPrice\":0.0}");
		Map<String, Object> dataMap=new HashMap<String, Object>();
		dataMap.put("content", "【喜乐航】您购买的VIPABC英语课程将在2个工作日内开通账号，账号为邮箱，初始密码为手机号后6位。开通后可登录VIPABC官网或APP预约上课。回复TD退订");
		//dataMap.put("18515287139", "18515287139");
		//dataMap.put("content","【喜乐航】"+"订购阿玛尼银色不锈钢表带黑色表盘圆形石英时尚成功"+" 回复TD退订");//短信内容 
		dataMap.put("mobile","18515287139,13161167381");//15311411026手机号,多个以分号分隔 
		//dataMap.put("extcode","18515287139");//扩展号，如果需要短信报告以及回复功能必须填写此项 
		System.out.println(sendMessage(dataMap));
	}
	public static String sendMessage() {
		String sendMsgUrl=ConfigUtils.getType("message.platform.sendMsgUrl"); 
		StringBuilder msgBuf = new StringBuilder(); 
		msgBuf.append("username=").append(ConfigUtils.getType("message.platform.username"));//用户名 
		msgBuf.append("&password=").append(ConfigUtils.getType("message.platform.password"));//密码 444335 
		msgBuf.append("&content=").append("您已成功订购梵克雅宝");//短信内容 
		msgBuf.append("&mobile=").append("18515287139");//手机号,多个以分号分隔 
		msgBuf.append("&extcode=").append("18515287139");//扩展号，如果需要短信报告以及回复功能必须填写此项 
		msgBuf.append("&senddate=").append("");//预约时间，如果为空代表即时发送 

		String result = httpPostRequest(sendMsgUrl+"?"+msgBuf.toString()); //发送post请求得到反馈结果
		String str = "";
		if ("0".equals(result)) {
			str = "数据提交成功";
		} else if ("-2".equals(result)) {
			str = "提交的号码中包含不符合格式的手机号码";
		} else if ("-1".equals(result)) {
			str = "数据保存失败";
		} else if ("1001".equals(result)) {
			str = "用户名或密码错误";
		} else if ("1002".equals(result)) {
			str = "余额不足";
		} else if ("1003".equals(result)) {
			str = "参数错误，请输入完整的参数";
		} else if ("1004".equals(result)) {
			str = "其他错误";
		} else if ("1005".equals(result)) {
			str = "预约时间格式不正确";
		}else{ str = "非正常返回值"; }
		logger.info("短信平台返回信息:"+str);
		return result;
	}
	public static String sendMessage(Map<String,Object> dataMap) {
		String sendMsgUrl=ConfigUtils.getType("message.platform.sendMsgUrl"); 
		dataMap.put("username", ConfigUtils.getType("message.platform.username"));//用户名 
		dataMap.put("password", ConfigUtils.getType("message.platform.password"));//密码
		dataMap.put("content","【喜乐航】"+"订购阿玛尼银色不锈钢表带黑色表盘圆形石英时尚成功"+" 回复TD退订");//短信内容 
		dataMap.put("mobile","18515287139");//手机号,多个以分号分隔 
		dataMap.put("extcode","18515287139");//扩展号，如果需要短信报告以及回复功能必须填写此项 
		dataMap.put("senddate","");//预约时间，如果为空代表即时发送 yyyyMMddHHmmss
		String result = null;
		try {
			result = httpPostRequest(sendMsgUrl,dataMap);
		} catch (UnsupportedEncodingException e) {
			logger.error("请求短信平台失败",e);
		} //发送post请求得到反馈结果
		String str = "";
		if ("0".equals(result)) {
			str = "数据提交成功";
		} else if ("-2".equals(result)) {
			str = "提交的号码中包含不符合格式的手机号码";
		} else if ("-1".equals(result)) {
			str = "数据保存失败";
		} else if ("1001".equals(result)) {
			str = "用户名或密码错误";
		} else if ("1002".equals(result)) {
			str = "余额不足";
		} else if ("1003".equals(result)) {
			str = "参数错误，请输入完整的参数";
		} else if ("1004".equals(result)) {
			str = "其他错误";
		} else if ("1005".equals(result)) {
			str = "预约时间格式不正确";
		}else{ str = "非正常返回值"; }
		logger.info("短信平台返回信息:"+str);
		return str;
	}
	public static void refund() {
		String orderNumber="";
	    String orderNumbers="072D3DDA18F1180B20170323140556,072D3DDA18F1180B20170323140944";
	   // orderNumbers="18F639C91197D16020170225171159";
	    String[] orders=orderNumbers.split(",") ;
	    for (int i = 0; i < orders.length; i++) {
	    	orderNumber=orders[i].trim();
	    	refundPortalPay(orderNumber,"1","0","1");
	    	portalPayQuery(orderNumber, "1");
	    	portalPayQuery(orderNumber, "2");
			
		}
	}
	/**
	 * 
	 * @param url  上传文件地址
	 * @param fileNamesPath 上传文件
	 */
	public static void submitPost(String url,String ...fileNamesPath){
		HttpClient httpclient = new DefaultHttpClient();
		try {
			HttpPost httppost = new HttpPost(url);
			MultipartEntity reqEntity = new MultipartEntity();
			for (int i = 0; i < fileNamesPath.length; i++) {
				//fileNamesPath为请求后台的File upload;属性   
				reqEntity.addPart("file"+i,new FileBody(new File(fileNamesPath[i])));
				//comment为请求后台的普通参数属性	
				StringBody comment = new StringBody(fileNamesPath[i]);
				reqEntity.addPart("file"+i+"comment",comment);
			}
		    httppost.setEntity(reqEntity);
		    HttpResponse response = httpclient.execute(httppost);
		    int statusCode = response.getStatusLine().getStatusCode();
			if(statusCode == HttpStatus.SC_OK){
				System.out.println("服务器正常响应.....");
		    	HttpEntity resEntity = response.getEntity();
		    	System.out.println(EntityUtils.toString(resEntity));//httpclient自带的工具类读取返回数据
		    	System.out.println(resEntity.getContent());   
		    	EntityUtils.consume(resEntity);
		    }
			} catch (ParseException e) {
				logger.error("submitPost",e);
			} catch (IOException e) {
				logger.error("submitPost",e);
			} finally {
			    try { 
			    	httpclient.getConnectionManager().shutdown(); 
			    } catch (Exception ignore) {
			    	
			    }
			}
		}
	
	
	
	/**
	 * 通过连接池获取HttpClient
	 * 
	 * @return
	 */
	private static CloseableHttpClient getHttpClient() {
		init();
		return HttpClients.custom().setConnectionManager(cm).build();
	}

	/**
	 * 
	 * @param url
	 * @return
	 */
	public static String httpGetRequest(String url) {
		HttpGet httpGet = new HttpGet(url);
		return getResult(httpGet);
	}

	public static String httpGetRequest(String url, Map<String, Object> params) throws URISyntaxException {
		URIBuilder ub = new URIBuilder();
		ub.setPath(url);

		ArrayList<NameValuePair> pairs = covertParams2NVPS(params);
		ub.setParameters(pairs);

		HttpGet httpGet = new HttpGet(ub.build());
		return getResult(httpGet);
	}

	public static String httpGetRequest(String url, Map<String, Object> headers, Map<String, Object> params)throws URISyntaxException {
		URIBuilder ub = new URIBuilder();
		ub.setPath(url);

		ArrayList<NameValuePair> pairs = covertParams2NVPS(params);
		ub.setParameters(pairs);

		HttpGet httpGet = new HttpGet(ub.build());
		for (Map.Entry<String, Object> param : headers.entrySet()) {
			httpGet.addHeader(param.getKey(), String.valueOf(param.getValue()));
		}
		return getResult(httpGet);
	}

	public static String httpPostRequest(String url) {
		HttpPost httpPost = new HttpPost(url);
		return getResult(httpPost);
	}

	public static String httpPostRequest(String url, Map<String, Object> params) throws UnsupportedEncodingException {
		HttpPost httpPost = new HttpPost(url);
		ArrayList<NameValuePair> pairs = covertParams2NVPS(params);
		httpPost.setEntity(new UrlEncodedFormEntity(pairs, UTF_8));
		return getResult(httpPost);
	}

	public static String httpPostRequest(String url, Map<String, Object> headers, Map<String, Object> params)
			throws UnsupportedEncodingException {
		HttpPost httpPost = new HttpPost(url);

		for (Map.Entry<String, Object> param : headers.entrySet()) {
			httpPost.addHeader(param.getKey(), String.valueOf(param.getValue()));
		}

		ArrayList<NameValuePair> pairs = covertParams2NVPS(params);
		httpPost.setEntity(new UrlEncodedFormEntity(pairs, UTF_8));

		return getResult(httpPost);
	}

	private static ArrayList<NameValuePair> covertParams2NVPS(Map<String, Object> params) {
		ArrayList<NameValuePair> pairs = new ArrayList<NameValuePair>();
		for (Map.Entry<String, Object> param : params.entrySet()) {
			pairs.add(new BasicNameValuePair(param.getKey(), String.valueOf(param.getValue())));
		}

		return pairs;
	}

	/**
	 * 处理Http请求
	 * 
	 * @param request
	 * @return
	 */
	private static String getResult(HttpRequestBase request) {
		// CloseableHttpClient httpClient = HttpClients.createDefault();
		CloseableHttpClient httpClient = getHttpClient();
		try {
			CloseableHttpResponse response = httpClient.execute(request);
			// response.getStatusLine().getStatusCode();
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				// long len = entity.getContentLength();// -1 表示长度未知
				String result = EntityUtils.toString(entity);
				response.close();
				// httpClient.close();
				return result;
			}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {

		}

		return EMPTY_STR;
	}

	public static void jsonSendCrossDomain(String requestUrl,Map<String,String> data) throws JSONException {
		long start=System.currentTimeMillis();
		long end = 0;
		try {
			// 创建连接
			URL url = new URL(requestUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);
			connection.setConnectTimeout(30000);
			//connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			connection.setRequestProperty("Content-Type","application/json; charset=UTF-8");
			connection.connect();
			// POST请求
			DataOutputStream out = new DataOutputStream(connection.getOutputStream());
			JSONObject obj = new JSONObject();
            Set<String> key=data.keySet();
            Iterator<String> iter=key.iterator();
            while(iter.hasNext()){
            	String keyStr=iter.next();
            	obj.put(keyStr, data.get(keyStr));
            }

			// System.out.println(obj.toString());
			// out.writeBytes(obj.toString());//这个中文会乱码
			out.write(obj.toString().getBytes());// 这样可以处理中文乱码问题
			out.flush();
			out.close();

			
			
			
			// 读取响应
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String lines;
			StringBuffer sb = new StringBuffer("");
			while ((lines = reader.readLine()) != null) {
				//lines = new String(lines.getBytes("utf-8"), "utf-8");
				//lines = new String(lines.getBytes("gbk"),"gbk");
//				lines = new String(lines.getBytes("gb2312"),"gb2312");
//				lines = new String(lines.getBytes("ISO8859-1"),"ISO8859-1");
				sb.append(lines);
			}
			//System.out.println(sb);
			reader.close();
			// 断开连接
			connection.disconnect();
		    end=System.currentTimeMillis();
		} catch (MalformedURLException e) {
			e.printStackTrace();
			System.out.println("-----1"+"\t"+(end-start));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			System.out.println("-----2"+"\t"+(end-start));
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("-----3"+"\t"+(end-start));
		}

	}

	public static String jsonSend(String requestUrl,Map<String,Object> data) throws JSONException {
		StringBuffer sb = new StringBuffer("");
		try {
			// 创建连接
			URL url = new URL(requestUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);

			// connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			connection.setRequestProperty("Content-Type","application/json; charset=UTF-8");
			connection.connect();
			// POST请求
			DataOutputStream out = new DataOutputStream(connection.getOutputStream());
			JSONObject obj = new JSONObject();
            Set<String> key=data.keySet();
            Iterator<String> iter=key.iterator();
            while(iter.hasNext()){
            	String keyStr=iter.next();
            	obj.put(keyStr, data.get(keyStr));
            }

			// System.out.println(obj.toString());
			// out.writeBytes(obj.toString());//这个中文会乱码
			out.write(obj.toString().getBytes());// 这样可以处理中文乱码问题
			out.flush();
			out.close();

			// 读取响应
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String lines;
			
			while ((lines = reader.readLine()) != null) {
				//lines = new String(lines.getBytes("utf-8"), "utf-8");
				//lines = new String(lines.getBytes("gbk"),"gbk");
//				lines = new String(lines.getBytes("gb2312"),"gb2312");
//				lines = new String(lines.getBytes("ISO8859-1"),"ISO8859-1");
				sb.append(lines);
			}
			reader.close();
			// 断开连接
			connection.disconnect();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	public static void jsonSend(String requestUrl,String jsonStr) throws JSONException {
		try {
			// 创建连接
			URL url = new URL(requestUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);

			// connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			connection.setRequestProperty("Content-Type","application/json; charset=UTF-8");
			connection.connect();
			// POST请求
			DataOutputStream out = new DataOutputStream(connection.getOutputStream());

			// System.out.println(obj.toString());
			// out.writeBytes(obj.toString());//这个中文会乱码
			out.write(net.sf.json.JSONObject.fromObject(jsonStr).toString().getBytes());// 这样可以处理中文乱码问题
			out.flush();
			out.close();

			// 读取响应
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String lines;
			StringBuffer sb = new StringBuffer("");
			while ((lines = reader.readLine()) != null) {
				//lines = new String(lines.getBytes("utf-8"), "utf-8");
				//lines = new String(lines.getBytes("gbk"),"gbk");
//				lines = new String(lines.getBytes("gb2312"),"gb2312");
//				lines = new String(lines.getBytes("ISO8859-1"),"ISO8859-1");
				sb.append(lines);
			}
			System.out.println(sb);
			reader.close();
			// 断开连接
			connection.disconnect();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	public static void jsonSendReturnGZIP(String requestUrl,Map<String,String> data) throws JSONException {
		try {
			// 创建连接
			URL url = new URL(requestUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);

			// connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			connection.setRequestProperty("Content-Type","application/json; charset=UTF-8");
			connection.connect();
			// POST请求
			DataOutputStream out = new DataOutputStream(connection.getOutputStream());
			
			JSONObject obj = new JSONObject();
            Set<String> key=data.keySet();
            Iterator<String> iter=key.iterator();
            while(iter.hasNext()){
            	String keyStr=iter.next();
            	obj.put(keyStr, data.get(keyStr));
            }

			// System.out.println(obj.toString());
			// out.writeBytes(obj.toString());//这个中文会乱码
			out.write(obj.toString().getBytes());// 这样可以处理中文乱码问题
			out.flush();
			out.close();

//			// 读取响应
//			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//			String lines;
//			StringBuffer sb = new StringBuffer("");
//			while ((lines = reader.readLine()) != null) {
//				//lines = new String(lines.getBytes("utf-8"), "utf-8");
//				//lines = new String(lines.getBytes("gbk"),"gbk");
////				lines = new String(lines.getBytes("gb2312"),"gb2312");
////				lines = new String(lines.getBytes("ISO8859-1"),"ISO8859-1");
//				sb.append(lines);
//			}
			
			int size=connection.getInputStream().available();
			byte bytes[]=new byte[size];
			connection.getInputStream().read(bytes);
			//logger.info(new String(bytes));
		    ByteArrayOutputStream outb = new ByteArrayOutputStream();  
	        ByteArrayInputStream in = new ByteArrayInputStream(bytes);  
	        try {  
	            GZIPInputStream ungzip = new GZIPInputStream(in);  
	            byte[] buffer = new byte[256];  
	            int n;  
	            while ((n = ungzip.read(buffer)) >= 0) {  
	            	outb.write(buffer, 0, n);  
	            }  
	           logger.info(new String(outb.toByteArray()));
	        } catch (IOException e) {  
	           logger.error("gzip uncompress error.", e);  
	        }  
			
			
			
			
			//System.out.println(sb);
			//reader.close();
			// 断开连接
	        outb.close();
			connection.disconnect();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	public static void jsonSendReturnGZIP2(String requestUrl,Map<String,String> data) throws JSONException {
		try {
			// 创建连接
			URL url = new URL(requestUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);

			// connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			connection.setRequestProperty("Content-Type","application/json; charset=UTF-8");
			connection.connect();
			// POST请求
			DataOutputStream out = new DataOutputStream(connection.getOutputStream());
			
			JSONObject obj = new JSONObject();
            Set<String> key=data.keySet();
            Iterator<String> iter=key.iterator();
            while(iter.hasNext()){
            	String keyStr=iter.next();
            	obj.put(keyStr, data.get(keyStr));
            }

			// System.out.println(obj.toString());
			// out.writeBytes(obj.toString());//这个中文会乱码
			out.write(obj.toString().getBytes());// 这样可以处理中文乱码问题
			out.flush();
			out.close();

//			// 读取响应
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String lines;
			StringBuffer sb = new StringBuffer("");
			while ((lines = reader.readLine()) != null) {
				sb.append(lines);
			}
			
//			int size=connection.getInputStream().available();
//			byte bytes[]=new byte[size];
//			connection.getInputStream().read(bytes);
			logger.info(sb.toString());
			logger.info(new String(sb.toString().getBytes("utf-8")));
		    ByteArrayOutputStream outb = new ByteArrayOutputStream();  
		    byte[] bytess=sb.toString().getBytes("utf-8");
	        ByteArrayInputStream in = new ByteArrayInputStream(bytess);  
	        try {  
	            GZIPInputStream ungzip = new GZIPInputStream(in);  
	            byte[] buffer = new byte[256];  
	            int n;  
	            while ((n = ungzip.read(buffer)) >= 0) {  
	            	outb.write(buffer, 0, n);  
	            }  
	           logger.info(new String(outb.toByteArray()));
	        } catch (IOException e) {  
	           logger.error("gzip uncompress error.", e);  
	        }  
			
			
			
			
			//System.out.println(sb);
			reader.close();
			// 断开连接
	        outb.close();
			connection.disconnect();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	 /**
	  * 
	  * @param orderNum  订单号
	  * @param type 1：支付订单  2：退款订单
	  * @return
	  */
	 //代扣查询接口
	 public static String portalPayQuery(String orderNumber,String type){
		 Map<String,Object> params=new LinkedHashMap<String,Object>();
			String resultQuery="";
			try {//调用代扣查询接口
				params.put("version", ConfigUtils.getType("portal.query.version"));
				params.put("serialID", orderNumber);//2017011175106295   DKFFD023B949D77EE720170111105445
				params.put("mode", ConfigUtils.getType("portal.query.mode"));
				params.put("type",type);
				params.put("orderID", orderNumber);
				params.put("partnerID",ConfigUtils.getType("portal.query.partnerID"));
				params.put("remark", ConfigUtils.getType("portal.query.remark"));
				params.put("charset",ConfigUtils.getType("portal.query.charset"));
				params.put("signType",ConfigUtils.getType("portal.query.signType"));
				params.put("signMsg", RSASignUtils.getSignMsg(orderNumber,type));
				try {
					resultQuery=HttpClientUtil.httpPostRequest("https://gateway.hnapay.com/website/queryOrderResult.htm", params);
					logger.info("代扣查询执行返回结果:"+resultQuery);
				} catch (Exception e) {
					logger.error("代扣执行结果查询error",e);
				}
			}catch(Exception e){
				logger.error("error:",e);
			}
			return resultQuery;
	 }
	 public static String sendMessageNew(Map<String,Object> dataMap) throws UnsupportedEncodingException {
			String charSet="utf-8";
			String sendMsgUrl=ConfigUtils.getType("message.platform.sendMsgNewUrl"); 
			dataMap.put("UserName", ConfigUtils.getType("message.platform.username"));//用户名 
			//Timestemp	必选	时间戳	格式为(MMddHHmmss)
			dataMap.put("Timestemp", DateUtil.sdfMMddHHmmss.format(new Date()));
			//Content	必选	短信内容	短信内容。RLEncoder.encode utf-8编码，500个字或字符以内
			//dataMap.put("Content",URLEncoder.encode((String)dataMap.get("Content"),charSet));//短信内容
			dataMap.put("Content",dataMap.get("content"));//短信内容
			//CharSet	必选	短信编码	暂时只支持utf-8编码
			dataMap.put("CharSet",charSet);
			//Mobiles	必选	手机号码	多个手机号码用“,”隔开。（半角逗号）1000个以内
	 		dataMap.put("Mobiles",dataMap.get("mobile"));//手机号,多个以分号分隔 
	 		//验证秘钥
			dataMap.put("Key", getKey((String)dataMap.get("UserName"),(String) ConfigUtils.getType("message.platform.password"),(String)dataMap.get("Timestemp")));//验证秘钥
//			dataMap.put("extcode","18515287139");//扩展号，如果需要短信报告以及回复功能必须填写此项 
			String result = null;
			net.sf.json.JSONObject resultMap=null;
			try {
				resultMap=net.sf.json.JSONObject.fromObject(httpPostRequest(sendMsgUrl,dataMap));
				result=resultMap.getString("result");
			} catch (UnsupportedEncodingException e) {
				logger.error("请求短信平台失败",e);
			} //发送post请求得到反馈结果
			String str = "";
			if ("0".equals(result)) {
				str = "数据提交成功";
			} else if ("-2001".equals(result)) {
				str = "内容中存在黑字典";
			} else if ("-2002".equals(result)) {
				str = "号码中存在黑名单";
			} else if ("-2004".equals(result)) {
				str = "用户名错误";
			} else if ("-2005".equals(result)) {
				str = "密码错误";
			} else if ("-2006".equals(result)) {
				str = "内容长度错";
			} else if ("-2007".equals(result)) {
				str = "号码长度超出范围";
			} else if ("-2008".equals(result)) {
				str = "余额为零";
			} else if ("-2009".equals(result)) {
				str = "余额不足";
			} else if ("-2010".equals(result)) {
				str = "用户名为空";
			} else if ("-2011".equals(result)) {
				str = "时间戳错误";
			} else if ("-2012".equals(result)) {
				str = "Key为空";
			} else if ("-2013".equals(result)) {
				str = "内容为空";
			} else if ("-2014".equals(result)) {
				str = "字符集错误";
			} else if ("-2015".equals(result)) {
				str = "号码不能为空";
			} else if ("-2016".equals(result)) {
				str = "定时时间错误";
			} else if ("-2017".equals(result)) {
				str = "优先级超出范围";
			} else if ("-2018".equals(result)) {
				str = "包ID超出范围0～50";
			} else if ("-2019".equals(result)) {
				str = "包sID超出范围0～50";
			} else if ("-2020".equals(result)) {
				str = "通信异常";
			} else if ("-2021".equals(result)) {
				str = "模式错误0-1";
			} else if ("-2022".equals(result)) {
				str = "回调地址错误";
			} else if ("-3001".equals(result)) {
				str = "通道信息错误";
			} else if ("-3002".equals(result)) {
				str = "通道扩展码超长";
			} else if ("-3003".equals(result)) {
				str = "通信包错误";
			} else if ("-3004".equals(result)) {
				str = "状态报告比对不存在";
			} else if ("-3005".equals(result)) {
				str = "Key队列满";
			} else if ("-3006".equals(result)) {
				str = "MT_RespKey重复";
			} else if ("-3007".equals(result)) {
				str = "MT超时,或状态报告ID重复";
			} else if ("-3008".equals(result)) {
				str = "用户策略失败";
			} else if ("-3009".equals(result)) {
				str = "查无订单记录";
			} else if ("-3010".equals(result)) {
				str = "没有找到匹配的订单";
			} else if ("-3011".equals(result)) {
				str = "路由不存在";
			} else if ("-3012".equals(result)) {
				str = "无当前业务路由";
			} else if ("-3013".equals(result)) {
				str = "未知号码";
			} else if ("-3015".equals(result)) {
				str = "用户调用频率过高";
			} else if ("-3016".equals(result)) {
				str = "内容不包含回，退订";
			} else if ("-4001".equals(result)) {
				str = "签名过长";
			} else if ("-4002".equals(result)) {
				str = "签名不匹配";
			} else if ("-4003".equals(result)) {
				str = "签名错误";
			} else if ("-4099".equals(result)) {
				str = "号码发送超限";
			} else if ("-502".equals(result)||"-5002".equals(result)) {
				str = "审核失败（或-5002）";
			} else {
				str = "非正常返回值";
			}
			logger.info("短信平台返回信息:"+str);
			return result;
		}
	 /**
		 * 
		 * @param userName
		 * @param password
		 * @param timestemp
		 * @return
		 */
		public static String getKey(String userName, String password, String timestemp) {
			String key = "";
			try {
				MessageDigest mdTemp = MessageDigest.getInstance("MD5");
				mdTemp.update(userName.getBytes());
				mdTemp.update(password.getBytes());
				mdTemp.update(timestemp.getBytes());
				key = bytesToHexString(mdTemp.digest());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return key;
		}
		public static String getTimestemp() {
				return (new SimpleDateFormat("MMddHHmmss")).format(new Date());
		}
		public static String bytesToHexString(byte[] src) {
				String resultString = "";
				StringBuilder stringBuilder = new StringBuilder("");
				if (src == null || src.length <= 0) {
					return null;
				}
				for (int i = 0; i < src.length; i++) {
					int v = src[i] & 0xFF;
					String hv = Integer.toHexString(v);
					if (hv.length() < 2) {
						stringBuilder.append(0);
					}
					stringBuilder.append(hv);
				}
				resultString = stringBuilder.toString();
				stringBuilder = null;
				return resultString;
		}
	 /**
	  * 
	  * @param orderNum 商品订单号
	  * @param refundAmount  退款金额
	  * @param remark  有无网模式
	  * @return
	  */
	 //代扣退款接口
	public static String refundPortalPay(String orderNum,String refundAmount,String remark,String refundType ){
		Map<String,Object> params=new LinkedHashMap<String,Object>();
		params.put("version", "2.6");
		//请求序列号
		params.put("serialID", "DKREFUND"+DateUtil.sdf.format(new Date()));//2017011175106295   DKFFD023B949D77EE720170111105445
		//商户退款订单号
		params.put("refundOrderID", UUID.randomUUID().toString().replaceAll("-", ""));
		//商户原始订单
		params.put("orderID",orderNum);
		//退款目的地类型 1：原路退回
		params.put("destType","1" );
		//退款类型 1：全额退款 2：部分退款
		params.put("refundType", refundType);
		//商户退款金额
		params.put("refundAmount", refundAmount);
		//商户退款订单时间
		params.put("refundTime", DateUtil.sdf.format(new Date()));
		//商户通知地址
		//params.put("noticeUrl", "http://101.200.162.214:8080/alipay/portalpay/receivePortalPayCallbackRefund");
		params.put("noticeUrl", ConfigUtils.getType("portalpay.noticeurl.refundcallback"));
		//商户 ID
		params.put("partnerID", "11000000473");
		//扩展字段
		params.put("remark", remark);
		//编码方式 1： UTF-8
		params.put("charset", "1");
		//签名类型 1： RSA 方式 2： MD5 方式
		params.put("signType","1" );
		//签名字符串
		Set<String> keys=params.keySet();
		Iterator<String> iter=keys.iterator();
		StringBuilder buf=new StringBuilder();
		while(iter.hasNext()){
			String key=iter.next();
			buf.append(key).append("=").append(params.get(key)).append("&");
		}
		buf.delete(buf.length()-1, buf.length());
		params.put("signMsg", RSASignUtils.genSignByRSA(buf.toString()));
		String result=null;
		try {
			result=httpPostRequest("https://gateway.hnapay.com/website/refund.htm", params);
			logger.info("代扣退款执行返回结果:"+result);
			return result;
		} catch (Exception e) {
			logger.error("请求代扣退款接口失败:",e);
		}
		return result;
	}
	
}
