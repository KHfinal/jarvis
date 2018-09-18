package kh.mark.jarvis.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.admin.model.vo.PageInfo;

public interface AdminDao {

	int updateHeader(SqlSessionTemplate sqlSession, PageInfo p);

	int updateSide(SqlSessionTemplate sqlSession, PageInfo p);

	int memberLock(SqlSessionTemplate sqlSession, Map map);

	int memberUnlock(SqlSessionTemplate sqlSession, int memberNo);

	int unlock(SqlSessionTemplate sqlSession);



}
