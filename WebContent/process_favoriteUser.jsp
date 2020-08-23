<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Arrays"%>
<jsp:useBean id="user" scope="session" class="kadai.UserDbaccess" />
<%
List<String> error = new ArrayList<String>();//エラーの内容を格納する配列
List<String> success = new ArrayList<String>();//成功したときのメッセージ格納配列
request.setCharacterEncoding("UTF-8");
List<String> login_info = (List<String>) session.getAttribute("login_info");
int user_favo_to = Integer.parseInt(request.getParameter("user_favo_to"));
int user_favo_id = Integer.parseInt(login_info.get(0));
String before_page = request.getParameter("page");


try{
	user.user_favorite(user_favo_id, user_favo_to);
	success.add("お気に入りに登録しました。");
	session.setAttribute("success",success);
	if (before_page.equals("all")){%>
		<jsp:forward page="view_allUser.jsp" />
	<%}
	if (before_page.equals("search")){
		%><jsp:forward page="view_searchUser.jsp" /><%
	}
}catch (Exception e){
	error.add("エラー");
	session.setAttribute("error", error);
	if (before_page.equals("all")){%>
	<jsp:forward page="view_allUser.jsp" />
<%}
if (before_page.equals("search")){
	%><jsp:forward page="view_searchUser.jsp" /><%
}
}

if(before_page.equals("favo")){
	%><jsp:forward page="view_showFavo.jsp" /><%
}
%>

