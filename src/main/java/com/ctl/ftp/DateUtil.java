package com.ctl.ftp;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DateUtil {
	  public static SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
	  public static SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	  public static SimpleDateFormat sdfdatemm = new SimpleDateFormat("yyyyMM");
	  public static SimpleDateFormat sdfdatemm2 = new SimpleDateFormat("yyyy-MM");
	  public static SimpleDateFormat sdfdatemmdd = new SimpleDateFormat("yyyyMMdd");
	  public static SimpleDateFormat sdfdatemmdd2 = new SimpleDateFormat("yyyy-MM-dd");
	  public static SimpleDateFormat sdfMMddHHmmss=new SimpleDateFormat("MMddHHmmss");
	  public static SimpleDateFormat sdfyyyyMMddHHmmss=new SimpleDateFormat("yyyyMMddHHmmss");
	  public static SimpleDateFormat sdfyyyyMMddHHmmssSSS=new SimpleDateFormat("yyyyMMddHHmmssSSS");
	  public static SimpleDateFormat sdfyyyyMMdd = new SimpleDateFormat("yyyyMMdd");
	  public static SimpleDateFormat sdfyyyyMM = new SimpleDateFormat("yyyyMM");
	  public static SimpleDateFormat sdfyyyy_MM_dd_HH_mm_ss=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	  public static SimpleDateFormat sdfyyyy_MM_dd_HH_mm = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	  public static SimpleDateFormat sdfyyyy_MM_dd = new SimpleDateFormat("yyyy-MM-dd");
	  public static SimpleDateFormat sdfyyyy_MM = new SimpleDateFormat("yyyy-MM");
	  public static void main(String[] args) throws ParseException {
		System.out.println(sdf2.parse("2017-01-05 00:00:00"));
	}
}
