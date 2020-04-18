package com.xtgj.j2ee.chapter03.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xtgj.j2ee.chapter03.car.beans.DBOperator;

public class AutoComplete extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 获取需要匹配的字符串前缀
		String prefix = request.getParameter("model");
		// 查询匹配的车型列表
		DBOperator db = new DBOperator();
		List models = null;
		try {
			models = db.findMakes(prefix);
		} catch (Exception e) {
			throw new ServletException("数据库错误");
		}
		// 设置响应格式和字符集
		response.setContentType("text/xml;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		// 以XML格式输出相应数据
		out.println("<response>");
		for (int i = 0; i < models.size(); i++) {
			String model = (String) models.get(i);
			out.println("<model>" + model + "</model>");
		}
		out.println("</response>");
		out.close();
	}
}
