package kh.mark.jarvis.schedule.model.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kh.mark.jarvis.schedule.model.dao.ScheduleDao;
import kh.mark.jarvis.schedule.model.vo.Schedule;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private Logger logger = LoggerFactory.getLogger(ScheduleServiceImpl.class);
	
	
	@Override
	public int addSchedule(Schedule s) {
		logger.debug("스케줄 등록 서비스단 시작");
		return dao.addSchedule(sqlSession,s);
	}


	@Override
	public List<Map<String, Object>> eventList(String userEmail) {
		return dao.eventList(sqlSession,userEmail);
	}


	@Override
	public Schedule loadEvent(Schedule s) {
		return dao.loadEvent(sqlSession,s);
	}


	@Override
	public int updateEvent(Schedule s) {
		return dao.updateEvent(sqlSession,s);
	}


	@Override
	public int deleteEvent(int sNo) {
		return dao.deleteEvent(sqlSession,sNo);
	}

}
