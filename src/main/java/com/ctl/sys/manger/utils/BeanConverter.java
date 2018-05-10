package com.ctl.sys.manger.utils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method; 
import java.util.HashMap; 
import java.util.Map; 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/** 
*转换器 
*1:将JavaBean 转换成Map、JSONObject 
*2:将JSONObject 转换成Map 
* 
* @author xxx 
*/ 
public class BeanConverter 
{ 
	static Logger logger = LoggerFactory.getLogger(BeanConverter.class);  
	static{
		try {
			new DesUtils();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		DataTest data=new DataTest(1,14.5f,70.1d,"ctllin林");
		Map<String,String> map=toEncryptMap(data);
		//System.out.println(map);
		data=(DataTest) toJavaBean(data, map);
		System.out.println("加密后"+data);
		 map=toDecryptMap(data);
	     toJavaBean(data, map);
		System.out.println("解密后:"+data);

	}
    /** 
     * 将javaBean转换成Map 
     * 
     * @param javaBean javaBean 
     * @return Map对象 
     */ 
    public static Map<String, String> toEncryptMap(Object javaBean) 
    { 
        Map<String, String> result = new HashMap<String, String>(); 
        Method[] methods = javaBean.getClass().getDeclaredMethods(); 

        for (Method method : methods) 
        { 
            try 
            { 
                if (method.getName().startsWith("get")) 
                { 
                    String field = method.getName(); 
                    String simpleName=method.getReturnType().getSimpleName();
                    field = field.substring(field.indexOf("get") + 3); 
                    field = field.toLowerCase().charAt(0) + field.substring(1); 

                    Object value = method.invoke(javaBean, (Object[])null); 
                    if(null!=value&&!"".equals(value)&&"String".equals(simpleName)){
                    	result.put(field, null == value ? "" : DesUtils.encrypt( value.toString()));
                    }else{
                    	result.put(field, null == value ? "" : value.toString());
                    }
                } 
            } 
            catch (Exception e) 
            { 
            	e.printStackTrace();
            } 
        } 

        return result; 
    } 

    public static Map<String, String> toDecryptMap(Object javaBean) 
    { 
        Map<String, String> result = new HashMap<String, String>(); 
        Method[] methods = javaBean.getClass().getDeclaredMethods(); 

        for (Method method : methods) 
        { 
            try 
            { 
                if (method.getName().startsWith("get")) 
                { 
                	 String simpleName=method.getReturnType().getSimpleName();
                	String field = method.getName(); 
                    field = field.substring(field.indexOf("get") + 3); 
                    field = field.toLowerCase().charAt(0) + field.substring(1); 

                    Object value = method.invoke(javaBean, (Object[])null); 
                    if(null!=value&&!"".equals(value)&&"String".equals(simpleName)){
                    	result.put(field, null == value ? "" : DesUtils.decrypt( value.toString()));
                    }else{
                    	result.put(field, null == value ? "" : value.toString());
                    }
                    
                } 
            } 
            catch (Exception e) 
            { 
            	e.printStackTrace();
            } 
        } 

        return result; 
    } 
    
    /** 
     * 将json对象转换成Map 
     * 
     * @param jsonObject json对象 
     * @return Map对象 
     */ 
//    public static Map<String, String> toMap(JSONObject jsonObject) 
//    { 
//        Map<String, String> result = new HashMap<String, String>(); 
//        Iterator<String> iterator = jsonObject.keys(); 
//        String key = null; 
//        String value = null; 
//        while (iterator.hasNext()) 
//        { 
//            key = iterator.next(); 
//            value = jsonObject.getString(key); 
//            result.put(key, value); 
//        } 
//        return result; 
//    } 

    /** 
     * 将javaBean转换成JSONObject 
     * 
     * @param bean javaBean 
     * @return json对象 
     */ 
//    public static JSONObject toJSON(Object bean) 
//    { 
//        return new JSONObject(toMap(bean)); 
//    } 

    /** 
     * 将map转换成Javabean 
     * 
     * @param javabean javaBean 
     * @param data map数据 
     */ 
    public static Object toJavaBean(Object javabean, Map<String, String> data) 
    { 
        Method[] methods = javabean.getClass().getDeclaredMethods(); 
        for (Method method : methods) 
        { 
            try 
            { 
                if (method.getName().startsWith("set")) 
                { 
                    String field = method.getName(); 
                    field = field.substring(field.indexOf("set") + 3); 
                    field = field.toLowerCase().charAt(0) + field.substring(1); 
                    method.invoke(javabean, new Object[] 
                    { 
                        data.get(field) 
                    }); 
                } 
            } 
            catch (Exception e) 
            { 
            } 
        } 
        return javabean; 
    } 
    public static Map<String, Object> transBean2Map(Object obj,Map<String,Object> map) {
        if(obj == null){
            return null;
        }        
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();
                // 过滤class属性
                if (!key.equals("class")) {
                    // 得到property对应的getter方法
                    Method getter = property.getReadMethod();
                    Object value = getter.invoke(obj);
                    if(null!=value&&!"".equals(value))
                    map.put(key, value);
                }

            }
        } catch (Exception e) {
        	logger.error("transBean2Map Error " + e);
        }
        return map;
    }
    
    
    public static Object transMap2Bean(Object javabean, Map<String, Object> data) 
    { 
        Method[] methods = javabean.getClass().getDeclaredMethods(); 
        for (Method method : methods) 
        { 
            try 
            { 
                if (method.getName().startsWith("set")) 
                { 
                    String field = method.getName(); 
                    field = field.substring(field.indexOf("set") + 3); 
                    field = field.toLowerCase().charAt(0) + field.substring(1); 
                    method.invoke(javabean, new Object[] 
                    { 
                        data.get(field) 
                    }); 
                } 
            } 
            catch (Exception e) 
            { 
            } 
        } 
        return javabean; 
    } 
    
    /** 
     * 将javaBean转换成JSONObject 
     * 
     * @param bean javaBean 
     * @return json对象 
     * @throws ParseException json解析异常 
     */ 
//    public static void toJavaBean(Object javabean, String data) throws ParseException 
//    { 
//        JSONObject jsonObject = new JSONObject(data); 
//        Map<String, String> datas = toMap(jsonObject); 
//        toJavaBean(javabean, datas); 
//    } 
}
class DataTest{
	private int id;
	private float unit;
	private double price;
	private String name;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getUnit() {
		return unit;
	}
	public void setUnit(float unit) {
		this.unit = unit;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public DataTest(int id, float unit, double price, String name) {
		super();
		this.id = id;
		this.unit = unit;
		this.price = price;
		this.name = name;
	}
	public DataTest() {
		super();
	}
	@Override
	public String toString() {
		return "DataTest [id=" + id + ", unit=" + unit + ", price=" + price
				+ ", name=" + name + "]";
	}
	
}