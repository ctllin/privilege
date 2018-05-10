package com.ctl.common.po;

import java.util.Date;

public class SysExportNames {
    private Integer id;

    private String filename;

    private String filenamepath;

    private String filenameurl;

    private String flag;

    private String tablename;

    private Date savetime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getFilenamepath() {
        return filenamepath;
    }

    public void setFilenamepath(String filenamepath) {
        this.filenamepath = filenamepath == null ? null : filenamepath.trim();
    }

    public String getFilenameurl() {
        return filenameurl;
    }

    public void setFilenameurl(String filenameurl) {
        this.filenameurl = filenameurl == null ? null : filenameurl.trim();
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag == null ? null : flag.trim();
    }

    public String getTablename() {
        return tablename;
    }

    public void setTablename(String tablename) {
        this.tablename = tablename == null ? null : tablename.trim();
    }

    public Date getSavetime() {
        return savetime;
    }

    public void setSavetime(Date savetime) {
        this.savetime = savetime;
    }
}