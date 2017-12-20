package com.xue.Common.Dao;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.Student;


public interface StudentDao {
	//≤È
    List<Student> query(Student stu);
    //∑÷“≥
    List<Student> listpage(String sql);
    
    int add(Student stu);
    int update(Student stu);
    int delete(String id);

}
