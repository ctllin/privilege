package com.ctl.sys.manger.mapper;

import com.ctl.sys.manger.pageModel.sys.Role;
import com.ctl.sys.manger.po.SysRole;
import com.ctl.sys.manger.po.SysRoleExample;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface SysRoleMapper {
    long countByExample(SysRoleExample example);

    int deleteByExample(SysRoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    List<SysRole> selectByExample(SysRoleExample example);

    SysRole selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SysRole record, @Param("example") SysRoleExample example);

    int updateByExample(@Param("record") SysRole record, @Param("example") SysRoleExample example);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);

	List<Role> selectByParameter(Role role);

	long countByParameter(Role role);

	List<Map<String, Object>> getResoureIdNameByRoleId(Map<String, Object> map);
}