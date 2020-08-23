<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
List<String> login_info = (List<String>) session.getAttribute("login_info");
if (login_info != null) {
	%>
<jsp:forward page="view_home.jsp" />
<%}%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>時間割管理システム</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script type="text/javascript" src="js/jquery-3.5.1.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</head>
<header class="stickey-top">
	<nav class='navbar navbar-expand-lg navbar-dark bg-primary'>
		<a class='navbar-brand' href='view_home.jsp'>時間割共有システム</a>
		<button class='navbar-toggler' type='button' data-toggle='collapse'
			data-target='#navbarSupportedContent'>
			<span class='navbar-toggler-icon'></span>
		</button>
		<div class='collapse navbar-collapse justify-content-end'
			id='navbarSupportedContent'>
			<ul class='navbar-nav'>
				<%if (login_info != null){%>
				<li class='nav-item'><a class='nav-link' href='view_registerLecture.jsp'>時間割登録</a></li>
				<li class='nav-item'><a class='nav-link' href='view_allUser.jsp'>ユーザ検索</a></li>
				<li class='nav-item'><a class='nav-link' href='view_showFavo.jsp'>お気に入り</a></li>
				<li class='nav-item'><a class='nav-link' href='process_logout.jsp' onclick="return confirm('ログアウトします。よろしいですか？')">ログアウト</a></li>
				<%if((Integer.parseInt(login_info.get(3))) == 1){
							%>
				<li class='nav-item'><a class='nav-link' href='view_openLecture.jsp'>管理者限定, 開講科目登録</a></li>
				<% }%>
				<% } else{%>
				<li class='nav-item'><a class='nav-link' href='view_loginUser.jsp'>ログイン</a></li>
				<li class='nav-item'><a class='nav-link' href='view_newUser.jsp'>ユーザ登録</a></li>
				<%} %>
			</ul>
		</div>
	</nav>
</header>
<body>
	<%
		List<String> errors = (List<String>) session.getAttribute("error");
		if (errors!=null) {
			%>
	<div id="error_explanation" class="alert alert-warning mt-3">
		<ul class="mb-0">
			<%
					session.removeAttribute("error");
					if (!errors.isEmpty()) {
						for (String error : errors) {
							%>
			<li><%=error%></li>
			<%}%>
			<%}%>
		</ul>
	</div>
	<%
		}
		List<String> successes = (List<String>) session.getAttribute("success");
		if (successes != null ) {
			%>
	<div id="error_explanation" class="alert alert-success mt-3">
		<ul class="mb-0">
			<%
					session.removeAttribute("success");
					if (!successes.isEmpty()) {
						for (String success : successes) {
							%>
			<li><%=success%></li>
			<%}%>
			<%}%>
		</ul>
	</div>
	<%}%>
	<div class='row mt-5'>
		<div class='offset-sm-3 col-sm-6'>
			<form action='process_loginUser.jsp' method='post'>
				<div class='form-group'>
					メールアドレス <input type='text' class='form-control' name='user_mail'
						required> パスワード <input type='password'
						class='form-control mb-4' name='user_password' required>
					<button type='submit' class='btn btn-primary'>ログイン</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>