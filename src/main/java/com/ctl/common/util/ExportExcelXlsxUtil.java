package com.ctl.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipException;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExportExcelXlsxUtil {
	SimpleDateFormat sdfyyyyMMdd=new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat sdfx=new SimpleDateFormat("yyyy/MM/dd");

	/**
	 * 将读取到的文件重新写入新的文件
	 * 
	 * @param output
	 * @param request 
	 * 
	 * @param bw
	 */
	public static void main(String[] args) {


		List<Map<String,Object>> dataList=new ArrayList<Map<String,Object>>();
		Map<String,Object> map1=new HashMap<String, Object>();
		Map<String,Object> map2=new HashMap<String, Object>();
		Map<String,Object> map3=new HashMap<String, Object>();
		map1.put("1", "1");
		map1.put("2", "2");
		map1.put("3", "3");
		map2.put("1", "a");
		map2.put("2", "b");
		map2.put("3", "c");
		map3.put("1", "测试a");
		map3.put("2", "测试b");
		map3.put("3", "测试c");
		dataList.add(map1);
		dataList.add(map2);
		dataList.add(map3);
		String fileName="E:\\Users\\ctl\\Desktop\\export\\export.xlsx";
		String templateName="E:\\Users\\ctl\\Desktop\\export\\t2.xlsx";
		ExportExcelXlsxUtil exportTempExcelXlsx=new ExportExcelXlsxUtil();
		String name=exportTempExcelXlsx.export(dataList,fileName,templateName);
		System.out.println(name);
		//List<String> fileNameList=new ArrayList<String>();
		//fileNameList.add(name);
		//String zipName=exportTempExcelXlsx.creatZip(fileNameList, "E:\\Users\\ctl\\Desktop\\export\\export.zip");
		//System.out.println(name+"\t"+zipName);
		
	}
	/**
	 * 
	 * @param dataList
	 * @param fileName
	 * @param templateName // 获取模版
	 * @return
	 */
    @SuppressWarnings("resource")
	public String export(List<Map<String,Object>> dataList,String fileName,String templateName ){
    	Workbook templatewb = null;
		Sheet tempSheet = null;
		int num = 1;//从第几行还是写入数据  0为第一行1为第二行
		int cellnum = 0;
		OutputStream output =null;//文件导出流
		try {
			output=new FileOutputStream(new File(fileName));
			//String modelName = templateName;// 获取模版
			// 获取模板
			templatewb = new XSSFWorkbook(new FileInputStream(new File(templateName)));
			tempSheet = templatewb.getSheetAt(0);//获取第一个sheet页
			//设置样式
			CellStyle style = templatewb.createCellStyle();
			// 获取模板sheet页
			style.setAlignment(HorizontalAlignment.CENTER);
			style.setVerticalAlignment(VerticalAlignment.CENTER);
			// 增加表格边框的样式 例子
			style.setBorderBottom(BorderStyle.THIN);
			style.setBorderLeft(BorderStyle.THIN);// 左边框
			style.setBorderRight(BorderStyle.THIN);// 右边框
			style.setBorderTop(BorderStyle.THIN);// 上边框
			// 用POI导出excel时，较长的数字不想被自动变为科学计数法的解决方式
  			DataFormat format = templatewb.createDataFormat(); 
   			style.setDataFormat(format.getFormat("@"));
//   			1）  文本：vnd.ms-excel.numberformat:@
//   			2）  日期：vnd.ms-excel.numberformat:yyyy/mm/dd
//   			3）  数字：vnd.ms-excel.numberformat:#,##0.00
//   			4）  货币：vnd.ms-excel.numberformat:￥#,##0.00
//   			5）  百分比：vnd.ms-excel.numberformat: #0.00%
			Font font = templatewb.createFont();
			font.setFontName("新宋体");
			font.setFontHeightInPoints((short) 9);// 字体大小
			style.setFont(font); // 调用字体样式对象
			style.setWrapText(true);
			// 将数据写入excel
			for (int i = 0; i < dataList.size(); i++) {
				Row row = tempSheet.createRow(num++);
				row.setHeightInPoints(22); // 设置行高
				Map<String, Object> dataMap = dataList.get(i);
				cellnum = -1;
				// 排名
				Cell cellNum = row.createCell(++cellnum);
				cellNum.setCellValue(i+1);
				cellNum.setCellStyle(style);

				// 终端编号
				Cell term_id = row.createCell(++cellnum);
				term_id.setCellValue(dataMap.get("1").toString());
				term_id.setCellStyle(style);

				Cell man_id = row.createCell(++cellnum);
				man_id.setCellValue(dataMap.get("2").toString());
				man_id.setCellStyle(style);

				Cell stop_time_9 = row.createCell(++cellnum);
				stop_time_9.setCellValue(dataMap.get("3").toString());
				stop_time_9.setCellStyle(style);
				// 终端编号
				Cell term_id1 = row.createCell(++cellnum);
				term_id1.setCellValue(dataMap.get("1").toString());
				term_id1.setCellStyle(style);

				Cell man_id1 = row.createCell(++cellnum);
				man_id1.setCellValue(dataMap.get("2").toString());
				man_id1.setCellStyle(style);

				Cell stop_time_91 = row.createCell(++cellnum);
				stop_time_91.setCellValue(dataMap.get("3").toString());
				stop_time_91.setCellStyle(style);
				// 终端编号
				Cell term_id11 = row.createCell(++cellnum);
				term_id11.setCellValue(dataMap.get("1").toString());
				term_id11.setCellStyle(style);

				Cell man_id11 = row.createCell(++cellnum);
				man_id11.setCellValue(dataMap.get("2").toString());
				man_id11.setCellStyle(style);

				Cell stop_time_911 = row.createCell(++cellnum);
				stop_time_911.setCellValue(dataMap.get("3").toString());
				stop_time_911.setCellStyle(style);
			}
			// 将内容写入Excel
			templatewb.write(output);
			return  fileName;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				output.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "";
    }
    @SuppressWarnings("resource")
  	public static String exportTermInfoServlet(String templateName,OutputStream output,List<Map<String,Object>> dataList){
    	XSSFWorkbook templatewb = null;
  		Sheet tempSheet = null;
  		int num = 1;//从第几行还是写入数据  0为第一行1为第二行
  		int cellnum = 0;
//  		OutputStream output =null;//文件导出流
  		try {
  			//output=new FileOutputStream(new File(fileName));
  			//String modelName = templateName;// 获取模版
  			// 获取模板
  			templatewb = new XSSFWorkbook(new FileInputStream(new File(templateName)));
  			tempSheet = templatewb.getSheetAt(0);//获取第一个sheet页
  			//设置样式
  			CellStyle style = templatewb.createCellStyle();
  			// 获取模板sheet页
  			style.setAlignment(HorizontalAlignment.CENTER);
  			style.setVerticalAlignment(VerticalAlignment.CENTER);
  			// 增加表格边框的样式 例子
  			style.setBorderBottom(BorderStyle.THIN);
  			style.setBorderLeft(BorderStyle.THIN);// 左边框
  			style.setBorderRight(BorderStyle.THIN);// 右边框
  			style.setBorderTop(BorderStyle.THIN);// 上边框
  			
  			Font font = templatewb.createFont();
  			font.setFontName("新宋体");
  			font.setFontHeightInPoints((short) 9);// 字体大小
  			style.setFont(font); // 调用字体样式对象
  			style.setWrapText(true);
  			// 将数据写入excel
  			for (int i = 0; i < dataList.size(); i++) {
  				Row row = tempSheet.createRow(num++);
  				row.setHeightInPoints(22); // 设置行高
  				Map<String, Object> dataMap = dataList.get(i);
  				cellnum = -1;
  				// 排名
  				Cell cellNum = row.createCell(++cellnum);
  				cellNum.setCellValue(i+1);
  				cellNum.setCellStyle(style);

  				// 终端编号
  				Cell serial = row.createCell(++cellnum);
  				serial.setCellValue((String)dataMap.get("serial"));
  				serial.setCellStyle(style);

  				Cell mac = row.createCell(++cellnum);
  				mac.setCellValue((String)dataMap.get("mac"));
  				mac.setCellStyle(style);

  				Cell airVersionName = row.createCell(++cellnum);
  				airVersionName.setCellValue((String)dataMap.get("airVersionName"));
  				airVersionName.setCellStyle(style);
  				// 终端编号
  				Cell cityName = row.createCell(++cellnum);
  				cityName.setCellValue((String)dataMap.get("cityName"));
  				cityName.setCellStyle(style);

  			}
  			// 将内容写入Excel
  			templatewb.write(output);
  		} catch (Exception e) {
  			e.printStackTrace();
  		} finally {
  			try {
  				output.close();
  			} catch (IOException e) {
  				e.printStackTrace();
  			}
  		}
  		return "";
      }
    public String creatZip(List<String> fileList,String fileName) {
		File file = null;
		int leng = 0;
		byte[] byteTemp = null;
		ZipOutputStream zos = null;
		FileInputStream fis = null;

		try {
			file = new File(fileName);
			byteTemp = new byte[1024];
			// 压缩
			zos = new ZipOutputStream(new FileOutputStream(file));
			zos.setEncoding("GBK");
			for (int i = 0; i < fileList.size(); i++) {
				// 被压缩的文件
				fis = new FileInputStream(fileList.get(i));
				// 在压缩包中的路径
				int index=fileList.get(i).lastIndexOf(File.separator);
				String zipFilePath=fileList.get(i).substring(index+1);
				ZipEntry zEntry = new ZipEntry(zipFilePath);
				zos.putNextEntry(zEntry);
				while ((leng = fis.read(byteTemp)) != -1) {
					zos.write(byteTemp, 0, leng);
				}
				zos.closeEntry();
				fis.close();
				fis = null;
			}
			return fileName;
		} catch (ZipException ze) {
			ze.printStackTrace();
			return null;
		} catch (IOException ioe) {
			ioe.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				zos.close();
				if (fis != null) {
					fis.close();
					fis = null;
				}
				file = null;
				byteTemp = null;
				zos = null;

				delFiles(fileList);
			} catch (Exception ex) {
				return null;
			}
		}
	
	}

	public boolean delFiles(List<String> fileNameList) {
		try {
			for (int i = 0; i < fileNameList.size(); i++) {
				delFile(fileNameList.get(i));
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	public boolean delFile(String filePath) {
		try {
			File fileTemp = new File(filePath);
			if (fileTemp.exists() && fileTemp.canWrite())
				return fileTemp.delete();
			else
				return false;
		} catch (Exception e) {
			return false;
		}
	}
}
