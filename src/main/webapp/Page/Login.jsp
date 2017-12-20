<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- CSS -->
        <link rel="stylesheet" href="assets/css/reset.css">
        <link rel="stylesheet" href="assets/css/supersized.css">
        <link rel="stylesheet" href="assets/css/style.css">   
        <link rel="stylesheet" type="text/css" href="css/styles.css">
		<!-- <style type="text/css">
		body,td,th { font-family: "Source Sans Pro", sans-serif; }
		/* body { background-color: #2B2B2B; } */
		</style> -->
</head>

<body>
        <div class="page-container">	           
		<div class="wrapper">	
			<div class="container">
				<strong><span style="font-weight: bold;font-size: 25px;">爱  码  士</span></strong> 
				<form class="form" id="formone" method="post">
					<input type="text" id="uname" placeholder="Username" value="admin">
					<input type="password" id="upsw"  placeholder="Password" value="123">
					<button type="button" id="login">登录</button>
				</form>
			</div>
	  </div>
        </div>
      <script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
        <!-- Javascript -->
        <script src="assets/js/jquery-1.8.2.min.js"></script>
        <script src="assets/js/supersized.3.2.7.min.js"></script>
        <script src="assets/js/supersized-init.js"></script>
        <script src="assets/js/scripts.js"></script>
</body>
<script type="text/javascript">

$("#login").click(function() {
        $.ajax({
    		url:"${pageContext.request.contextPath}/findByUser.action",
            type : "post",
            dataType : "json",
            contentType : "application/json;charset=UTF-8",
            data : JSON.stringify({
            	uname:$("#uname").val(),
            	upsw:$("#upsw").val()
            }),
            success : function(result) {
            	if(result.msg){
            		window.location.href="${pageContext.request.contextPath }/login.action";
                	//alert("loginSuccess");
            	}else{
            		//alert("loginError!!");
				}
            },
        
           
        });
    });
</script>
</html>