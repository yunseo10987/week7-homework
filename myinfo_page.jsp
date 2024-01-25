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

    String sql = "SELECT id, password, name, birth_year, phone_number, email, nickname, gender FROM account WHERE account.idx = ?"; 
    PreparedStatement query = conn.prepareStatement(sql); 
    query.setString(1, idx);
    
    ResultSet result = query.executeQuery(); 

    ArrayList<String> data = new ArrayList<String>();
    
    while(result.next()){
        String id = result.getString(1);
        String pw = result.getString(2);
        String name = result.getString(3);
        String birth_year = result.getString(4);
        String phone_number = result.getString(5);
        String email = result.getString(6);
        String nickname = result.getString(7);
        String gender = result.getString(8);
        data.add("\"" + id + "\"");
        data.add("\"" + pw + "\"");
        data.add("\"" + name + "\"");
        data.add("\"" + birth_year + "\"");
        data.add("\"" + phone_number + "\"");
        data.add("\"" + email + "\"");
        data.add("\"" + nickname + "\"");
        data.add("\"" + gender + "\"");
    }


%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type="text/css" href="index.css">
    <link rel = "stylesheet" type="text/css" href="signup_page.css">
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
        <div class = "signup_box">
            <h2>내 정보</h2>
            <table>
                <tr>
                    <td>아이디 : </td>
                    <td id = "td0">

                    </td>
                </tr>
                <tr>
                    <td>비밀번호 : </td>
                    <td id = "td1">
                        
                    </td>
                </tr>
                <tr>
                    <td>이름 : </td>
                    <td id = "td2">
                            
                    </td>
                </tr>
                <tr>
                    <td>생년 : </td>
                    <td id = "td3"> 
                            
                    </td>
                </tr>
                <tr>
                    <td>핸드폰 번호 : </td>
                    <td id = "td4">
                            
                    </td>
                </tr>
                <tr>
                    <td>이메일 : </td>
                    <td id = "td5">
                            
                    </td>
                </tr>
                <tr>
                    <td>닉네임 : </td>
                    <td id = "td6">
                            
                    </td>
                </tr>
                <tr>
                    <td>성별 : </td>
                    <td id = "td7">
                        
                    </td>
                </tr>
            </table>
            <input type="submit" value="회원 정보 수정" onclick = "location.href = 'myinfo_revice_page.jsp'">
            <input type="submit" value="회원 탈퇴" onclick = "checkUnsign()">
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
        function insertInfo(){
            var data = <%=data%>
            for(var index = 0; index < data.length; index++){
                var td = document.getElementById("td" + index)
                td.innerHTML =  data[index]
                
            }
        }
        function checkUnsign(){
            var flag = confirm("정말로 탈퇴하실건가요?")
            if(flag){
                location.href = 'unsignup_action.jsp'
            }
        }
        accountLogin(<%=idx%>)
        insertInfo()
    </script>
    
</body>