package sfs2x.extension.test.dblogin;



	import java.sql.ResultSet;
	import java.sql.SQLException;

	/*
	 * 使用java直接访问数据库
	 * */
	public class DBTest {

		static String sql = null;
		static DBHelper db1 = null;
		static ResultSet ret = null;

		public DBTest() {
			sql = "select *from muppets";//SQL语句
			db1 = new DBHelper(sql);//创建DBHelper对象

			try {
				ret = db1.pst.executeQuery();//执行语句，得到结果集
				while (ret.next()) {
					String uid = ret.getString(1);
					String ufname = ret.getString(2);
					String pword = ret.getString(3);
					String email = ret.getString(4);
					System.out.println(uid + "\t" + ufname + "\t" + pword + "\t" + email );
				}//显示数据
				ret.close();
				db1.close();//关闭连接
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
