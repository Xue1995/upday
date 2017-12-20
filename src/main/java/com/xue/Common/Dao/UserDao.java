package com.xue.Common.Dao;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.User;

public interface UserDao {
    //µÇÂ½
    List<Map> findUserByNameAndPwd(User user); 
    //²é
    List<User> query(User user);
    //·ÖÒ³
    List<User> listpage(String sql);
    
    int delete(String id);
    int add(User user);
    int update(User user);
    
}
