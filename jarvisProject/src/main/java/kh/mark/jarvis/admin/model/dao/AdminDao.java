package kh.mark.jarvis.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.admin.model.vo.PageInfo;

public interface AdminDao {

	int updateHeader(SqlSessionTemplate sqlSession, PageInfo p);

	int updateSide(SqlSessionTemplate sqlSession, PageInfo p);

}
