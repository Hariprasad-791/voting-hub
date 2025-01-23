package com.login;
import java.io.IOException;


import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/loginr")
public class loginr extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        response.setContentType("text/html");
        String adharNumber = request.getParameter("adharNumber");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            log("Error loading JDBC driver", e);
            pw.println("<h3>Error during login</h3>");
            return;
        }

        try (Connection con = DriverManager.getConnection("jdbc:mysql:///votinghub", "root", "")) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM voter WHERE adharNumber = ?");
            ps.setString(1, adharNumber);
            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                // User found, check password
                String storedPassword = resultSet.getString("password");
                if (password.equals(storedPassword)) {
                    // Passwords match
                    	response.sendRedirect("home.jsp?adharNumber=" + adharNumber);

                } else {
                    // Incorrect password
                	response.sendRedirect("index.jsp?message=Incorrect password."); 
                }
            } else {
                // User not found, ask to register
            	response.sendRedirect("index.jsp?message=User not found. Please register.");
            }

        } catch (SQLException sc) {
            log("SQL Error during login", sc);
            pw.println("<h3>Error during login</h3>");
        } catch (Exception e) {
            log("General Error during login", e);
            pw.println("<h3>Error during login</h3>");
        } finally {
            pw.close();
        }
    }
}
