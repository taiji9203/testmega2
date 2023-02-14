<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>

<script src="/resources/js/movie/movieSave.js"></script>
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->
	
		<div class="container has-lnb">
			<div class="page-util">
				<div class="inner-wrap" id="myLoaction">
					<div class="location">
						<span>Home</span> <a class="no-link">관리자 페이지</a> <a
							class="no-link">영화 저장</a>
					</div>
				</div>
			</div>
			<div class="inner-wrap">
				<div class="lnb-area">
					<nav id="lnb">
						<p class="tit">
							<a href="#">영화 관리</a>
						</p>
						<ul>
							<li class="on"><a href="/movieSave">영화</a></li>
							<li class=""><a href="/movieTheaterSave">상영관</a></li>
							<li class=""><a href="/movieTotalSave">통합저장</a></li>
						</ul>
					</nav>
				</div>
				<div id="myLoactionInfo" style="display: none;">
					<div class="location">
						<span>Home</span> <a href="#">관리자 페이지</a> <a href="#">영화 저장</a>
					</div>
				</div>
				<div id="contents" class="">
					<h2 class="tit">영화 저장</h2>
					<div class="tit-util mt40 mb10">
						<h3 class="tit">기본정보</h3>
					</div>
					<form action="movieUpload" method="post"
						enctype="multipart/form-data" name="myForm">
						<div class="table-wrap mb40">
							<table class="board-form">
								<caption>이름, 생년월일, 휴대폰, 이메일, 비밀번호, 주소 항목을 가진 기본정보 표</caption>
								<colgroup>
									<col style="width: 180px;">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="movieNm_value">영화 이름</label></th>
										<td><input type="text" id="movieNm_value"
											name="movieNm_value" class="input-text w200px"></td>
									</tr>
									<tr>
										<th scope="row"><label>관람등급</label></th>
										<td><select name="vcNum" id="ask-type"
											class="small" tabindex="-98">
												<option value="">관람등급 선택</option>
												<c:forEach var="dto" items="${vcLists}">
													<option value="${dto.num }">${dto.hangle }</option>
												</c:forEach>
										</select></td>
									</tr>
									<tr>
										<th scope="row">영화 이미지</th>
										<td>
											<div class="upload-image-box">
												<div class="info-txt">
													<input type="file" class="btn-image-add" name="upload" />
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="btn-group mt40">							
							<input type="button" class="button purple large" value="등록"	onclick="sendIt();" />
							<input type="button" class="button large" value="취소" />
						</div>
					</form>
				</div>
				<!--// container -->
			</div>
		</div>
			
	<!-- footer -->
	<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
    <!-- //footer -->
	</div>
</body>
</html>