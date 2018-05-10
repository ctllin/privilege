package com.ctl.sys.manger.mapper;

import com.ctl.sys.manger.pageModel.sys.Resource;
import com.ctl.sys.manger.po.SysResource;
import com.ctl.sys.manger.po.SysResourceExample;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface SysResourceMapper {
    long countByExample(SysResourceExample example);

    int deleteByExample(SysResourceExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(SysResource record);

    int insertSelective(SysResource record);

    List<SysResource> selectByExample(SysResourceExample example);

    SysResource selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SysResource record, @Param("example") SysResourceExample example);

    int updateByExample(@Param("record") SysResource record, @Param("example") SysResourceExample example);

    int updateByPrimaryKeySelective(SysResource record);

    int updateByPrimaryKey(SysResource record);

	List<String> selectUrl();

	List<Resource> treeGrid(Map<String,Object> map);

	List<Integer> selectIdByPid(Integer id);

	Integer resourceUnionRoleNum(Map<String, Object> map);

	List<Resource> setTreeByPrivilege(Map<String, Object> map);
}