package com.ctl.sys.manger.utils;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import net.sf.json.JSONObject;

/**
 * 自定义数字字典转换，支持json和map两种
 * @author ctl
 *
 */
public class StatusTag extends TagSupport {
	static Logger logger = LoggerFactory.getLogger(StatusTag.class);  
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	protected String name;

	private static HashMap<String, Map<Object, Object>> hashMap;

	protected String type;
	
	private String jsonName;
	
	private String mapName;
	
	private String jsonline;//0  输出json整行内容 其他不变
	
	public String getMapName() {
		return mapName;
	}

	public void setMapName(String mapName) {
		this.mapName = mapName;
	}

	public String getJsonName() {
		return jsonName;
	}

	public void setJsonName(String jsonName) {
		this.jsonName = jsonName;
	}
    static{
    	hashMap=new HashMap<String,Map<Object,Object>>();
//    	Map<String,Object> portalPayStatus=new HashMap<String, Object>();
//    	portalPayStatus.put("0", "已经接受");
//    	portalPayStatus.put("1", "处理中");
//    	portalPayStatus.put("2", "支付成功");
//    	portalPayStatus.put("3", "支付失败");
//    	hashMap.put("portalPayStatus", portalPayStatus);
    }
    public static HashMap<String, Map<Object, Object>> getDictionaryData(){
    	return hashMap;
    }
	@SuppressWarnings("unchecked")
	public int doEndTag() throws JspException {

		JspWriter out=null;
		try {
			out = pageContext.getOut();
			if("json".equals(type)){//如果类型为json 对应的js文件存放zai/conf/json下面
				if(hashMap.get(jsonName)==null||"".equals(hashMap.get(jsonName))){//如果是第二次调用json文件则从map中取值，避免多次读取文件
					Scanner scanner = new Scanner(StatusTag.class.getClassLoader().getResourceAsStream("json" + File.separator + jsonName + ".js"),"utf-8");
					StringBuilder buf = new StringBuilder();

					while (scanner.hasNext()) {
						String str = scanner.nextLine();
						if (str != null) {
							if(!str.trim().startsWith("//"))
							buf.append(str.trim());
						}
					}
					scanner.close();
					Map<Object, Object> jsonMap = JSONObject.fromObject(buf.toString());
					jsonMap.put("jsonline", buf.toString().trim());
					hashMap.put(jsonName, jsonMap);//将数据放到map中,防止多次执行调用读取js文件
					String value=jsonMap.get(name).toString();
					if(!"0".equals(jsonline)){
						if(value==null){
							out.print(name);
						}else{
							out.print(value);
						}
					}else{
						out.print(buf.toString().trim());
					}
				}else{
					String value=(String) hashMap.get(jsonName).get(name);
					if(!"0".equals(jsonline)){
						if(value==null){
							out.print(name);
						}else{
							out.print(value);
						}
					}else{
						out.print(hashMap.get(jsonName).get("jsonline"));
					}
				}
				
			}else if("map".equals(type)){
				try {
					if(hashMap.get(mapName)==null){
						out.print(name);
					}else{
						if(hashMap.get(mapName).get(name)==null){
							out.print(name);
						}else{
							out.print(hashMap.get(mapName).get(name));
						}
					}
				} catch (Exception e) {
					out.print(name);
				}
			}
			

		} catch (Exception e) {
			try {
				out.print(name);
			} catch (IOException e1) {
			}
			logger.error("自定义标签转换异常",e);
		}

		return super.doEndTag();
	}

	public int doStartTag() throws JspTagException {

		return EVAL_BODY_INCLUDE;

	}

	public HashMap<String, Map<Object, Object>> getHashMap() {
		return hashMap;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		if(name!=null){
			this.name = name.trim();
		}else{
			this.name="";
		}
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getJsonline() {
		return jsonline;
	}

	public void setJsonline(String jsonline) {
		this.jsonline = jsonline;
	}
	
	
}
