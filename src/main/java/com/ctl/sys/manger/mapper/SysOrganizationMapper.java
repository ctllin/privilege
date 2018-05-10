package com.ctl.sys.manger.mapper;

import com.ctl.sys.manger.pageModel.sys.Organization;
import com.ctl.sys.manger.po.SysOrganization;
import com.ctl.sys.manger.po.SysOrganizationExample;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

public interface SysOrganizationMapper {
    long countByExample(SysOrganizationExample example);

    int deleteByExample(SysOrganizationExample example);

    long deleteByPrimaryKey(Integer id);

    int insert(SysOrganization record);

    int insertSelective(SysOrganization record);

    List<SysOrganization> selectByExample(SysOrganizationExample example);

    SysOrganization selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SysOrganization record, @Param("example") SysOrganizationExample example);

    int updateByExample(@Param("record") SysOrganization record, @Param("example") SysOrganizationExample example);

    int updateByPrimaryKeySelective(SysOrganization record);

    int updateByPrimaryKey(SysOrganization record);

	List<Organization> treeGrid(Map<String ,Object> map);

	Integer organizationUnionUserNum(Map<String, Object> map);

	List<Integer> selectIdByPid(Integer id);

}