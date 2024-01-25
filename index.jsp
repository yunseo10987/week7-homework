<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.TimeZone" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.time.LocalDateTime" %>
<%@ page import = "java.time.ZoneId" %>
<%@ page import = "java.time.Instant" %>
<%@ page import = "java.time.ZonedDateTime" %>
<%@ page import = "java.time.format.DateTimeFormatter" %>


<%
    request.setCharacterEncoding("utf-8"); 

    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정
    String categoryIdx = request.getParameter("category_idx");
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
    if(categoryIdx == null){
        String sql = "SELECT post.idx, post.date, post_category.name, post.title,  account.nickname, post.idx FROM post, account, post_category WHERE post.post_category_idx = post_category.idx AND post.account_idx= account.idx ORDER BY post.idx"; 
        PreparedStatement query = conn.prepareStatement(sql); 
        
        ResultSet result = query.executeQuery();  
        while(result.next()){
            //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh::mm::ss");
            //sdf.timeZone = TimeZone.getTimeZone("Asia/Seoul");
            Timestamp date = result.getTimestamp(2);

            LocalDateTime ldt = date.toLocalDateTime();
            ZonedDateTime zdt = ldt.atZone(ZoneId.of("Asia/Seoul"));
            String category = result.getString(3);
            String title = result.getString(4);
            String writer = result.getString(5);
            String idx = result.getString(6);
            ArrayList<String> elem = new ArrayList<String>();
            elem.add("\"" + zdt + "\"");
            elem.add("\"" + category + "\"");
            elem.add("\"" + title + "\"");
            elem.add("\"" + writer + "\"");
            elem.add(idx);
            data.add(elem);
        }
    }
    else{
        String sql = "SELECT  post.idx, post.date, post_category.name, post.title,  account.nickname, post.idx FROM post, account, post_category WHERE post.post_category_idx = post_category.idx AND post.account_idx= account.idx AND post.post_category_idx = ? ORDER BY post.idx"; 
        PreparedStatement query = conn.prepareStatement(sql); 
        query.setString(1, categoryIdx);
        ResultSet result = query.executeQuery(); 

        while(result.next()){
            //SimpleDataFormat sdf = new SimpleDataFormat("yyyy-MM-dd HH::mm::ss");
            String date = result.getString(2);
            //sdf.format(data);
            String category = result.getString(3);
            String title = result.getString(4);
            String writer = result.getString(5);
            String idx = result.getString(6);
            ArrayList<String> elem = new ArrayList<String>();
            elem.add("\"" + date + "\"");
            elem.add("\"" + category + "\"");
            elem.add("\"" + title + "\"");
            elem.add("\"" + writer + "\"");
            elem.add(idx);
            data.add(elem);
        }
    }
    

    

    session = request.getSession();
    String idx =  (String)session.getAttribute("idx");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type="text/css" href="index.css">
    <link rel = "stylesheet" type="text/css" href="index_main.css">
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
    <main id = "post_box">
        <div id = "write_post">
            <input type = "button" value = "게시물 쓰기" onclick = "return checkLogin()">
        </div>
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
        function createPost(){
            var parent = document.getElementById("post_box")
            var data = <%=data%>
            for(index = 0; index < data.length; index++){
                var list = data[index]
                var postA = document.createElement("a")
                var postMainDiv = document.createElement("div")
                var categoryDiv = document.createElement("div")
                var titleDiv = document.createElement("div")
                var detailDiv = document.createElement("div")
                postA.className = "post"
                postA.href = "post_page.jsp?" + "idx=" + list[4]
                postMainDiv.className = "post_main"
                categoryDiv.className = "category_box"
                titleDiv.className = "title_box" 
                detailDiv.className = "post_detail"
                categoryDiv.innerHTML = list[1]
                titleDiv.innerHTML = list[2]
                detailDiv.innerHTML = list[0] + " " + list[3]
                parent.appendChild(postA)
                postA.appendChild(postMainDiv)
                postMainDiv.appendChild(categoryDiv) 
                postMainDiv.appendChild(titleDiv)
                postA.appendChild(detailDiv)
                
            }
        }
        function checkLogin(){
            if(!<%=idx%>){
                alert("로그인 후 게시물을 써주세요.")
                return false
            }
            else{
                location.href = "post_write_page.jsp"
            }
        }
        accountLogin(<%=idx%>)
        createPost()
        console.log(<%=idx%>)
    </script>
    
</body>