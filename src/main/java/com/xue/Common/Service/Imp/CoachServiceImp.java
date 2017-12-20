package com.xue.Common.Service.Imp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xue.Common.Dao.CoachDao;
import com.xue.Common.Entity.Coach;
import com.xue.Common.Service.CoachService;

@Service("coachService")
public class CoachServiceImp implements CoachService{
	@Autowired
	CoachDao coachDao; 

	@Override
	public List<Coach> query(Coach coa) {
		// TODO Auto-generated method stub
		List<Coach> list=coachDao.query(coa);
		return list;
	}
	
	
	@Override
	public List listpage(String pageno, String pagesize) {
		// TODO Auto-generated method stub
		System.out.println("pageno"+pageno+"pagesize"+pagesize);
		String tablename="coach";
		String sql="select * from ( SELECT ROWNUM AS LIMITNUM,T.*  FROM "+tablename+" T  ) WHERE LIMITNUM BETWEEN ("+pageno+"-1)*"+pagesize+" AND "+pageno+"*"+pagesize;
		return coachDao.listpage(sql);
	}

	@Override
	public int add(Coach coa) {
		// TODO Auto-generated method stub
		return coachDao.add(coa);
	}


	@Override
	public int update(Coach coa) {
		// TODO Auto-generated method stub
		return coachDao.update(coa);
	}


	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return coachDao.delete(id);
	}

	

}
