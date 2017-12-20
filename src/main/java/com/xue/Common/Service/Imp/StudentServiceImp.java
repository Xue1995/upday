package com.xue.Common.Service.Imp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xue.Common.Dao.StudentDao;
import com.xue.Common.Entity.Student;
import com.xue.Common.Service.StudentService;

@Service("studentService")
public class StudentServiceImp implements StudentService{
	@Autowired
	StudentDao studentDao;

	@Override
	public List<Student> query(Student stu) {
		// TODO Auto-generated method stub
		List<Student> list=studentDao.query(stu);
		return list;
	}

	@Override
	public List<Student> listpage(String pageno, String pagesize) {
		// TODO Auto-generated method stub
		System.out.println("pageno"+pageno+"pagesize"+pagesize);
		String tablename="tstudent";
		String sql="select * from ( SELECT ROWNUM AS LIMITNUM,T.*  FROM "+tablename+" T  ) WHERE LIMITNUM BETWEEN ("+pageno+"-1)*"+pagesize+" AND "+pageno+"*"+pagesize;
		return studentDao.listpage(sql);
	}
	
	@Override
	public int add(Student stu) {
		// TODO Auto-generated method stub
		return studentDao.add(stu);
	}

	@Override
	public int update(Student stu) {
		// TODO Auto-generated method stub
		return studentDao.update(stu);
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return studentDao.delete(id);
	}

}
