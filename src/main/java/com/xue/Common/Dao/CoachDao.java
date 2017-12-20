package com.xue.Common.Dao;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.Coach;

public interface CoachDao {
	//��
    List<Coach> query(Coach coa);
    //��ҳ
    List<Coach> listpage(String sql);
    
    int add(Coach coa);
    int update(Coach coa);
    int delete(String id);
    

}
