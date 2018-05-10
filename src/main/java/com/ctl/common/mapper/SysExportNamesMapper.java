package com.ctl.common.mapper;

import com.ctl.common.po.SysExportNames;
import com.ctl.common.po.SysExportNamesExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SysExportNamesMapper {
    long countByExample(SysExportNamesExample example);

    int deleteByExample(SysExportNamesExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(SysExportNames record);

    int insertSelective(SysExportNames record);

    List<SysExportNames> selectByExample(SysExportNamesExample example);

    SysExportNames selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SysExportNames record, @Param("example") SysExportNamesExample example);

    int updateByExample(@Param("record") SysExportNames record, @Param("example") SysExportNamesExample example);

    int updateByPrimaryKeySelective(SysExportNames record);

    int updateByPrimaryKey(SysExportNames record);
}