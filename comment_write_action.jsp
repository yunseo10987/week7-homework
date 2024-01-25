<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 

<%
    request.setCharacterEncoding("utf-8"); 
    session = request.getSession();
    String idx = (String)session.getAttribute("idx");

    String contentValue = request.getParameter("comment_content_value");
    String postValue = request.getParameter("post_value");
    
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); 

    
    String sql = "INSERT INTO comment(content, post_idx, account_idx) VALUES(?, ?, ?)"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, contentValue);
    query.setString(2, postValue);
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
        location.href= "post_page.jsp?"+"idx="+ <%=postValue%>
    </script>
</body>