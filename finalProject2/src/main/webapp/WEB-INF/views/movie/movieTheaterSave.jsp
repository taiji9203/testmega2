<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<script src="/resources/js/movie/movieTheaterSave.js"></script>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->
	
		<div class="container has-lnb">
			<div class="page-util">
				<div class="inner-wrap" id="myLoaction">
					<div class="location">
						<span>Home</span> <a class="no-link">관리자 페이지</a> <a
							class="no-link">영화 상영관 저장</a>
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
							<li class=""><a href="/movieSave">영화</a></li>
							<li class="on"><a href="/movieTheaterSave">상영관</a></li>
							<li class=""><a href="/movieTotalSave">통합저장</a></li>
						</ul>
					</nav>
				</div>
				<div id="myLoactionInfo" style="display: none;">
					<div class="location">
						<span>Home</span> <a href="#">관리자 페이지</a> <a href="#">영화극장
							저장</a>
					</div>
				</div>
				<div id="contents" class="">
					<h2 class="tit">영화 상영관 저장</h2>
					<div class="tit-util mt40 mb10">
						<h3 class="tit">기본정보</h3>
					</div>
					<form action="movieUpload" method="post"
						enctype="multipart/form-data" name="myForm">
						
						<input type="hidden" id="rdToken" value="0" /> 
						<input type="hidden" id="preListsLength" value="0" /> 
						<input type="hidden" id="theaterToken" value="0" /> 
						<input type="hidden" id="preTheaterListsLength" value="0" /> 
						
						<div class="table-wrap mb40">
							<table class="board-form">
								<colgroup>
									<col style="width: 180px;">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="theaterNm_value">영화 상영관</label></th>
										<td><input type="text" id="theaterNm_value"
											name="theaterNm_value" class="input-text w200px"></td>
									</tr>
									<tr>
										<th scope="row"><label>지역</label></th>
										<td><select id="region_value" name="region_value" class="small" style="width:200px;">
												<option value="">지역 선택</option>
												<c:forEach var="dto" items="${regionLists}">
													<option value="${dto.num }">${dto.name }</option>
												</c:forEach>
										</select>
										<button type="button" id="btnRegion" class="button gray w100px ml08" onclick="rdView();">지역상세</button>
										</td>
									</tr>
									<tr>
										<th scope="row"><label>지역상세</label></th>
										<td><select id="rd_value" name="rd_value" class="small" style="width:200px;" disabled="true">
												<option value="">지역상세 선택</option>
										</select>
										</td>
									</tr>	
									<tr>
										<th scope="row"><label for="totalSeat_value">총 좌석 수</label></th>
										<td><input type="number" id="totalSeat_value"
											name="totalSeat_value" class="input-text w200px"></td>
									</tr>								
								</tbody>
							</table>
						</div>
						<div class="btn-group mt40">
							<input type="button" class="button purple large" value="등록" onclick="sendIt();" />
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