<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
<link rel="stylesheet" type="text/css" href="/resources/css/list.css"/>
	
<script type="text/javascript" src="/resources/js/util.js"></script>
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
		
		f.action = "<%=cp%>/movie/created";
		f.submit();
		
	}

</script>	

<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!-- container -->
	<div class="container has-lnb">
		<div class="page-util">
			<div class="inner-wrap">
				<div class="location">
					<span>Home</span>
					<a href="#" title="고객센터 페이지로 이동">고객센터</a>
					<a href="/movie/list" title="공지사항 페이지로 이동">공지사항</a>
				</div>
			</div>
		</div>

		<div class="inner-wrap">
			<div class="lnb-area addchat location-fixed">
				<nav id="lnb" class="ty2">
					<p class="tit"><a href="support" title="고객센터">고객센터</a></p>
					<ul>
						<li><a href="#" title="고객센터 홈">고객센터 홈</a></li>
						<li ><a href="#" title="자주 묻는 질문">자주 묻는 질문</a></li>
						<li class="on"><a href="/movie/list" title="공지사항">공지사항</a></li>
						<li><a href="/movie/list2" title="1:1문의">1:1문의</a></li>
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

			<div id="contents" class="location-fixed">
				<h2 class="tit">공지사항</h2>
				
				<div class="mypage-infomation mb30">
					<ul class="dot-list">
						<li>문의하시기 전 FAQ를 확인하시면 궁금증을 더욱 빠르게 해결하실 수 있습니다. </li>
					</ul>

					<div class="btn-group right">
						<a href="/movie/list" class="button purple" id="myQnaBtn" title="나의 문의내역 페이지로 이동">나의 문의내역</a><!-- btn-layer-open -->
					</div>
				</div>

					<div class="agree-box">
					<dl>
						<dt>
							<span class="bg-chk mr10">
								<input type="checkbox" id="chk">
								<label for="chk"><strong>개인정보 수집에 대한 동의</strong></label>
							<span class="font-orange">[필수]</span></span>

							
						</dt>
						<dd style="font-size:13px;">
							귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집·이용에 대한 본인동의가 필요한 항목입니다.<br><br>

							[개인정보의 수집 및 이용목적]<br>
							회사는 1:1 문의 내역의 확인, 요청사항 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다.<br><br>

							[필수 수집하는 개인정보의 항목]<br>
							이름, 휴대전화, 이메일, 문의내용<br><br>

							[개인정보의 보유기간 및 이용기간]<br>
							<span class="ismsimp">문의 접수 ~ 처리 완료 후 6개월<br>
							(단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존)<br>
							자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.</span>
						</dd>
					</dl>
				</div>
				<br/>
			<p class="reset mt10">* 원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다</p>
			<br/>
			<!-- <div id="bbs">
			<div id="bbs_title">
				게 시 판(boot jsp)
			</div>
			 -->
			<form action="" method="post" name="myForm">
				<div class="table-wrap">
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
							<td><input type="text"  name ="name" class="input-text w150px" value="" maxlength="15"></td>
							<th scope="row"><label for="qnaRpstEmail">이메일</label> <em class="font-orange">*</em></th>
							<td><input type="text" name="email"  class="input-text" value="" maxlength="50"></td>
						</tr>

						<tr>
							<th scope="row"><label for="qnaCustInqTitle">제목</label> <em class="font-orange">*</em></th>
							<td colspan="3"><input type="text" name="subject"  class="input-text" maxlength="100"></td>
						</tr>
						
						<tr>
							<th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
							<td colspan="3">
								<div class="textarea">
									<textarea  name="content" rows="5" cols="30" title="내용입력" placeholder="※ 불편사항이나 문의사항을 남겨주시면 최대한 신속하게 답변 드리겠습니다.<br>
※ 문의 내용에 개인정보(이름, 연락처, 카드번호 등)가 포함되지 않도록 유의하시기 바랍니다." class="input-textarea"></textarea>
									<div class="util">
										<p class="count">
											<span id="textareaCnt">0</span> / 2000
										</p>
									</div>
								</div>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><label for="name">패스워드</label> <em class="font-orange">*</em></th>
							<td colspan="3"><input type="password"  name ="pwd" class="input-text w150px" value="" maxlength="100"></td>							
						</tr>						
					</tbody>
				</table>
			</div>
			<!--<div class="bbsCreated_noLine">
			<dl>
				<dt>패스워드</dt>
				<dd>
				<input type="password" name="pwd" size="35" 
				maxlength="7" class="boxTF"/>
				&nbsp;(게시물 수정 및 삭제시 필요!!)
				</dd>
			</dl>		
			</div>	 -->
	
					<br/><br/>	
					<div id="bbsCreated_footer" align="center">
						<input type="button" value=" 등록하기 " class="button purple large" onclick="sendIt();"/>
						<input type="reset"  value=" 다시입력 " class="button purple large" onclick="document.myForm.subject.focus();"/>
						<input type="button" value=" 작성취소 " class="button large" onclick="javascript:location.href='<%=cp%>/movie/list';"/>
					</div>

					</form>
				</div>
			</div>	
		</div>

		<div class="quick-area" style="display: none;">
			<a href="#" class="btn-go-top" title="top" style="position: fixed;">top</a>
		</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!-- //footer -->

</body>
</html>





























