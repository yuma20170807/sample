<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
session.removeAttribute("login_info");
%>
<jsp:forward page="view_loginUser.jsp" />