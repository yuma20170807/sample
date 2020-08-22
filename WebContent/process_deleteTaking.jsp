<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Arrays"%>
<jsp:useBean id="taking" scope="session" class="kadai.TakingLecture" />
<%
List<String> error = new ArrayList<String>();//エラーの内容を格納する配列
List<String> success = new ArrayList<String>();//成功したときのメッセージ格納配列
request.setCharacterEncoding("UTF-8");
int user_id = Integer.parseInt(request.getParameter("user_id"));
int lecture_id = Integer.parseInt(request.getParameter("lecture_id"));
try{
	taking.deleteTaking(user_id, lecture_id);
	success.add("登録完了");
	session.setAttribute("success", success);
	%><jsp:forward page="view_registerLecture.jsp" /><%
}catch (Exception e){
	error.add("エラー");
	session.setAttribute("error", error);
	%>
	<jsp:forward page="view_registerLecture.jsp" />
<%
}
%>