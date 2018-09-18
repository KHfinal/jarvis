package kh.mark.jarvis.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.admin.model.vo.PageInfo;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Override
	public int updateHeader(SqlSessionTemplate sqlSession, PageInfo p) {
		
		int result = sqlSession.update("siteinfo.updateHeader", p);
		System.out.println("mapper갔다왔음");
		return result;
	}

	@Override
	public int updateSide(SqlSessionTemplate sqlSession, PageInfo p) {
		return sqlSession.update("siteinfo.updateSide",p);
	}

}
