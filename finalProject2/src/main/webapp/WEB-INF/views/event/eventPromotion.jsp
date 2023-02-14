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

		if('4' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
		$('.event-slider .event-count .total').text(real_count)

		// 이벤트 배너 1개 이하일 경우 좌우 버튼 숨기기
		if(real_count < 2 ){

			$('.event-prev').hide();
			$('.event-next').hide();

			$('.swiper-slide-duplicate').hide(); //스와이프용 duplicate 이미지 숨기기
		}

		// 현재 활성화된 swiper
		event_swiper.on('slideChange', function(){
			if('4' > 0) $('.event-slider .event-count .active').text(event_swiper.realIndex + 1);
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
		fn_chgEventTab('CED05');
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
							<li id="eventTab_CED02" class=""><a href="/event/eventTheater" title="극장 탭으로 이동">극장</a></li>
						
							<!--  li id="eventTab_CED05"><a href="javascript:fn_chgEventTab('CED05')">제휴/할인</a></li-->
							<li id="eventTab_CED05" class="on"><a href="/event/eventPromotion" title="제휴/할인 탭으로 이동">제휴/할인</a></li>
						
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

					<div class="event-pagination swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span></div>

					<div class="event-count">
						<span title="현재 페이지" class="active">2</span> /
						<span title="전체 페이지" class="total">4</span>
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
					<div class="swiper-wrapper" style="transform: translate3d(-1710px, 0px, 0px); transition-duration: 300ms;"><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="2" style="width: 530px; margin-right: 40px;">
								<a href="/event/promotion#" data-no="9187" data-netfunnel="N" class="eventBtn" title="U+멤버십 고객 영화 2,000원 할인 상세보기">
									
									<p class="img"><img src="/resources/event/poxTnLz5oVfwTJlW6TINBrEKv3jP2GIJ.jpg" alt="U+멤버십 고객 영화 2,000원 할인" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">U+멤버십 고객 영화 2,000원 할인</p>
										<p class="date">2021.02.01 ~ 2023.12.31</p>
									</div>
								</a>

							</div><div class="cell swiper-slide swiper-slide-duplicate" data-swiper-slide-index="3" style="width: 530px; margin-right: 40px;">
								<a href="/event/promotion#" data-no="11263" data-netfunnel="N" class="eventBtn" title="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요! 상세보기">
									
									<p class="img"><img src="/resources/event/HmcDZ2pEwgwyYTNCKXJxU0WKdDOOOENG.jpg" alt="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!</p>
										<p class="date">2022.04.18 ~ 2023.12.31</p>
									</div>
								</a>

							</div>
						<!-- 반복 -->
						
							<div class="cell swiper-slide swiper-slide-prev" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
								<a href="/event/promotion#" data-no="12392" data-netfunnel="N" class="eventBtn" title="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자! 상세보기">
									
									<p class="img"><img src="/resources/event/iFpskcjm9wzchFEmLxHd9nmyUrEPdwTq.png" alt="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!</p>
										<p class="date">2022.12.23 ~ 2023.03.05</p>
									</div>
								</a>

							</div>
						
							<div class="cell swiper-slide swiper-slide-active" data-swiper-slide-index="1" style="width: 530px; margin-right: 40px;">
								<a href="/event/promotion#" data-no="11739" data-netfunnel="N" class="eventBtn" title="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트 상세보기">
									
									<p class="img"><img src="/resources/event/iFnmkKFpZXrfGUAG6f2XvrELUL9DDF8A.jpg" alt="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트</p>
										<p class="date">2022.08.22 ~ 2023.02.28</p>
									</div>
								</a>

							</div>
						
							<div class="cell swiper-slide swiper-slide-next" data-swiper-slide-index="2" style="width: 530px; margin-right: 40px;">
								<a href="/event/promotion#" data-no="9187" data-netfunnel="N" class="eventBtn" title="U+멤버십 고객 영화 2,000원 할인 상세보기">
									
									<p class="img"><img src="/resources/event/poxTnLz5oVfwTJlW6TINBrEKv3jP2GIJ.jpg" alt="U+멤버십 고객 영화 2,000원 할인" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">U+멤버십 고객 영화 2,000원 할인</p>
										<p class="date">2021.02.01 ~ 2023.12.31</p>
									</div>
								</a>

							</div>
						
							<div class="cell swiper-slide" data-swiper-slide-index="3" style="width: 530px; margin-right: 40px;">
								<a href="/event/promotion#" data-no="11263" data-netfunnel="N" class="eventBtn" title="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요! 상세보기">
									
									<p class="img"><img src="/resources/event/HmcDZ2pEwgwyYTNCKXJxU0WKdDOOOENG.jpg" alt="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!</p>
										<p class="date">2022.04.18 ~ 2023.12.31</p>
									</div>
								</a>

							</div>
						
					<div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
								<a href="/event/promotion#" data-no="12392" data-netfunnel="N" class="eventBtn" title="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자! 상세보기">
									
									<p class="img"><img src="/resources/event/iFpskcjm9wzchFEmLxHd9nmyUrEPdwTq.png" alt="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!</p>
										<p class="date">2022.12.23 ~ 2023.03.05</p>
									</div>
								</a>

							</div><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="1" style="width: 530px; margin-right: 40px;">
								<a href="/event/promotion#" data-no="11739" data-netfunnel="N" class="eventBtn" title="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트 상세보기">
									
									<p class="img"><img src="/resources/event/iFnmkKFpZXrfGUAG6f2XvrELUL9DDF8A.jpg" alt="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트" onerror="noImg(this);"></p>

									<div class="cont">
										<p class="tit">[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트</p>
										<p class="date">2022.08.22 ~ 2023.02.28</p>
									</div>
								</a>

							</div></div>
				<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
			</div>
		

		<div id="boardSearch" class="inner-wrap" style="">
			

			
				<div class="board-list-util mt40">
			

				<p class="result-count"><strong>전체 <b>12</b>건</strong></p>

				<div class="board-search">
					<input type="text" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text">
					<button type="button" class="btn-search-input">검색</button>
				</div>
			</div>
		</div>

		<div id="event-list-wrap">


	<div class="inner-wrap">
		

			<div class="event-list ">
          
			
                <input type="hidden" id="totCount" name="totCount" value="12">
				<ul>
				
					<li>
						<a href="/event/promotion#" data-no="11739" data-netfunnel="N" class="eventBtn" title="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트 상세보기">
							

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
						<a href="/event/promotion#" data-no="11263" data-netfunnel="N" class="eventBtn" title="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요! 상세보기">
							

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
						<a href="/event/promotion#" data-no="12392" data-netfunnel="N" class="eventBtn" title="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자! 상세보기">
							

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
						<a href="/event/promotion#" data-no="8865" data-netfunnel="N" class="eventBtn" title="[메가박스X현대카드] 현대M포인트 금토일 5,000원 할인! 상세보기">
							

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

				
					<li>
						<a href="/event/promotion#" data-no="8820" data-netfunnel="N" class="eventBtn" title="[도서상품권] 온라인 예매도 도서문화상품권으로 간편하게! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/OpuLwqCq8mWRzy9x20xA8Vphz5FiIw4q.jpg" alt="[도서상품권] 온라인 예매도 도서문화상품권으로 간편하게!" onerror="noImg(this);"></p>

							<p class="tit">
								[도서상품권] 온라인 예매도 도서문화상품권으로 간편하게!
							</p>

							<p class="date">
								2020.10.15 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/promotion#" data-no="8782" data-netfunnel="N" class="eventBtn" title="[메가박스X컬쳐랜드] 문화상품권으로 메가박스를 즐기자! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/nWvPu6YhzejumPOeP9aYH6ovOsTtc1Cc.jpg" alt="[메가박스X컬쳐랜드] 문화상품권으로 메가박스를 즐기자!" onerror="noImg(this);"></p>

							<p class="tit">
								[메가박스X컬쳐랜드] 문화상품권으로 메가박스를 즐기자!
							</p>

							<p class="date">
								2020.10.06 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/promotion#" data-no="8724" data-netfunnel="N" class="eventBtn" title="[제로페이] 이제는 영화볼 때도 제로페이 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/gyREinDV8ZpKmHoYikOdfR4vu0iKdT4Q.jpg" alt="[제로페이] 이제는 영화볼 때도 제로페이" onerror="noImg(this);"></p>

							<p class="tit">
								[제로페이] 이제는 영화볼 때도 제로페이
							</p>

							<p class="date">
								2020.09.14 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/promotion#" data-no="9198" data-netfunnel="N" class="eventBtn" title="KT멤버십 고객 메가박스 영화 할인 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/QnqACuKoPlMtYGM262yAyvmV0TGAt4Ui.jpg" alt="KT멤버십 고객 메가박스 영화 할인" onerror="noImg(this);"></p>

							<p class="tit">
								KT멤버십 고객 메가박스 영화 할인
							</p>

							<p class="date">
								2023.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/promotion#" data-no="9187" data-netfunnel="N" class="eventBtn" title="U+멤버십 고객 영화 2,000원 할인 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/KFa8pQA1xZ0Ah1p8oHUNQVeDNStXkS4L.jpg" alt="U+멤버십 고객 영화 2,000원 할인" onerror="noImg(this);"></p>

							<p class="tit">
								U+멤버십 고객 영화 2,000원 할인
							</p>

							<p class="date">
								2021.02.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/promotion#" data-no="9043" data-netfunnel="N" class="eventBtn" title="[롯데멤버스] L.POINT로 할인 받고 2% 적립까지! 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/e3BLbNx56lNPYNrjtoiBKfg2e9cNTk3U.jpg" alt="[롯데멤버스] L.POINT로 할인 받고 2% 적립까지!" onerror="noImg(this);"></p>

							<p class="tit">
								[롯데멤버스] L.POINT로 할인 받고 2% 적립까지!
							</p>

							<p class="date">
								2020.12.17 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/promotion#" data-no="5118" data-netfunnel="N" class="eventBtn" title="메가박스 마스터콤보를 제공받을 수 있는 카드는? 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/7Wv9ErsevpJobv4RTyW3mNTbuCegoJfl.jpg" alt="메가박스 마스터콤보를 제공받을 수 있는 카드는?" onerror="noImg(this);"></p>

							<p class="tit">
								메가박스 마스터콤보를 제공받을 수 있는 카드는?
							</p>

							<p class="date">
								2017.01.01 ~ 2023.12.31
							</p>
						</a>
                
					</li>

				
					<li>
						<a href="/event/promotion#" data-no="4443" data-netfunnel="N" class="eventBtn" title="메가박스 하나카드 콤보 이벤트 상세보기">
							

							<!--<p class="img"><img src="../../../static/pc/images/event/@img-event-list-megabox.jpg" alt="" /></p>-->
							<p class="img"> <img src="/resources/event/y8iDbdor9E21ccFsJMyhyoE9YODKiKOy.jpg" alt="메가박스 하나카드 콤보 이벤트" onerror="noImg(this);"></p>

							<p class="tit">
								메가박스 하나카드 콤보 이벤트
							</p>

							<p class="date">
								2016.03.04 ~ 2023.12.31
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
        



<section id="saw_movie_regi" class="modal-layer"><a href="/event/promotion" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/event/promotion" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/event/promotion#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>