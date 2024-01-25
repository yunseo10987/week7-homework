<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 

<%
    request.setCharacterEncoding("utf-8"); 
    session = request.getSession();
    String idx = (String)session.getAttribute("idx");

    String titleValue = request.getParameter("title_value");
    String categoryValue = request.getParameter("category_value");
    String contentValue = request.getParameter("content_value");
    
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); 

    
    String sql = "INSERT INTO post(title, content, account_idx, post_category_idx) VALUES(?, ?, ?, ?)"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, titleValue);
    query.setString(2, contentValue);
    query.setString(3, idx);
    query.setString(4, categoryValue);
        
    query.executeUpdate(); 
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script>
        alert("게시물이 작성되었습니다")
        location.href= "index.jsp"
    </script>
</body>