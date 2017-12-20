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
    function searchStu() {
        $("#dg").datagrid('load', {
            "xname" : $("#xname").val()
        });
    }
    function openStuAddDialog() {
    	$("#dlg").dialog("open").dialog("setTitle", "添加学员信息");
		url = "${pageContext.request.contextPath}/addStu.action";
	}

	function openStuModifyDialog() {
		var selectedRows = $("#dg").datagrid('getSelections');
		if (selectedRows.length != 1) {
			$.messager.alert('系统提示', '请选择一条要编辑的数据！');
			return;
		}
		var row = selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "修改学员");
		$("#fm").form("load", row);
		url = "${pageContext.request.contextPath}/updateStu.action?xid="+row.xid;
		//alert(url);
	}
	//保存
	function saveStu(){
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
					closeStuDialog();
					$("#dg").datagrid("reload");
				}
			}
		});
	}

    //关闭按钮
    function closeStuDialog() {
        $("#dlg").dialog("close");
        $("#fm").form('clear');
    }
	
    //删除
   function deleteStu() {
		var selectedRows = $("#dg").datagrid('getSelections');
		if (selectedRows.length == 0) {
			$.messager.alert('系统提示', '请选择删除的学员！');
			return;
		}
		var strIds = [];
		for (var i = 0; i < selectedRows.length; i++) {
			strIds.push(selectedRows[i].xid);
		}
		//alert(strIds);
		var ids = strIds.join(",");
		$.messager.confirm("系统提示", "您确认要删除这<font color=red>"
				+ selectedRows.length + "</font>个学员吗？", function(r) {
			if (r) {
				$.post("${pageContext.request.contextPath}/delStu.action", {
					delids : ids
				}, function(result) {
					if (result.msg) {
						$.messager.alert('系统提示', "您已成功删除<font color=red>"
								+ result.delNums + "</font>个学员！");
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

    <table id="dg" title="学员管理" class="easyui-datagrid" fitColumns="true"
        pagination="true" rownumbers="true"
        url="studentcuslist.action" fit="true"
        toolbar="#tb">
        <thead>
            <tr>
                <th field="cb" checkbox="true" align="center"></th>
                <!--<th field="xid" width="50" align="center">编号</th>-->
                <th field="xname" width="50" align="center">学员名</th>
                <th field="xsex" width="50" align="center">性别</th>
                <th field="xage" width="50" align="center">年龄</th>
                <th field="xmoney" width="50" align="center">学费</th>
                <th field="xstatus" width="50" align="center">科目</th>
                <th field="fromadd" width="50" align="center">地址</th>
            </tr>
        </thead>
    </table>
    <div id="tb">
        <a href="javascript:openStuAddDialog()" class="easyui-linkbutton"
            iconCls="icon-add" plain="true">添加</a> <a
            href="javascript:openStuModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改</a> <a
            href="javascript:deleteStu()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除</a>
        <div>
            &nbsp;学员名：&nbsp;<input type="text" id="xname" size="20"
                onkeydown="if(event.keyCode == 13)searchStu()" /> <a
                href="javascript:searchStu()" class="easyui-linkbutton"
                iconCls="icon-search" plain="true">查询</a>
        </div>

        <div id="dlg-buttons">
            <a href="javascript:saveStu()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> 
            <a href="javascript:closeStuDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>

        <div id="dlg" class="easyui-dialog"
            style="width: 580px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    <tr>
                        <td>学员名：</td>
                        <td><input type="text" id="xname" name="xname"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>性别：</td>
                        <td><input type="text" id="xsex" name="xsex"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                     <tr>
                        <td>年龄：</td>
                        <td><input type="text" id="xage" name="xage"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>学费：</td>
                        <td><input type="text" id="xmoney" name="xmoney"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                     <tr>
                        <td>科目：</td>
                        <td><input type="text" id="xstatus" name="xstatus"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>地址：</td>
                        <td><input type="text" id="fromadd" name="fromadd"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
</body>
</html>