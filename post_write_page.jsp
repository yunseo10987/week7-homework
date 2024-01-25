<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import = "java.util.ArrayList" %>


<%  
    request.setCharacterEncoding("utf-8"); 
    session = request.getSession();
    String idx = (String)session.getAttribute("idx");

    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정

%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type="text/css" href="index.css">
    <link rel = "stylesheet" type="text/css" href="post_write_page.css">
    <title>Document</title>
</head>
<body>
    <header>
        <section>
            <a id = "login" href = "login_page.jsp">로그인</a>
            <a id = "signup" href = "signup_page.jsp">회원가입</a>
            <a id = "myinfo" href = "myinfo_page.jsp">내 정보</a>
            <a id = "logout" href = "logout_action.jsp">로그아웃</a>
        </section>
        <h1>
            <a href = "index.jsp">게시판 이름</a>
        </h1>
        <nav id = "menu">
            <a href = "index.jsp?category_idx=1">잡담</a>
            <a href = "index.jsp?category_idx=2">운동</a>
            <a href = "index.jsp?category_idx=3">게임</a>
            <a href = "index.jsp?category_idx=4">취미</a>
            <a href = "index.jsp?category_idx=5">웃음</a>
        </nav>
    </header>
    <main>
        <h2>글쓰기</h2>
        <form action = "post_write_action.jsp" onsubmit = "return checkPost()">
            <div id = "category_box">
                카테고리
                <select id = "category_select" name = "category_value">
                    <option value = "1">잡담</option>
                    <option value = "2">운동</option>
                    <option value = "3">게임</option>
                    <option value = "4">취미</option>
                    <option value = "5">웃음</option>
                </select>
                제목
                <input type = "text" placeholder = "제목을 입력하세요(30자 이내)" name= "title_value">
            </div>
            <textarea id = "content_box" placeholder = "내용을 입력하세요" name = "content_value"></textarea>
            <div>
                <input type = "submit" value = "제출">
            </div>
        </form>
    </main>
    <script>
        function accountLogin(account){
            if(account){
                document.getElementById("login").style.display = "none";
                document.getElementById("signup").style.display = "none";
                document.getElementById("myinfo").style.display = "block";
                document.getElementById("logout").style.display = "block";
            }
            else{
                document.getElementById("login").style.display = "block";
                document.getElementById("signup").style.display = "block";
                document.getElementById("myinfo").style.display = "none";
                document.getElementById("logout").style.display = "none";
            }
        }
        function checkPost(){
            var title = document.getElementsByName("title_value")[0].value
            var content = document.getElementsByName("content_value")[0].value
            if(title == ""){
                alert("제목을 작성하세요")
                return false
            }
            else if(title < 2 || title > 30){
                alert("제목은 2자 이상 30자 이하로 작성하세요")
                return false
            }
            if(!content){
                alert("내용을 작성하세요")
                return false
            }
        }
        accountLogin(<%=idx%>)
    </script>
    
</body>