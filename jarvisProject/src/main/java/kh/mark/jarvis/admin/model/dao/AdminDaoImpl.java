package kh.mark.jarvis.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.admin.model.vo.Notify;
import kh.mark.jarvis.admin.model.vo.PageInfo;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.Post;

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

	@Override
	public int memberLock(SqlSessionTemplate sqlSession, Map map) {
		return sqlSession.update("siteinfo.memberLock",map);
	}

	@Override
	public int memberUnlock(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.update("siteinfo.memberUnlock", memberNo);
	}

	@Override
	public int unlock(SqlSessionTemplate sqlSession) {
		return sqlSession.update("siteinfo.unlock");
	}

	@Override
	public List<Map<String, String>> notifyList(SqlSessionTemplate sqlSession, int cPage, int numPerPage) {
		return sqlSession.selectList("siteinfo.notifyList", null, new RowBounds((cPage-1)*numPerPage, numPerPage));
	}

	@Override
	public int selectTotalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("siteinfo.selectTotalCount");
	}

	@Override
	public int insertPostNotify(SqlSessionTemplate sqlSession, Notify notify) {
		return sqlSession.insert("siteinfo.insertPostNotify", notify);
	}

	@Override
	public Notify selectNotifyInfo(SqlSessionTemplate sqlSession, int nNo) {
		return sqlSession.selectOne("siteinfo.selectNotifyInfo", nNo);
	}

	@Override
	public Post selectPostInfo(SqlSessionTemplate sqlSession, int pNo) {
		return sqlSession.selectOne("siteinfo.selectPostInfo",pNo);
	}

	@Override
	public List<Attachment> selectAttachInfo(SqlSessionTemplate sqlSession, int pNo) {
		return sqlSession.selectList("siteinfo.selectAttachInfo",pNo);
	}

}
