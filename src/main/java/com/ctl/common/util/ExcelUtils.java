package com.ctl.common.util;
import java.io.File;
import java.io.FileInputStream;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUtils {
public static void main(String[] args) {
	try {
		 // 声明一个工作薄
	      XSSFWorkbook workbook = new XSSFWorkbook(new FileInputStream(new File("d:\\1.xlsx")));
	      // 生成一个表格
	      XSSFSheet sheet = workbook.getSheetAt(0);
	      System.out.println(sheet.getLastRowNum());;
	      System.out.println(sheet.getRow(1).getCell(0)); 
	      System.out.println(sheet.getRow(1).getCell(1)); 
	      System.out.println(sheet.getRow(1).getCell(2)); 
	     workbook.close();
	} catch (Exception e) {
		System.out.println(e);
	}
}
}
