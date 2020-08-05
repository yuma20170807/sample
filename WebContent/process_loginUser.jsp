<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import= "java.util.*" %>
<%@page import= "java.io.*" %>
<%@page import="java.util.Arrays" %>
<jsp:useBean id="user" scope="session" class="kadai.UserDbaccess"/>

<%
List<String> result = new ArrayList<String>();
List<String> error = new ArrayList<String>();//エラーの内容を格納する配列
List<String> success = new ArrayList<String>();//成功したときのメッセージ格納配列
request.setCharacterEncoding("UTF-8");
//パラメータを取ってくる
String mail  = request.getParameter("user_mail");
String password = request.getParameter("user_password");
//メールアドレスのテンプレート
String mailFormat = "^[a-zA-Z0-9!#$%&'_`/=~\\*\\+\\-\\?\\^\\{\\|\\}]+(\\.[a-zA-Z0-9!#$%&'_`/=~\\*\\+\\-\\?\\^\\{\\|\\}]+)*+(.*)@[a-zA-Z0-9][a-zA-Z0-9\\-]*(\\.[a-zA-Z0-9\\-]+)+$";
if (!mail.matches(mailFormat)) {//メールアドレスの形式の精査
    error.add("メールアドレスの形式が間違っています");
}

if (!error.isEmpty()){
	session.setAttribute("error", error);
	%>
	<jsp:forward page="view_loginUser.jsp" />
	<%
}
%>
<%
try{
	result = user.userLogin(mail,password);
	if (result.size() != 0){
		success.add("ログインに成功しました");
		session.setAttribute("login_info",result);
		session.setAttribute("success",success);
		%>
		<jsp:forward page="view_home.jsp" />
		<%
	}else{
		error.add("メールアドレスもしくはパスワードが間違っています。");
		session.setAttribute("error", error);
		%>
		<jsp:forward page="view_loginUser.jsp" />
		<%
	}
} catch(Exception e){
	error.add("エラー");
	session.setAttribute("error", error);
%>
<jsp:forward page="view_loginUser.jsp" />
<%
}
%>

