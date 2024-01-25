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
        <form action="myinfo_revice_action.jsp" class = "signup_box" onsubmit = "return checkInfo()">
            <h2>회원 정보 수정</h2>
            <table>
                <tr>
                    <td>아이디 : </td>
                    <td>
                        <input id = "input0" type="text" name = "id_value" >
                    </td>
                </tr>
                <tr>
                    <td>비밀번호 : </td>
                    <td>
                        <input id = "input1" type="password" name = "pw_value">
                    </td>
                </tr>
                <tr>
                    <td>비밀번호 확인 : </td>
                    <td>
                        <input type="password" name = "pw_check_value">
                    </td>
                </tr>
                <tr>
                    <td>이름 : </td>
                    <td>
                        <input id = "input2" type="text" name = "name_value">
                    </td>
                </tr>
                <tr>
                    <td>생년 : </td>
                    <td>
                        <input id = "input3" type="number" name = "birth_value">
                    </td>
                </tr>
                <tr>
                    <td>핸드폰 번호 : </td>
                    <td>
                        <input id = "input4" type="tel" name = "phonenumber_value">
                    </td>
                </tr>
                <tr>
                    <td>이메일 : </td>
                    <td>
                        <input id = "input5" type="email" name = "email_value">
                    </td>
                </tr>
                <tr>
                    <td>닉네임 : </td>
                    <td>
                        <input id = "input6" type="text" name = "nickname_value">
                    </td>
                </tr>
                <tr>
                    <td>성별 : </td>
                    <td>
                        <input id = "input7" class = "radio" type="radio" name = "gender_value" value ="M"> 
                        <span>남자</span>
                        <input id = "input8" class = "radio" type="radio" name = "gender_value" value ="W"> 
                        <span>여자</span> 
                    </td>
                </tr>
            </table>
            <input type="submit" value="회원 정보 수정">
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
        function insertInfo(){
            var data = <%=data%>
            for(var index = 0; index < data.length; index++){
                var input = document.getElementById("input" + index)
                if(index == 7){
                    if(data[index] == 'M'){
                        input.checked = true;
                    }
                    else{
                        document.getElementById("input8").checked = true;
                    }
                }
                else{
                    input.value =  data[index]
                }
            }
        }
        function checkInfo(){
            var idFlag = document.getElementsByName("id_value")[0].value
            var pwFlag = document.getElementsByName("pw_value")[0].value
            var pwCheckFlag = document.getElementsByName("pw_check_value")[0].value
            var nameFlag = document.getElementsByName("name_value")[0].value
            var birthFlag = document.getElementsByName("birth_value")[0].value
            var phonenumberFlag = document.getElementsByName("phonenumber_value")[0].value
            var emailFlag = document.getElementsByName("email_value")[0].value
            var nicknameFlag = document.getElementsByName("nickname_value")[0].value
            
            var phoneReg = /^\d{3}-\d{4}-\d{4}$/g
            
            
            if(idFlag.length < 5 || idFlag.length > 14){
                alert("아이디는 5자 이상 14자 이하로 작성해주세요.")
                return false
            }
            if(pwFlag.length < 5 || pwFlag.length > 14){
                alert("비밀번호는 5자 이상 14자 이하로 작성해주세요.")
                return false
            }
            if(!(pwFlag == pwCheckFlag)){
                alert("비밀번호를 다시 확인해주세요")
                return false
            }
            if(nameFlag == ""){
                alert("이름을 입력하세요.")
                return false
            }
            if(birthFlag < 1901 || birthFlag > 2022){
                alert("생년은 1901-2022만 입력이 가능합니다.")
                return false
            }
            if(!phoneReg.test(phonenumberFlag)){
                alert("번호를 ###-####-#### 같은 형식으로 입력해주세요")
                return false
            }
            if(emailFlag == ""){
                alert("이메일을 입력하세요")
                return false
            }
            if(nicknameFlag.length < 2 || nicknameFlag.length > 14 ){
                alert("닉네임은 2-14자리로 지어주세요")
                return false
            }
           
        }
        accountLogin(<%=idx%>)
        insertInfo()
    </script>
    
</body>