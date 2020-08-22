package kadai;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TakingLecture {

	ArrayList<String> id = new ArrayList<String>();
	ArrayList<String> name = new ArrayList<String>();
	ArrayList<String> day = new ArrayList<String>();
	ArrayList<String> time = new ArrayList<String>();
	ArrayList<String> credit = new ArrayList<String>();
	ArrayList<String> target = new ArrayList<String>();
	int num = 0;


	public void loadTaking(int user_id) throws Exception{
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
		String sql = "select lectures.lecture_id,lecture_name,lecture_credit,lecture_day,lecture_time,lecture_target from lectures inner join register_list on lectures.lecture_id=register_list.lecture_id where user_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, user_id);
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


	public int getLecture(String lecture_day, int lecture_time) {
		for (String name : this.name) {
			int ind = this.name.indexOf(name);
			if (this.day.get(ind).equals(lecture_day)) {
				if(Integer.parseInt(this.time.get(ind)) == lecture_time) {
					return ind;
				}
			}
		}
		return 9999999;
	}

	public void deleteTaking(int user_id, int lecture_id) throws Exception{
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url = "jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql = "delete from register_list where user_id = ? and lecture_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, user_id);
		stmt.setInt(2, lecture_id);
		stmt.execute();
		stmt.close();
		conn.close();
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
