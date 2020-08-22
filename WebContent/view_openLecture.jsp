<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
List<String> login_info = (List<String>) session.getAttribute("login_info");
if (login_info == null){
	%>
<jsp:forward page="view_loginUser.jsp" />
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
				<li class='nav-item'><a class='nav-link'
					href='view_registerLecture.jsp'>時間割登録</a></li>
				<li class='nav-item'><a class='nav-link' href='view_allUser.jsp'>ユーザ検索</a></li>
				<li class='nav-item'><a class='nav-link' href='/'>お気に入り</a></li>
				<li class='nav-item'><a class='nav-link'
					href='process_logout.jsp'
					onclick="return confirm('ログアウトします。よろしいですか？')">ログアウト</a></li>
				<%if((Integer.parseInt(login_info.get(3))) == 1){
							%>
				<li class='nav-item'><a class='nav-link'
					href='view_openLecture.jsp'>管理者限定, 開講科目登録</a></li>
				<% }%>
				<% } else{%>
				<li class='nav-item'><a class='nav-link'
					href='view_loginUser.jsp'>ログイン</a></li>
				<li class='nav-item'><a class='nav-link'
					href='view_newUser.jsp'>ユーザ登録</a></li>
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
	<div class="row mt-5">
		<div class="offset-sm-3 col-sm-6">
			<form action="process_createLecture.jsp" method="post">
				講義名<input type="text" class="form-control mb-4" name="lecture_name"
					required> 単位数 <SELECT NAME="lecture_credit"
					class="form-control" required>
					<OPTION value="">選択してください</OPTION>
					<OPTION VALUE=1>1</OPTION>
					<OPTION VALUE=2>2</OPTION>
				</SELECT><br> 曜日 <SELECT NAME="lecture_day" class="form-control"
					required>
					<OPTION value="">選択してください</OPTION>
					<OPTION VALUE="月">月曜日</OPTION>
					<OPTION VALUE="火">火曜日</OPTION>
					<OPTION VALUE="水">水曜日</OPTION>
					<OPTION VALUE="木">木曜日</OPTION>
					<OPTION VALUE="金">金曜日</OPTION>
				</SELECT><br> 時限 <SELECT NAME="lecture_time" class="form-control"
					required>
					<OPTION value="">選択してください</OPTION>
					<OPTION VALUE=1>１時限目</OPTION>
					<OPTION VALUE=2>２時限目</OPTION>
					<OPTION VALUE=3>３時限目</OPTION>
					<OPTION VALUE=4>４時限目</OPTION>
					<OPTION VALUE=5>５時限目</OPTION>
				</SELECT><br> 開講年次 <SELECT NAME="lecture_target" class="form-control"
					required>
					<OPTION value="">選択してください</OPTION>
					<OPTION VALUE=1>１年生</OPTION>
					<OPTION VALUE=2>２年生</OPTION>
					<OPTION VALUE=3>３年生</OPTION>
					<OPTION VALUE=4>４年生</OPTION>
				</SELECT><br>
				<button type="submit" class="btn btn-primary">登録</button>
			</form>
		</div>
	</div>
</body>

</html>