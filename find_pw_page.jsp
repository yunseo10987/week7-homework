<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="index.css">
    <link rel = "stylesheet" type="text/css" href="login_page.css">
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
         <form action="find_pw_action.jsp" class = "login_box" onsubmit ="return checkFindPw()">
            <h2>비밀번호 찾기</h2>
            <input type="text" name = "id_value" placeholder ="아이디">
            <input type="text" name = "phonenumber_value" placeholder ="전화번호">
            <input type="submit" value="비밀번호 찾기">
        </form>
    </main>
    <script>
        function checkFindPw(){
            var phonenumberFlag = document.getElementsByName("phonenumber_value")[0].value
            var idFlag = document.getElementsByName("id_value")[0].value
            var phoneReg = /^\d{3}-\d{4}-\d{4}$/g

            if(idFlag == ""){
                alert("아이디를 입력하세요")
                return false
            }
            if(!phoneReg.test(phonenumberFlag)){
                alert("번호를 ###-####-#### 같은 형식으로 입력해주세요")
                return false
            }
       }
    </script>

</body>