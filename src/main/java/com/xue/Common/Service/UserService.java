package com.xue.Common.Service;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.User;

public interface UserService {
	//�û���¼  
    List<Map> findUserByNameAndPwd(User user);
    //��
    List<User> query(User user);
    //��ҳ
    List listpage(String pageno,String pagesize);
    
    int delete(String id);
    int add(User user);
    int update(User user);

}
