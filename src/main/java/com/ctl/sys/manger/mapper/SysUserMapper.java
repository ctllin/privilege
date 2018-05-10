package com.ctl.sys.manger.mapper;

import com.ctl.sys.manger.model.sys.Tuser;
import com.ctl.sys.manger.po.SysUser;
import com.ctl.sys.manger.po.SysUserExample;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
public interface SysUserMapper {
    long countByExample(SysUserExample example);

    int deleteByExample(SysUserExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(SysUser record);

    int insertSelective(SysUser record);

    List<SysUser> selectByExample(SysUserExample example);

    SysUser selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SysUser record, @Param("example") SysUserExample example);

    int updateByExample(@Param("record") SysUser record, @Param("example") SysUserExample example);

    int updateByPrimaryKeySelective(SysUser record);

    int updateByPrimaryKey(SysUser record);

	List<String> selectUrl(Integer id);

	Tuser selectUserUserroleRole(Map<String,Object> map);
}