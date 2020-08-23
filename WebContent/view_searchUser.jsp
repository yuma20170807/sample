<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="user" scope="session" class="kadai.UserDbaccess" />
<%
List<String> login_info = (List<String>) session.getAttribute("login_info");

if (login_info == null){
	%>
<jsp:forward page="view_loginUser.jsp" />
<%}else{
	user.take_favolist(Integer.parseInt(login_info.get(0)));

}
%>
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
	<%request.setCharacterEncoding("UTF-8");
	String query = request.getParameter("query"); %>
	<h3 class='text-center mt-3'>検索結果</h3>
	<table class="table table-bordered table-xl mt-3">

		<thead class="thread-light">
			<tr>
				<th scope="col">名前</th>
			</tr>
		</thead>
		<tbody>
			<%
				int num = 0;
				for (int i = 0 ; i < user.getNum() ; i++){
					if (user.getAdmin(i) != 1){
						if (user.getUser_id(i) != Integer.parseInt(login_info.get(0))){
							if(user.getUser_name(i).indexOf(query) != -1){
							num++;%>
			<td>
				<div class="row">
					<div class="col-8">
						<form action='view_friendTaking.jsp' method='post'>
							<input type='hidden' name="user_id"
								value='<%=user.getUser_id(i)%>'>
							<div class="row">
								<h3 class="offset-3"><%=user.getUser_name(i)%></h3>
								<button type='submit' class='btn btn-info offset-2'>時間割閲覧</button>
							</div>
						</form>
					</div>
					<%
					if (user.getFavo_list().contains(user.getUser_id(i))){%>
					<form action="process_non_favoriteUser.jsp" method="post">
						<input type="hidden" name="user_favo_to"
							value="<%=user.getUser_id(i) %>"> <input type="hidden"
							name="page" value="all">
						<button type='submit' class='btn btn-danger'>解除</button>
					</form>
					<%}else{
					%>
					<form action="process_favoriteUser.jsp" method="post">
						<input type="hidden" name="user_favo_to"
							value="<%=user.getUser_id(i) %>"> <input type="hidden"
							name="page" value="all">
						<button type='submit' class='btn btn-info'>お気に入り</button>
					</form>
					<%} %>
				</div>
			</td>
			<%
								}
							}
						}
					}
%>
		</tbody>
	</table>
	<%if (num == 0){%>
	<p class="text-center">合致する友達はいないようです・・・</p>
	<%}%>
</body>
</html>