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
    function searchCoach() {
        $("#dg").datagrid('load', {
            "cname" : $("#cname").val()
        });
    }
    function openCoachAddDialog() {
        $("#dlg").dialog("open").dialog("setTitle", "添加教练信息");
        url = "${pageContext.request.contextPath}/addCoach.action";
    }

    function openCoachModifyDialog() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length != 1) {
            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
            return;
        }
        var row = selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "修改学员");
		$("#fm").form("load", row);
		url = "${pageContext.request.contextPath}/updateCoach.action?cid="+row.cid;
		//alert(url);
	}
    //保存
	function saveCoach(){
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
					closeCoachDialog();
					$("#dg").datagrid("reload");
				}
			}
		});
	}

    //关闭按钮
    function closeCoachDialog() {
        $("#dlg").dialog("close");
        $("#fm").form('clear');
    }
	
    //删除
    function deleteCoach() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的数据！");
            return;
        }
        var strIds = [];
        for ( var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].cid);
        }
        //alert(strIds);
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>条数据吗？", function(r) {
            if (r) {
                $.post("${pageContext.request.contextPath}/delCoach.action", {
                	delids : ids
                }, function(result) {
                	if (result.msg) {
						$.messager.alert('系统提示', "您已成功删除<font color=red>"
								+ result.delNums + "</font>个数据！");
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

    <table id="dg" title="教练管理" class="easyui-datagrid" fitColumns="true"
        pagination="true" rownumbers="true"
        url="coachcuslist.action" fit="true"
        toolbar="#tb">
        <thead>
            <tr>
                <th field="cb" checkbox="true" align="center"></th>
                <!--<th field="cid" width="50" align="center">编号</th>-->
                <th field="cname" width="50" align="center">教练名</th>
                <th field="csex" width="50" align="center">性别</th>
                <th field="cage" width="50" align="center">年龄</th>
            </tr>
        </thead>
    </table>
    <div id="tb">
        <a href="javascript:openCoachAddDialog()" class="easyui-linkbutton"
            iconCls="icon-add" plain="true">添加</a> <a
            href="javascript:openCoachModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改</a> <a
            href="javascript:deleteCoach()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除</a>
        <div>
            &nbsp;教练名：&nbsp;<input type="text" id="cname" size="20"
                onkeydown="if(event.keyCode == 13)searchCoach()" /> <a
                href="javascript:searchCoach()" class="easyui-linkbutton"
                iconCls="icon-search" plain="true">查询</a>
        </div>

        <div id="dlg-buttons">
            <a href="javascript:saveCoach()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> 
            <a href="javascript:closeCoachDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>

        <div id="dlg" class="easyui-dialog"
            style="width: 580px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    <tr>
                        <td>教练名：</td>
                        <td><input type="text" id="cname" name="cname"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>性别：</td>
                        <td><input type="text" id="csex" name="csex"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                     <tr>
                        <td>年龄：</td>
                        <td><input type="text" id="cage" name="cage"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
</body>
</html>