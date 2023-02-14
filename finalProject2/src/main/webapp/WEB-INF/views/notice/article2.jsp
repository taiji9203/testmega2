<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
<link rel="stylesheet" type="text/css" href="/resources/css/list.css"/>

<script type="text/javascript">
	function sendIt(){
		
		var f = document.searchForm;
		f.action = "<%=cp%>/movie/list";
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
					<a href="support" title="고객센터 페이지로 이동">고객센터</a>
					<a href="support/notice" title="공지사항 페이지로 이동">공지사항</a>
				</div>

			</div>
		</div>

		<div class="inner-wrap">
			<div class="lnb-area addchat">
				<nav id="lnb">
					<p class="tit"><a href="support" title="고객센터">고객센터</a></p>
					<ul>
						<li><a href="#" title="고객센터 홈">고객센터 홈</a></li>
						<li><a href="#" title="자주 묻는 질문">자주 묻는 질문</a></li>
						<li><a href="/movie/list" title="공지사항">공지사항</a></li>
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
				<h2 class="tit">1:1문의</h2>

				<div class="table-wrap">
					<div class="board-view">

						<div class="info" id="mod_info">
									<p>
										<span class="tit">작성자</span>
										<span class="txt">${dto.name }</span>
									</p>
									<p>
										<span class="tit">등록일</span>
										<span class="txt">${dto.created }</span>
									</p>
									<p>
										<span class="tit">조회수</span>
										<span class="txt">${dto.hitCount }</span>
									</p>
						</div>
						<div class="tit-area" id="mod_title">
							<p class="tit">	${dto.subject }</p>
						</div>

						<div class="cont" id="mod_cont">${dto.content }</div>
					</div>
				</div>

				<div class="btn-group pt40">
					<a href="javascript:location.href='<%=cp%>/movie/updated2?num=${dto.num }&${params }';" class="button purple large" title="수정">수정</a>
					<a href="javascript:location.href='<%=cp%>/movie/deleted2_ok?num=${dto.num }&${params }';" class="button purple large" title="삭제">삭제</a>
					<a href="javascript:location.href='<%=cp%>/movie/list2?${params }';" class="button large" title="리스트">리스트</a>
				</div>
			</div>
		</div>
	</div>
	<!--// container -->

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!-- //footer -->

</body>
</html>






