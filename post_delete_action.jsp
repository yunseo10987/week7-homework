<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 


<%  
    request.setCharacterEncoding("utf-8"); 
    
    String postIdxValue = request.getParameter("idx");

    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정

    String sql = "DELETE FROM post WHERE idx = ?"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, postIdxValue);
    
    query.executeUpdate(); 
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script>
        alert("게시물이 삭제되었습니다.")
        location.href= "index.jsp"
    </script>
</body>