<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 

<%
    request.setCharacterEncoding("utf-8"); 
    session = request.getSession();
    String idx = (String)session.getAttribute("idx");

    String postIdxValue = request.getParameter("post_idx");
    String titleValue = request.getParameter("title_value");
    String categoryValue = request.getParameter("category_value");
    String contentValue = request.getParameter("content_value");
    
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); 

    
    String sql = "UPDATE post SET title=?, content=?,post_category_idx=? WHERE idx = ?"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, titleValue);
    query.setString(2, contentValue);
    query.setString(3, categoryValue);
    query.setString(4, postIdxValue);
        
    query.executeUpdate(); 
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script>
        alert("게시물이 수정되었습니다.")
        location.href= "post_page.jsp?" +"idx="+<%=postIdxValue%> 
    </script>
</body>