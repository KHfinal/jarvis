package kh.mark.jarvis.admin.model.service;


import java.util.Map;

import kh.mark.jarvis.admin.model.vo.PageInfo;

public interface AdminService {

	int updateHeader(PageInfo p);

	int updateSide(PageInfo p);

	int memberLock(Map map);

	int memberUnlock(int memberNo);

	int unlock();


}
