package kadai;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LectureDbaccess {
	public boolean lectureRegister(String lecture_name,int lecture_credit,String lecture_day,int lecture_time,int lecture_target) throws Exception{
		int num = 0;
		boolean result = false;
		Class.forName("com.mysql.jdbc.Driver").newInstance(); //com.mysql.jdbc.Drive
		String url="jdbc:mysql://localhost/share_class";
		Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		String sql2 = "select * from lectures where lecture_name = ?";
		PreparedStatement stmt2 =conn.prepareStatement(sql2);
		stmt2.setString(1,lecture_name);
		ResultSet rs2 = stmt2.executeQuery();
		while(rs2.next()) {
			num+=1;
		}

		if (num==0){
			String sql = "insert into lectures (lecture_name,lecture_credit,lecture_day,lecture_time,lecture_target)values(?,?,?,?,?)";
			PreparedStatement stmt =conn.prepareStatement(sql);
			stmt.setString(1,lecture_name);
			stmt.setInt(2,lecture_credit);
			stmt.setString(3,lecture_day);
			stmt.setInt(4,lecture_time);
			stmt.setInt(5,lecture_target);
			stmt.execute();
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

}
