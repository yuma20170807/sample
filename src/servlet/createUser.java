package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SampleServlet
 */
@WebServlet("/createUser")
public class createUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public createUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e1) {
			// TODO 自動生成された catch ブロック
			e1.printStackTrace();
		} //com.mysql.jdbc.Driverはドライバのクラス名
		String url = "jdbc:mysql://localhost/sample"; //schoolがデータベース名：文字エンコードはUTF-8
		try {
			Connection conn = DriverManager.getConnection(url, "root", "yuma0101");
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		} //上記URL設定でユーザ名とパスワードを使って接続

		request.setCharacterEncoding("UTF-8");
		List<String> lists = new ArrayList<String>();
		String user_mail = request.getParameter("user_mail");
		String user_name = request.getParameter("user_name");

		String user_password = request.getParameter("user_password");
		String user_password_certification = request.getParameter("user_password_certification");

		lists.add(user_mail);
		lists.add(user_name);
		lists.add(user_password);
		lists.add(user_password_certification);
		System.out.println(user_mail);

		// 遷移先で、listsを使えるように
		request.setAttribute("lists", lists);

		// sample.jspへ
		getServletConfig().getServletContext()
				.getRequestDispatcher("/newUser.jsp")
				.forward(request, response);

	}
}