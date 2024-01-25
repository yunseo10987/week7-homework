<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="index.css">
    <link rel = "stylesheet" type="text/css" href="signup_page.css">
</head>
<body>
    <header>
        <section>
            <a href = "login_page.jsp">로그인</a>
            <a href = "signup_page.jsp">회원가입</a>
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
        <form action="signup_action.jsp" class = "signup_box" onsubmit = "return checkInfo()">
            <h2>회원가입</h2>
            <table>
                <tr>
                    <td>아이디 : </td>
                    <td>
                        <input type="text" name = "id_value" >
                    </td>
                </tr>
                <tr>
                    <td>비밀번호 : </td>
                    <td>
                        <input type="password" name = "pw_value">
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
                        <input type="text" name = "name_value">
                    </td>
                </tr>
                <tr>
                    <td>생년 : </td>
                    <td>
                        <input type="number" name = "birth_value">
                    </td>
                </tr>
                <tr>
                    <td>핸드폰 번호 : </td>
                    <td>
                        <input type="tel" name = "phonenumber_value">
                    </td>
                </tr>
                <tr>
                    <td>이메일 : </td>
                    <td>
                        <input type="email" name = "email_value">
                    </td>
                </tr>
                <tr>
                    <td>닉네임 : </td>
                    <td>
                        <input type="text" name = "nickname_value">
                    </td>
                </tr>
                <tr>
                    <td>성별 : </td>
                    <td>
                        <input class = "radio" type="radio" name = "gender_value" value ="M" checked> 
                        <span>남자</span>
                        <input class = "radio" type="radio" name = "gender_value" value ="W"> 
                        <span>여자</span> 
                    </td>
                </tr>
            </table>
            <input type="submit" value="회원가입">
        </form>
    </main>
    <script>
        function checkInfo(){
            console.log("오잉?")
            var idFlag = document.getElementsByName("id_value")[0].value
            var pwFlag = document.getElementsByName("pw_value")[0].value
            var pwCheckFlag = document.getElementsByName("pw_check_value")[0].value
            var nameFlag = document.getElementsByName("name_value")[0].value
            var birthFlag = document.getElementsByName("birth_value")[0].value
            var phonenumberFlag = document.getElementsByName("phonenumber_value")[0].value
            var emailFlag = document.getElementsByName("email_value")[0].value
            var nicknameFlag = document.getElementsByName("nickname_value")[0].value
            
            var phoneReg = /^\d{3}-\d{4}-\d{4}$/g
            
            console.log(idFlag)
            
            if(idFlag.length < 5 || idFlag.length > 14){
                console.log(1)
                alert("아이디는 5자 이상 14자 이하로 작성해주세요.")
                return false
            }
            if(pwFlag.length < 5 || pwFlag.length > 14){
                console.log(2)
                alert("비밀번호는 5자 이상 14자 이하로 작성해주세요.")
                return false
            }
            if(!(pwFlag == pwCheckFlag)){
                console.log(3)
                alert("비밀번호를 다시 확인해주세요")
                return false
            }
            if(nameFlag == ""){
                console.log(4)
                alert("이름을 입력하세요.")
                return false
            }
            if(birthFlag < 1901 || birthFlag > 2022){
                console.log(5)
                alert("생년은 1901-2022만 입력이 가능합니다.")
                return false
            }
            if(!phoneReg.test(phonenumberFlag)){
                console.log(6)
                alert("번호를 ###-####-#### 같은 형식으로 입력해주세요")
                return false
            }
            if(emailFlag == ""){
                console.log(7)
                alert("이메일을 입력하세요")
                return false
            }
            if(nicknameFlag.length < 2 || nicknameFlag.length > 14 ){
                console.log(8)
                alert("닉네임은 2-14자리로 지어주세요")
                return false
            }
           
        }
    </script>
</body>
