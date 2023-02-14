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

		if('1' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
		$('.event-slider .event-count .total').text(real_count)

		// 이벤트 배너 1개 이하일 경우 좌우 버튼 숨기기
		if(real_count < 2 ){

			$('.event-prev').hide();
			$('.event-next').hide();

			$('.swiper-slide-duplicate').hide(); //스와이프용 duplicate 이미지 숨기기
		}

		// 현재 활성화된 swiper
		event_swiper.on('slideChange', function(){
			if('1' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
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
		fn_chgEventTab('CED01');
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
							<li id="eventTab_CED01" class="on"><a href="/event/eventMovie" title="영화 탭으로 이동">영화</a></li>
						
							<!--  li id="eventTab_CED02"><a href="javascript:fn_chgEventTab('CED02')">극장</a></li-->
							<li id="eventTab_CED02" class=""><a href="/event/eventTheater" title="극장 탭으로 이동">극장</a></li>
						
							<!--  li id="eventTab_CED05"><a href="javascript:fn_chgEventTab('CED05')">제휴/할인</a></li-->
							<li id="eventTab_CED05" class=""><a href="/event/eventPromotion" title="제휴/할인 탭으로 이동">제휴/할인</a></li>
						
							<!--  li id="eventTab_CED04"><a href="javascript:fn_chgEventTab('CED04')">시사회/무대인사</a></li-->
							<li id="eventTab_CED04" class=""><a href="/event/eventCurtaincall" title="시사회/무대인사 탭으로 이동">시사회/무대인사</a></li>
						
					</ul>
				</div>

				<div id="toptablist" class="toptablist"><ul> <li class="on"><a href="javascript:void(0);">전체</a></li><li data-cd="ZEC"><a href="javascript:void(0);">빵원쿠폰</a></li><li data-cd="ZECP"><a href="javascript:void(0);">빵원쿠폰플러스</a></li><li data-cd="CET03"><a href="javascript:void(0);">굿즈패키지</a></li><li data-cd="POP"><a href="javascript:void(0);">포인트플러스</a></li></ul></div>











			
			
		</div>

		
			<div id="divTopArea" class="event-slider" style="display: none;">
				<div class="inner-wrap">

					<p class="name">추천 이벤트</p>

					<div class="event-pagination swiper-pagination-bullets"><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span></div>

					<div class="event-count">
						<span title="현재 페이지" class="active">1</span> /
						<span title="전체 페이지" class="total">1</span>
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
					<div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;"><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-active swiper-slide-duplicate-next" data-swiper-slide-index="0" style="width: 530px; display: none; margin-right: 40px;">
								<a href="/event/movie#" data-no="12553" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판 상세보기">
									
									<p class="img"><img src="/resources/event/5cPQ7RnaFh8uXdWOswzLGiiXz3XZDHaC.jpg" alt="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판</p>
										<p class="date">2023.02.19 ~ 2023.02.19</p>
									</div>
								</a>

							</div>
						<!-- 반복 -->
						
							<div class="cell swiper-slide swiper-slide-duplicate-active swiper-slide-next swiper-slide-duplicate-prev" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
								<a href="/event/movie#" data-no="12553" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판 상세보기">
									
									<p class="img"><img src="/resources/event/5cPQ7RnaFh8uXdWOswzLGiiXz3XZDHaC.jpg" alt="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판</p>
										<p class="date">2023.02.19 ~ 2023.02.19</p>
									</div>
								</a>

							</div>
						
					<div class="cell swiper-slide swiper-slide-duplicate swiper-slide-prev swiper-slide-duplicate-next" data-swiper-slide-index="0" style="width: 530px; display: none; margin-right: 40px;">
								<a href="/event/movie#" data-no="12553" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판 상세보기">
									
									<p class="img"><img src="/resources/event/5cPQ7RnaFh8uXdWOswzLGiiXz3XZDHaC.jpg" alt="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판</p>
										<p class="date">2023.02.19 ~ 2023.02.19</p>
									</div>
								</a>

							</div></div>
				<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
			</div>
		

		<div id="boardSearch" class="inner-wrap" style="">
			

			
				<div class="board-list-util mt40">
			

				<p class="result-count"><strong>전체 <b>58</b>건</strong></p>

				<div class="board-search">
					<input type="text" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text">
					<button type="button" class="btn-search-input">검색</button>
				</div>
			</div>
		</div>

		<div id="event-list-wrap">


	<div class="inner-wrap">
		

			<div class="event-list ">
          
			
                <input type="hidden" id="totCount" name="totCount" value="58">
				<ul>
				
					<li>
						<a href="/event/movie#" data-no="12552" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 강연 안내 상세보기">
							

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
						<a href="/event/movie#" data-no="12553" data-netfunnel="N" class="eventBtn" title="[2023 사건 읽는 영화관] 2월의 사건 : ep.01 시체 없는 살인사건의 공판 상세보기">
							

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
						<a href="/event/movie#" data-no="12618" data-netfunnel="N" class="eventBtn" title="&lt;어메이징 모리스&gt; 관람인증 이벤트 상세보기">
							

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
						<a href="/event/movie#" data-no="12616" data-netfunnel="N" class="eventBtn" title="[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 개봉 기념 현장증정 이벤트 상세보기">
							

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

				
					<li>
						<a href="/event/movie#" data-no="12635" data-netfunnel="N" class="eventBtn" title="&lt;다음 소희&gt; 개봉주말 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/qYZt8WzitXPqOI3x8kS7afYhH7tSCSBz.jpg" alt="&lt;다음 소희&gt; 개봉주말 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;다음 소희&gt; 개봉주말 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.11 ~ 2023.02.25
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12613" data-netfunnel="N" class="eventBtn" title="&lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 유키사다 이사오 감독 내한 메가토크 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/4JLk0h2o0slKHzAhvLeQjLWvrRn7Kt5r.jpg" alt="&lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 유키사다 이사오 감독 내한 메가토크" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 유키사다 이사오 감독 내한 메가토크
							</p>

							<p class="date">
								2023.02.10 ~ 2023.02.11
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12627" data-netfunnel="N" class="eventBtn" title="&lt;극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연&gt; 2주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/NaB1EqoiYnuJtVZ0kWqU9tWFWPZvBPhl.jpg" alt="&lt;극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연&gt; 2주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연&gt; 2주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.09 ~ 2023.02.15
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12630" data-netfunnel="N" class="eventBtn" title="&lt;이마 베프&gt; 2주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/puXeenl8710CyZFLKoYLPeZgT72k8LsC.jpg" alt="&lt;이마 베프&gt; 2주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;이마 베프&gt; 2주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.08 ~ 2024.02.21
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12629" data-netfunnel="N" class="eventBtn" title="&lt;라인&gt; 3주차 현장증정이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/RCPhqLuEIAXbAjPUZnXiYsyFScZas2nk.jpg" alt="&lt;라인&gt; 3주차 현장증정이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;라인&gt; 3주차 현장증정이벤트
							</p>

							<p class="date">
								2023.02.08 ~ 2023.03.22
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12636" data-netfunnel="N" class="eventBtn" title="&lt;단순한 열정&gt; 2주차 현장 증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/LyEgH2jkkYPBES3Ib34SJhbXCK8RaxjK.jpg" alt="&lt;단순한 열정&gt; 2주차 현장 증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;단순한 열정&gt; 2주차 현장 증정 이벤트
							</p>

							<p class="date">
								2023.02.08 ~ 2023.02.22
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12634" data-netfunnel="N" class="eventBtn" title="&lt;네가 떨어뜨린 푸른 하늘&gt; 개봉기념 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/uSX7Sh1F7awk1IR6rC9Sd6OI6Z7ilFgB.jpg" alt="&lt;네가 떨어뜨린 푸른 하늘&gt; 개봉기념 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;네가 떨어뜨린 푸른 하늘&gt; 개봉기념 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.08 ~ 2023.02.22
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12633" data-netfunnel="N" class="eventBtn" title="&lt;성스러운 거미&gt; 개봉기념 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/mXShtK1Jxv0TIviqWuNJtzdvfmlioLnK.jpg" alt="&lt;성스러운 거미&gt; 개봉기념 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;성스러운 거미&gt; 개봉기념 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.08 ~ 2023.02.22
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12631" data-netfunnel="N" class="eventBtn" title="&lt;애프터썬&gt; 2주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/4yYJiqL7npPE3UTxUWVFGJGzYAKOKQem.jpg" alt="&lt;애프터썬&gt; 2주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;애프터썬&gt; 2주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.08 ~ 2023.02.22
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12622" data-netfunnel="N" class="eventBtn" title="&lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 개봉기념 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/gD6jhLYmB0kHDpb3jNFeVK0rx1S9prmc.jpg" alt="&lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 개봉기념 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 개봉기념 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.08 ~ 2023.02.22
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12617" data-netfunnel="N" class="eventBtn" title="&lt;바빌론&gt; 2주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/FYy4wzf6tdYifOss797UOcj0ET0fVJ1X.jpg" alt="&lt;바빌론&gt; 2주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;바빌론&gt; 2주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.08 ~ 2023.02.22
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12541" data-netfunnel="N" class="eventBtn" title="&lt;다음 소희&gt; 메가토크 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/KJfWlKYOtogwbgbTlLhuNMbNqhHTH9rB.jpg" alt="&lt;다음 소희&gt; 메가토크" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;다음 소희&gt; 메가토크
							</p>

							<p class="date">
								2023.02.08 ~ 2023.02.08
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12626" data-netfunnel="N" class="eventBtn" title="아트나인과 함께 하는&lt;시간을 꿈꾸는 소녀&gt; 시네마구구 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/Mvw3hX8FIBX3s2m2iwP09cuKl1ZuPzUN.jpg" alt="아트나인과 함께 하는&lt;시간을 꿈꾸는 소녀&gt; 시네마구구" onerror="noImg(this);"></p>

							<p class="tit">
								아트나인과 함께 하는&lt;시간을 꿈꾸는 소녀&gt; 시네마구구
							</p>

							<p class="date">
								2023.02.07 ~ 2023.02.16
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12625" data-netfunnel="N" class="eventBtn" title="아트나인과 함께 하는 &lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 시네마구구 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/i6NqJKVQP5WYA8fiNhRtVu5dqcYUoxpL.jpg" alt="아트나인과 함께 하는 &lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 시네마구구" onerror="noImg(this);"></p>

							<p class="tit">
								아트나인과 함께 하는 &lt;궁지에 몰린 쥐는 치즈 꿈을 꾼다&gt; 시네마구구
							</p>

							<p class="date">
								2023.02.07 ~ 2023.02.11
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12615" data-netfunnel="N" class="eventBtn" title="[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 1+1 관람쿠폰 선착순 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/8MD1StTb94AoQv4LXItAl0FDCqtBJjcy.jpg" alt="[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 1+1 관람쿠폰 선착순 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 1+1 관람쿠폰 선착순 이벤트
							</p>

							<p class="date">
								2023.02.07 ~ 2023.02.11
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12619" data-netfunnel="N" class="eventBtn" title="[트윈] 선착순 빵원티켓 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/ULIjYnTxMQdGDdVIjcg87OkC8lStNSMj.jpg" alt="[트윈] 선착순 빵원티켓" onerror="noImg(this);"></p>

							<p class="tit">
								[트윈] 선착순 빵원티켓
							</p>

							<p class="date">
								2023.02.07 ~ 2023.02.08
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12620" data-netfunnel="N" class="eventBtn" title="&lt;더 퍼스트 슬램덩크&gt; 응원상영회 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/fq98tyLQlQxzmPGw530LH2MBd9XTgo6h.jpg" alt="&lt;더 퍼스트 슬램덩크&gt; 응원상영회 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;더 퍼스트 슬램덩크&gt; 응원상영회 이벤트
							</p>

							<p class="date">
								2023.02.06 ~ 2023.02.12
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12605" data-netfunnel="N" class="eventBtn" title="[울프 하운드] 선착순 빵원티켓 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/NkNypOWrxlMNOH6zI1toviRGXdKHktJw.jpg" alt="[울프 하운드] 선착순 빵원티켓" onerror="noImg(this);"></p>

							<p class="tit">
								[울프 하운드] 선착순 빵원티켓
							</p>

							<p class="date">
								2023.02.06 ~ 2023.02.07
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12604" data-netfunnel="N" class="eventBtn" title="[원 웨이] 선착순 빵원티켓 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/eolR99p2rrVsOnCKNhztfZP4726cjwpB.jpg" alt="[원 웨이] 선착순 빵원티켓" onerror="noImg(this);"></p>

							<p class="tit">
								[원 웨이] 선착순 빵원티켓
							</p>

							<p class="date">
								2023.02.06 ~ 2023.02.07
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12602" data-netfunnel="N" class="eventBtn" title="&lt;오늘 밤, 세계에서 이 사랑이 사라진다 해도&gt; &#39;마오리의 일기장&#39; 앵콜증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/n7gtH0B74LiO91SFnnIQrChY2WnJdvO3.jpg" alt="&lt;오늘 밤, 세계에서 이 사랑이 사라진다 해도&gt; &#39;마오리의 일기장&#39; 앵콜증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;오늘 밤, 세계에서 이 사랑이 사라진다 해도&gt; '마오리의 일기장' 앵콜증정 이벤트
							</p>

							<p class="date">
								2023.02.04 ~ 2023.02.18
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12547" data-netfunnel="N" class="eventBtn" title="&lt;바빌론&gt; 돌비시네마 관람 포스터 증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/ttV2r3ySfq1NncU5QlgsdEieNhTA6Un1.jpg" alt="&lt;바빌론&gt; 돌비시네마 관람 포스터 증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;바빌론&gt; 돌비시네마 관람 포스터 증정 이벤트
							</p>

							<p class="date">
								2023.02.04 ~ 2023.02.18
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12608" data-netfunnel="N" class="eventBtn" title="&lt;상견니&gt; 2주차 주말 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/f0hY0PiM2IdyYzH5RSjkSxQY4Q64GVv6.jpg" alt="&lt;상견니&gt; 2주차 주말 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;상견니&gt; 2주차 주말 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.04 ~ 2023.02.07
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12612" data-netfunnel="N" class="eventBtn" title="[2023 메트오페라] 시즌 상영 안내 Live on Screen in Cinemas @ The Met 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/NoqTVDOz2BHBcVRiuHfrDqx302j6E2ib.jpg" alt="[2023 메트오페라] 시즌 상영 안내 Live on Screen in Cinemas @ The Met" onerror="noImg(this);"></p>

							<p class="tit">
								[2023 메트오페라] 시즌 상영 안내 Live on Screen in Cinemas @ The Met
							</p>

							<p class="date">
								2023.02.03 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12614" data-netfunnel="N" class="eventBtn" title="[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 발렌타인데이 기념 댓글 초대 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/5YuFGXJGKnqP7BccS274kPyvczhHs6k0.jpg" alt="[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 발렌타인데이 기념 댓글 초대 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								[로열 발레] &lt;달콤 쌉사름한 초콜릿&gt; 발렌타인데이 기념 댓글 초대 이벤트
							</p>

							<p class="date">
								2023.02.03 ~ 2023.02.09
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12588" data-netfunnel="N" class="eventBtn" title="&lt;쥴 앤 짐&gt; 2주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/fWg6ZujEeIj2c99DGqsta85qFMBbHvb8.jpg" alt="&lt;쥴 앤 짐&gt; 2주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;쥴 앤 짐&gt; 2주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.02 ~ 2023.02.16
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12592" data-netfunnel="N" class="eventBtn" title="&lt;몬스터 하우스2: 인비져블 피닉스&gt; 관람인증 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/O97HUpSdd3SnqIJsUkr881Derygkiumt.jpg" alt="&lt;몬스터 하우스2: 인비져블 피닉스&gt; 관람인증 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;몬스터 하우스2: 인비져블 피닉스&gt; 관람인증 이벤트
							</p>

							<p class="date">
								2023.02.02 ~ 2023.02.12
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12576" data-netfunnel="N" class="eventBtn" title="&lt;극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연&gt; 1주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/NaB1EqoiYnuJtVZ0kWqU9tWFWPZvBPhl.jpg" alt="&lt;극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연&gt; 1주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연&gt; 1주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.02 ~ 2023.02.08
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12582" data-netfunnel="N" class="eventBtn" title="&lt;이마 베프&gt; 개봉기념 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/jWbWvMX7D4pYS3y0rPbXmfAVIqjbJ7uq.jpg" alt="&lt;이마 베프&gt; 개봉기념 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;이마 베프&gt; 개봉기념 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2024.02.14
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12586" data-netfunnel="N" class="eventBtn" title="&lt;라인&gt; 2주차 현장증정이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/0cO1SVySNy7UrbyrY1rpmpNQK4ZVVI5q.jpg" alt="&lt;라인&gt; 2주차 현장증정이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;라인&gt; 2주차 현장증정이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2023.03.15
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12573" data-netfunnel="N" class="eventBtn" title="&lt;교섭&gt; 3주차 스페셜 할인 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/RuYO6n3pgN0RhlzNmcIYfwHhNwplGeha.jpg" alt="&lt;교섭&gt; 3주차 스페셜 할인 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;교섭&gt; 3주차 스페셜 할인 이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2023.02.28
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12569" data-netfunnel="N" class="eventBtn" title="[메가박스X시네마캐슬] 시네마캐슬 2월 상영작 안내 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/7Cug7kT11R1KuOijvfkCsmQoNsjju7dE.jpg" alt="[메가박스X시네마캐슬] 시네마캐슬 2월 상영작 안내" onerror="noImg(this);"></p>

							<p class="tit">
								[메가박스X시네마캐슬] 시네마캐슬 2월 상영작 안내
							</p>

							<p class="date">
								2023.02.01 ~ 2023.02.28
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12628" data-netfunnel="N" class="eventBtn" title="&lt;더 퍼스트 슬램덩크&gt; 6주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/dTjmbEcWCA9Ndc7cCSfar7ZT6KQpSDRj.jpg" alt="&lt;더 퍼스트 슬램덩크&gt; 6주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;더 퍼스트 슬램덩크&gt; 6주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2023.02.15
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12585" data-netfunnel="N" class="eventBtn" title="&lt;단순한 열정&gt; 개봉기념 현장이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/3Y4WZEr0tMjR8KuKy1PnQUBuuPMJCqxf.jpg" alt="&lt;단순한 열정&gt; 개봉기념 현장이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;단순한 열정&gt; 개봉기념 현장이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2023.02.15
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12578" data-netfunnel="N" class="eventBtn" title="&lt;더 퍼스트 슬램덩크&gt; 5주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/B2wfTDNnHEOdsXkPxnBEqXQGSuEhOoPM.jpg" alt="&lt;더 퍼스트 슬램덩크&gt; 5주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;더 퍼스트 슬램덩크&gt; 5주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2023.02.15
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12575" data-netfunnel="N" class="eventBtn" title="&lt;아바타: 물의 길&gt; 천만 돌파 기념 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/R9rcDLAGPAj0bVpMxzw0iIQy8PnGmnwm.jpg" alt="&lt;아바타: 물의 길&gt; 천만 돌파 기념 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;아바타: 물의 길&gt; 천만 돌파 기념 이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2023.02.15
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12607" data-netfunnel="N" class="eventBtn" title="&lt;두다다쿵: 후후섬의 비밀&gt; SNS 기대평 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/k0f6JZBlUc0bVaSOkY4rbxRsBn4JNt0Z.jpg" alt="&lt;두다다쿵: 후후섬의 비밀&gt; SNS 기대평 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;두다다쿵: 후후섬의 비밀&gt; SNS 기대평 이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2023.02.14
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12587" data-netfunnel="N" class="eventBtn" title="&lt;애프터썬&gt; 개봉기념 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/ikPaZYHDjes6Gb9m5AcKZ7jNWvfGiRy7.jpg" alt="&lt;애프터썬&gt; 개봉기념 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;애프터썬&gt; 개봉기념 현장증정 이벤트
							</p>

							<p class="date">
								2023.02.01 ~ 2023.02.08
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12514" data-netfunnel="N" class="eventBtn" title="&lt;어메이징 모리스&gt; SNS 기대평 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/YhRpK6iFjl0sv9AQXVa5RrPThdtIQoue.jpg" alt="&lt;어메이징 모리스&gt; SNS 기대평 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;어메이징 모리스&gt; SNS 기대평 이벤트
							</p>

							<p class="date">
								2023.01.31 ~ 2023.02.12
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12584" data-netfunnel="N" class="eventBtn" title="아트나인과 함께 하는 &lt;성스러운 거미&gt; 시네마구구 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/EzxOBwu3J7DNGuZEMqpgFPpkGNDTa7pT.jpg" alt="아트나인과 함께 하는 &lt;성스러운 거미&gt; 시네마구구" onerror="noImg(this);"></p>

							<p class="tit">
								아트나인과 함께 하는 &lt;성스러운 거미&gt; 시네마구구
							</p>

							<p class="date">
								2023.01.31 ~ 2023.02.09
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12567" data-netfunnel="N" class="eventBtn" title="&lt;영웅&gt; 노래자막버전 상영 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/X5Y39WR4pHMiKudCJWVrZFu40HENfoQC.png" alt="&lt;영웅&gt; 노래자막버전 상영 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;영웅&gt; 노래자막버전 상영 이벤트
							</p>

							<p class="date">
								2023.01.28 ~ 2023.02.14
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12563" data-netfunnel="N" class="eventBtn" title="&lt;더 퍼스트 슬램덩크&gt; 4주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/E3txcV5tjdPdoaMHjONFWjxzuU3et1k2.jpg" alt="&lt;더 퍼스트 슬램덩크&gt; 4주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;더 퍼스트 슬램덩크&gt; 4주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.01.28 ~ 2023.02.11
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12551" data-netfunnel="N" class="eventBtn" title="&lt;교섭&gt; 2주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/MFpPEx3G3wNGzRY6gYsvEDx2Gj28eNNH.jpg" alt="&lt;교섭&gt; 2주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;교섭&gt; 2주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.01.28 ~ 2023.02.11
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12550" data-netfunnel="N" class="eventBtn" title="&lt;엄마의 땅: 그리샤와 숲의 주인&gt; 개봉기념 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/JyMNaTpBlAIIlunXDdeRR3x3E5VTkAZ1.jpg" alt="&lt;엄마의 땅: 그리샤와 숲의 주인&gt; 개봉기념 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;엄마의 땅: 그리샤와 숲의 주인&gt; 개봉기념 현장증정 이벤트
							</p>

							<p class="date">
								2023.01.28 ~ 2023.02.11
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12506" data-netfunnel="N" class="eventBtn" title="&lt;교섭&gt; N차 관람 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/bNlBTKK5VpwwwxOrTXup74SyeZ8deLah.jpg" alt="&lt;교섭&gt; N차 관람 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;교섭&gt; N차 관람 이벤트
							</p>

							<p class="date">
								2023.01.26 ~ 2023.02.14
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12545" data-netfunnel="N" class="eventBtn" title="&lt;400번의 구타&gt;, &lt;쥴 앤 짐&gt; 개봉기념 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/P0gPkkbQdtnkfoFfIyF26Ge6qppd8Ezk.jpg" alt="&lt;400번의 구타&gt;, &lt;쥴 앤 짐&gt; 개봉기념 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;400번의 구타&gt;, &lt;쥴 앤 짐&gt; 개봉기념 현장증정 이벤트
							</p>

							<p class="date">
								2023.01.25 ~ 2023.02.08
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12535" data-netfunnel="N" class="eventBtn" title="&lt;상견니&gt; 개봉기념 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/GkXtN4kbeFTO5phsirZU58mwmJhPDHEw.jpg" alt="&lt;상견니&gt; 개봉기념 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;상견니&gt; 개봉기념 현장증정 이벤트
							</p>

							<p class="date">
								2023.01.25 ~ 2023.02.08
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12530" data-netfunnel="N" class="eventBtn" title="&lt;라인&gt; 개봉기념 현장증정이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/6OQvFWgT7d4DW9ZstM7yEk737Ed3yeCu.jpg" alt="&lt;라인&gt; 개봉기념 현장증정이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;라인&gt; 개봉기념 현장증정이벤트
							</p>

							<p class="date">
								2023.01.25 ~ 2023.02.08
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12539" data-netfunnel="N" class="eventBtn" title="&lt;더 퍼스트 슬램덩크&gt; 설연휴 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/HosRvBcnia9sAN8NGCagFZUuBzmjJ14h.jpg" alt="&lt;더 퍼스트 슬램덩크&gt; 설연휴 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;더 퍼스트 슬램덩크&gt; 설연휴 현장증정 이벤트
							</p>

							<p class="date">
								2023.01.21 ~ 2023.02.11
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12519" data-netfunnel="N" class="eventBtn" title="&lt;시간을 꿈꾸는 소녀&gt; 2주차 현장증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/jqCsBlWFY3Rp9RwurPYgtdgccVbnBD1S.jpg" alt="&lt;시간을 꿈꾸는 소녀&gt; 2주차 현장증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;시간을 꿈꾸는 소녀&gt; 2주차 현장증정 이벤트
							</p>

							<p class="date">
								2023.01.19 ~ 2023.02.09
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12467" data-netfunnel="N" class="eventBtn" title="&lt;제 10회 시네마 리플레이&gt; 상영작 및 이벤트 안내 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/PF8X5ApGc0oAlgGnhluVMFIp1Wg8bb0T.jpg" alt="&lt;제 10회 시네마 리플레이&gt; 상영작 및 이벤트 안내" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;제 10회 시네마 리플레이&gt; 상영작 및 이벤트 안내
							</p>

							<p class="date">
								2023.01.09 ~ 2023.02.19
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12410" data-netfunnel="N" class="eventBtn" title="[100회 기념] 베로나 오페라 페스티벌 시리즈 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/ojIYAnvGpLDyBMnG9eQQsA4KyC5fPrRh.jpg" alt="[100회 기념] 베로나 오페라 페스티벌 시리즈" onerror="noImg(this);"></p>

							<p class="tit">
								[100회 기념] 베로나 오페라 페스티벌 시리즈
							</p>

							<p class="date">
								2022.12.27 ~ 2023.03.12
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12019" data-netfunnel="N" class="eventBtn" title="[시즌 안내] 2022/23 로열 오페라 하우스 라이브 시네마 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/WmofGtKpSqCeBuwwG1CYCDV2RMmkIL3H.jpg" alt="[시즌 안내] 2022/23 로열 오페라 하우스 라이브 시네마" onerror="noImg(this);"></p>

							<p class="tit">
								[시즌 안내] 2022/23 로열 오페라 하우스 라이브 시네마
							</p>

							<p class="date">
								2022.10.14 ~ 2023.08.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12581" data-netfunnel="N" class="eventBtn" title="&lt;오늘 밤, 세계에서 이 사랑이 사라진다 해도&gt; 하루필름포스터 증정 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/xJfAHNQ4pgSZ7gKszHPITqVVRTe50Nez.jpg" alt="&lt;오늘 밤, 세계에서 이 사랑이 사라진다 해도&gt; 하루필름포스터 증정 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;오늘 밤, 세계에서 이 사랑이 사라진다 해도&gt; 하루필름포스터 증정 이벤트
							</p>

							<p class="date">
								2023.02.02 ~ 2023.02.16
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/movie#" data-no="12544" data-netfunnel="N" class="eventBtn" title="&lt;천룡팔부: 교봉전&gt; 관람인증 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/fTscZMsSFsBY1ipP2XwYw6mkwXw5T45F.jpg" alt="&lt;천룡팔부: 교봉전&gt; 관람인증 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								&lt;천룡팔부: 교봉전&gt; 관람인증 이벤트
							</p>

							<p class="date">
								2023.01.25 ~ 2023.02.07
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
        



<section id="saw_movie_regi" class="modal-layer"><a href="/event/movie" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/event/movie" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/event/movie#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>