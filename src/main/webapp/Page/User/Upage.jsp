<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@include file="../contextjs.jsp" %>
<script type="text/javascript">
    var url;
    function searchUser() {
        $("#dg").datagrid('load', {
            "uname" : $("#uname").val()
        });
    }
    function openUserAddDialog() {
    	$("#dlg").dialog("open").dialog("setTitle", "添加用户信息");
		url = "${pageContext.request.contextPath}/addUser.action";
	}

	function openUserModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if (selectedRows.length != 1) {
			$.messager.alert('系统提示', '请选择一条要编辑的数据！');
			return;
		}
		var row = selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "修改用户");
		$("#fm").form("load", row);
		//alert(row);
		url = "${pageContext.request.contextPath}/updateUser.action?id="+row.id;
		//alert(url);
	}
	//保存
	function saveUser(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				//alert(result);
				var result=eval('('+result+')');
				if(result.errorMsg){
					$.messager.alert('系统提示',"<font color=red>"+result.errorMsg+"</font>");
					return;
				}else{
					$.messager.alert('系统提示','保存成功');
					closeUserDialog();
					$("#dg").datagrid("reload");
				}
			}
		});
	}

    //关闭按钮
    function closeUserDialog() {
        $("#dlg").dialog("close");
        $("#fm").form('clear');
    }
    
    
	
    //删除
   function deleteUser() {
		var selectedRows = $("#dg").datagrid('getSelections');
		if (selectedRows.length == 0) {
			$.messager.alert('系统提示', '请选择删除的用户！');
			return;
		}
		var strIds = [];
		for (var i = 0; i < selectedRows.length; i++) {
			strIds.push(selectedRows[i].id);
		}
		var ids = strIds.join(",");
		$.messager.confirm("系统提示", "您确认要删除这<font color=red>"
				+ selectedRows.length + "</font>个用户吗？", function(r) {
			if (r) {
				$.post("${pageContext.request.contextPath}/delUser.action", {
					delids : ids
				}, function(result) {
					if (result.msg) {
						$.messager.alert('系统提示', "您已成功删除<font color=red>"
								+ result.delNums + "</font>个用户！");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert('系统提示', result.errorMsg);
					}
				}, "json");
			}
		});
	}
</script>
</head>

<body style="margin: 1px">

    <table id="dg" title="用户管理" class="easyui-datagrid" fitColumns="true"
        pagination="true" rownumbers="true"
        url="usercuslist.action" fit="true"
        toolbar="#tb">
        <thead>
            <tr>
                <th field="cb" checkbox="true" align="center"></th>
                <!--<th field="id" width="50" align="center">编号</th>-->
                <th field="uname" width="50" align="center">用户名</th>
                <th field="upsw" width="50" align="center">密码</th>
                <th field="truename" width="50" align="center">真实姓名</th>
            </tr>
        </thead>
    </table>
    <div id="tb">
        <a href="javascript:openUserAddDialog()" class="easyui-linkbutton"
            iconCls="icon-add" plain="true">添加</a> <a
            href="javascript:openUserModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改</a> <a
            href="javascript:deleteUser()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除</a>
        <div>
            &nbsp;用户名：&nbsp;<input type="text" id="uname" size="20"
                onkeydown="if(event.keyCode == 13)searchUser()" /> <a
                href="javascript:searchUser()" class="easyui-linkbutton"
                iconCls="icon-search" plain="true">查询</a>
        </div>

        <div id="dlg-buttons">
            <a href="javascript:saveUser()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> 
            <a href="javascript:closeUserDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>

        <div id="dlg" class="easyui-dialog"
            style="width: 580px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    <tr>
                        <td>用户名：</td>
                        <td><input type="text" id="uname" name="uname"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>密码：</td>
                        <td><input type="password" id="upsw" name="upsw"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>真实姓名：</td>
                        <td><input type="text" id="truename" name="truename"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        
</body>
</html>