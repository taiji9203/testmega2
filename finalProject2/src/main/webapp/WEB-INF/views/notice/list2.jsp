<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
<link rel="stylesheet" type="text/css" href="/resources/css/list.css"/>

<script type="text/javascript">

	function sendIt(){
		
		var f = document.searchForm;
		f.action = "<%=cp%>/movie/list2";
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
				<a href="/movie/list" title="공지사항 페이지로 이동">1:1문의내역</a>
			</div>

		</div>
	</div>

	<div class="inner-wrap">
		<div class="lnb-area">
			<nav id="lnb" class="ty2">
				<p class="tit"><a href="#" title="나의 메가박스">나의 메가박스</a></p>
						<ul>
							<li class=""><a href="/booking/booking" title="예매/구매내역">예매/구매내역</a></li>
							<li><a href="#" title="고객센터 홈">고객센터 홈</a></li>
							<li ><a href="#" title="자주 묻는 질문">자주 묻는 질문</a></li>
							<li><a href="/movie/list" title="공지사항">공지사항</a></li>
							<li class="on"><a href="/movie/created2" title="1:1문의">1:1문의</a></li>
							<li><a href="#" title="단체관람 및 대관문의">단체관람 및 대관문의</a></li>
							<li><a href="#" title="분실물 문의">분실물 문의</a></li>
							<li><a href="#" title="이용약관">이용약관</a></li>
							<li><a href="#" title="위치기반서비스이용약관">위치기반서비스이용약관</a></li>
							<li><a href="#" title="개인정보처리방침">개인정보처리방침</a></li>
							<li><a href="#" style="border-radius: 0 0 10px 10px;" title="스크린배정수에관한기준">스크린배정수에관한기준</a></li>
						</ul>
					</li>
				</ul>
			</nav>
		</div>
	
	<input type="hidden" name="currentPage" value="1">

	<div id="myLoactionInfo" style="display: none;">
		<div class="location">
			<span>Home</span>
			<a href="movie/join" title="나의 메가박스 페이지로 이동">나의 메가박스</a>
			<a href="/movie/list2" title="나의 문의내역 페이지로 이동">나의 문의내역</a>
		</div>
	</div>

	<div id="contents" class="">
		<h2 class="tit">나의 문의내역</h2>

		<div class="tab-block">
			<ul>
				<li data-url="/mypage/myinquiry?cd=INQD01" class="on"><a href="mypage/myinquiry#" class="btn" data-cd="INQD01" title="1:1 문의내역 탭으로 이동">1:1 문의내역</a></li>

			</ul>
		</div>

		<div class="mypage-infomation mt20">
			<ul class="dot-list mb20">
				<li id="tabDesc">고객센터를 통해 남기신 1:1 문의내역을 확인하실 수 있습니다.</li>
				<!-- <li>문의하시기 전 <a href="/support/faq" class="a-link"><strong>자주묻는질문</strong></a>을 확인하시면 궁금증을 더욱 빠르게 해결하실 수 있습니다</li> -->
			</ul>

			<div class="btn-group purple large right">
				<a href="/movie/created2" class="button" id="inqBtn" title="1:1 문의하기">1:1 문의하기</a>
			</div>
		</div>

		<div class="board-list-util mb10">
			<p class="result-count">
				<!-- to 개발 : 검색을 안한 경우 -->
			<!-- 	<strong>전체 (<b id="totalCnt">0</b>건)</strong> -->
			</p>

			<div id="bbsList">	
				<div id="bbsList_header">
					<div id="leftHeader">
						<form action="" method="post" name="searchForm">
							<select id="custInqStatCd" onchange="javascript:$(&#39;#searchBtn&#39;).click();" class="" tabindex="-98">
								<option value="">전체</option>
								<option value="INQST1">미답변</option>
								<option value="INQST2">답변완료</option>
							</select>
							<select name="searchKey" class="selectField">
								<option value="subject">제목</option>
								<option value="name">작성자</option>
								<option value="content">내용</option>
							</select>
							<div class="board-search">
								<input type="text" name="searchValue" class="input-text"/>
								<input type="button" value=" 검 색 " class="btn-search-input" onclick="sendIt()"/>
							</div>
						</form>

					</div>
				</div>			
			<div class="table-wrap">
				<table class="board-list a-c">
					<caption>번호, 극장, 유형, 제목, 답변상태, 등록일 순서로 보여주는 1:1 문의 내역 표입니다</caption>
						<!-- <div id="bbsList_title">
							게 시 판(boot jsp)
						</div> -->

					<table class="board-list">
						<thead>
							<tr>
								<th class="num" style="width:10%;">번호</th>
								<th class="subject">제목</th>
								<th class="name" style="width:15%;">작성자</th>
								<th class="created" style="width:15%;">작성일</th>
								<th class="hitCount" style="width:10%;">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${lists }"> <%-- BoardDTO : lists와 동일 EL로 받은것  --%>
								<tr>								
									<td class="num">${dto.num }</td> 
									<th class="subject"><a href="${articleUrl }&num=${dto.num }">${dto.subject }</a></th>
									<td class="name">${dto.name }</td>
									<td class="created">${dto.created }</td>
									<td class="hitCount">${dto.hitCount }</td>									
								</tr>
								<tr>
									<c:if test="${dataCount==0 }">등록된 게시물이 없습니다.</c:if>
								</tr>
							</c:forEach>							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
</div>

			




<div class="quick-area">
<a href="/movie/list" class="btn-go-top" title="top">top</a>
</div>

   
<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!-- //footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="support/notice#" data-url="https://m.megabox.co.kr">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>






