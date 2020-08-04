package kadai;


import java.security.Key;
//SQLに関連したクラスライブラリをインポート
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.IvParameterSpec;


public class UserDbaccess {
	protected int num;
	protected int  user_id;
	protected String user_name;
	protected String user_password;
	protected int admin;
	protected String user_mail;

	public void dataload()throws Exception{
		num=0;
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/sample";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "select * from sample_table";
		PreparedStatement stmt =conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			System.out.println(rs.getInt("id"));
			System.out.println(rs.getInt("num"));
		}
		rs.close();
		stmt.close();
		conn.close();

	}

	public boolean  userRegister(String name, String password, String mail)throws Exception{//ユーザ登録用のメソッド
		num=0;
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql2 = "select * from users where user_mail = ?";
		PreparedStatement stmt2 =conn.prepareStatement(sql2);
		stmt2.setString(1,mail);
		ResultSet rs2 = stmt2.executeQuery();
		while(rs2.next()) {
			num+=1;
		}
		if (num==0) {
			String sql = "INSERT INTO users(user_name,user_password,user_mail)VALUES(?,?,?)";
			PreparedStatement stmt =conn.prepareStatement(sql);
			stmt.setString(1,name);
			stmt.setString(2, password);
			stmt.setString(3,mail);
			stmt.executeUpdate();
			stmt.close();
			rs2.close();
			stmt2.close();
			conn.close();
			return true;
		}else {
			stmt2.close();
			rs2.close();
			conn.close();
			return false;

		}


	}
	public void userLogin(String mail,String password)throws Exception{//ユーザログイン用のメソッド
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "select * from users where user_mail = ?";
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setString(1,mail);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			user_id = rs.getInt("user_id");
			user_name=rs.getString("user_name");
			user_password = rs.getString("user_password");
			admin = rs.getInt("admin");
			user_mail=rs.getString("user_mail");
		}
		byte[] encrypted=user_password.getBytes();
		System.out.println(encrypted);
		KeyGenerator kg = KeyGenerator.getInstance("DES");
		Key key = kg.generateKey();
		Cipher c = Cipher.getInstance("DES/CBC/PKCS5Padding");
		byte[] iv = c.getIV();
		IvParameterSpec dps = new IvParameterSpec(iv);
		c.init(Cipher.DECRYPT_MODE, key, dps);
		byte[] output = c.doFinal(encrypted);
		System.out.println(new String(output));

	    rs.close();
		stmt.close();
		conn.close();


	}
}
