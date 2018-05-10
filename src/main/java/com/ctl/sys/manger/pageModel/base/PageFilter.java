package com.ctl.sys.manger.pageModel.base;

@SuppressWarnings("unused")
public class PageFilter implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private int currow;//查询起始行 mysql默认为第0行开始
	private String sort;// 排序字段
	private String order;// asc/desc
    private String begintime;
    private String endtime;
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page<1?1:page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public int getCurrow() {
		return this.currow=(page-1)*rows;
	}

	public void setCurrow(int currow) {
		this.currow = currow;
	}

	public String getBegintime() {
		return begintime;
	}

	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
//	public void setBegintime(String begintime) {
//		if(begintime==null||"".equals(begintime.trim())){
//			this.begintime = begintime;
//		}else{
//			this.begintime=begintime.split(" ")[0]+" 00:00:00";
//		}
//	}
//
//	public void setEndtime(String endtime) {
//		if(endtime==null||"".equals(endtime.trim())){
//			this.endtime = endtime;
//		}else{
//			this.endtime=endtime.split(" ")[0]+" 23:59:59";
//		}
//	}
}
