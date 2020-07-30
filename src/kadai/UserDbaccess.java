package kadai;


//SQLに関連したクラスライブラリをインポート
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class UserDbaccess {
	protected int id;
	protected int  num;
	protected int data_num;

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

	public void  userRegister(String name, String password, String mail)throws Exception{
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "INSERT INTO users(user_name,user_password,user_mail)VALUES(?,?,?)";
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setString(1,name);
		stmt.setString(2, password);
		stmt.setString(3,mail);
		stmt.executeUpdate();
		stmt.close();
		conn.close();
	}
	public void userLogin(String mail,String password)throws Exception{

	}
}
