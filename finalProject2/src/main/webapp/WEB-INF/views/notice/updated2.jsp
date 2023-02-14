<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
<link rel="stylesheet" type="text/css" href="/resources/css/list.css"/>

<script type="text/javascript" src="/resources/js/util.js"></script>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<script type="text/javascript">

	function sendIt(){
		
		var f = document.myForm;
	
		str = f.subject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
		
		str = f.name.value;
		str = str.trim();
		if(!str){
			alert("\n이름을 입력하세요.");
			f.name.focus();
			return;
		}		
		
		/* if(!isValidKorean(str)){
			alert("\n이름을 정확히 입력하세요.");
			f.name.focus()
			return;
		}	*/	
		f.name.value = str;
		
		if(f.email.value){
			if(!isValidEmail(f.email.value)){
				alert("\n정상적인 E-Mail을 입력하세요.");
				f.email.focus();
				return;
			}
		}
		
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;
		
		str = f.pwd.value;
		str = str.trim();
		if(!str){
			alert("\n패스워드를 입력하세요.");
			f.pwd.focus();
			return;
		}
		
		f.pwd.value = str;
		
		f.action = "<%=cp%>/movie/updated2_ok";
		f.submit();
		
	}
</script>

	
<!-- container -->
	<div class="container has-lnb">
		<div class="page-util">
			<div class="inner-wrap">
				<div class="location">
					<span>Home</span>
					<a href="#" title="고객센터 페이지로 이동">고객센터</a>
					<a href="/movie/list" title="공지사항 페이지로 이동">1:1문의 수정</a>
				</div>

			</div>
		</div>

			<div class="inner-wrap">
				<div class="lnb-area addchat ">
					<nav id="lnb" class="ty2">
						<p class="tit"><a href="#" title="고객센터">고객센터</a></p>
						<ul>
							<li><a href="#" title="고객센터 홈">고객센터 홈</a></li>
							<li ><a href="#" title="자주 묻는 질문">자주 묻는 질문</a></li>
							<li class=""><a href="/movie/created" title="공지사항">공지사항</a></li>
							<li class="on"><a href="/movie/list2" title="1:1문의">1:1문의</a></li>
							<li><a href="#" title="단체관람 및 대관문의">단체관람 및 대관문의</a></li>
							<li><a href="#" title="분실물 문의">분실물 문의</a></li>
							<li><a href="#" title="이용약관">이용약관</a></li>
							<li><a href="#" title="위치기반서비스이용약관">위치기반서비스이용약관</a></li>
							<li><a href="#" title="개인정보처리방침">개인정보처리방침</a></li>
							<li><a href="#" style="border-radius: 0 0 10px 10px;" title="스크린배정수에관한기준">스크린배정수에관한기준</a></li>
						</ul>

						<!-- 고객센터 메뉴일때만 출력 -->
						<div class="left-customer-info">
							<p class="tit">
								메가박스 고객센터
								<span>Dream center</span>
							</p>
							<p class="time"><i class="iconset ico-clock"></i> 10:00~19:00</p>
						</div>
					</nav>
				</div>

				
					<div id="contents" class="">
						<h2 class="tit">1:1문의 수정</h2>
						<div class="table-wrap">

							<form action="" method="post" name="myForm">

									<table class="board-form va-m">
										<colgroup>
											<col style="width:150px;">
											<col>
											<col style="width:150px;">
											<col>
										</colgroup>
									<tbody>			
									<tr>
										<th scope="row"><label for="name">이름</label> <em class="font-orange">*</em></th>
										<td><input type="text"  name ="name" class="input-text w150px" value="${dto.name }" maxlength="15"></td>
										<th scope="row"><label for="qnaRpstEmail">이메일</label> <em class="font-orange">*</em></th>
										<td><input type="text" name="email"  class="input-text" value="${dto.email }" maxlength="50"></td>
									</tr>
									<tr>


									</tr>


									<tr>
										<th scope="row"><label for="qnaCustInqTitle">제목</label> <em class="font-orange">*</em></th>
										<td colspan="3"><input type="text" name="subject" value="${dto.subject }"  class="input-text" maxlength="100"></td>
									</tr>
									<tr>
										<th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
										<td colspan="3">
											<div class="textarea">
												<textarea  name="content" rows="5" cols="30" title="내용입력" class="input-textarea">${dto.content }</textarea>
												<div class="util">
													<p class="count">

													</p>
												</div>
											</div>
										</td>
									</tr>

									<tr>

										<th scope="row"><label for="name">패스워드</label> <em class="font-orange">*</em></th>
										<td colspan="3"><input type="password"  name ="pwd" class="input-text w150px" value="" maxlength="15"></td>
									</tr>				
							</tbody>
							</table>
							<br/><br/>
							<div id="btn-group pt40" style="text-align: center;">

								<input type="hidden" name="num" value="${dto.num }"/>
								<input type="hidden" name="pageNum" value="${pageNum }"/>

								<input type="hidden" name="searchKey" value="${searchKey }"/>
								<input type="hidden" name="searchValue" value="${searchValue }"/> 

								<input type="button" value=" 수정하기 " class="button purple large" onclick="sendIt();"/>
								<input type="button" value=" 수정취소 " class="button large" onclick="javascript:location.href='<%=cp%>/movie/list2?${params }';"/>
							</div>

							</form>			
				</div>
			</div>
		</div>
	</div>	
<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!-- //footer -->


</body>
</html>





























