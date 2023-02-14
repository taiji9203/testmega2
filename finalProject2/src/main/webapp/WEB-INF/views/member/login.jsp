<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
<%@page import="java.net.URLDecoder"%>
	
<link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
<link rel="stylesheet" type="text/css" href="/resources/css/list.css"/>

<!-- header -->
<jsp:include page="../layout/header.jsp"></jsp:include>
<!--// header -->

<script type="text/javascript">
function sendIt(){
	
	var f= document.myForm;
	
  	f.action="<%=cp%>/movie/login_ok";
	f.submit();

	}

	//비밀번호 input창에서 엔터눌렀을 경우 로그인 버튼 눌리게
	function enterkey() {
		if (window.event.keyCode == 13) {
			$("#loginBtn").click();
		}
	}	
</script>

<script type="text/javascript">

var idck = 0;
var f = document.myForm;

$(function() {
	
    $("#loginBtn").click(function() {

        var obj = new Object(); 
        obj.id = $("#id").val();
        obj.pwd = $("#pwd").val();

        var json_data = JSON.stringify(obj); // form의 값을 넣은 오브젝트를 JSON형식으로 변환
        
        $.ajax({
            type : 'POST',
            data : json_data,
            url : "loginAjax",
            contentType : "application/json; charset=UTF-8",
            success : function(data) {
            	
            	if(data.cnt==0) {
                    alert("아이디 또는 비밀번호가 틀립니다.");
					$("#id").focus();
                    	                
                } else {
                    alert("로그인 성공");
                    //아이디가 중복하지 않으면  idck = 1 
                    idck = 1;
					sendIt();
                }     
            },
            beforeSend:showRequest,
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }

        });
        
    });
});

function showRequest() {
    
	var id=$.trim($("#id").val());
	var pwd=$.trim($("#pwd").val());
	
    if(id==""){
    	alert("아이디을 입력해주세요.");
    	$("#id").focus();
    	return false;//이거 안쓰면 success부분의 alert창이 뜸
    }
    
    if(pwd==""){
    	alert("비밀번호를 입력해주세요.");
    	$("#pwd").focus();
    	return false;
    }
	
}
</script>
		
	<!-- container -->
	<div class="container location-fixed" align="center" >
		<div class="col-lg-6" align="center" style="width: 400px;">
		
		<h2 class="tit">로그인</h2>
			<form action="" method="post" name="myForm">
			</br>
			
				<div align="left">
					<label class="login_title" for="">아이디</label>
					<input type="text" class="form-control" id="id" name="id" value="${cookie.id.value}" placeholder="아이디를 입력하세요">
				</div>
				</br>
				<div class="" align="left">
					<label class="login_title" for="">비밀번호</label>
					<input type="password" class="form-control" id="pwd" name="pwd" placeholder="패스워드를 입력하세요" onkeydown="javascript:if(event.keyCode == 13) {login();}">
				</div>
				</br>
				<div class="" align="left">
					<label class="form-check-lable">
						<input type="checkbox" name="rememberId" class="login_text01" value="on" ${empty cookie.id.value ? "" : "checked" }>아이디 저장
						<!-- <input class="form-check-input" type="checkbox" id="idsave" name="idsave" checked="checked"> 아이디저장 -->
					</label>
					<div class="login_text02">
						<a href="/movie/searchId" >아이디 찾기</a> 
						<a> | </a>
						<a href="/movie/searchPw">비밀번호 찾기</a>
					</div>
				</div>
				<div class="" align="center">
					<button type="button" id="loginBtn" class="button purple large"> 로그인</button>
					<button type="button" onclick="location.replace('/movie/join')" class="button large">회원가입</button>
				</div>
			</form>
		</div>
	</div>
<!--<div id="bodyContent"> -->


<!-- footer -->
<jsp:include page="../layout/footer.jsp"></jsp:include>
<!-- //footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/booking/booking#"data-url="/">모바일웹으로 보기<i class="iconset ico-go-mobile"></i></a>
</div>
<div class="normalStyle" style="display: none; position: fixed; top: 0; left: 0; background: #000; opacity: 0.7; text-indent: -9999px; width: 100%; height: 100%; z-index: 100;">닫기</div>
<div class="alertStyle" style="display: none; position: fixed; top: 0px; left: 0px; background: #000; opacity: 0.7; width: 100%; height: 100%; z-index: 5005;"></div>
<div id="fatkun-drop-panel">
<a id="fatkun-drop-panel-close-btn">×</a>
</div>
</body>
</html>