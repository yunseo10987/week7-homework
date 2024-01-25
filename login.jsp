<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%-- table에서 가져온 값을 처리하는 라이브러리 --%>
<%-- select는 다른 것들과는 다르게 데이터베이스에서 받아와야 하기 때문에 import 하나 더함 --%>
<%@ page import = "java.util.ArrayList" %>
<%-- 리스트 라이브러리 --%>

<%
    // jsp 영역
    request.setCharacterEncoding("utf-8"); 
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");

    //db 연결 코드
    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정

    //SQL 준비 및 전송
    String sql = "SELECT * FROM test WHERE id =? AND pw =?"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, idValue);
    query.setString(2, pwValue);
    
    //sql 결과 받아오기
    ResultSet result = query.executeQuery(); 

    //후처리 (resultSet을 jsp 내에서 모두 읽은 다음에, 2차원 리스트로 만들어줄 것
    //원래 db에서 받아올 때 첫째줄에 가상의 커서가 있음, 10번째 줄을 읽기 위해서는 1-9번째 줄을 다 읽어야함
    //result.next()가 cursor를 한 줄 움직이는 명령어
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
    //2차원 리스트, 사실 로그인 기능은 2차원 리스트 필요없긴해. 아이디 비번이 있냐 없냐기 때문에
    while(result.next()){
        String id = result.getString(1); //첫번째 column 읽어오기
        String pw = result.getString(2); //두번째 column 읽어오기
        ArrayList<String> elem = new ArrayList<String>();
        elem.add("\"" + id + "\"");
        elem.add("\"" + pw + "\"");
        //이것도 아까와 마찬가지로 raw 데이터가 되는 걸 막음
        data.add(elem);
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>


    <script>
       var data = <%=data%>
       for(var index = 0; index<data.length; index++){
        console.log(data[index])
       }
    </script>
</body>