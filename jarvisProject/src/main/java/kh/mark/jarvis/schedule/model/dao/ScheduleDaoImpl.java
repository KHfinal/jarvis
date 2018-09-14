package kh.mark.jarvis.schedule.model.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kh.mark.jarvis.schedule.model.vo.Schedule;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {

	private Logger logger = LoggerFactory.getLogger(ScheduleDaoImpl.class);
	
	@Override
	public int addSchedule(SqlSessionTemplate sqlSession, Schedule s) {
		logger.debug("스케줄등록 dao단 시작");
		return sqlSession.insert("schedule.addSchedule",s);
	}

	@Override
	public List<Map<String, Object>> eventList(SqlSessionTemplate sqlSession, String userEmail) {
		return sqlSession.selectList("schedule.loadEventList", userEmail);
	}

	@Override
	public Schedule loadEvent(SqlSessionTemplate sqlSession, Schedule s) {
		return sqlSession.selectOne("schedule.loadEvent", s);
	}

	@Override
	public int updateEvent(SqlSessionTemplate sqlSession, Schedule s) {
		return sqlSession.update("schedule.updateEvent", s);
	}

	@Override
	public int deleteEvent(SqlSessionTemplate sqlSession, int sNo) {
		return sqlSession.delete("schedule.deleteEvent",sNo);
	}

}
