<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<script src="/resources/js/megabox.api.min.js"></script>
<script src="/resources/js/booking/booking_1.js"></script>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->
	<!-- loading -->
	<!--<div class="bg-loading">
		<div class="spinner-border" role="status">
			<span class="sr-only">Loading...</span>
		</div>
	</div>-->
		
		<div class="container" style="padding-bottom: 240px;">
			<div class="page-util" style="">
				<div class="inner-wrap">
					<div class="location">
						<span>Home</span> <a href="booking"
							title="예매 페이지로 이동">예매</a> <a
							href="booking" title="빠른예매 페이지로 이동">빠른예매</a>
					</div>
				</div>
			</div>
			<div class="inner-wrap" style="padding-top: 40px; padding-bottom: 100px;">
				<form action="" method="post" name="myForm">
					<input type="hidden" id="rdToken" value="0" />
					<input type="hidden" id="preListsLength" value="0" />
					<input type="hidden" id="mtToken" value="0" /> 
					<input type="hidden" id="preMtListsLength" value="0" />
					<input type="hidden" id="mcToken" value="0" />
					<input type="hidden" id="thToken" value="0" />
					<input type="hidden" id="movieSel" name="movieSel" value="" /> 
					<input type="hidden" id="regionSel" name="regionSel" value="" /> 
					<input type="hidden" id="rdSel" name="rdSel" value="" />
					<input type="hidden" id="daySel" name="daySel" value="${dayWeekList[1].year}.${dayWeekList[1].month}.${dayWeekList[1].day}" />
					<input type="hidden" id="daySel2" name="daySel2" value="${dayWeekList[1].day}" />
					<input type="hidden" id="timeSel" name="timeSel" value="" /> 
					<input type="hidden" id="mtnNum" name="mtnNum" value="" />
					<div class="quick-reserve">
						<div class="tit-util">
							<h2 class="tit">빠른예매</h2>
							<div id="btnLangChg" class="right btn-ticket" style="display: none">
								<button type="button" class="button gray-line" onclick="parent.setLangChg()">English</button>
							</div>
						</div>
						<div class="mege-quick-reserve-inculde">
							<div class="time-schedule quick">
								<div class="wrap">
									<button type="button" title="이전 날짜 보기" class="btn-pre" disabled="true">
										<i class="iconset ico-cld-pre"></i> <em>이전</em>
									</button>
									<div class="date-list">
										<div class="year-area">
											<div class="year" style="left: 30px; z-index: 1; opacity: 1;">${dayWeekList[1].year}.${dayWeekList[1].month}</div>
											<div class="year" style="left: 450px; z-index: 1; opacity: 0;"></div>
										</div>
										<div class="date-area" id="formDeList">
											<div class="wrap"
												style="position: relative; width: 2100px; border: none; left: -70px;">
												<c:forEach var="dto" items="${dayWeekList}" varStatus="status">
													<c:if test="${status.index == 1}">
													<button class="on" type="button" id="day_${dto.day }" date-data="${dto.year }.${dto.month }.${dto.day }" onclick="dateClk(${dto.year },${dto.month },${dto.day });">
													</c:if>
													<c:if test="${status.index != 1}">
													<button class="" type="button" id="day_${dto.day }" date-data="${dto.year }.${dto.month }.${dto.day }" onclick="dateClk(${dto.year },${dto.month },${dto.day });">
													</c:if>
													
														<span class="ir">${dto.year }년 ${dto.month }월</span> <em style="pointer-events: none;">${dto.day }<span style="pointer-events: none;" class="ir">일</span></em> <span class="day-kr" style="pointer-events: none; display: inline-block">${dto.dayOfweek }</span>
													</button>
												</c:forEach>
											</div>
										</div>
									</div>

									<!-- 다음날짜 -->
									<button type="button" title="다음 날짜 보기" class="btn-next" disabled="true">
										<i class="iconset ico-cld-next"></i> <em>다음</em>
									</button>
									<!--// 다음날짜 -->

									<!-- 달력보기 -->
									<div class="bg-line">
										<input type="hidden" id="datePicker" value="2022.04.11" class="hasDatepicker">
										<button type="button" id="calendar" onclick="$('#datePicker').datepicker('show')" class="btn-calendar-large" title="달력보기">달력보기</button>
									</div>
									<!--// 달력보기 -->
								</div>
							</div>
							<div class="quick-reserve-area">
								<div class="movie-choice">
									<p class="tit">영화</p>
									<div class="list-area">
										<div class="all-list">
											<button type="button" class="btn-tab on" id="movieAll">전체</button>
											<div class="list">
												<div class="scroll m-scroll mCustomScrollbar _mCS_1" id="movieList">
													<div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0">
														<div id="mCSB_1_container" class="mCSB_container" style="position: relative; top: 0; left: 0;" dir="ltr">
															<ul>
																<c:forEach var="dto" items="${movieNamelists}">
																	<li><button type="button" class="btn" id="mn_${dto.num }" onclick="mnClk(${dto.num})">
																			<span class="movie-grade small ${dto.tagName }"></span>
																			<i class="iconset ico-heart-small">보고싶어 설정안함</i>
																			<span class="txt">${dto.name }</span>
																		</button></li>
																</c:forEach>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>

									</div>
									<!--// list-area -->

									<!-- view-area -->
									<div class="view-area">

										<!-- 영화 선택 하지 않았을 때 -->
										<div class="choice-all" id="choiceMovieNone" style="display: none;">
											<strong>모든영화</strong> <span>목록에서 영화를 선택하세요.</span>
										</div>
										<div class="choice-list" id="choiceMovieList" style="display: block;">
											<div class="bg" id="mChoice_1"></div>
											<div class="bg" id="mChoice_2"></div>
											<div class="bg" id="mChoice_3"></div>
										</div>
									</div>
								</div>

								<div class="theater-choice">
									<div class="tit-area">
										<p class="tit">극장</p>
									</div>
									<div class="list-area" id="brchTab">
										<div class="all-list">
											<button type="button" class="btn-tab on">전체</button>
											<div class="list">
												<div class="scroll" id="brchList">
													<ul>
														<c:forEach var="dto" items="${regionlists}">
															<li>
																<button type="button" class="btn" id="region_${dto.num }" onclick="regionClk(${dto.num});">
																	<span calss="txt">${dto.name }</span>
																</button>
																<div class="depth on">
																	<div
																		class="detail-list m-scroll area-cd10 mCustomScrollbar _mCS_4">
																		<div id="mCSB_4" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0">
																			<div id="mCSB_4_container" class="mCSB_container" style="position: relative; top: 0; left: 0;" dir="ltr">
																				<ul>
																					<li id="regionDetailPos"></li>
																				</ul>
																			</div>
																		</div>
																	</div>
															</li>
														</c:forEach>
													</ul>
												</div>
											</div>
										</div>

									</div>
									<!--// list-area -->

									<!-- view-area -->
									<div class="view-area">

										<!-- 영화관 선택 하지 않았을 때 -->
										<div class="choice-all" id="choiceBrchNone"
											style="display: none;">
											<strong>전체극장</strong> <span>목록에서 극장을 선택하세요.</span>
										</div>

										<!-- 영화관을 한개라도 선택 했을때 -->
										<div class="choice-list" id="choiceBrchList" style="display: block;">
											<div class="bg" id="thChoice_1"></div>
											<div class="bg" id="thChoice_2"></div>
											<div class="bg" id="thChoice_3"></div>
										</div>
									</div>
								</div>
								<div class="time-choice">
									<div class="tit-area">
										<p class="tit">시간</p>

										<div class="right legend">
											<i class="iconset ico-sun" title="조조"></i> 조조 <i class="iconset ico-brunch" title="브런치"></i> 브런치 <i class="iconset ico-moon" title="심야"></i> 심야
										</div>
									</div>
									<div class="hour-schedule">
										<button type="button" class="btn-prev-time">이전 시간 보기</button>

										<div class="wrap">
											<div class="view" style="position: absolute; width: 1015px; transition: none 0s ease 0s; left: -665px;" id="hour-scheduleView">
												<% for (int i = 0; i < 19; i++) { %> <button type="button" class="hour">00</button> <% } %>
												
												<c:forEach var="timeList" items="${timeList}" varStatus="status">
													<button type="button" class="hour" style="opacity: 0.5;"
														id="time_${timeList }">${timeList }</button>
												</c:forEach>
											</div>
										</div>
										<button type="button" class="btn-next-time">다음 시간 보기</button>
									</div>
									<div class="movie-schedule-area">
										<div class="no-result" id="playScheduleNonList" style="display: none;">
											<i class="iconset ico-movie-time"></i>
											<p class="txt">
												영화와 극장을 선택하시면<br> 상영시간표를 비교하여 볼 수 있습니다.
											</p>
										</div>
										<!-- 영화, 영화관 선택 했을때 -->
										<div class="result">
											<div
												class="scroll m-scroll mCustomScrollbar _mCS_16 mCS_no_scrollbar" id="playScheduleList" style="">
												<div id="mCSB_16" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0">
													<div id="mCSB_16_container" class="mCSB_container mCS_no_scrollbar_y" style="position: relative; top: 0; left: 0;" dir="ltr">
														<ul>
															<li id="movieTimePos"></li>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>

		</div>
		<section id="saw_movie_regi" class="modal-layer"> <a href="booking" class="focus">레이어로 포커스 이동 됨</a> <input type="hidden" id="isLogin" value="Y">
		<div class="wrap">
			<header class="layer-header">
			<h3 class="tit">본 영화 등록</h3>
			</header>

			<div class="layer-con">
				<p class="reset">발권하신 티켓 하단의 거래번호 또는 예매번호를 입력해주세요.</p>

				<div class="pop-gray mt10 mb30">
					<label for="movie_regi" class="mr10">거래번호 또는 예매번호</label> 
					<input type="text" id="movie_regi" class="input-text w280px numType" maxlength="20" placeholder="숫자만 입력해 주세요" title="티켓 거래번호 입력">
					<button class="button gray ml05" id="regBtn">등록</button>
				</div>

				<div class="box-border v1 mt30">
					<p class="tit-box">이용안내</p>

					<ul class="dot-list">
						<li>극장에서 예매하신 내역을 본 영화(관람이력)로 등록하실 수 있습니다.</li>
						<li>예매처를 통해 예매하신 고객님은 극장에서 발권하신 티켓 하단의 온라인 예매번호 <br>12자리를
							입력해주세요.(Yes24, 네이버, 인터파크, SKT, KT, 다음)
						</li>
						<li>본 영화 등록은 관람인원수 만큼 등록가능하며, 동일 계정에 중복등록은 불가합니다.</li>
						<li>상영시간 종료 이후 등록 가능합니다.</li>
						<li>본 영화로 수동 등록한 내역은 이벤트 참여 및 포인트 추후 적립이 불가합니다.</li>
					</ul>
				</div>
			</div>

			<div class="btn-group-fixed">
				<button type="button" class="button purple close-layer">닫기</button>
			</div>

			<button type="button" class="btn-modal-close">레이어 닫기</button>
		</div>
		</section>

		<div class="quick-area">
			<a href="booking" class="btn-go-top"
				title="top">top</a>
		</div>


	<!-- footer -->
	<jsp:include page="../layout/footer.jsp"></jsp:include>
    <!-- //footer -->
	</div>
</body>
</html>