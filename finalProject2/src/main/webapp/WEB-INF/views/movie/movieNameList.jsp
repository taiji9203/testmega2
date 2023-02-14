<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	

	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

		<!-- container -->
		<div class="container has-lnb">
			<div class="page-util">
				<div class="inner-wrap">
					<div class="location">
						<span>Home</span> <a href="#">관리자 페이지</a> <a href="#">영화이름 리스트</a>
					</div>

				</div>
			</div>

			<div class="inner-wrap">
				<div class="lnb-area addchat">
					<nav id="lnb">
						<p class="tit">
							<a href="#">관리자 페이지</a>
						</p>
						<ul>
							<li><a href="#"
								title="고객센터 홈">영화이름 리스트</a></li>
						</ul>
					</nav>
				</div>

				<div id="contents" class="">
					<h2 class="tit">영화이름 리스트</h2>
					<div class="board-list-util">
						<p class="result-count">
							<strong>전체 <em class="font-gblue">5,834</em>건
							</strong>
						</p>

						<div class="board-search">
							<input type="text" id="searchTxt" title="검색어를 입력해 주세요."
								placeholder="검색어를 입력해 주세요." class="input-text" value=""
								maxlength="15">
							<button type="button" id="searchBtn" class="btn-search-input">검색</button>
						</div>
					</div>
					<div class="table-wrap">
						<table class="board-list">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">이름</th>
									<th scope="col">관람가</th>
									<th scope="col">이미지파일</th>
									<th scope="col">썸네일파일</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>청라지젤</td>
									<td>공지</td>
									<td>공지</td>
									<td>공지</td>
								</tr>

							</tbody>
						</table>
					</div>

					<!-- pagination -->
					<nav class="pagination">
						<a title="처음 페이지 보기" href="javascript:void(0)"
							class="control first" pagenum="1">first</a> <a
							title="이전 10페이지 보기" href="javascript:void(0)"
							class="control prev" pagenum="1">prev</a> <strong class="active">1</strong>
						<a title="2페이지보기" href="javascript:void(0)" pagenum="2">2</a> <a
							title="3페이지보기" href="javascript:void(0)" pagenum="3">3</a> <a
							title="4페이지보기" href="javascript:void(0)" pagenum="4">4</a> <a
							title="5페이지보기" href="javascript:void(0)" pagenum="5">5</a> <a
							title="6페이지보기" href="javascript:void(0)" pagenum="6">6</a> <a
							title="7페이지보기" href="javascript:void(0)" pagenum="7">7</a> <a
							title="8페이지보기" href="javascript:void(0)" pagenum="8">8</a> <a
							title="9페이지보기" href="javascript:void(0)" pagenum="9">9</a> <a
							title="10페이지보기" href="javascript:void(0)" pagenum="10">10</a> <a
							title="이후 10페이지 보기" href="javascript:void(0)"
							class="control next" pagenum="11">next</a> <a title="마지막 페이지 보기"
							href="javascript:void(0)" class="control last" pagenum="584">last</a>
					</nav>
					<!--// pagination -->
				</div>
			</div>
		</div>
		

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

		
	</div>
	
</body>
</html>