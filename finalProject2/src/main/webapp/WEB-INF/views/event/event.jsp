<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->
<script type="text/javascript">

var loginPopupCallScn = "MySbscDtlsL";		  //로그인 레이어 팝업 띄울때 필요한 PARAM

//이벤트 리스트 기본값
var paramData = { currentPage        : '1'
				, recordCountPerPage : '1000'
				, eventStatCd        : 'ONG'
				, eventTitle         : ''
				, eventDivCd         : ''
	            , eventTyCd          : ''
				, orderReqCd         : 'ONGlist'
				};

var _init = {
	cache	: Date.now(),
	path	: '../../../static/pc/js/'
};

$(function(){
	if( $('.event-swiper').length > 0 ){
		var event_swiper = new Swiper('.event-swiper', {
			autoplay: {
				delay: 3000,
				disableOnInteraction: true,
			},
			loop : true,
			slidesPerView: 2,
			spaceBetween: 40,
			pagination: {
				el: '.event-pagination',
				//type: 'fraction',
				clickable: false,
			},
			navigation : {
				prevEl : '.event-prev',
				nextEl : '.event-next',
			},
			ally : {
				enabled : true
			}
		});

		// swiper 전체 count
		all_count = $('.event-swiper .cell').length;
		dupli_count = $('.event-swiper .swiper-slide-duplicate').length;
		real_count = all_count - dupli_count;

		if('6' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
		$('.event-slider .event-count .total').text(real_count)

		// 이벤트 배너 1개 이하일 경우 좌우 버튼 숨기기
		if(real_count < 2 ){

			$('.event-prev').hide();
			$('.event-next').hide();

			$('.swiper-slide-duplicate').hide(); //스와이프용 duplicate 이미지 숨기기
		}

		// 현재 활성화된 swiper
		event_swiper.on('slideChange', function(){
			if('6' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
		});

		// 자동실행 정지
		$('.event-util .pause').on('click', function(){
			event_swiper.autoplay.stop();

			$(this).removeClass('on');
			$('.event-util .play').addClass('on').focus();
		});

		// 자동실행 시작
		$('.event-util .play').on('click', function(){
			event_swiper.autoplay.start();

			$(this).removeClass('on');
			$('.event-util .pause').addClass('on').focus();
		});

		// 좌우 이동시 자동실행 정지됨
		$(document).on('click','.event-prev, .event-next', function(){
			$('.event-util .pause').removeClass('on');
			$('.event-util .play').addClass('on');
		});

		// 포커스 됐을때 정지
		/* $('.event-swiper .cell a').on({
			focus : function(){
				event_swiper.autoplay.stop();
			}
		}); */

		// 마우스 오버시 정지
		/* $('.event-swiper').on({
			mouseenter : function(){
				event_swiper.autoplay.stop();
				$('.event-util .pause').removeClass('on');
				$('.event-util .play').addClass('on');
			}
		}); */

		$(window).resize(function(){
			event_swiper.update();
		}).resize();
	}

	//로그인 전 로그인 버튼
	$(document).on('click', '#moveLogin', function() {

		fn_viewLoginPopup('default','pc');
	});

	// 검색
	$(".board-search").children().on({
		click : function(e){
			if($(this).is('button')) fn_searchTitle();
		}
		,keydown : function(e){
			if(e.keyCode != 13) return;
			if($(this).is('input')) fn_searchTitle();
		}
	});

	// 더보기
	$('.btn-more').on('click', function(){

		// 페이지 계산
		paramData.currentPage = (parseInt(paramData.currentPage)+1) + '';

		// 이벤트 목록 조회
		fn_searchEventList();
	});

	// 이벤트 리스트 조회
	$(document).ready(function(){
		fn_chgEventTab('');
	});

	// 이벤트 유형별 조회
	// $('#toptablist li').on('click', function () {
	// 	$('#toptablist li').removeClass('on');
	// 	$(this).addClass('on');
	//
	// 	// 기본값 설정
	// 	paramData.currentPage = '1';
	// 	paramData.eventTyCd = $(this).data('cd');
	//
	// 	fn_searchEventList();
	// });
});

/* 이벤트 타이틀 */
function fn_chgEventTab(cdId){

	// 기본값 설정
	paramData.currentPage = '1';
	paramData.eventTitle  = '';
	paramData.eventDivCd  = cdId;

	   // 검색 초기화
    //$(".board-search input").val('');

	var searchText = '';

    if (searchText == null || searchText == 'null' || searchText == 'undefined' || searchText == '') {
        $('.board-search input').val('');
    } else {
        $('.board-search input').val(searchText);
    }

	// 이벤트 목록 조회
	fn_searchEventList();

	if(cdId == 'CED01') {
		$.ajaxMegaBox({
			dataType      : 'json',
			type		  : "POST",
			contentType   : 'application/json;charset=UTF-8',
			url           : '/on/oh/ohe/Event/selectEventTyCdList.do',
			data          : JSON.stringify({ grpCd:cdId}),
			success       : function (data, textStatus, jqXHR) {
				var $obj = $('#toptablist');
				var toptabHtml = '';
				toptabHtml += '<ul> <li class="on"><a href="javascript:void(0);">전체</a></li>';

				$.each(data.eventTyCdList, function(i, v) {
					toptabHtml += '<li data-cd="'+v.cdId+'"><a href="javascript:void(0);">'+v.cdNm+'</a></li>';
				});
				toptabHtml += '</ul>';
				$obj.html(toptabHtml);
				$('#toptablist').removeClass('display-none');

				// 이벤트 유형별 조회
				$('#toptablist li').on('click', function () {
					$('#toptablist li').removeClass('on');
					$(this).addClass('on');

					// 기본값 설정
					paramData.currentPage = '1';
					paramData.eventTyCd = $(this).data('cd');

					fn_searchEventList();
				});
			},
			error: function(xhr,status,error) {
				var err = JSON.parse(xhr.responseText);
				alert(xhr.status);
				alert(err.message);
			}
		});
	} else {
		$('#toptablist').addClass('display-none');
	}

	$(".tab-list ul li").attr('class','');

	// 메인 노출영역변경
	switch(cdId){
	case ''        :
	case undefined :
		$('#divTopArea').show();
		$('#eventTab_').attr('class','on');
		break;
	default        :
		$('#divTopArea').hide();
		$('#eventTab_'+cdId).attr('class','on');
	}
}

/* 이벤트 검색 목록 조회 */
function fn_searchTitle(){
	// 기본값 설정
	paramData.currentPage = '1';
	paramData.eventTitle  = $('.board-search input').val();

	var tState ={'searchText': paramData.eventTitle };
	var pageUrl = '?';
	for(var key in tState){
		pageUrl = pageUrl + key+'='+tState[key];
	}

	window.history.pushState(tState, null, pageUrl);

	// 이벤트 목록 조회
	fn_searchEventList();
}

/* 이벤트 목록 조회 */
function fn_searchEventList(){

	if (paramData.eventStatCd == 'ONG') {
		paramData.recordCountPerPage = '1000';
	} else if (paramData.eventStatCd == 'END') {
		paramData.recordCountPerPage = '12';
	}
    paramData.eventTitle  = $('.board-search input').val();

	$.ajaxMegaBox({
		dataType      : 'html',
		contentType   : 'application/json;charset=UTF-8',
		url           : '/on/oh/ohe/Event/eventMngDiv.do',
		data          : JSON.stringify(paramData),
		success       : function (data, textStatus, jqXHR) {
			var $obj = $('#event-list-wrap');

			// 목록 추가
			if(paramData.currentPage == '1'){
				$obj.html(data);
			}else{
				$obj.append(data);
			}

			// 더보기 노출 변경
			if (paramData.eventStatCd == 'END') {
				if($('[name=totCount]:last').val() > $obj.find('li').length){
					$('.btn-more').show();
				}else{
					$('.btn-more').hide();
				}
			}

			if (paramData.eventStatCd == 'END' || (paramData.eventStatCd == 'ONG' && paramData.eventDivCd != null && paramData.eventDivCd != '')) {
				$('#boardSearch').show();

				var totCount = $('#totCount').val();

				if (totCount == null || totCount == '') {
					totCount = 0;
				}

				var resultCount = "<strong>전체 <b>" + numberFormat(totCount) + "</b>건</strong>";
				$(".result-count").html(resultCount);
			}else{
				$('#boardSearch').hide();
			}
		},
		error: function(xhr,status,error) {
			var err = JSON.parse(xhr.responseText);
			alert(xhr.status);
			alert(err.message);
		}
	});
}

/* 이벤트 탭 이동 */
function fn_eventTabMove(cdId){

    var $eventForm = $("#eventForm");
    var contentUrl = "";
    //$('[name=eventDivCd]').val(cdId);
    //$('[name=tabDivCd]').val(cdId);

    switch(cdId){
    case ''        : contentUrl = "#";      break;
    case 'CED01'   : contentUrl = "#";     break;
    case 'CED02'   : contentUrl = "#";   break;
    case 'CED03'   : contentUrl = "#";      break;
    case 'CED04'   : contentUrl = "#";   break;
    case 'CED05'   : contentUrl = "#";        break;


    }

    $eventForm.attr("action",contentUrl);
    $eventForm.submit();
}

/* 당첨자발표 상세 이동 */
function fn_movePrwinAnunDtl(eventNo){
	var $eventForm = $("#eventDtlForm");
	var contentUrl = "/event/winner/detail";

	$eventForm.attr("action",contentUrl);
	$eventForm.attr("method","get");
	$eventForm.append("<input type='hidden' name='eventNo' value='" + eventNo + "' />");

	//$eventForm.append("<input type='hidden' name='callBackPage' value='/on/oh/ohe/Event/eventMngMain.do?eventStatCd=END'/>");

// 	$eventForm.append("<input type='hidden' name='callBackPage' value='/event/end?a='/>");
	$("#searchText").val($('.board-search input').val());
	$eventForm.submit();

}

//로그인 페이지 이동
function fn_moveLoginPage() {
	$('[name=menuId]').val('MySbscDtlsL');
	$('[name=mappingId]').val('/mypage/myevent?currPage=1&searchText=');

	var form = $('#loginForm');
	form.attr('action', '/on/oh/ohg/MbLogin/viewMbLoginMainPage.rest');
	form.submit();

	//fn_viewLoginPopup('MySbscDtlsL','pc');
}

//*천단위 콤마
function numberFormat(inputNumber) {
	if(inputNumber > 0){
		return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}else{
		return inputNumber;
	}

}

</script>
<form id="eventForm" name="eventForm" method="post">
    <input type="hidden" name="currentPage" value="1">
    <input type="hidden" name="recordCountPerPage" value="1000">
    <input type="hidden" name="eventStatCd" value="ONG">
    <input type="hidden" name="eventTitle">
</form>

<form id="eventDtlForm" name="eventForm" method="post">
<input type="hidden" name="searchText" id="searchText">
</form>

<form id="loginForm" method="post">
	<input type="hidden" name="menuId">
	<input type="hidden" name="mappingId">
</form>

<!-- container -->
<div class="container">

	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="#" onclick="#" title="이벤트 메인 페이지로 이동">이벤트</a>

				
					<a href="#" onclick="#" title="진행중 이벤트 페이지로 이동">진행중 이벤트</a>
				

				
			</div>

			
		</div>
	</div>

	<div id="contents">

		<div class="inner-wrap">
			
				<h2 class="tit">진행중인 이벤트</h2>

				<div class="tab-list fixed">
					<ul>
						<!-- li class="on" id="eventTab_"><a href="javascript:fn_chgEventTab('')">전체</a></li-->
						<li class="on" id="eventTab_"><a href="/event/event" title="전체">전체</a></li>
						
							<!--  li id="eventTab_CED03"><a href="javascript:fn_chgEventTab('CED03')">메가Pick</a></li-->
							<li id="eventTab_CED03" class=""><a href="/event/eventMegabox" title="메가Pick 탭으로 이동">메가Pick</a></li>
						
							<!--  li id="eventTab_CED01"><a href="javascript:fn_chgEventTab('CED01')">영화</a></li-->
							<li id="eventTab_CED01" class=""><a href="/event/eventMovie" title="영화 탭으로 이동">영화</a></li>
						
							<!--  li id="eventTab_CED02"><a href="javascript:fn_chgEventTab('CED02')">극장</a></li-->
							<li id="eventTab_CED02" class=""><a href="/event/eventTheater" title="극장 탭으로 이동">극장</a></li>
						
							<!--  li id="eventTab_CED05"><a href="javascript:fn_chgEventTab('CED05')">제휴/할인</a></li-->
							<li id="eventTab_CED05" class=""><a href="/event/eventPromotion" title="제휴/할인 탭으로 이동">제휴/할인</a></li>
						
							<!--  li id="eventTab_CED04"><a href="javascript:fn_chgEventTab('CED04')">시사회/무대인사</a></li-->
							<li id="eventTab_CED04" class=""><a href="/event/eventCurtaincall" title="시사회/무대인사 탭으로 이동">시사회/무대인사</a></li>
						
					</ul>
				</div>

				<div id="toptablist" class="toptablist display-none">
				</div>











			
			
		</div>

		
			<div id="divTopArea" class="event-slider">
				<div class="inner-wrap">

					<p class="name">추천 이벤트</p>

					<div class="event-pagination swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span></div>

					<div class="event-count">
						<span title="현재 페이지" class="active">6</span> /
						<span title="전체 페이지" class="total">6</span>
					</div>

					<div class="event-util">
						<button type="button" class="event-prev" tabindex="0" role="button" aria-label="Previous slide">이전 이벤트 보기</button>
						<button type="button" class="event-next" tabindex="0" role="button" aria-label="Next slide">다음 이벤트 보기</button>
						<button type="button" class="pause on">일시정지</button>
						<button type="button" class="play">자동재생</button>
					</div>

					<div class="event-control">
						<button type="button" class="event-prev" tabindex="0" role="button" aria-label="Previous slide">이전 이벤트 보기</button>
						<button type="button" class="event-next" tabindex="0" role="button" aria-label="Next slide">다음 이벤트 보기</button>
					</div>
				</div>

				<div class="event-swiper swiper-container-initialized swiper-container-horizontal">
					<div class="swiper-wrapper" style="transform: translate3d(-3990px, 0px, 0px); transition-duration: 0ms;"><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" data-swiper-slide-index="4" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="12624" data-netfunnel="N" class="eventBtn" title="&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫  상세보기">
									
									<p class="img"><img src="/resources/event/Vnd3lcOxo7YPIQ3YoN0EF8izzM565ni2.jpg" alt="&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫 " onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫 </p>
										<p class="date">2023.02.07 ~ 2023.02.19</p>
									</div>
								</a>

							</div><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="5" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="11263" data-netfunnel="N" class="eventBtn" title="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요! 상세보기">
									
									<p class="img"><img src="/resources/event/HmcDZ2pEwgwyYTNCKXJxU0WKdDOOOENG.jpg" alt="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!</p>
										<p class="date">2022.04.18 ~ 2023.12.31</p>
									</div>
								</a>

							</div>
						<!-- 반복 -->
						
							<div class="cell swiper-slide swiper-slide-duplicate-next" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="12553" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판 상세보기">
									
									<p class="img"><img src="/resources/event/5cPQ7RnaFh8uXdWOswzLGiiXz3XZDHaC.jpg" alt="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판</p>
										<p class="date">2023.02.19 ~ 2023.02.19</p>
									</div>
								</a>

							</div>
						
							<div class="cell swiper-slide" data-swiper-slide-index="1" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="12392" data-netfunnel="N" class="eventBtn" title="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자! 상세보기">
									
									<p class="img"><img src="/resources/event/iFpskcjm9wzchFEmLxHd9nmyUrEPdwTq.png" alt="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!</p>
										<p class="date">2022.12.23 ~ 2023.03.05</p>
									</div>
								</a>

							</div>
						
							<div class="cell swiper-slide" data-swiper-slide-index="2" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="11739" data-netfunnel="N" class="eventBtn" title="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트 상세보기">
									
									<p class="img"><img src="/resources/event/iFnmkKFpZXrfGUAG6f2XvrELUL9DDF8A.jpg" alt="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트</p>
										<p class="date">2022.08.22 ~ 2023.02.28</p>
									</div>
								</a>

							</div>
						
							<div class="cell swiper-slide" data-swiper-slide-index="3" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="9187" data-netfunnel="N" class="eventBtn" title="U+멤버십 고객 영화 2,000원 할인 상세보기">
									
									<p class="img"><img src="/resources/event/poxTnLz5oVfwTJlW6TINBrEKv3jP2GIJ.jpg" alt="U+멤버십 고객 영화 2,000원 할인" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">U+멤버십 고객 영화 2,000원 할인</p>
										<p class="date">2021.02.01 ~ 2023.12.31</p>
									</div>
								</a>

							</div>
						
							<div class="cell swiper-slide swiper-slide-prev" data-swiper-slide-index="4" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="12624" data-netfunnel="N" class="eventBtn" title="&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫  상세보기">
									
									<p class="img"><img src="/resources/event/Vnd3lcOxo7YPIQ3YoN0EF8izzM565ni2.jpg" alt="&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫 " onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫 </p>
										<p class="date">2023.02.07 ~ 2023.02.19</p>
									</div>
								</a>

							</div>
						
							<div class="cell swiper-slide swiper-slide-active" data-swiper-slide-index="5" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="11263" data-netfunnel="N" class="eventBtn" title="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요! 상세보기">
									
									<p class="img"><img src="/resources/event/HmcDZ2pEwgwyYTNCKXJxU0WKdDOOOENG.jpg" alt="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!</p>
										<p class="date">2022.04.18 ~ 2023.12.31</p>
									</div>
								</a>

							</div>
						
					<div class="cell swiper-slide swiper-slide-duplicate swiper-slide-next" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="12553" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판 상세보기">
									
									<p class="img"><img src="/resources/event/5cPQ7RnaFh8uXdWOswzLGiiXz3XZDHaC.jpg" alt="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판</p>
										<p class="date">2023.02.19 ~ 2023.02.19</p>
									</div>
								</a>

							</div><div class="cell swiper-slide swiper-slide-duplicate" data-swiper-slide-index="1" style="width: 530px; margin-right: 40px;">
								<a href="/event#" data-no="12392" data-netfunnel="N" class="eventBtn" title="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자! 상세보기">
									
									<p class="img"><img src="/resources/event/iFpskcjm9wzchFEmLxHd9nmyUrEPdwTq.png" alt="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!</p>
										<p class="date">2022.12.23 ~ 2023.03.05</p>
									</div>
								</a>

							</div></div>
				<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
			</div>
		

		<div id="boardSearch" class="inner-wrap" style="display:none">
			

			
				<div class="board-list-util mt40">
			

				<p class="result-count"></p>

				<div class="board-search">
					<input type="text" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text">
					<button type="button" class="btn-search-input">검색</button>
				</div>
			</div>
		</div>

		<div id="event-list-wrap">


	<div class="inner-wrap">
		


		

			
				
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
                        
				<div class="tit-util mt70">
					<h3 class="tit">메가Pick</h3>
					<div class="right">
						<a href="javascript:fn_chgEventTab(&#39;CED03&#39;)" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml05"></i></a>
					</div>
				</div>
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				

				<div class="event-list mt15">
				
                    <ul>
					

					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12624" data-netfunnel="N" class="eventBtn" title="&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫  상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/18JLZUfedJAoy8C4i8Ir934l5g9k1lKI.jpg" alt="&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫 " onerror="noImg(this);"></p>

										<p class="tit">
											&lt;타이타닉: 25주년&gt; 행운의 25명은? 100P 럭키티켓🎫 
										</p>

										<p class="date">
											2023.02.07 ~ 2023.02.19
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12621" data-netfunnel="N" class="eventBtn" title="메가박스 오리지널 티켓 Re.15 &lt;타이타닉&gt; 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/diI0p38TtHFat6pQIddG3V0HD4aJaIgM.jpg" alt="메가박스 오리지널 티켓 Re.15 &lt;타이타닉&gt;" onerror="noImg(this);"></p>

										<p class="tit">
											메가박스 오리지널 티켓 Re.15 &lt;타이타닉&gt;
										</p>

										<p class="date">
											2023.02.06 ~ 2023.03.06
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12593" data-netfunnel="N" class="eventBtn" title="모바일오더로 주문하면 선물이 팡팡! 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/K47oASJFTl3GLN63FL3Wfs7v1jTPam6o.jpg" alt="모바일오더로 주문하면 선물이 팡팡!" onerror="noImg(this);"></p>

										<p class="tit">
											모바일오더로 주문하면 선물이 팡팡!
										</p>

										<p class="date">
											2023.02.01 ~ 2023.03.31
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12579" data-netfunnel="N" class="eventBtn" title="황홀하지만, 위태로운 &lt;바빌론&gt; 1PICK 이벤트 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/ZkTG10NtwqduBiOQ3JVkAA9qv0HqCZfB.jpg" alt="황홀하지만, 위태로운 &lt;바빌론&gt; 1PICK 이벤트" onerror="noImg(this);"></p>

										<p class="tit">
											황홀하지만, 위태로운 &lt;바빌론&gt; 1PICK 이벤트
										</p>

										<p class="date">
											2023.02.01 ~ 2023.02.21
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
                    </ul>
                
				</div>

			
				
				
				  
                        
				<div class="tit-util mt70">
					<h3 class="tit">영화</h3>
					<div class="right">
						<a href="javascript:fn_chgEventTab(&#39;CED01&#39;)" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml05"></i></a>
					</div>
				</div>
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				

				<div class="event-list mt15">
				
                    <ul>
					

					
						
							
								<li>
									<a href="/event#" data-no="12552" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 강연 안내 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/gU6vjNjCCIiwDHJuGRHbwBzG65pa39I1.jpg" alt="[2023 사건 읽는 영화관] 강연 안내" onerror="noImg(this);"></p>

										<p class="tit">
											[2023 사건 읽는 영화관] 강연 안내
										</p>

										<p class="date">
											2023.02.19 ~ 2024.02.18
										</p>
									</a>
								</li>
						
					
						
							
								<li>
									<a href="/event#" data-no="12553" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/TherDqa6keDedqcvozSfjYiRfjEZiVD8.jpg" alt="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판" onerror="noImg(this);"></p>

										<p class="tit">
											[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판
										</p>

										<p class="date">
											2023.02.19 ~ 2023.02.19
										</p>
									</a>
								</li>
						
					
						
							
								<li>
									<a href="/event#" data-no="12618" data-netfunnel="N" class="eventBtn" title="&lt;어메이징 모리스&gt; 관람인증 이벤트 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/zOGo2UxmPCDHmFtutr45G1UDmkGqWQGm.jpg" alt="&lt;어메이징 모리스&gt; 관람인증 이벤트" onerror="noImg(this);"></p>

										<p class="tit">
											&lt;어메이징 모리스&gt; 관람인증 이벤트
										</p>

										<p class="date">
											2023.02.15 ~ 2023.02.28
										</p>
									</a>
								</li>
						
					
						
							
								<li>
									<a href="/event#" data-no="12616" data-netfunnel="N" class="eventBtn" title="[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 개봉 기념 현장증정 이벤트 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/8uAIpqawh1RRUry1FboZqH3O2k0rfwEg.jpg" alt="[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 개봉 기념 현장증정 이벤트" onerror="noImg(this);"></p>

										<p class="tit">
											[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 개봉 기념 현장증정 이벤트
										</p>

										<p class="date">
											2023.02.13 ~ 2023.03.05
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
                    </ul>
                
				</div>

			
				
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
                        
				<div class="tit-util mt70">
					<h3 class="tit">극장</h3>
					<div class="right">
						<a href="javascript:fn_chgEventTab(&#39;CED02&#39;)" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml05"></i></a>
					</div>
				</div>
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				

				<div class="event-list mt15">
				
                    <ul>
					

					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12596" data-netfunnel="N" class="eventBtn" title="[부산경남지역] 인제대학교 재학생, 교직원 할인 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/YYiRRxjbvxhbfqxA7fdJ2IA3W4UK9qEE.jpg" alt="[부산경남지역] 인제대학교 재학생, 교직원 할인" onerror="noImg(this);"></p>

										<p class="tit">
											[부산경남지역] 인제대학교 재학생, 교직원 할인
										</p>

										<p class="date">
											2023.02.01 ~ 2024.01.31
										</p>
									</a>
								</li>
						
					
						
							
								<li>
									<a href="/event#" data-no="12600" data-netfunnel="N" class="eventBtn" title="[킨텍스] 킨텍스점 전용 관람권 할인! 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/jSB2S9LIcwGca2cEFskMSgIbVn2bhzuZ.jpg" alt="[킨텍스] 킨텍스점 전용 관람권 할인!" onerror="noImg(this);"></p>

										<p class="tit">
											[킨텍스] 킨텍스점 전용 관람권 할인!
										</p>

										<p class="date">
											2023.02.01 ~ 2023.12.31
										</p>
									</a>
								</li>
						
					
						
							
								<li>
									<a href="/event#" data-no="12597" data-netfunnel="N" class="eventBtn" title="[강남] 강남점 전용 관람권 패키지 특가 한정 판매! 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/wLuaoRwCwO8CZImjsLjIoc0CivqBjVOF.jpg" alt="[강남] 강남점 전용 관람권 패키지 특가 한정 판매!" onerror="noImg(this);"></p>

										<p class="tit">
											[강남] 강남점 전용 관람권 패키지 특가 한정 판매!
										</p>

										<p class="date">
											2023.02.01 ~ 2023.12.31
										</p>
									</a>
								</li>
						
					
						
							
								<li>
									<a href="/event#" data-no="12564" data-netfunnel="N" class="eventBtn" title="[정관] 당첨률 100%! 영화보고 관람권 받자! 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/KKF9Fd4S9ivMi31Yb9ErRnEl2hVO489O.jpg" alt="[정관] 당첨률 100%! 영화보고 관람권 받자!" onerror="noImg(this);"></p>

										<p class="tit">
											[정관] 당첨률 100%! 영화보고 관람권 받자!
										</p>

										<p class="date">
											2023.02.01 ~ 2023.03.31
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
                    </ul>
                
				</div>

			
				
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				

				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
                        
				<div class="tit-util mt70">
					<h3 class="tit">제휴/할인</h3>
					<div class="right">
						<a href="javascript:fn_chgEventTab(&#39;CED05&#39;)" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml05"></i></a>
					</div>
				</div>
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				

				<div class="event-list mt15">
				
                    <ul>
					

					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="11739" data-netfunnel="N" class="eventBtn" title="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/Xrp5Tofqsk1VhCZhJKfyuUjmtO9nVbVi.jpg" alt="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트" onerror="noImg(this);"></p>

										<p class="tit">
											[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트
										</p>

										<p class="date">
											2022.08.22 ~ 2023.02.28
										</p>
									</a>
								</li>
						
					
						
							
								<li>
									<a href="/event#" data-no="11263" data-netfunnel="N" class="eventBtn" title="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요! 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/hJ4pNRGMutomAaucRjyj0ganFC3yUGOg.jpg" alt="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!" onerror="noImg(this);"></p>

										<p class="tit">
											내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!
										</p>

										<p class="date">
											2022.04.18 ~ 2023.12.31
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12392" data-netfunnel="N" class="eventBtn" title="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자! 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/anLN8vsd0zV3ZO8L8UVo9jFQFbJO3d7m.png" alt="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!" onerror="noImg(this);"></p>

										<p class="tit">
											[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!
										</p>

										<p class="date">
											2022.12.23 ~ 2023.03.05
										</p>
									</a>
								</li>
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="8865" data-netfunnel="N" class="eventBtn" title="[메가박스X현대카드] 현대M포인트 금토일 5,000원 할인! 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/iaqx1sdAqvW8HLxO5Rsevdh08yYPdoDn.jpg" alt="[메가박스X현대카드] 현대M포인트 금토일 5,000원 할인!" onerror="noImg(this);"></p>

										<p class="tit">
											[메가박스X현대카드] 현대M포인트 금토일 5,000원 할인!
										</p>

										<p class="date">
											2020.10.29 ~ 2023.12.31
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
                    </ul>
                
				</div>

			
				
				
				  
				
				  
				
				  
				
				  
				
				  
                        
				<div class="tit-util mt70">
					<h3 class="tit">시사회/무대인사</h3>
					<div class="right">
						<a href="javascript:fn_chgEventTab(&#39;CED04&#39;)" title="더보기">더보기 <i class="iconset ico-arr-right-gray ml05"></i></a>
					</div>
				</div>
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				
				  
				

				<div class="event-list mt15">
				
                    <ul>
					

					
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12623" data-netfunnel="N" class="eventBtn" title="&lt;서치 2&gt; 다니엘 헤니 무대인사 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/djkhMh9BYEzBOrfZSCH2WV4KNi3JVcW9.jpg" alt="&lt;서치 2&gt; 다니엘 헤니 무대인사" onerror="noImg(this);"></p>

										<p class="tit">
											&lt;서치 2&gt; 다니엘 헤니 무대인사
										</p>

										<p class="date">
											2023.02.12 ~ 2023.02.12
										</p>
									</a>
								</li>
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12606" data-netfunnel="N" class="eventBtn" title="&lt;다음 소희&gt; 개봉기념 무대인사 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/BVmYozU9mGsFd7tbQhnGNC6A5h8cocfz.jpg" alt="&lt;다음 소희&gt; 개봉기념 무대인사" onerror="noImg(this);"></p>

										<p class="tit">
											&lt;다음 소희&gt; 개봉기념 무대인사
										</p>

										<p class="date">
											2023.02.11 ~ 2023.02.11
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12603" data-netfunnel="N" class="eventBtn" title="&lt;카운트&gt; 메가박스 회원 시사회 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/PcKfqYMunXRzUgivxa3YEpvuGKLhCmCc.png" alt="&lt;카운트&gt; 메가박스 회원 시사회" onerror="noImg(this);"></p>

										<p class="tit">
											&lt;카운트&gt; 메가박스 회원 시사회
										</p>

										<p class="date">
											2023.02.01 ~ 2023.02.08
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
					
						
							
								<li>
									<a href="/event#" data-no="12574" data-netfunnel="N" class="eventBtn" title="&lt;서치 2&gt; 메가박스 회원 시사회 상세보기">
										<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
										<p class="img"> <img src="/resources/event/9M0RWjHwm7P5vqOdNxknKBWNXHFcRvs5.jpg" alt="&lt;서치 2&gt; 메가박스 회원 시사회" onerror="noImg(this);"></p>

										<p class="tit">
											&lt;서치 2&gt; 메가박스 회원 시사회
										</p>

										<p class="date">
											2023.01.30 ~ 2023.02.12
										</p>
									</a>
								</li>
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					

						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
						
					
                    </ul>
                
				</div>

			
		
	</div>

</div>


		
	</div>
</div>
<!--// container -->

<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/event" class="focus">레이어로 포커스 이동 됨</a>
	<input type="hidden" id="isLogin">
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
                        <li>예매처를 통해 예매하신 고객님은 극장에서 발권하신 티켓 하단의 온라인 예매번호 <br>12자리를 입력해주세요.(Yes24, 네이버, 인터파크, SKT, KT, 다음)</li>
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
	<a href="/event" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/event/curtaincall#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>