<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import = "java.util.ArrayList" %>


<%
    request.setCharacterEncoding("utf-8"); 
    String idValue = request.getParameter("id_value");
    String phonenumberValue = request.getParameter("phonenumber_value");

    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정

    String sql = "SELECT password FROM account WHERE id =? AND phone_number =?"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, idValue);
    query.setString(2, phonenumberValue);

    ResultSet result = query.executeQuery(); 
    String pw = null;
    while(result.next()){
        pw = "\"" + result.getString(1) + "\"";
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        var data = <%=pw%>
        console.log(data)
        if(!data){
            alert("일치하는 비밀번호가 없습니다.")
            location.href = "find_pw_page.jsp"
        }
        else{
            alert("당신의 비밀번호는 " + data + "입니다")
            location.href = "index.jsp"
        } 
    </script>
</body>