package kadai;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
public class LectureDbaccess {

	ArrayList<String> id = new ArrayList<String>();
	ArrayList<String> name = new ArrayList<String>();
	ArrayList<String> day = new ArrayList<String>();
	ArrayList<String> time = new ArrayList<String>();
	ArrayList<String> credit = new ArrayList<String>();
	ArrayList<String> target = new ArrayList<String>();
	int num = 0;

	public void dataload(String time, String day) throws Exception {
		this.id = new ArrayList<String>();
		this.name = new ArrayList<String>();
		this.day = new ArrayList<String>();
		this.time = new ArrayList<String>();
		this.credit = new ArrayList<String>();
		this.target = new ArrayList<String>();
		this.num = 0;
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url = "jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "select * from lectures where lecture_time = ? and lecture_day = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, Integer.parseInt(time));
		stmt.setString(2, day);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			this.id.add(rs.getString("lecture_id"));
			this.name.add(rs.getString("lecture_name"));
			this.credit.add(rs.getString("lecture_credit"));
			this.day.add(rs.getString("lecture_day"));
			this.time.add(rs.getString("lecture_time"));
			this.target.add(rs.getString("lecture_target"));
			num++;
		}
		rs.close();
		stmt.close();
		conn.close();
	}
	public boolean takeLecture(int user_id, int lecture_id) throws Exception{
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url = "jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "insert into register_list(user_id,lecture_id) values (?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,user_id);
		stmt.setInt(2,lecture_id);
		stmt.execute();
		stmt.close();
		conn.close();
		return true;

	}

	public boolean lectureRegister(String lecture_name, int lecture_credit, String lecture_day, int lecture_time,
			int lecture_target) throws Exception {
		int num = 0;
		boolean result = false;
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url = "jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql2 = "select * from lectures where lecture_name = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, lecture_name);
		ResultSet rs2 = stmt2.executeQuery();
		while (rs2.next()) {
			num += 1;
		}

		if (num == 0) {
			String sql = "insert into lectures (lecture_name,lecture_credit,lecture_day,lecture_time,lecture_target)values(?,?,?,?,?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, lecture_name);
			stmt.setInt(2, lecture_credit);
			stmt.setString(3, lecture_day);
			stmt.setInt(4, lecture_time);
			stmt.setInt(5, lecture_target);
			stmt.execute();
			stmt.close();
			rs2.close();
			stmt2.close();
			conn.close();
			return true;
		} else {
			rs2.close();
			stmt2.close();
			conn.close();
			return false;
		}
	}

	public String getId(int i) {
		return id.get(i);
	}

	public String getName(int i) {
		return name.get(i);
	}

	public String getDay(int i) {
		return day.get(i);
	}

	public String getTime(int i) {
		return time.get(i);
	}

	public String getCredit(int i) {
		return credit.get(i);
	}

	public String getTarget(int i) {
		return target.get(i);
	}

	public int getNum() {
		return num;
	}

}
