package kadai;


//SQLに関連したクラスライブラリをインポート
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDbaccess {
	int num;
	ArrayList<Integer> user_id = new ArrayList<Integer>();
	ArrayList<String> user_name = new ArrayList<String>();
	ArrayList<String> user_mail = new ArrayList<String>();
	ArrayList<Integer> admin = new ArrayList<Integer>();
	ArrayList<Integer> favo_list = new ArrayList<Integer>();
	String pass;

	public void dataload()throws Exception{
		this.user_id = new ArrayList<Integer>();
		this.user_name = new ArrayList<String>();
		this.user_mail = new ArrayList<String>();
		this.admin = new ArrayList<Integer>();
		this.num=0;
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "select * from users";
		PreparedStatement stmt =conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			this.user_id.add(rs.getInt("user_id"));
			this.user_name.add(rs.getString("user_name"));
			this.pass = rs.getString("user_password");
			this.admin.add(rs.getInt("admin"));
			this.user_mail.add(rs.getString("user_mail"));
			this.num++;
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

	public void user_favorite(int user_favo_id, int user_favo_to) throws Exception{
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "insert into favorite_list(user_favo_id,user_favo_to)values(?,?) ";
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setInt(1,user_favo_id);
		stmt.setInt(2,user_favo_to);
		stmt.execute();
		stmt.close();
		conn.close();
	}

	public void user_non_favorite(int user_favo_id, int user_favo_to) throws Exception{
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "delete from favorite_list where user_favo_id = ? and user_favo_to = ? ";
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setInt(1,user_favo_id);
		stmt.setInt(2,user_favo_to);
		stmt.execute();
		stmt.close();
		conn.close();
	}

	public void take_favolist(int user_id)throws Exception {
		this.favo_list = new ArrayList<Integer>();
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "select user_favo_to from favorite_list where user_favo_id = ?";
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setInt(1, user_id);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			this.favo_list.add(rs.getInt("user_favo_to"));
		}
		rs.close();
		stmt.close();
		conn.close();


	}

	public List<String> userLogin(String mail,String password)throws Exception{//ユーザログイン用のメソッド
		int num;
		int user_id = -1;
		String user_name = null;
		String user_password = null;
		int admin = 0;
		String user_mail = null;
		List<String> result = new ArrayList<String>();
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
		if(user_id == -1){
		    rs.close();
			stmt.close();
			conn.close();
			return result;
		}
		if (user_password.equals(password)){
		    rs.close();
			stmt.close();
			conn.close();
			result.add(String.valueOf(user_id));
			result.add(user_name);
			result.add(user_password);
			result.add(String.valueOf(admin));
			result.add(user_mail);

			return result;
		}else {
		    rs.close();
			stmt.close();
			conn.close();
			return result;
		}

	}

	public int getNum() {
		return num;
	}

	public int getUser_id(int i) {
		return user_id.get(i);
	}

	public String getUser_name(int i) {
		return user_name.get(i);
	}

	public String getUser_mail(int i) {
		return user_mail.get(i);
	}

	public int getAdmin(int i) {
		return admin.get(i);
	}

	public ArrayList<Integer> getFavo_list() {
		return favo_list;
	}
}
