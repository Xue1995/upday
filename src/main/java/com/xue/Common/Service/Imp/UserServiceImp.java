package com.xue.Common.Service.Imp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xue.Common.Dao.UserDao;
import com.xue.Common.Entity.User;
import com.xue.Common.Service.UserService;

@Service("userService")
public class UserServiceImp implements UserService{
	@Autowired
	UserDao userDao;

	//µÇÂ½
	@Override
	public List<Map> findUserByNameAndPwd(User user) {
		// TODO Auto-generated method stub
		return userDao.findUserByNameAndPwd(user);
	}
	//²éÑ¯
	@Override
	public List<User> query(User user) {
		// TODO Auto-generated method stub
		List<User> list = userDao.query(user);
		return list;
	}
	
	//·ÖÒ³
	@Override
	public List listpage(String pageno, String pagesize) {
		System.out.println("pageno"+pageno+"pagesize"+pagesize);
		String tablename="users";
		String sql="select * from ( SELECT ROWNUM AS LIMITNUM,T.*  FROM "+tablename+" T  ) WHERE LIMITNUM BETWEEN ("+pageno+"-1)*"+pagesize+" AND "+pageno+"*"+pagesize;
		return userDao.listpage(sql);
	}
	
	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return userDao.delete(id);
	}
	@Override
	public int add(User user) {
		// TODO Auto-generated method stub
		return userDao.add(user);
	}
	@Override
	public int update(User user) {
		// TODO Auto-generated method stub
		return userDao.update(user);
	}
	
}
