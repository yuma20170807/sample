<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="lecture" scope="session" class="kadai.LectureDbaccess" />
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
boolean result;
List<String> error = new ArrayList<String>();//エラーの内容を格納する配列
List<String> success = new ArrayList<String>();//成功したときのメッセージ格納配列
request.setCharacterEncoding("UTF-8");
int lecture_id = Integer.parseInt(request.getParameter("lec_id"));
List<String> login_info = (List<String>) session.getAttribute("login_info");
int user_id = Integer.parseInt(login_info.get(0));
try{
	lecture.takeLecture(user_id,lecture_id);
	success.add("登録完了");
	session.setAttribute("success", success);
	%><jsp:forward page="view_registerLecture.jsp" /><%
}catch(Exception e){
	error.add("エラー");
	session.setAttribute("error", error);
	%>
	<jsp:forward page="view_registerLecture.jsp" />
<%}%>