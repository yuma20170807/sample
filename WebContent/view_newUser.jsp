<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>ユーザ登録</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script type="text/javascript" src="js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</head>
<header class="sticky-top">
	<nav class='navbar navbar-expand-lg navbar-dark bg-primary'>
		<a class='navbar-brand' href='home.jsp'>時間割共有システム</a>
		<button class='navbar-toggler' type='button' data-toggle='collapse'
			data-target='#navbarSupportedContent'>
			<span class='navbar-toggler-icon'></span>
		</button>
		<div class='collapse navbar-collapse justify-content-end'
			id='navbarSupportedContent'>
			<ul class='navbar-nav'>
				<li class='nav-item'><a class='nav-link' href='/'>時間割登録</a></li>
				<li class='nav-item'><a class='nav-link' href='/'>ユーザ検索</a></li>
				<li class='nav-item'><a class='nav-link' href='/'>お気に入り</a></li>
				<li class='nav-item'><a class='nav-link' href='/'>ログアウト</a></li>
				<li class='nav-item'><a class='nav-link' href='loginUser.jsp'>ログイン</a></li>
				<li class='nav-item'><a class='nav-link' href='newUser.jsp'>ユーザ登録</a></li>
			</ul>
		</div>
	</nav>
</header>
<body>
<%if (session.getAttribute("error")!=null){%>
	<div id="error_explanation" class="alert alert-warning mt-3">
		<ul class="mb-0">
<%
	List<String> errors = (List<String>)session.getAttribute("error");
	session.removeAttribute("error");
	if (!errors.isEmpty()){
		for(String error: errors){
%>
	<li><%= error%></li>
		<%}%>
		</ul>
	<%}%>
</div>
<%} %>

<%if (session.getAttribute("success")!=null){%>
	<div id="error_explanation" class="alert alert-success mt-3">
		<ul class="mb-0">
<%
	List<String> successes = (List<String>)session.getAttribute("success");
	session.removeAttribute("success");
	if (!successes.isEmpty()){
		for(String success: successes){
%>
	<li><%= success%></li>
		<%}%>
		</ul>
	<%}%>
</div>
<%} %>


	<div class='row mt-5'>
		<div class='offset-sm-3 col-sm-6'>
			<form action='process_createUser.jsp' method='post'>
				<div class='form-group'>
					メールアドレス <input type='text' class='form-control' name='user_mail' required>
					名前 <input type='text' class='form-control' name='user_name' required>
					パスワード <input type='password' class='form-control'name='user_password' required>
					パスワードの再入力 <input type='password'class='form-control mb-4' name='user_password_certification' required>
					<button type='submit' class='btn btn-primary'>登録</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>