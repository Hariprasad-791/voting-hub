package com.voting;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/VotingProcess")
public class VotingProcess extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter pw = response.getWriter();
        response.setContentType("text/html");

        String adharNumber = request.getParameter("adharNumber");
        String votedParty = request.getParameter("votedParty");
        String election = request.getParameter("election"); // Get election name from request
        String regionI = request.getParameter("regionID");
        int regionID=Integer.parseInt(regionI);
        Connection con = null;
        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql:///votinghub", "root", "");
            LocalDate ld = LocalDate.now();

            // Retrieve VID from the voter table
            String vid = null;
            PreparedStatement psVoterID = con.prepareStatement("SELECT VID FROM voter WHERE adharNumber = ?");
            psVoterID.setString(1, adharNumber);
            ResultSet rsVoterID = psVoterID.executeQuery();
            if (rsVoterID.next()) {
                vid = rsVoterID.getString("VID");
            } else {
                pw.println("<h3>Error: Aadhaar number not found in voter table.</h3>");
                return;
            }

            // Retrieve PID from the party table
            String pid = null;
           
            // Retrieve ElectionID from the election table based on the election name
            int electionId ;
            PreparedStatement psElectionID = con.prepareStatement("SELECT ElectionID FROM election WHERE Type= ?");
            psElectionID.setString(1, election);
            ResultSet rsElectionID = psElectionID.executeQuery();
            if (rsElectionID.next()) {
                electionId = rsElectionID.getInt("ElectionID");
            } else {
            
                pw.println("<h3>Error: Election name not found in the election table.</h3>");
                return;
            }
            PreparedStatement psPartyID = con.prepareStatement("SELECT PID FROM party WHERE Pname = ?  AND ElectionID=? AND RegionID=?");
            psPartyID.setString(1, votedParty);
            psPartyID.setInt(2, electionId);
            psPartyID.setInt(3, regionID);
            ResultSet rsPartyID = psPartyID.executeQuery();
            if (rsPartyID.next()) {
                pid = rsPartyID.getString("PID");
            } else {
                pw.println("<h3>Error: Party name not found in party table.</h3>");
                return;
            }

            // Insert vote into votesfor table, including ElectionID
            PreparedStatement psVote = con.prepareStatement(
                    "INSERT INTO votesfor (VID, adharNumber, PID, date, ElectionID) VALUES (?, ?, ?, ?, ?)"
            );
            psVote.setString(1, vid);
            psVote.setString(2, adharNumber);
            psVote.setString(3, pid);
            psVote.setDate(4, Date.valueOf(ld));
            psVote.setInt(5, electionId);

            int rowsAffectedVote = psVote.executeUpdate();

            if (rowsAffectedVote > 0) {
                // Increment votes for the selected party in the party table
                PreparedStatement psUpdateParty = con.prepareStatement(
                        "UPDATE party SET votes = votes + 1 WHERE PID = ? AND ElectionID=? AND RegionID=? "
                );
                psUpdateParty.setString(1, pid);
                psUpdateParty.setInt(2, electionId);
                psUpdateParty.setInt(3, regionID);
                int rowsAffectedParty = psUpdateParty.executeUpdate();

                if (rowsAffectedParty > 0) {
                    response.sendRedirect("thankyou.jsp");
                } else {
                	pw.println(pid+""+electionId+""+regionID);
                    pw.println("<h3>Error incrementing votes for the selected party.</h3>");
                }
            } else {
                pw.println("<h3>Error recording vote for Aadhaar number " + adharNumber + ".</h3>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            log("Error during voting process", e);
            pw.println("<h3>An error occurred during the voting process. Please try again later.</h3>");
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            pw.close();
        }
    }
}
