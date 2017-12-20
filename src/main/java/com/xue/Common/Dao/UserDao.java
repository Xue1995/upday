package com.xue.Common.Dao;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.User;

public interface UserDao {
    //��½
    List<Map> findUserByNameAndPwd(User user); 
    //��
    List<User> query(User user);
    //��ҳ
    List<User> listpage(String sql);
    
    int delete(String id);
    int add(User user);
    int update(User user);
    
}
