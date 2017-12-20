package com.xue.Common.Service;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.User;

public interface UserService {
	//用户登录  
    List<Map> findUserByNameAndPwd(User user);
    //查
    List<User> query(User user);
    //分页
    List listpage(String pageno,String pagesize);
    
    int delete(String id);
    int add(User user);
    int update(User user);

}
