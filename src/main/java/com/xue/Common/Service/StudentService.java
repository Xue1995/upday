package com.xue.Common.Service;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.Student;

public interface StudentService {
	//≤È
    List<Student> query(Student stu);
    //∑÷“≥
    List<Student> listpage(String pageno, String pagesize);
    
    int add(Student stu);
    int update(Student stu);
    int delete(String id);

}
