<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> <%-- DB 탐색 라이브러리 --%>
<%@ page import ="java.sql.Connection"%> <%-- db 연결 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement"%> <%-- db sql 전송 라이브러리 --%>

<%
    // jsp 영역
    request.setCharacterEncoding("utf-8"); //이전 페이지에서 온 값에 대한 인코딩 설정
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");

    //db 연결 코드
    Class.forName("com.mysql.jdbc.Driver"); //Connector 파일 찾아오는 명령어
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정

    //SQL 준비 및 전송
    String sql = "INSERT INTO test(id,pw) VALUES(?, ?)"; 
    PreparedStatement query = conn.prepareStatement(sql); //sql을 전송 대기 상태로 만든 것
    query.setString(1, idValue);
    query.setString(2, pwValue);
    query.executeUpdate(); //DB에 전달 
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%-- <h1>아이디 : <%=idValue%> </h1>
    <h1>비밀번호 : <%=pwValue%></h1> --%>

    <script>
        alert("<%=idValue%>" + "님의 회원가입이 성공하였습니다")
        location.href= "index.html"
        console.log("<%=idValue%>")
        //큰따옴표 달아야 하는 이유 jsp에서 넘어올 때 자료형이 없는 raw 데이터로 넘어오게 됨
        //예를 들어 test를 입력했다면 string test가 오는 게 아니라 t 따로 e 따로 s 따로 t 따로 넘어와 하나의 변수로 생각함
        console.log("<%=pwValue%>")
    </script>
</body>