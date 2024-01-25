<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import = "java.util.ArrayList" %>


<%
    request.setCharacterEncoding("utf-8"); 
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");

    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정

    String sql = "SELECT idx FROM account WHERE id =? AND password =?"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, idValue);
    query.setString(2, pwValue);

    ResultSet result = query.executeQuery(); 
    String idx = null;
    while(result.next()){
        idx = result.getString(1); 
        session.setAttribute("idx", idx);
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script>
        var data = <%=idx%>
        if(!data){
            alert("아이디 혹은 비밀번호가 틀렸습니다.")
            location.href = "login_page.jsp"
        }
        else{
            location.href = "index.jsp"
        } 
    </script>
</body>