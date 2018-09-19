package kh.mark.jarvis.admin.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mark.jarvis.admin.model.dao.AdminDao;
import kh.mark.jarvis.admin.model.vo.Notify;
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

	@Override
	public int updateSide(PageInfo p) {
		return dao.updateSide(sqlSession,p);
	}

	@Override
	public int memberLock(Map map) {
		return dao.memberLock(sqlSession,map);
	}

	@Override
	public int memberUnlock(int memberNo) {
		return dao.memberUnlock(sqlSession,memberNo);
	}

	@Override
	public int unlock() {
		return dao.unlock(sqlSession);
	}

	@Override
	public List<Map<String, String>> notifyList(int cPage, int numPerPage) {
		return dao.notifyList(sqlSession,cPage,numPerPage);
	}

	@Override
	public int selectTotalcount() {
		return dao.selectTotalCount(sqlSession);
	}

	// 용
	@Override
	public int insertPostNotify(Notify notify) {
		return dao.insertPostNotify(sqlSession, notify);
	}
	
}
