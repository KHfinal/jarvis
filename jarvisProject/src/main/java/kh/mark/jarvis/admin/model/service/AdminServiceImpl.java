package kh.mark.jarvis.admin.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mark.jarvis.admin.model.dao.AdminDao;
import kh.mark.jarvis.admin.model.vo.PageInfo;
import kh.mark.jarvis.chatting.model.dao.ChattingDao;


@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Override
	
	public int updateHeader(PageInfo p) {
		return dao.updateHeader(sqlSession,p);
	}

}
