package com.xue.Common.Service;

import java.util.List;
import java.util.Map;

import com.xue.Common.Entity.Student;

public interface StudentService {
	//��
    List<Student> query(Student stu);
    //��ҳ
    List<Student> listpage(String pageno, String pagesize);
    
    int add(Student stu);
    int update(Student stu);
    int delete(String id);

}
