<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="taking" scope="session" class="kadai.TakingLecture" />
<%
	List<String> login_info = (List<String>) session.getAttribute("login_info");
if (login_info == null){
	%>
<jsp:forward page="view_loginUser.jsp" />
<%}else{
	taking.loadTaking(Integer.parseInt(login_info.get(0)));
}%>

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
				<%
					if (login_info != null) {
				%>
				<li class='nav-item'><a class='nav-link'
					href='view_registerLecture.jsp'>時間割登録</a></li>
				<li class='nav-item'><a class='nav-link' href='view_allUser.jsp'>ユーザ検索</a></li>
				<li class='nav-item'><a class='nav-link' href='/'>お気に入り</a></li>
				<li class='nav-item'><a class='nav-link'
					href='process_logout.jsp'
					onclick="return confirm('ログアウトします。よろしいですか？')">ログアウト</a></li>
				<%
					if ((Integer.parseInt(login_info.get(3))) == 1) {
				%>
				<li class='nav-item'><a class='nav-link'
					href='view_openLecture.jsp'>管理者限定, 開講科目登録</a></li>
				<%
					}
				%>
				<%
					} else {
				%>
				<li class='nav-item'><a class='nav-link'
					href='view_loginUser.jsp'>ログイン</a></li>
				<li class='nav-item'><a class='nav-link'
					href='view_newUser.jsp'>ユーザ登録</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</nav>
</header>
<body>
	<%
		List<String> errors = (List<String>) session.getAttribute("error");
	if (errors != null) {
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
	if (successes != null) {
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
	<table class="table table-bordered table-xl mt-5">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">月曜日</th>
				<th scope="col">火曜日</th>
				<th scope="col">水曜日</th>
				<th scope="col">木曜日</th>
				<th scope="col">金曜日</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th scope="row">1</th>
				<td>

							<% int ind = taking.getLecture("月",1);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="月">
								<input type="hidden" name="time" value="1">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%} %>
						</div>
					</form>
				</td>
				<td>
							<%  ind = taking.getLecture("火",1);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="火"> <input
									type="hidden" name="time" value="1">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

							<%  ind = taking.getLecture("水",1);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class = 'form-group'>
							<p>
								<input type="hidden" name="day" value="水"> <input
									type="hidden" name="time" value="1">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("木",1);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="木"> <input
									type="hidden" name="time" value="1">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%   ind = taking.getLecture("金",1);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="金"> <input
									type="hidden" name="time" value="1">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
			</tr>
			<tr>
				<th scope="row">2</th>
				<td>

						<%  ind = taking.getLecture("月",2);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="月"> <input
									type="hidden" name="time" value="2">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("火",2);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="火"> <input
									type="hidden" name="time" value="2">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("水",2);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="水"> <input
									type="hidden" name="time" value="2">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("木",2);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="木"> <input
									type="hidden" name="time" value="2">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("金",2);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="金"> <input
									type="hidden" name="time" value="2">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
			</tr>
			<tr>
				<th scope="row">3</th>
				<td>

						<%  ind = taking.getLecture("月",3);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="月"> <input
									type="hidden" name="time" value="3">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("火",3);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="火"> <input
									type="hidden" name="time" value="3">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("水",3);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="水"> <input
									type="hidden" name="time" value="3">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("木",3);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="木"> <input
									type="hidden" name="time" value="3">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("金",3);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="金"> <input
									type="hidden" name="time" value="3">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
			</tr>
			<tr>
				<th scope="row">4</th>
				<td>

						<%  ind = taking.getLecture("月",4);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="月"> <input
									type="hidden" name="time" value="4">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("火",4);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="火"> <input
									type="hidden" name="time" value="4">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("水",4);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="水"> <input
									type="hidden" name="time" value="4">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("木",4);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="木"> <input
									type="hidden" name="time" value="4">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("金",4);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="金"> <input
									type="hidden" name="time" value="4">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
			</tr>
			<tr>
				<th scope="row">5</th>
				<td>

						<%  ind = taking.getLecture("月",5);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="月"> <input
									type="hidden" name="time" value="5">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("火",5);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="火"> <input
									type="hidden" name="time" value="5">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("水",5);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="水"> <input
									type="hidden" name="time" value="5">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("木",5);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="木"> <input
									type="hidden" name="time" value="5">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
				<td>

						<%  ind = taking.getLecture("金",5);
								if (ind != 9999999){%>
								<form action="process_deleteTaking.jsp" method="post">
						<div class='form-group'>
									<p><%= taking.getName(ind)%></p>
									<p>
										<input type="hidden" name="user_id" value="<%=login_info.get(0)%>">
										<input type="hidden" name="lecture_id" value="<%=taking.getId(ind)%>">
										<button type='submit' class='btn btn-danger'>削除</button>
									</p>
									</div>
									</form>
							<%}else{%>
							<form action="view_selectLecture.jsp" method="post">
							<div class='form-group'>
							<p>
								<input type="hidden" name="day" value="金"> <input
									type="hidden" name="time" value="5">
								<button type='submit' class='btn btn-primary'>登録</button>
							</p>
							<%}%>
						</div>
					</form>
				</td>
			</tr>
		</tbody>
	</table>
</body>
</html>