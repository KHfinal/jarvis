package kh.mark.jarvis.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.admin.model.vo.Notify;
import kh.mark.jarvis.admin.model.vo.PageInfo;
import kh.mark.jarvis.post.model.vo.Attachment;
import kh.mark.jarvis.post.model.vo.Post;

public interface AdminDao {

	int updateHeader(SqlSessionTemplate sqlSession, PageInfo p);

	int updateSide(SqlSessionTemplate sqlSession, PageInfo p);

	int memberLock(SqlSessionTemplate sqlSession, Map map);

	int memberUnlock(SqlSessionTemplate sqlSession, int memberNo);

	int unlock(SqlSessionTemplate sqlSession);

	List<Map<String, String>> notifyList(SqlSessionTemplate sqlSession, int cPage, int numPerPage);

	int selectTotalCount(SqlSessionTemplate sqlSession);

	// 용
	int insertPostNotify(SqlSessionTemplate sqlSession, Notify notify);

	Notify selectNotifyInfo(SqlSessionTemplate sqlSession, int nNo);

	Post selectPostInfo(SqlSessionTemplate sqlSession, int pNo);

	List<Attachment> selectAttachInfo(SqlSessionTemplate sqlSession, int pNo);



}
