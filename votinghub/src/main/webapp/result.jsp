<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%
    String adminID = request.getParameter("adminID");
    String password = request.getParameter("password");
    String electionID = request.getParameter("electionID");
        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/votinghub", "root", "");

            // Validate the admin details
            String query = "SELECT * FROM election_admin WHERE AdminID = ? AND Password = ? AND ElectionID = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, adminID);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, electionID);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
        
            }else{
            	 response.sendRedirect("instruct.jsp");
                 return;
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voting Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            text-align: center;
        }
        .parties {
            display: flex;
            justify-content: space-around; 
            flex-wrap: nowrap; 
        }
        .party {
            flex: 0 0 auto; 
            margin-bottom: 20px;
            text-align: center;
        }
        .party img {
            display: block;
            margin: 0 auto;
            width: 200px;
            height: auto;
        }
        .party-info {
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Voting Results</h1>
        <div id="votingResults" >
            <div class="parties">
                <div class="party">
                    <img src="bjp.png" alt="BJP">
                    <div class="party-info">
                        <h3>BJP</h3>
                        <p>Votes: <% out.print(getVotesForParty("bjp", request.getParameter("regionID"), request.getParameter("electionID"))); %></p>
                    </div>
                </div>
                <div class="party">
                    <img src="congress.png" alt="Congress">
                    <div class="party-info">
                        <h3>Congress</h3>
                        <p>Votes: <% out.print(getVotesForParty("congress", request.getParameter("regionID"), request.getParameter("electionID"))); %></p>
                    </div>
                </div>
                <div class="party">
                    <img src="aap.png" alt="AAP">
                    <div class="party-info">
                        <h3>AAP</h3>
                        <p>Votes: <% out.print(getVotesForParty("aap", request.getParameter("regionID"), request.getParameter("electionID"))); %></p>
                    </div>
                </div>
                <div class="party">
                    <img src="nota.png" alt="NOTA">
                    <div class="party-info">
                        <h3>NOTA</h3>
                        <p>Votes: <% out.print(getVotesForParty("nota", request.getParameter("regionID"), request.getParameter("electionID"))); %></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%! 
    public int getVotesForParty(String partyName, String regionID, String electionID) {
        int votes = 0;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost/votinghub", "root", "");
            
            // Prepare SQL statement to retrieve votes for the given party, region, and election
            String sql = "SELECT votes FROM party WHERE Pname = ? AND RegionID = ? AND ElectionID = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, partyName);
            preparedStatement.setString(2, regionID);
            preparedStatement.setString(3, electionID);
            
            // Execute the query
            resultSet = preparedStatement.executeQuery();
            
            // If there are results, get the votes
            if (resultSet.next()) {
                votes = resultSet.getInt("votes");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return votes;
    }
    %>
</body>
</html>
