package kh.mark.jarvis.conversation.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.mark.jarvis.conversation.model.dao.ConversationDao;

@Service
public class ConversationServiceImpl implements ConversationService{
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Autowired
	private ConversationDao dao;
	
	
	
}
