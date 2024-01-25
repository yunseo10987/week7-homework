<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 

<%
    request.setCharacterEncoding("utf-8");
    session = request.getSession();
    String idx = (String)session.getAttribute("idx");

    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    String nameValue = request.getParameter("name_value");
    String birthValue = request.getParameter("birth_value");
    String phonenumberValue = request.getParameter("phonenumber_value");
    String emailValue = request.getParameter("email_value");
    String nicknameValue = request.getParameter("nickname_value");
    String genderValue = request.getParameter("gender_value");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); 

    
    String sql = "UPDATE account SET id =?, password=?, name=?, birth_year=?, phone_number=?, email=?, nickname=?, gender=? WHERE idx =?"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, idValue);
    query.setString(2, pwValue);
    query.setString(3, nameValue);
    query.setString(4, birthValue);
    query.setString(5, phonenumberValue);
    query.setString(6, emailValue);
    query.setString(7, nicknameValue);
    query.setString(8, genderValue);
    query.setString(9, idx);

        
    query.executeUpdate(); 
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <script>
        console.log(<%=idx%>)
        alert("회원정보가 수정되었습니다.")
        location.href= "myinfo_page.jsp"
    </script>
</body>