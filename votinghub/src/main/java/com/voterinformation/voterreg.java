package com.voterinformation;

import java.io.*;
import java.time.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/voterreg")
public class voterreg extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        response.setContentType("text/html");

        String name = request.getParameter("name");
        String adharNumber = request.getParameter("adharNumber");
        String dob = request.getParameter("dob");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String regionName = request.getParameter("region"); // Retrieve region name from form

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }

        try (Connection con = DriverManager.getConnection("jdbc:mysql:///votinghub", "root", "")) {
            // Check if Aadhar number already exists
            PreparedStatement checkStatement = con.prepareStatement("SELECT * FROM Voter WHERE adharNumber = ?");
            checkStatement.setString(1, adharNumber);
            ResultSet resultSet = checkStatement.executeQuery();

            if (resultSet.next()) {
                // Aadhar number already exists, redirect to login page
                response.sendRedirect("index.jsp?adharRegistered=true");
            } else {
                LocalDate birthDate = LocalDate.parse(dob);
                LocalDate currentDate = LocalDate.now();

                // Calculate age
                int age = Period.between(birthDate, currentDate).getYears();

                // Retrieve RegionID based on RegionName
                PreparedStatement regionStatement = con.prepareStatement("SELECT RegionID FROM Region WHERE RegionName = ?");
            
               
                regionStatement.setString(1, regionName);
                ResultSet regionResultSet = regionStatement.executeQuery();

                int regionID = 0;
                if (regionResultSet.next()) {
                    regionID = regionResultSet.getInt("RegionID");
                } else {
                    pw.println("<h3>Invalid region name provided.</h3>");
                    return;
                }

                // Insert new voter into the database
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Voter (vname, adharNumber, Bdate, age, email, password, RegionID) VALUES (?, ?, ?, ?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, adharNumber);
                ps.setString(3, dob);
                ps.setInt(4, age);
                ps.setString(5, email);
                ps.setString(6, password);
                ps.setInt(7, regionID);

                int row = ps.executeUpdate();
                if (row == 1) {
                    // Registration completed, redirect to index.jsp
                    response.sendRedirect("index.jsp?registration=complete");
                } else {
                    pw.println("<h3>Error during registration</h3>");
                }
            }
        } catch (SQLException sc) {
            pw.println("<h3>" + sc.getMessage() + "</h3>");
            sc.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        pw.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
