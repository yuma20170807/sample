<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import= "java.util.*" %>
<%@page import= "java.io.*" %>
<%@page import="java.security.*" %>
<%@page import="javax.crypto.*" %>
<%@page import="java.util.Arrays" %>
<%@page import="javax.crypto.spec.IvParameterSpec" %>
<jsp:useBean id="user" scope="session" class="kadai.UserDbaccess"/>

<%
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
	user.userLogin(mail,password);
	success.add("ログインに成功しました");
	session.setAttribute("success", success);
%>
<jsp:forward page="view_home.jsp" />
<%
} catch(Exception e){
	error.add("ログインに失敗しました");
	session.setAttribute("error", error);
%>
<jsp:forward page="view_loginUser.jsp" />
<%
}
%>

