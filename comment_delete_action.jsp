<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 


<%  
    request.setCharacterEncoding("utf-8"); 

    String commentIdxValue = request.getParameter("comment_idx");
    String postIdxValue = request.getParameter("post_idx");

    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정

    String sql = "DELETE FROM comment WHERE idx = ?"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, commentIdxValue);
    
    query.executeUpdate(); 
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script>
        alert("댓글이 삭제되었습니다.")
        location.href= "post_page.jsp?" + "idx=" + <%=postIdxValue%>
    </script>
</body>