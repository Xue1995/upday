package com.xue.Common.Service;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.Coach;

public interface CoachService {
	//��
	List<Coach> query(Coach coa);
    //��ҳ
    List listpage(String pageno,String pagesize);
    
    int add(Coach coa);
    int update(Coach coa);
    int delete(String id);
    

}
