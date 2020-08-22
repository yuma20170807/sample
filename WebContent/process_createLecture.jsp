<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Arrays"%>
<jsp:useBean id="lecture" scope="session" class="kadai.LectureDbaccess" />

<%
boolean result ;
List<String> error = new ArrayList<String>();//エラーの内容を格納する配列
List<String> success = new ArrayList<String>();//成功したときのメッセージ格納配列
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("lecture_name");
int credit = Integer.parseInt(request.getParameter("lecture_credit"));
String day = request.getParameter("lecture_day");
int time = Integer.parseInt(request.getParameter("lecture_time"));
int target = Integer.parseInt(request.getParameter("lecture_target"));

try{
	result = lecture.lectureRegister(name, credit, day, time, target);
	if (result){
		success.add("登録完了");
		session.setAttribute("success", success);
		%>
<jsp:forward page="view_openLecture.jsp" />
<%
	}else{
		error.add("その講義名で既に登録されているようです");
		session.setAttribute("error", error);
		%>
<jsp:forward page="view_openLecture.jsp" />
<%
	}
}catch(Exception e){
	error.add("登録できませんでした");
	session.setAttribute("error", error);
%>
<jsp:forward page="view_newUser.jsp" />
<%

}
%>