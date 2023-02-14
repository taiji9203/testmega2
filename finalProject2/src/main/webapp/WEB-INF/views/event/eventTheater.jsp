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

		if('0' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
		$('.event-slider .event-count .total').text(real_count)

		// 이벤트 배너 1개 이하일 경우 좌우 버튼 숨기기
		if(real_count < 2 ){

			$('.event-prev').hide();
			$('.event-next').hide();

			$('.swiper-slide-duplicate').hide(); //스와이프용 duplicate 이미지 숨기기
		}

		// 현재 활성화된 swiper
		event_swiper.on('slideChange', function(){
			if('0' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
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
		fn_chgEventTab('CED02');
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
    case ''        : contentUrl = "/event";      break;
    case 'CED01'   : contentUrl = "/event/movie";     break;
    case 'CED02'   : contentUrl = "/event/theater";   break;
    case 'CED03'   : contentUrl = "/event/megabox";      break;
    case 'CED04'   : contentUrl = "/event/curtaincall";   break;
    case 'CED05'   : contentUrl = "/event/promotion";        break;


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
				<a href="javascript:void(0)" onclick="NetfunnelChk.aTag(&#39;EVENT_LIST&#39;,&#39;/event&#39;);return false;" title="이벤트 메인 페이지로 이동">이벤트</a>

				
					<a href="javascript:void(0)" onclick="NetfunnelChk.aTag(&#39;EVENT_LIST&#39;,&#39;/event&#39;);return false;" title="진행중 이벤트 페이지로 이동">진행중 이벤트</a>
				

				
			</div>

			
		</div>
	</div>

	<div id="contents">

		<div class="inner-wrap">
			
				<h2 class="tit">진행중인 이벤트</h2>

				<div class="tab-list fixed">
					<ul>
						<!-- li class="on" id="eventTab_"><a href="javascript:fn_chgEventTab('')">전체</a></li-->
						<li id="eventTab_" class=""><a href="/event/event" title="전체">전체</a></li>
						
							<!--  li id="eventTab_CED03"><a href="javascript:fn_chgEventTab('CED03')">메가Pick</a></li-->
							<li id="eventTab_CED03" class=""><a href="/event/eventMegabox" title="메가Pick 탭으로 이동">메가Pick</a></li>
						
							<!--  li id="eventTab_CED01"><a href="javascript:fn_chgEventTab('CED01')">영화</a></li-->
							<li id="eventTab_CED01" class=""><a href="/event/eventMovie" title="영화 탭으로 이동">영화</a></li>
						
							<!--  li id="eventTab_CED02"><a href="javascript:fn_chgEventTab('CED02')">극장</a></li-->
							<li id="eventTab_CED02" class="on"><a href="/event/eventTheater" title="극장 탭으로 이동">극장</a></li>
						
							<!--  li id="eventTab_CED05"><a href="javascript:fn_chgEventTab('CED05')">제휴/할인</a></li-->
							<li id="eventTab_CED05" class=""><a href="/event/eventPromotion" title="제휴/할인 탭으로 이동">제휴/할인</a></li>
						
							<!--  li id="eventTab_CED04"><a href="javascript:fn_chgEventTab('CED04')">시사회/무대인사</a></li-->
							<li id="eventTab_CED04" class=""><a href="/event/eventCurtaincall" title="시사회/무대인사 탭으로 이동">시사회/무대인사</a></li>
						
					</ul>
				</div>

				<div id="toptablist" class="toptablist display-none">
				</div>











			
			
		</div>

		
			<div id="divTopArea" class="event-slider" style="display: none;">
				<div class="inner-wrap">

					<p class="name">추천 이벤트</p>

					<div class="event-pagination swiper-pagination-bullets"></div>

					<div class="event-count">
						<span title="현재 페이지" class="active">0</span> /
						<span title="전체 페이지" class="total">0</span>
					</div>

					<div class="event-util">
						<button type="button" class="event-prev" tabindex="0" role="button" aria-label="Previous slide" style="display: none;">이전 이벤트 보기</button>
						<button type="button" class="event-next" tabindex="0" role="button" aria-label="Next slide" style="display: none;">다음 이벤트 보기</button>
						<button type="button" class="pause on">일시정지</button>
						<button type="button" class="play">자동재생</button>
					</div>

					<div class="event-control">
						<button type="button" class="event-prev" tabindex="0" role="button" aria-label="Previous slide" style="display: none;">이전 이벤트 보기</button>
						<button type="button" class="event-next" tabindex="0" role="button" aria-label="Next slide" style="display: none;">다음 이벤트 보기</button>
					</div>
				</div>

				<div class="event-swiper swiper-container-initialized swiper-container-horizontal">
					<div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
						<!-- 반복 -->
						
					</div>
				<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
			</div>
		

		<div id="boardSearch" class="inner-wrap" style="">
			

			
				<div class="board-list-util mt40">
			

				<p class="result-count"><strong>전체 <b>39</b>건</strong></p>

				<div class="board-search">
					<input type="text" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text">
					<button type="button" class="btn-search-input">검색</button>
				</div>
			</div>
		</div>

		<div id="event-list-wrap">


	<div class="inner-wrap">
		

			<div class="event-list ">
          
			
                <input type="hidden" id="totCount" name="totCount" value="39">
				<ul>
				
					<li>
						<a href="/event/theater#" data-no="12596" data-netfunnel="N" class="eventBtn" title="[부산경남지역] 인제대학교 재학생, 교직원 할인 상세보기">
							

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
						<a href="/event/theater#" data-no="12600" data-netfunnel="N" class="eventBtn" title="[킨텍스] 킨텍스점 전용 관람권 할인! 상세보기">
							

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
						<a href="/event/theater#" data-no="12597" data-netfunnel="N" class="eventBtn" title="[강남] 강남점 전용 관람권 패키지 특가 한정 판매! 상세보기">
							

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
						<a href="/event/theater#" data-no="12564" data-netfunnel="N" class="eventBtn" title="[정관] 당첨률 100%! 영화보고 관람권 받자! 상세보기">
							

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

				
					<li>
						<a href="/event/theater#" data-no="12595" data-netfunnel="N" class="eventBtn" title="[대전중앙로] 대전중앙로점 전용 관람권 패키지 출시 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/bxYtzWmwXuBO2uBHzAwYpdb4GyUDmhl8.jpg" alt="[대전중앙로] 대전중앙로점 전용 관람권 패키지 출시" onerror="noImg(this);"></p>

							<p class="tit">
								[대전중앙로] 대전중앙로점 전용 관람권 패키지 출시
							</p>

							<p class="date">
								2023.01.21 ~ 2023.06.30
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12556" data-netfunnel="N" class="eventBtn" title="[대전] 꽝 없는 추억의 뽑기 도전! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/iKLRYXJ7A2o4AIPviwhaJHramVds1V2l.jpg" alt="[대전] 꽝 없는 추억의 뽑기 도전!" onerror="noImg(this);"></p>

							<p class="tit">
								[대전] 꽝 없는 추억의 뽑기 도전!
							</p>

							<p class="date">
								2023.01.21 ~ 2023.06.30
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12523" data-netfunnel="N" class="eventBtn" title="[대전충청지역] 충청지역 빅사이즈 팝콘 출시! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/e5ShVUnBw0Z6q9Hclq9wmcfsVCgFWw6T.jpg" alt="[대전충청지역] 충청지역 빅사이즈 팝콘 출시!" onerror="noImg(this);"></p>

							<p class="tit">
								[대전충청지역] 충청지역 빅사이즈 팝콘 출시!
							</p>

							<p class="date">
								2023.01.18 ~ 2023.07.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12525" data-netfunnel="N" class="eventBtn" title="[세종] 팝콘 유료 리필 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/EDI3e4RyXcbfFT3EikU3nCkbl9moimvC.jpg" alt="[세종] 팝콘 유료 리필 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[세종] 팝콘 유료 리필 이벤트
							</p>

							<p class="date">
								2023.01.18 ~ 2023.02.28
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12524" data-netfunnel="N" class="eventBtn" title="[세종] 토끼띠 인증하고 영화 할인 받자! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/Mambd0JGd0SIXYrHr11spaZ0hAnk6xuC.jpg" alt="[세종] 토끼띠 인증하고 영화 할인 받자!" onerror="noImg(this);"></p>

							<p class="tit">
								[세종] 토끼띠 인증하고 영화 할인 받자!
							</p>

							<p class="date">
								2023.01.18 ~ 2023.02.28
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12561" data-netfunnel="N" class="eventBtn" title="[대전유성] 대전유성점 관람권 패키지 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/TBwmBD9Iqkt2rwmMRBrN8Egmx36uOmpo.jpg" alt="[대전유성] 대전유성점 관람권 패키지" onerror="noImg(this);"></p>

							<p class="tit">
								[대전유성] 대전유성점 관람권 패키지
							</p>

							<p class="date">
								2023.01.17 ~ 2023.06.30
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12562" data-netfunnel="N" class="eventBtn" title="[수도권남부지역] 2023년 단체 최저가 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/5YHMzSDRb4OmToDL4D0S9vxpNVpPMZLr.jpg" alt="[수도권남부지역] 2023년 단체 최저가 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[수도권남부지역] 2023년 단체 최저가 이벤트
							</p>

							<p class="date">
								2023.01.16 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12557" data-netfunnel="N" class="eventBtn" title="[대전] 지점 전용 관람권 4+1 특가판매 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/wWCZr0ddM2jakUhmneIIfc3v9MCiO0xL.jpg" alt="[대전] 지점 전용 관람권 4+1 특가판매" onerror="noImg(this);"></p>

							<p class="tit">
								[대전] 지점 전용 관람권 4+1 특가판매
							</p>

							<p class="date">
								2023.01.14 ~ 2023.06.30
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12555" data-netfunnel="N" class="eventBtn" title="[천안] 추운 겨울 미니붕어빵으로 따뜻하게 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/dAo4SUDyadfgF14eTMnlYjFIVBnwml7z.jpg" alt="[천안] 추운 겨울 미니붕어빵으로 따뜻하게" onerror="noImg(this);"></p>

							<p class="tit">
								[천안] 추운 겨울 미니붕어빵으로 따뜻하게
							</p>

							<p class="date">
								2023.01.12 ~ 2023.06.30
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12483" data-netfunnel="N" class="eventBtn" title="[양산] 학생증 인증하고 할인 받자! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/KufJeubCW1KWwcSASqIp3quOqeDkAur1.jpg" alt="[양산] 학생증 인증하고 할인 받자!" onerror="noImg(this);"></p>

							<p class="tit">
								[양산] 학생증 인증하고 할인 받자!
							</p>

							<p class="date">
								2023.01.11 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12482" data-netfunnel="N" class="eventBtn" title="[양산] 재방문하고 할인 받자! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/2go25JTdPscbKCBfLqaUhhPMWCNYXq19.jpg" alt="[양산] 재방문하고 할인 받자!" onerror="noImg(this);"></p>

							<p class="tit">
								[양산] 재방문하고 할인 받자!
							</p>

							<p class="date">
								2023.01.11 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12484" data-netfunnel="N" class="eventBtn" title="[부산경남지역] 2023년도는 3 6 9로 쏜다! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/JAch1EQKtfQlRR3FgaizA3B1e3YgaAN2.jpg" alt="[부산경남지역] 2023년도는 3 6 9로 쏜다!" onerror="noImg(this);"></p>

							<p class="tit">
								[부산경남지역] 2023년도는 3 6 9로 쏜다!
							</p>

							<p class="date">
								2023.01.11 ~ 2023.03.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12554" data-netfunnel="N" class="eventBtn" title="[천안] 2023 계묘년 가장 빠른 사람은? 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/r0z9cUrqI7QuJDMghAZSgqVwaBFPWzMT.jpg" alt="[천안] 2023 계묘년 가장 빠른 사람은?" onerror="noImg(this);"></p>

							<p class="tit">
								[천안] 2023 계묘년 가장 빠른 사람은?
							</p>

							<p class="date">
								2023.01.09 ~ 2023.03.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12560" data-netfunnel="N" class="eventBtn" title="[부산대] 래미안장전 아파트 X 메가박스 부산대점 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/scbRk1794HV5Jg3XabxomVzgrgiwJgMG.jpg" alt="[부산대] 래미안장전 아파트 X 메가박스 부산대점" onerror="noImg(this);"></p>

							<p class="tit">
								[부산대] 래미안장전 아파트 X 메가박스 부산대점
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12559" data-netfunnel="N" class="eventBtn" title="[부산대] 부산외대 재학생, 임직원 할인! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/J3MrVP8ObVmNKmweQ2JPBMQlyoF7U3g8.jpg" alt="[부산대] 부산외대 재학생, 임직원 할인!" onerror="noImg(this);"></p>

							<p class="tit">
								[부산대] 부산외대 재학생, 임직원 할인!
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12522" data-netfunnel="N" class="eventBtn" title="[송도] 송도점 로컬 할인 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/5g3kh1Z9g4g1YjGW668qk5IBiINsaGYw.jpg" alt="[송도] 송도점 로컬 할인 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[송도] 송도점 로컬 할인 이벤트
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12452" data-netfunnel="N" class="eventBtn" title="[화곡] 전국공무원노동조합 강서구지부 조합원 제휴 할인!  상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/4Muwjts7cvK7sZTScOb35fgkPvziDBCD.jpg" alt="[화곡] 전국공무원노동조합 강서구지부 조합원 제휴 할인! " onerror="noImg(this);"></p>

							<p class="tit">
								[화곡] 전국공무원노동조합 강서구지부 조합원 제휴 할인! 
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12451" data-netfunnel="N" class="eventBtn" title="[삼천포] 아르떼리조트 이용객이라면? 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/mwmj2M28TLnF6sF3HD4tRjhLwxuixQ7Q.jpg" alt="[삼천포] 아르떼리조트 이용객이라면?" onerror="noImg(this);"></p>

							<p class="tit">
								[삼천포] 아르떼리조트 이용객이라면?
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12380" data-netfunnel="N" class="eventBtn" title="[화곡] 한국폴리텍대학 강서캠퍼스 제휴 할인! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/VYkl6Uf3yLxTbOzKAJXI5WNeXWPAQ26v.jpg" alt="[화곡] 한국폴리텍대학 강서캠퍼스 제휴 할인!" onerror="noImg(this);"></p>

							<p class="tit">
								[화곡] 한국폴리텍대학 강서캠퍼스 제휴 할인!
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12161" data-netfunnel="N" class="eventBtn" title="[구미강동] 구미 다둥e카드 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/Hse3uLs4A4rXtAeqopDrvMJwlkfws4ou.jpg" alt="[구미강동] 구미 다둥e카드 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[구미강동] 구미 다둥e카드 이벤트
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="11757" data-netfunnel="N" class="eventBtn" title="[부산대] 이마트 금정점 구매 영수증으로 할인 받자! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/zMOPjojHZ3wOtxw0hxaTb63oUFM1u2LB.jpg" alt="[부산대] 이마트 금정점 구매 영수증으로 할인 받자!" onerror="noImg(this);"></p>

							<p class="tit">
								[부산대] 이마트 금정점 구매 영수증으로 할인 받자!
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="11580" data-netfunnel="N" class="eventBtn" title="[부산대] 중,고등학생!! 할인 받고 영화 보자! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/AiqmOFZBVhyx8nmw6lvFNdNOAZu1HgvI.jpg" alt="[부산대] 중,고등학생!! 할인 받고 영화 보자!" onerror="noImg(this);"></p>

							<p class="tit">
								[부산대] 중,고등학생!! 할인 받고 영화 보자!
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="10826" data-netfunnel="N" class="eventBtn" title="[부산대] 22년도 금정구 구민 할인 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/7WaPVaeJaSqwhMA4xOxJpfHmz4V3kW7d.jpg" alt="[부산대] 22년도 금정구 구민 할인" onerror="noImg(this);"></p>

							<p class="tit">
								[부산대] 22년도 금정구 구민 할인
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="11971" data-netfunnel="N" class="eventBtn" title="[청라지젤] 카카오 플러스 친구 추가 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/nBuAIlIGWgiJvzWWCYrbKZ8yHx3X6gBI.jpg" alt="[청라지젤] 카카오 플러스 친구 추가 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[청라지젤] 카카오 플러스 친구 추가 이벤트
							</p>

							<p class="date">
								2023.01.01 ~ 2023.06.30
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12558" data-netfunnel="N" class="eventBtn" title="[춘천석사] 딜리버리 런칭 이벤트! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/XFUHSRKHLndN6BVvBX4LSKFca8tJ35u8.jpg" alt="[춘천석사] 딜리버리 런칭 이벤트!" onerror="noImg(this);"></p>

							<p class="tit">
								[춘천석사] 딜리버리 런칭 이벤트!
							</p>

							<p class="date">
								2023.01.01 ~ 2023.03.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12411" data-netfunnel="N" class="eventBtn" title="[대구이시아] 라운지 이용권 런칭! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/IwOFR5fvobJmrVwYXm4M8cqjdwQj0LoO.jpg" alt="[대구이시아] 라운지 이용권 런칭!" onerror="noImg(this);"></p>

							<p class="tit">
								[대구이시아] 라운지 이용권 런칭!
							</p>

							<p class="date">
								2022.12.15 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12351" data-netfunnel="N" class="eventBtn" title="[송도] 시흥 웨이브파크 할인 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/a4t2BLjuDB8ftF16zt1oXpjEviOSphLR.jpg" alt="[송도] 시흥 웨이브파크 할인 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[송도] 시흥 웨이브파크 할인 이벤트
							</p>

							<p class="date">
								2022.12.15 ~ 2023.02.14
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12314" data-netfunnel="N" class="eventBtn" title="[대구경북지역] 포대 팝콘 출시!  상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/pcZEERMpzPSs4Bkejvxh4cLiG5znNs2S.jpg" alt="[대구경북지역] 포대 팝콘 출시! " onerror="noImg(this);"></p>

							<p class="tit">
								[대구경북지역] 포대 팝콘 출시! 
							</p>

							<p class="date">
								2022.12.08 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12348" data-netfunnel="N" class="eventBtn" title="[사상] 동서대 재학생, 임직원은 사상지점으로! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/A9Ixy807Idhrx4yhbv6cAImFaeOaSPPM.jpg" alt="[사상] 동서대 재학생, 임직원은 사상지점으로!" onerror="noImg(this);"></p>

							<p class="tit">
								[사상] 동서대 재학생, 임직원은 사상지점으로!
							</p>

							<p class="date">
								2022.12.05 ~ 2023.12.04
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12280" data-netfunnel="N" class="eventBtn" title="[부산경남지역] 부산 경남 직영점 관람권 패키지 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/Bdlz1tYmptA59VOeHJNFEcRTUVM06767.jpg" alt="[부산경남지역] 부산 경남 직영점 관람권 패키지" onerror="noImg(this);"></p>

							<p class="tit">
								[부산경남지역] 부산 경남 직영점 관람권 패키지
							</p>

							<p class="date">
								2022.12.01 ~ 2023.05.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12349" data-netfunnel="N" class="eventBtn" title="[대구경북지역] 대경이가 쏘는 초특급 혜택 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/2nai0TcbtlUHEZlwya1kXWAUrOV9oA7j.jpg" alt="[대구경북지역] 대경이가 쏘는 초특급 혜택" onerror="noImg(this);"></p>

							<p class="tit">
								[대구경북지역] 대경이가 쏘는 초특급 혜택
							</p>

							<p class="date">
								2022.12.01 ~ 2023.02.28
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="12480" data-netfunnel="N" class="eventBtn" title="[대구신세계] 대구신세계에서 즐기는 풀코스! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/HTnqQ2VkvZbIeT44jvbNYP2FXDrDG9xl.jpg" alt="[대구신세계] 대구신세계에서 즐기는 풀코스!" onerror="noImg(this);"></p>

							<p class="tit">
								[대구신세계] 대구신세계에서 즐기는 풀코스!
							</p>

							<p class="date">
								2022.09.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="11833" data-netfunnel="N" class="eventBtn" title="[사상] 신라대학교 할인 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/ovZJ1epW05CNadtkmI4rDyt6M50ytsE4.jpg" alt="[사상] 신라대학교 할인 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[사상] 신라대학교 할인 이벤트
							</p>

							<p class="date">
								2022.08.30 ~ 2023.08.29
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="10179" data-netfunnel="N" class="eventBtn" title="[정관] 카카오채널 친구추가 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/dqNxzGSdzGA7YFC7p6Rb3PCmVL7KeDYQ.png" alt="[정관] 카카오채널 친구추가 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[정관] 카카오채널 친구추가 이벤트
							</p>

							<p class="date">
								2022.06.01 ~ 2023.02.28
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/theater#" data-no="11288" data-netfunnel="N" class="eventBtn" title="[코엑스] 프로포즈 인 프라이빗 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/JfazFggntygIWVR2CJH25BH6XEjmPKHb.jpg" alt="[코엑스] 프로포즈 인 프라이빗" onerror="noImg(this);"></p>

							<p class="tit">
								[코엑스] 프로포즈 인 프라이빗
							</p>

							<p class="date">
								2022.04.22 ~ 2023.03.31
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
        



<section id="saw_movie_regi" class="modal-layer"><a href="/event/theater" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/event/theater" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/event/theater#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>