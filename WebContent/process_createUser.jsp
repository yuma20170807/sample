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
byte[] encrypted = null;
String password_locked=null;
boolean result ;
List<String> error = new ArrayList<String>();//エラーの内容を格納する配列
List<String> success = new ArrayList<String>();//成功したときのメッセージ格納配列
request.setCharacterEncoding("UTF-8");
//パラメータを取ってくる
String mail  = request.getParameter("user_mail");
String password = request.getParameter("user_password");
String password_certification = request.getParameter("user_password_certification");
String name = request.getParameter("user_name");
if (!password.equals(password_certification)) {//パスワードを二回入力させて、どちらかが違う場合
	error.add("パスワードの認証ができませんでした");
}
//メールアドレスのテンプレート
String mailFormat = "^[a-zA-Z0-9!#$%&'_`/=~\\*\\+\\-\\?\\^\\{\\|\\}]+(\\.[a-zA-Z0-9!#$%&'_`/=~\\*\\+\\-\\?\\^\\{\\|\\}]+)*+(.*)@[a-zA-Z0-9][a-zA-Z0-9\\-]*(\\.[a-zA-Z0-9\\-]+)+$";
if (!mail.matches(mailFormat)) {//メールアドレスの形式の精査
    error.add("メールアドレスの形式が間違っています");
}
//ここからパスワードの暗号化
try{
	KeyGenerator kg = KeyGenerator.getInstance("DES");
	Key key = kg.generateKey();
	Cipher c = Cipher.getInstance("DES/CBC/PKCS5Padding");
	c.init(Cipher.ENCRYPT_MODE,key);
	byte[] input = password.getBytes();
	encrypted = c.doFinal(input);//byte
	password_locked=Arrays.toString(encrypted);//String
} catch(Exception e){
	e.printStackTrace();
}
if (!error.isEmpty()){
	session.setAttribute("error", error);
	%>
	<jsp:forward page="view_newUser.jsp" />
	<%
}
%>
<%
try{
	result = user.userRegister(name,password_locked,mail);
	if (result){
		success.add("正常に登録しました");
		session.setAttribute("success", success);
	}else{
		error.add("そのメールアドレスは既に登録されているようです");
		session.setAttribute("error", error);
	}

%>
<jsp:forward page="view_newUser.jsp" />
<%
} catch(Exception e){
	error.add("登録できませんでした");
	session.setAttribute("error", error);
%>
<jsp:forward page="view_newUser.jsp" />
<%
}
%>

