<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>

<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<script type="text/javascript">
$(function(){

/******************************************************************
*  초기 로딩 시 조회처리
/******************************************************************/


	fn_cardInfoList();
	fn_animation(); //배너 스와이프 애니메이션 처리



/******************************************************************
*  UI 컴포넌트 이벤트 처리
/******************************************************************/

// 검색버튼 클릭 이벤트
	$('#btnCardSearch').on('click', function() {
		var value = $('#searchTxt').val(); //카드명을 검색해보세요
		var form = $(document.forms.dcInfoForm);

		if(value == '') return false;

		$('[name=searchStr]').val(value);

		form.attr('action', '/benefit/discount/cardList');
		form.submit();
	});


// 검색 텍스트 엔터키 눌렀을때 클릭이벤트 실행
	$('#searchTxt').on('keydown', function(e) {
		if(e.keyCode == 13) {
			$('#btnCardSearch').click();
		}
	});


//통신사 셀렉트박스선택
	$('#sbxTelecom').change(function(){

		var form = $(document.forms.dcInfoForm);
		var selectVal = $('#sbxTelecom option:selected').text();

		$('[name=cardPartrCd]').val(selectVal).selectpicker('refresh');

		form.attr('action', '/benefit/discount/telecomcard');
		form.submit();

	});

//신용카드 셀렉트박스선택
	$('#sbxCredit').change(function(){
		var selectVal = $(this).val();
		var form = $(document.forms.dcInfoForm);
		//$('[name=cardPartrCd]').val(selectVal);
		$('[name=cardPartrCd]').val(selectVal).selectpicker('refresh');

		form.attr('action', '/benefit/discount/creditcard');
		form.submit();

	});

//포인트/기타제휴 셀렉트박스선택
	$('#sbxPoint').change(function(){
		var selectVal = $(this).val();
		var form = $(document.forms.dcInfoForm);
		$('[name=cardPartrCd]').val(selectVal).selectpicker('refresh');

		form.attr('action', '/benefit/discount/pointcard');
		form.submit();

	});

});

/******************************************************************
* 함수 선언
/******************************************************************/

/*상단 탭 카드 건수 , 셀렉트박스 카드사 리스트 조회*/
function fn_cardInfoList(){

	$.ajaxMegaBox({
		url: "/on/oh/ohf/DcCardGuide/selectDcCardCount.do",
		type: "POST",
		contentType: "application/json;charset=UTF-8",
		dataType: "json",
		data: JSON.stringify(),
		success: function (data, textStatus, jqXHR) {

			var telecom = data.returnMap.count.ckc01Cnt; //통신사
			var credit =  data.returnMap.count.ckc02Cnt; //신용카드
			var point =   data.returnMap.count.ckc03Cnt; //포인트


			$('#ckc01cnt').html(telecom);
			$('#ckc02cnt').html(credit);
		    $('#ckc03cnt').html(point);

		    //상단 탭에 갯수 셋팅
			$("#tab_credit").text("신용카드(" + credit + ")");
			$("#tab_telecom").text("통신사(" + telecom + ")");
			$("#tab_point").text("포인트/기타제휴(" + point + ")");

			//셀렉트박스에 옵션 셋팅 함수
			fn_selectCardList(data.returnMap.creditlist);
			fn_selectTelList(data.returnMap.telecom);
			fn_selectPointList(data.returnMap.pointlist);

			$("#dcInfoForm").append("<input type='hidden' name='count_credit' value='"+credit+"' />");
			$("#dcInfoForm").append("<input type='hidden' name='count_telecom' value='"+telecom+"' />");
			$("#dcInfoForm").append("<input type='hidden' name='count_point' value='"+point+"' />");
		},
		error: function(xhr,status,error){
			 var err = JSON.parse(xhr.responseText);
			 alert(xhr.status);
			 alert(err.message);
		}
	});

}


/*제휴이벤트 하단 > '더 많은 제휴혜택보기' 링크이동*/
function fn_goEvent() {

	var contentUrl = "/event/promotion"; //이벤트 페이지
	$("#dcInfoForm").attr("method","post");
	$("#dcInfoForm").attr("action",contentUrl);
	//$("#dcInfoForm").submit(); // 폼전송
	NetfunnelChk.formSubmit("EVENT_LIST", $("#dcInfoForm"), function(){}); //넷퍼넬적용
}


/*셀렉트 박스 옵션 셋팅 : 신용카드 카드사 리스트*/
function fn_selectCardList(result) {
	var items = result.cardComList;
		var target = $('#sbxCredit');
		var option;

		for(var i = 0; i < items.length; ++i) {
			option = $('<option>').val(items[i].cdId).html(items[i].cdNm);

			target.append(option);

		}

		target.selectpicker('refresh');


}

/*셀렉트 박스 옵션 셋팅 : 통신사 리스트*/
function fn_selectTelList(result) {
	var items = result.telecomList;
		var target = $('#sbxTelecom');
		var option;

		for(var i = 0; i < items.length; ++i) {
			option = $('<option>').val(items[i].cdId).html(items[i].cdNm);

			target.append(option);
		}
		target.selectpicker('refresh');
}

/*셀렉트 박스 옵션 셋팅 : 포인트카드 카드사 리스트*/
function fn_selectPointList(result) {
	var items = result.cardComList;
		var target = $('#sbxPoint');
		var option;

		for(var i = 0; i < items.length; ++i) {
			option = $('<option>').val(items[i].cdId).html(items[i].cdNm);

			target.append(option);
		}
		target.selectpicker('refresh');
}


/*상단 탭 이동 처리 함수*/
function fn_goTab(tabId){

	var id = tabId;

	switch(id){

	case "tab_credit":  //신용카드
		$("#dcInfoForm").attr("method","post");
		$("#dcInfoForm").attr("action","/benefit/discount/creditcard");
		$("#dcInfoForm").submit(); // 폼전송
	break;

	case "tab_telecom": //통신사

		$("#dcInfoForm").attr("method","post");
		$("#dcInfoForm").attr("action","/benefit/discount/telecomcard");
		$("#dcInfoForm").submit(); // 폼전송
	break;

	case "tab_point": // 포인트/기타제휴
		$("#dcInfoForm").attr("method","post");
		$("#dcInfoForm").attr("action","/benefit/discount/pointcard");
		$("#dcInfoForm").submit(); // 폼전송
	break;
	}

}


/*제휴할인 이벤트 전시 배너 스와이프 애니메이션 처리*/
function fn_animation(){
	if( $('.partnership-swiper').length > 0 ){
		var partnership_swiper = new Swiper('.partnership-swiper', {
			autoplay: {
				delay: 3000,
				disableOnInteraction: true,
			},
			loop : true,
			slidesPerView: 2,
			spaceBetween: 40,
			pagination: {
				el: '.partnership-pagination',
				//type: 'fraction',
				clickable: false,
			},
			navigation : {
				prevEl : '.partnership-prev',
				nextEl : '.partnership-next',
			},
			ally : {
				enabled : true
			}
		});

		// swiper 전체 count
		all_count = $('.partnership-swiper  .cell').length;
		dupli_count = $('.partnership-swiper .swiper-slide-duplicate').length;
		real_count = all_count - dupli_count;
		$('.partnership-slider .partnership-count .total').text(real_count)

		// 이벤트 배너 1개 이하일 경우 좌우 버튼 숨기기
		if(real_count < 2 ){
			$('#btnPrevEvent').hide();
			$('#btnNextEvent').hide();

			$('#btnPrevEvent2').hide();
			$('#btnNextEvent2').hide();

			$('.swiper-slide-duplicate').hide(); //스와이프용 duplicate 이미지 숨기기
		}

		// 현재 활성화된 swiper
		partnership_swiper.on('slideChange', function(){
			$('.partnership-slider .partnership-count .active').text(partnership_swiper.realIndex + 1)
		});

		// 자동실행 정지
		$('.partnership-util .pause').on('click', function(){
			partnership_swiper.autoplay.stop();

			$(this).removeClass('on');
			$('.partnership-util .play').addClass('on').focus();
		});

		// 자동실행 시작
		$('.partnership-util .play').on('click', function(){
			partnership_swiper.autoplay.start();

			$(this).removeClass('on');
			$('.partnership-util .pause').addClass('on').focus();
		});

		// 좌우 이동시 자동실행 정지됨
		$(document).on('click','.partnership-prev, .partnership-next', function(){
			$('.partnership-util .pause').removeClass('on');
			$('.partnership-util .play').addClass('on');
		});

		$(window).resize(function(){
			partnership_swiper.update();
		}).resize();
	}

}
</script>

<!-- 폼 전송 start -->
<form id="dcInfoForm" method="post">
	<input type="hidden" name="searchStr">
	<input type="hidden" name="cardPartrCd">

<input type="hidden" name="count_credit" value="286"><input type="hidden" name="count_telecom" value="2"><input type="hidden" name="count_point" value="13"></form>

<form id="dcEventInfo" method="get">
</form>
<!-- 폼 전송 end -->


<!-- container -->
		<div class="container">
			<div class="page-util">
				<div class="inner-wrap">
					<div class="location">
						<span>Home</span>
						<a href="#" title="혜택 메인 페이지로 이동">혜택</a>
						<a href="#" title="제휴할인 페이지로 이동">제휴/할인</a>
						<a href="#" title="할인안내 페이지로 이동">할인안내</a>
					</div>

				</div>
			</div>

			<!-- contents -->
			<div id="contents">
				<div class="inner-wrap">
					<h2 class="tit">제휴할인</h2>
				</div>

		
				<div class="partnership-slider">
					<div class="inner-wrap">
						<h3 class="tit">제휴이벤트</h3>

						<div class="partnership-pagination swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span><span class="swiper-pagination-bullet"></span></div>

						<div class="partnership-count">
							<span title="현재 페이지" class="active">3</span> /
							<span title="전체 페이지" class="total">4</span>
						</div>

						<div class="partnership-util">
							<button id="btnPrevEvent" type="button" class="partnership-prev" tabindex="0" role="button" aria-label="Previous slide">이전 이벤트 보기</button>
							<button id="btnNextEvent" type="button" class="partnership-next" tabindex="0" role="button" aria-label="Next slide">다음 이벤트 보기</button>

							<button type="button" class="pause on">일시정지</button>
							<button type="button" class="play">자동재생</button>
						</div>

						<div class="partnership-control">
							<button id="btnPrevEvent2" type="button" class="partnership-prev" tabindex="0" role="button" aria-label="Previous slide">이전 이벤트 보기</button>
							<button id="btnNextEvent2" type="button" class="partnership-next" tabindex="0" role="button" aria-label="Next slide">다음 이벤트 보기</button>
						</div>



						<div class="partnership-swiper swiper-container-initialized swiper-container-horizontal">
							<div class="swiper-wrapper" id="swiper-wrapper-area" style="transform: translate3d(-2280px, 0px, 0px); transition-duration: 300ms;"><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="2" style="width: 530px; margin-right: 40px;">
										<a href="#" class="eventBtn" data-no="11263" data-netfunnel="N" title="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요! 상세보기">
											<p class="img"><img src="/resources/benefits/HmcDZ2pEwgwyYTNCKXJxU0WKdDOOOENG.jpg" alt="" onerror="noImg(this);"></p>
											<div class="cont">
												<p class="tit">내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!</p>
												<p class="date">2022.04.18~2023.12.31</p>
											</div>
										</a>
									</div><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="3" style="width: 530px; margin-right: 40px;">
										<a href="#" class="eventBtn" data-no="9187" data-netfunnel="N" title="U+멤버십 고객 영화 2,000원 할인 상세보기">
											<p class="img"><img src="/resources/benefits/poxTnLz5oVfwTJlW6TINBrEKv3jP2GIJ.jpg" alt="" onerror="noImg(this);"></p>
											<div class="cont">
												<p class="tit">U+멤버십 고객 영화 2,000원 할인</p>
												<p class="date">2021.02.01~2023.12.31</p>
											</div>
										</a>
									</div>
 								<!-- 제휴이벤트 배너 반복  -->
								
									<div class="cell swiper-slide" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
										<a href="#" class="eventBtn" data-no="12392" data-netfunnel="N" title="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자! 상세보기">
											<p class="img"><img src="/resources/benefits/iFpskcjm9wzchFEmLxHd9nmyUrEPdwTq.png" alt="" onerror="noImg(this);"></p>
											<div class="cont">
												<p class="tit">[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!</p>
												<p class="date">2022.12.23~2023.03.05</p>
											</div>
										</a>
									</div>
								
									<div class="cell swiper-slide swiper-slide-prev" data-swiper-slide-index="1" style="width: 530px; margin-right: 40px;">
										<a href="#" class="eventBtn" data-no="11739" data-netfunnel="N" title="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트 상세보기">
											<p class="img"><img src="/resources/benefits/iFnmkKFpZXrfGUAG6f2XvrELUL9DDF8A.jpg" alt="" onerror="noImg(this);"></p>
											<div class="cont">
												<p class="tit">[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트</p>
												<p class="date">2022.08.22~2023.02.28</p>
											</div>
										</a>
									</div>
								
									<div class="cell swiper-slide swiper-slide-active" data-swiper-slide-index="2" style="width: 530px; margin-right: 40px;">
										<a href="#" class="eventBtn" data-no="11263" data-netfunnel="N" title="내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요! 상세보기">
											<p class="img"><img src="/resources/benefits/HmcDZ2pEwgwyYTNCKXJxU0WKdDOOOENG.jpg" alt="" onerror="noImg(this);"></p>
											<div class="cont">
												<p class="tit">내 차 보험료 확인하고 영화 1만원 할인쿠폰 받으세요!</p>
												<p class="date">2022.04.18~2023.12.31</p>
											</div>
										</a>
									</div>
								
									<div class="cell swiper-slide swiper-slide-next" data-swiper-slide-index="3" style="width: 530px; margin-right: 40px;">
										<a href="#" class="eventBtn" data-no="9187" data-netfunnel="N" title="U+멤버십 고객 영화 2,000원 할인 상세보기">
											<p class="img"><img src="/resources/benefits/poxTnLz5oVfwTJlW6TINBrEKv3jP2GIJ.jpg" alt="" onerror="noImg(this);"></p>
											<div class="cont">
												<p class="tit">U+멤버십 고객 영화 2,000원 할인</p>
												<p class="date">2021.02.01~2023.12.31</p>
											</div>
										</a>
									</div>
								
 								<!--// 제휴이벤트 배너 반복 -->
							<div class="cell swiper-slide swiper-slide-duplicate" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
										<a href="#" class="eventBtn" data-no="12392" data-netfunnel="N" title="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자! 상세보기">
											<p class="img"><img src="/resources/benefits/iFpskcjm9wzchFEmLxHd9nmyUrEPdwTq.png" alt="" onerror="noImg(this);"></p>
											<div class="cont">
												<p class="tit">[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!</p>
												<p class="date">2022.12.23~2023.03.05</p>
											</div>
										</a>
									</div><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" data-swiper-slide-index="1" style="width: 530px; margin-right: 40px;">
										<a href="#" class="eventBtn" data-no="11739" data-netfunnel="N" title="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트 상세보기">
											<p class="img"><img src="/resources/benefits/iFnmkKFpZXrfGUAG6f2XvrELUL9DDF8A.jpg" alt="" onerror="noImg(this);"></p>
											<div class="cont">
												<p class="tit">[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트</p>
												<p class="date">2022.08.22~2023.02.28</p>
											</div>
										</a>
									</div></div>
						<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>

						<div class="more">
							<a href="#" onclick="fn_goEvent()" title="이벤트 페이지로 이동">더 많은 제휴혜택 보기 <i class="iconset ico-arr-right-green"></i></a>

						</div>
					</div>
				</div>
		


				<!-- inner-wrap -->
				<div class="inner-wrap mt40">

					<div class="tab-list fixed">
						<ul>
							<li class="on"><a href="#" title="할인안내 탭으로 이동">할인안내</a></li>
							<li><a href="#" id="tab_credit" title="신용카드 탭으로 이동">신용카드(286)</a></li>
							<li><a href="#" id="tab_telecom" title="통신사 탭으로 이동">통신사(2)</a></li>
							<li><a href="#" id="tab_point" title="포인트 기타제휴 탭으로 이동">포인트/기타제휴(13)</a></li>
							<li><a href="#" id="tab_gift" title="상품권 관람권 탭으로 이동">상품권/관람권(4)</a></li>
						</ul>
					</div>

					<!-- partnership-page -->
					<div class="partnership-page mt40">

						<!-- search-card -->
						<div class="search-card">
							<div class="tit-area">
								<p class="tit">더욱 알뜰하게 메가박스를 즐기는 방법!</p>

								<p class="txt">소지하고 계신 카드를 검색해 보세요. 할인 및 혜택정보를 빠르게 확인할 수 있어요.</p>
							</div>

							<div class="search-area">
								<input type="text" placeholder="카드명을 검색해보세요." title="카드명 입력" class="input-text" name="searchStr" id="searchTxt">
								<button type="button" class="btn-search-card" id="btnCardSearch">검색</button>
							</div>
						</div>
						<!--// search-card -->

						<!-- select-group -->
						<div class="select-group">
							<div class="block col-3">
								<div class="col">
									<div class="tit-area">
										<p class="tit">통신사</p>

										<a href="benefit/discount/telecomcard" title="통신사 전체보기">전체보기 <i class="iconset ico-arr-right-gray-small"></i></a>
									</div>

									<div class="number" id="ckc01cnt">2</div>

									<div class="select">
										<div class="dropdown bootstrap-select bs3 dropup"><select title="통신사 선택" id="sbxTelecom" class="selectpicker" tabindex="-98"><option class="bs-title-option" value=""></option>
											<option>통신사 선택</option>
										<option value="TCSKT">SKT</option><option value="TCKT">KT</option><option value="TCLGU">LGU＋</option></select><button type="button" class="btn dropdown-toggle bs-placeholder btn-default" data-toggle="dropdown" role="button" data-id="sbxTelecom" title="통신사 선택"><div class="filter-option"><div class="filter-option-inner"><div class="filter-option-inner-inner">통신사 선택</div></div> </div><span class="bs-caret"><span class="caret"></span></span></button><div class="dropdown-menu open" role="combobox" style="overflow: hidden;"><div class="inner open" role="listbox" aria-expanded="false" tabindex="-1" style="overflow-y: auto;"><ul class="dropdown-menu inner "><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">통신사 선택</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">SKT</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">KT</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">LGU＋</span></a></li></ul></div></div></div>
									</div>
								</div>

								<div class="col">
									<div class="tit-area">
										<p class="tit">신용카드</p>

										<a href="benefit/discount/creditcard" title="신용카드 전체보기">전체보기 <i class="iconset ico-arr-right-gray-small"></i></a>
									</div>

									<div class="number" id="ckc02cnt">286</div>

									<div class="select">
										<div class="dropdown bootstrap-select bs3 dropup"><select title="카드 선택" id="sbxCredit" name="sbxCredit" class="selectpicker" tabindex="-98"><option class="bs-title-option" value=""></option>
											<option>카드 선택</option>
										<option value="CPCT00">메가박스카드</option><option value="CPCT01">삼성카드</option><option value="CPCT02">현대카드</option><option value="CPCT03">신한카드</option><option value="CPCT04">비씨카드</option><option value="CPCT05">KB국민카드</option><option value="CPCT06">우리카드</option><option value="CPCT07">하나카드</option><option value="CPCT09">NH농협카드</option><option value="CPCT10">씨티카드</option><option value="CPCT11">IBK기업은행</option><option value="CPCT15">SC제일은행</option><option value="CPCT99">기타</option></select><button type="button" class="btn dropdown-toggle bs-placeholder btn-default" data-toggle="dropdown" role="button" data-id="sbxCredit" title="카드 선택"><div class="filter-option"><div class="filter-option-inner"><div class="filter-option-inner-inner">카드 선택</div></div> </div><span class="bs-caret"><span class="caret"></span></span></button><div class="dropdown-menu open" role="combobox" style="max-height: 302px; overflow: hidden; min-width: 113px;"><div class="inner open" role="listbox" aria-expanded="false" tabindex="-1" style="max-height: 300px; overflow-y: auto;"><ul class="dropdown-menu inner "><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">카드 선택</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">메가박스카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">삼성카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">현대카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">신한카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">비씨카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">KB국민카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">우리카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">하나카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">NH농협카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">씨티카드</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">IBK기업은행</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">SC제일은행</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">기타</span></a></li></ul></div></div></div>
									</div>
								</div>

								<div class="col">
									<div class="tit-area">
										<p class="tit">포인트/기타제휴</p>

										<a href="benefit/discount/pointcard" title="포인트 기타제휴 전체보기">전체보기 <i class="iconset ico-arr-right-gray-small"></i></a>
									</div>

									<div class="number" id="ckc03cnt">13</div>

									<div class="select">
										<div class="dropdown bootstrap-select bs3 dropup"><select title="포인트/기타제휴 선택" id="sbxPoint" class="selectpicker" tabindex="-98"><option class="bs-title-option" value=""></option>
											<option>포인트/기타제휴 선택</option>
										<option value="CPCT99">기타</option></select><button type="button" class="btn dropdown-toggle bs-placeholder btn-default" data-toggle="dropdown" role="button" data-id="sbxPoint" title="포인트/기타제휴 선택"><div class="filter-option"><div class="filter-option-inner"><div class="filter-option-inner-inner">포인트/기타제휴 선택</div></div> </div><span class="bs-caret"><span class="caret"></span></span></button><div class="dropdown-menu open" role="combobox" style="overflow: hidden;"><div class="inner open" role="listbox" aria-expanded="false" tabindex="-1" style="overflow-y: auto;"><ul class="dropdown-menu inner "><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">포인트/기타제휴 선택</span></a></li><li><a role="option" aria-disabled="false" tabindex="0" aria-selected="false"><span class="text">기타</span></a></li></ul></div></div></div>
									</div>
								</div>
							</div>

							<div class="block mt25">
								<div class="col">
									<div class="tit-area">
										<p class="tit">상품권/관람권</p>

										<a href="benefit/discount/giftcard" title="상품권 관람권 전체보기">전체보기 <i class="iconset ico-arr-right-gray-small"></i></a>
									</div>
								</div>
							</div>
						</div>
						<!--// select-group -->
					</div>
					<!--// partnership-page -->
				</div>
				<!--// inner-wrap -->
			</div>
			<!--// contents -->
		</div>
		<!--// container -->

<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="benefit/discount/guide" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="benefit/discount/guide" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="#" data-url="https://m.megabox.co.kr">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>