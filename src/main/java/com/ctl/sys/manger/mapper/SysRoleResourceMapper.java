package com.ctl.sys.manger.mapper;

import com.ctl.sys.manger.po.SysRoleResourceExample;
import com.ctl.sys.manger.po.SysRoleResourceKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SysRoleResourceMapper {
    long countByExample(SysRoleResourceExample example);

    int deleteByExample(SysRoleResourceExample example);

    int deleteByPrimaryKey(SysRoleResourceKey key);

    int insert(SysRoleResourceKey record);

    int insertSelective(SysRoleResourceKey record);

    List<SysRoleResourceKey> selectByExample(SysRoleResourceExample example);

    int updateByExampleSelective(@Param("record") SysRoleResourceKey record, @Param("example") SysRoleResourceExample example);

    int updateByExample(@Param("record") SysRoleResourceKey record, @Param("example") SysRoleResourceExample example);
}