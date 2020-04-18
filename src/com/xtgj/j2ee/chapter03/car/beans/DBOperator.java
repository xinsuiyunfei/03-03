package com.xtgj.j2ee.chapter03.car.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.xtgj.j2ee.chapter02.db.DBUtil;

public class DBOperator {
	// 查找所有品牌列表
	public List findMakes(String modelPrefix) throws Exception {
		List list = new ArrayList();
		Connection cn = getConnection();
		Statement st = cn.createStatement();
		String sql = "select model from car where model like '" + modelPrefix
				+ "%' group by model";
		ResultSet rs = st.executeQuery(sql);

		while (rs.next()) {
			list.add(rs.getString(1));
		}
		rs.close();
		st.close();
		cn.close();
		return list;
	}

	
	// 获取数据库连接
	private Connection getConnection() throws Exception {
		return DBUtil.getConn();
	}
}

