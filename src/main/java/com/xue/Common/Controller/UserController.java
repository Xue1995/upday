package com.xue.Common.Controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xue.Common.Entity.User;
import com.xue.Common.Service.UserService;

@Controller
public class UserController {
	@Resource(name="userService")
	UserService userService;
	
	//��½
	@RequestMapping(value="/findByUser",produces="application/json;charset=utf-8")
	@ResponseBody
	public String findByUser(@RequestBody User user){

		JSONObject jsonObject = new JSONObject();

		if (userService.findUserByNameAndPwd(user).size() == 1) {
			jsonObject.put("msg", true);

		} else {
			jsonObject.put("msg", false);
		}
		System.out.println(jsonObject.toString());
		return jsonObject.toString();
	}
	
	@RequestMapping("/login")
	public String show(Model model){
		
		
		return "Page/main.html";
	}
	
	@RequestMapping("/userpage")
	public String page(Model model){
		
		
		return "Page/User/Upage.jsp";
	}
	
	
	//��ҳ
	@RequestMapping("/usercuslist")
	@ResponseBody
	public void query(User user,HttpServletRequest request,HttpServletResponse response) throws IOException {
		List<User> total=userService.query(user);
		String pageno=request.getParameter("page")==null?"1":request.getParameter("page");
		String rows=request.getParameter("rows")==null?"1":request.getParameter("rows");
		List list=userService.listpage(pageno, rows);
		Map map = new HashMap();
		map.put("total", total);
		map.put("rows", list);
		

		JSONObject jsonArray= JSONObject.fromObject(map);
		System.out.println("JSONARRAY:"+jsonArray.toString());	
		
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().write(jsonArray.toString());
		//return jsonArray.toString();
	}
	
	
	 	//���
		@RequestMapping(value = "addUser", produces = "text/html;charset=utf-8;")
		@ResponseBody
		public String addUser(User user) throws Exception {
			String c = UU();
			user.setId(c);
			int mvlues = userService.add(user);
			JSONObject result = new JSONObject();
			if (mvlues > 0) {
				result.put("msg", true);
			} else {
				result.put("msg", false);
				result.put("errorMsg", "���ʧ��");
			}
			return result.toString();
		}
		
		//�޸�
		@RequestMapping("/updateUser")
		@ResponseBody
		public String updateUser(User user) throws Exception {
			int mvlues = userService.update(user);
			JSONObject result = new JSONObject();
			if (mvlues > 0) {
				result.put("msg", true);
			} else {
				result.put("msg", false);
				result.put("errorMsg", "�޸�ʧ��");
			}
			return result.toString();
		}
	 	
		//ɾ��
		@RequestMapping("/delUser")
		@ResponseBody
		public String delUser(HttpServletRequest request) throws Exception {
			String delids = request.getParameter("delids");
			int delNums = userService.delete(delids);
			JSONObject result = new JSONObject();
			if (delNums > 0) {
				result.put("msg", true);
				result.put("delNums", delNums);
			} else {
				result.put("msg", false);
				result.put("errorMsg", "ɾ��ʧ��");
			}
			return result.toString();
		}
	 	
	 	public String UU(){
			String uuid="";   
		    //��ȡ��ǰʱ���         
		    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");    
		    String temp = sf.format(new Date());    
		    //��ȡ6λ�����  
		    int random=(int) ((Math.random()+1)*100000);    
		    uuid=temp+random; 
			return uuid;
		}
	 	
}
