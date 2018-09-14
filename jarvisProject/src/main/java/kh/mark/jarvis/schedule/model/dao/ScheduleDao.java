package kh.mark.jarvis.schedule.model.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import kh.mark.jarvis.schedule.model.vo.Schedule;

public interface ScheduleDao {

	int addSchedule(SqlSessionTemplate sqlSession, Schedule s);

	List<Map<String, Object>> eventList(SqlSessionTemplate sqlSession, String userEmail);

	Schedule loadEvent(SqlSessionTemplate sqlSession, Schedule s);

	int updateEvent(SqlSessionTemplate sqlSession, Schedule s);

	int deleteEvent(SqlSessionTemplate sqlSession, int sNo);

}
