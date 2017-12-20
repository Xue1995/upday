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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mchange.v2.coalesce.CoalesceTest;
import com.xue.Common.Entity.Coach;
import com.xue.Common.Entity.Student;
import com.xue.Common.Entity.User;
import com.xue.Common.Service.CoachService;

@Controller
public class CoachController {
	@Resource(name="coachService")
	CoachService coachService;
	
	@RequestMapping("/coachpage")
	public String page(Model model){
		
		
		return "Page/Coach/Cpage.jsp";
	}
	
	@RequestMapping("/coachcuslist")
	@ResponseBody
	public void query(Coach coa,HttpServletRequest request,HttpServletResponse response) throws IOException {
		String search=request.getParameter("search")==null?"":request.getParameter("search");
		List<Coach> total=coachService.query(coa);

		String pageno=request.getParameter("page")==null?"1":request.getParameter("page");
		
		String rows=request.getParameter("rows")==null?"1":request.getParameter("rows");
		List list=coachService.listpage(pageno, rows);
		Map map = new HashMap();
		map.put("total", total);
		map.put("rows", list);
		

		JSONObject jsonArray= JSONObject.fromObject(map);
		System.out.println("JSONARRAY:"+jsonArray.toString());	
		
		response.setContentType("text/html;charset=utf-8"); 
		response.getWriter().write(jsonArray.toString());
		//return jsonArray.toString();
	}
	
	//添加
	@RequestMapping(value = "addCoach", produces = "text/html;charset=utf-8;")
	@ResponseBody
	public String addUser(Coach coa) throws Exception {
		String c = UU();
		coa.setCid(c);
		int mvlues = coachService.add(coa);
		JSONObject result = new JSONObject();
		if (mvlues > 0) {
			result.put("msg", true);
		} else {
			result.put("msg", false);
			result.put("errorMsg", "添加失败");
		}
		return result.toString();
	}
	//删除
	@RequestMapping("/delCoach")
	@ResponseBody
	public String delCoa(HttpServletRequest request) throws Exception {
		String delids = request.getParameter("delids");
		int delNums = coachService.delete(delids);
		JSONObject result = new JSONObject();
		if (delNums > 0) {
			result.put("msg", true);
			result.put("delNums", delNums);
		} else {
			result.put("msg", false);
			result.put("errorMsg", "删除失败");
		}
		return result.toString();
	}
	
	//修改
	@RequestMapping("/updateCoach")
	@ResponseBody
	public String updateCoach(Coach coa) throws Exception {
		int mvlues = coachService.update(coa);
		JSONObject result = new JSONObject();
		if (mvlues > 0) {
			result.put("msg", true);
		} else {
			result.put("msg", false);
			result.put("errorMsg", "修改失败");
		}
		return result.toString();
	}
	
	
	public String UU(){
		String uuid="";   
	    //获取当前时间戳         
	    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");    
	    String temp = sf.format(new Date());    
	    //获取6位随机数  
	    int random=(int) ((Math.random()+1)*100000);    
	    uuid=temp+random; 
		return uuid;
	}

}
