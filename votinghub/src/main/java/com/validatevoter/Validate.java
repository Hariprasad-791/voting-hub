package com.validatevoter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/Validate")
public class Validate extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adharNumber = request.getParameter("adharNumber");
        String electionType = request.getParameter("electionType");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        PrintWriter out = response.getWriter();

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/votinghub", "root", "");

            // Fetch ElectionID based on election type
            ps = con.prepareStatement("SELECT ElectionID FROM Election WHERE Type = ?");
            ps.setString(1, electionType);
            rs = ps.executeQuery();

            int electionID = -1; // Initialize electionID to a default value
            if (rs.next()) {
                electionID = rs.getInt("ElectionID");
            } else {
                // Invalid election type
                response.sendRedirect("home.jsp");
                out.println("<script>alert('Invalid election type selected.');</script>");
                return; // Exit the method
            }

            // Close the ResultSet and PreparedStatement for reuse
            rs.close();
            ps.close();

            // Check if the voter has already voted for this election
            ps = con.prepareStatement("SELECT * FROM Votesfor WHERE adharNumber = ? AND ElectionID = ?");
            ps.setString(1, adharNumber);
            ps.setInt(2, electionID);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Voter has already voted
                response.sendRedirect("home.jsp");
                out.println("<script>alert('You have already voted for this election.');</script>");
            } else {
                // Fetch RegionID for the voter
                rs.close();
                ps.close();

                ps = con.prepareStatement("SELECT RegionID FROM voter WHERE adharNumber = ?");
                ps.setString(1, adharNumber);
                rs = ps.executeQuery();

                int regionID = -1; // Initialize RegionID to a default value
                if (rs.next()) {
                    regionID = rs.getInt("RegionID");
                } else {
                    // RegionID not found for the voter
                    response.sendRedirect("home.jsp");
                    out.println("<script>alert('Voter information not found. Please register.');</script>");
                    return; // Exit the method
                }

                // Redirect to voting page with parameters
                response.sendRedirect("votingpage.jsp?adharNumber=" + adharNumber + "&election=" + electionType + "&Regionid=" + regionID);
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred. Please try again later.');</script>");
        } finally {
            // Close all resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
