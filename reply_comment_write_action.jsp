<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 

<%
    request.setCharacterEncoding("utf-8"); 
    session = request.getSession();
    String idx = (String)session.getAttribute("idx");
    String postIdxValue = request.getParameter("post_idx");
    String contentValue = request.getParameter("update_comment_value");
    String commentIdxValue = request.getParameter("comment_idx");
    
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); 

    
    String sql = "INSERT INTO reply_comment(content, comment_idx, account_idx) VALUES(?, ?, ?)"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, contentValue);
    query.setString(2, commentIdxValue);
    query.setString(3, idx);

    query.executeUpdate(); 
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script>
        location.href= "post_page.jsp?"+"idx="+ <%=postIdxValue%>
    </script>
</body>