<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->

<script type="text/javascript">

$(function(){

	fn_animation(); //이벤트 배너 애니메이션
	fn_selectVipActivity();

/************************************************************************
*  UI 컴포넌트 이벤트
**************************************************************************/

	//로그인 전 로그인 버튼
	$(document).on('click', '#moveLogin', function() {

		fn_viewLoginPopup('default','pc');
	});

	//vip 미션 이벤트 보기 버튼
	$('#btnVipMission').on('click', function(){
		if( '' == "NORMAL"){ //회원등급  : 일반
			return gfn_alertMsgBox('VIP 회원만 이용 가능합니다.');
		}else{

			fn_vipStampMission();
		}

	});

	//vip 미션 이벤트 보기 버튼
	$('#btnVipStamp').on('click', function(){

		fn_vipStampMission();
	});



	//카드신청하기(중앙멤버십) 버튼
	$('#btnJoinMbship').on('click', function(){

		var paperYn ="N"; //중앙일보 구독여부
		var giganToDate = '2023.02.28';

		var svcEndDe =  giganToDate.replaceAll(".","");

		// 임시 휴대폰번호 인 회원 RETURN
		if('' == "010-9999-****"){
			return gfn_alertMsgBox('휴대폰번호 변경 후 신청 바랍니다.');
		}

		if('' == "NORMAL"){

			return gfn_alertMsgBox('VIP 회원만 중앙멤버십 신청이 가능합니다.');

		}else{
			if(!$('#jggMembershipChk_1').prop('checked') ){ //중앙멤버십 혜택 체크박스 미선택 시
				return gfn_alertMsgBox('중앙멤버십 혜택 신청은 필수 선택입니다.');
			}

			if(!$('#jggMembershipChk_3').prop('checked') ){ //정보제공동의 체크박스 미선택 시
				return gfn_alertMsgBox('제3자 정보제공에 동의해주세요.');
			}


			if($('#jggMembershipChk_2').prop('checked')){ //중앙일보 구독 신청 체크박스 선택 시
				paperYn = "Y";
			}

			fn_jggMbshipJoin(paperYn, svcEndDe);

		}

	});




});



/*vip 배너 스와이프 처리*/
function fn_animation(){

	if( $('.benefit-swiper').length > 0 ){
		var benefit_swiper = new Swiper('.benefit-swiper', {
			autoplay: {
				delay: 3000,
				disableOnInteraction: true,
			},
			loop : true,
			slidesPerView: 2,
			spaceBetween: 40,
			pagination: {
				el: '.benefit-pagination',
				//type: 'fraction',
				clickable: false,
			},
			navigation : {
				prevEl : '.benefit-prev',
				nextEl : '.benefit-next',
			},
			ally : {
				enabled : true
			}
		});

		// swiper 전체 count
		all_count = $('.benefit-swiper .cell').length;
		dupli_count = $('.benefit-swiper .swiper-slide-duplicate').length;
		real_count = all_count - dupli_count;

		if('8' > 0) $('.benefit-slider .benefit-count .active').text(benefit_swiper.realIndex + 1);
		$('.benefit-slider .benefit-count .total').text(real_count);

		// 이벤트 배너 1개 이하일 경우 좌우 버튼 숨기기
		if(real_count < 2 ){
			$('#btnPrevEvent').hide();
			$('#btnNextEvent').hide();

			$('#btnPrevEvent2').hide();
			$('#btnNextEvent2').hide();

			$('.swiper-slide-duplicate').hide(); //스와이프용 duplicate 이미지 숨기기
		}


		// 현재 활성화된 swiper
		benefit_swiper.on('slideChange', function(){
			if('8' > 0) $('.benefit-slider .benefit-count .active').text(benefit_swiper.realIndex + 1);
		});

		// 자동실행 정지
		$('.benefit-util .pause').on('click', function(){
			benefit_swiper.autoplay.stop();

			$(this).removeClass('on');
			$('.benefit-util .play').addClass('on').focus();
		});

		// 자동실행 시작
		$('.benefit-util .play').on('click', function(){
			benefit_swiper.autoplay.start();

			$(this).removeClass('on');
			$('.benefit-util .pause').addClass('on').focus();
		});

		// 좌우 이동시 자동실행 정지됨
		$(document).on('click','.benefit-prev, .benefit-next', function(){
			$('.benefit-util .pause').removeClass('on');
			$('.benefit-util .play').addClass('on');
		});

		$(window).resize(function(){
			benefit_swiper.update();
		}).resize();
	}

}

/*vip미션이벤트 팝업 호출*/
function fn_vipStampMission(){

	var option = {
		url    : '/on/oh/ohh/MyScnBoard/MyVipEventPopup.do',
		height : 800,
		width  : 600
	}

	gfn_divLayPopUp(option);

}


/*중앙 멤버십 신청하기 */
function fn_jggMbshipJoin(paperYn, svcEndDe){

	$.ajaxMegaBox({
		url: "/on/oh/ohf/VipGuide/jggMbship.do",
		type: "POST",
		contentType: "application/json;charset=UTF-8",
		dataType: "json",
		data: JSON.stringify({regPaper : paperYn, svcEndDe: svcEndDe }),
		clickLmtChk	  : true, //중복클릭 방지 실행
		success: function (data, textStatus, jqXHR) {

			var dataList = data.result; //리턴 값 받아오기

			if(dataList.beforeJoinYn == "Y"){ //중앙멤버십 기가입자인 경우
				gfn_alertMsgBox('이미 중앙멤버십에 가입된 회원입니다.');
				return false;

			}else{


				if(dataList.newJoinJgg =="Y" && dataList.newJoinMbx =="Y"){ //가입 성공 여부 파라미터 값이 Y 이면
					var options = {};
					options.msg = 'VIP 멤버십 혜택 신청이 완료되었습니다.';
					options.callback  = fn_closeModal;
					options.minWidth  = 300;
					options.minHeight = 250;
					gfn_alertMsgBox(options);
				}

				if(dataList.newJoinJgg =="err01"){ //기가입여부 확인 실패
					gfn_alertMsgBox('기존 가입여부 조회 오류로 인해 가입에 실패했습니다.');
					return false;
				}

				if(dataList.newJoinJgg =="err02"){ //연계오류
					gfn_alertMsgBox('중앙멤버십 서버 오류로 인해 \n가입에 실패했습니다. \n중앙멤버십 고객 센터 : 02-2108-3456(평일 9~18시)');
					return false;
				}

				if(dataList.newJoinJgg =="err03"){ //전화번호 오류
					gfn_alertMsgBox('휴대폰 번호 변경 후 신청 바랍니다.');
					return false;
				}
			}

		},

		complete : function(xhr){
			clearLmt();    		//중복제한 초기화
		},
		error: function(xhr,status,error){
			 var err = JSON.parse(xhr.responseText);
			 alert(xhr.status);
			 alert(err.message);
		}
	});

}

/*레이어 팝업 닫기*/
function fn_closeModal(){
	$('#layer_card_request button.btn-modal-close').trigger("click");
}

/* VIP선정활동내역 HTML*/
function fn_selectVipActivity(){

	var htmlTxt="";

	htmlTxt +="	<ul class=\"dot-list gray\">";
	htmlTxt +="		<li>";
	htmlTxt +="			<div class=\"block\">";
	htmlTxt +="				<p class=\"left\">서로 다른 영화 관람</p>";
	htmlTxt +="				<p class=\"right\">"+  +" 편</p>";
	htmlTxt +="			</div>";
	htmlTxt +="		</li>";
	htmlTxt +="		<li>";
	htmlTxt +="			<div class=\"block\">";
	htmlTxt +="				<p class=\"left\">포인트</p>";
	htmlTxt +="				<p class=\"right\">"+numberFormat()+" P</p>";
	htmlTxt +="			</div>";

	htmlTxt +="			<ul class=\"detail\">";
	htmlTxt +="				<li>";
	htmlTxt +="					<p class=\"left\">티켓</p>";

	htmlTxt +="					<p class=\"right\">"+numberFormat()+" P</p>";
	htmlTxt +="				</li>";
	htmlTxt +="				<li>";
	htmlTxt +="					<p class=\"left\">매점</p>";

	htmlTxt +="					<p class=\"right\">"+numberFormat()+" P</p>";
	htmlTxt +="				</li>";
	htmlTxt +="				<li>";
	htmlTxt +="					<p class=\"left\">이벤트</p>";

	htmlTxt +="					<p class=\"right\">"+numberFormat()+" P</p>";
	htmlTxt +="				</li>";
	htmlTxt +="			</ul>";
	htmlTxt +="		</li>";
	htmlTxt +="	</ul>";
	htmlTxt +="<div style='text-align: center;margin-top: 10px;'>실적 산정 기간 : 22년 1월 1일 ~ 23년 2월 28일</div>";

	$('.activityInfo').html(htmlTxt);
}

/*천단위 콤마*/
function numberFormat(inputNumber) {
	if(inputNumber > 0){
		return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}else{
		return inputNumber;
	}

}

</script>

<!-- 폼 전송 start -->
<form id="vipInfoForm" method="post">
</form>
<!-- 폼 전송 end -->



<!-- container -->
		<div class="container">
			<div class="page-util">
				<div class="inner-wrap">
					<div class="location">
						<span>Home</span>
						<a href="/benefits/memberShip" title="혜택 메인 페이지로 이동">혜택</a>
						<a href="/benefits/memberShip" title="멤버십안내 페이지로 이동">메가박스 멤버십</a>
						<a href="/benefits/vipLounge" title="VIP LOUNGE 페이지로 이동">VIP LOUNGE</a>
					</div>

				</div>
			</div>

			<!-- contents -->
			<div id="contents">
				<div class="inner-wrap">
					<h2 class="tit">메가박스 멤버십</h2>

					<div class="tab-list">
						<ul>
							<li><a href="/benefits/memberShip" title="멤버십 안내 탭으로 이동">멤버십 안내</a></li>
							<li class="on"><a href="/benefits/vipLounge" title="VIP LOUNGE 탭으로 이동">VIP LOUNGE</a></li>
						</ul>
					</div>

					<!-- benefit-vip-lounge -->

				<!-- 로그인 전 -->
				
					<div class="benefit-vip-lounge common">
						<div class="tit-area">
							<p class="tit">MEGABOX VIP</p>
							<p class="txt">
								메가박스의 더 많은 혜택을 누릴 수 있는 방법!<br>
							</p>
						</div>
						<div class="cont-area">
							<div class="login-before">
								<i class="iconset ico-question-circle-big"></i>
								<p class="txt">
									로그인 후 메가박스 등급을 확인하세요.
								</p>
								<div>
									<a href="/benefits/vipLounge#layer_login_select" id="moveLogin" class="button gray-line large btn-modal-open" w-data="850" h-data="484" title="로그인하기">로그인</a>
								</div>
							</div>
						</div>
					</div>

				

				<!-- 로그인 후 -->
				
				<!--cont-area -->

<!-- 							</div> -->
							
						</div>
						<!--// cont-area -->
					</div>
					<!--// benefit-vip-lounge -->


				<div class="benefit-slider">
					<div class="inner-wrap">
						<p class="tit-slider">VIP 회원님을 위한 특별한 이벤트!!</p>

						<div class="benefit-pagination swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span></div>

						<div class="benefit-count">
							<span title="현재 페이지" class="active">3</span> /
							<span title="전체 페이지" class="total">8</span>
						</div>

						<div class="benefit-util">
							<button type="button" class="benefit-prev" id="btnPrevEvent" tabindex="0" role="button" aria-label="Previous slide">이전 이벤트 보기</button>
							<button type="button" class="benefit-next" id="btnNextEvent" tabindex="0" role="button" aria-label="Next slide">다음 이벤트 보기</button>
							<button type="button" class="pause on">일시정지</button>
							<button type="button" class="play">자동재생</button>
						</div>

						<div class="benefit-control">
							<button type="button" class="benefit-prev" id="btnPrevEvent2" tabindex="0" role="button" aria-label="Previous slide">이전 이벤트 보기</button>
							<button type="button" class="benefit-next" id="btnNextEvent2" tabindex="0" role="button" aria-label="Next slide">다음 이벤트 보기</button>
						</div>
					</div>

					<div class="benefit-swiper swiper-container-initialized swiper-container-horizontal">
						<div class="swiper-wrapper" id="swiper-wrapper-area" style="transform: translate3d(-2280px, 0px, 0px); transition-duration: 0ms;"><div class="cell swiper-slide swiper-slide-duplicate" data-swiper-slide-index="6" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="11082" data-netfunnel="" title="[VIP제휴혜택] 2022 교보문고 &amp; 핫트랙스 특별 제휴 안내 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/6hwXgAshZjvSCu2EwkjelmByKxFaj2EW.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">[VIP제휴혜택] 2022 교보문고 &amp; 핫트랙스 특별 제휴 안내</p>
											<p class="date">2022.03.01~2023.02.28</p>
										</div>
									</a>
								</div><div class="cell swiper-slide swiper-slide-duplicate" data-swiper-slide-index="7" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12408" data-netfunnel="" title="나도 영화 평론가! 관람평 작성하면 50P 적립! 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/QCNmZVvKhycHX24jnZkpfWCDGgBNvbCM.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">나도 영화 평론가! 관람평 작성하면 50P 적립!</p>
											<p class="date">2023.01.01~2023.12.31</p>
										</div>
									</a>
								</div>
							<!-- 반복 -->
							
								<div class="cell swiper-slide" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12621" data-netfunnel="" title="메가박스 오리지널 티켓 Re.15 &lt;타이타닉&gt; 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/ZjyzLdb4Xn0XQdgQK5Yfd405HgngiJqz.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">메가박스 오리지널 티켓 Re.15 &lt;타이타닉&gt;</p>
											<p class="date">2023.02.06~2023.03.06</p>
										</div>
									</a>
								</div>
							
								<div class="cell swiper-slide swiper-slide-prev" data-swiper-slide-index="1" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12591" data-netfunnel="" title="&lt;교섭&gt; 4주차 첫관람 이벤트! 안 본 눈 삽니다👀 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/oo73kg65C1g8Ae0UHhdh4Gcvac46wp7T.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">&lt;교섭&gt; 4주차 첫관람 이벤트! 안 본 눈 삽니다👀</p>
											<p class="date">2023.02.01~2023.02.19</p>
										</div>
									</a>
								</div>
							
								<div class="cell swiper-slide swiper-slide-active" data-swiper-slide-index="2" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12579" data-netfunnel="" title="황홀하지만, 위태로운 &lt;바빌론&gt; 1PICK 이벤트 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/xuQBpqut4Vffnf4h5VfzWl6H2hY207tv.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">황홀하지만, 위태로운 &lt;바빌론&gt; 1PICK 이벤트</p>
											<p class="date">2023.02.01~2023.02.21</p>
										</div>
									</a>
								</div>
							
								<div class="cell swiper-slide swiper-slide-next" data-swiper-slide-index="3" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12570" data-netfunnel="" title="메가박스 오리지널 티켓 No.68 &lt;바빌론&gt; 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/tdlN0ZGcmNK4d4qJ9TWUns2G8wzoap3t.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">메가박스 오리지널 티켓 No.68 &lt;바빌론&gt;</p>
											<p class="date">2023.01.30~2023.03.15</p>
										</div>
									</a>
								</div>
							
								<div class="cell swiper-slide" data-swiper-slide-index="4" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12509" data-netfunnel="" title="메가박스 오리지널 티켓 No.67 &lt;교섭&gt; 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/6QRiKzjeLbGXK0ijKPqxacyW8aSFZbqB.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">메가박스 오리지널 티켓 No.67 &lt;교섭&gt;</p>
											<p class="date">2023.01.16~2023.02.15</p>
										</div>
									</a>
								</div>
							
								<div class="cell swiper-slide" data-swiper-slide-index="5" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12419" data-netfunnel="" title="2023 VIP 선정 기준 안내 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/P7EzMunWsib47AyiLQQlQ83fkh1CZCjX.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">2023 VIP 선정 기준 안내</p>
											<p class="date">2022.12.28~2023.02.28</p>
										</div>
									</a>
								</div>
							
								<div class="cell swiper-slide" data-swiper-slide-index="6" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="11082" data-netfunnel="" title="[VIP제휴혜택] 2022 교보문고 &amp; 핫트랙스 특별 제휴 안내 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/6hwXgAshZjvSCu2EwkjelmByKxFaj2EW.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">[VIP제휴혜택] 2022 교보문고 &amp; 핫트랙스 특별 제휴 안내</p>
											<p class="date">2022.03.01~2023.02.28</p>
										</div>
									</a>
								</div>
							
								<div class="cell swiper-slide" data-swiper-slide-index="7" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12408" data-netfunnel="" title="나도 영화 평론가! 관람평 작성하면 50P 적립! 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/QCNmZVvKhycHX24jnZkpfWCDGgBNvbCM.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">나도 영화 평론가! 관람평 작성하면 50P 적립!</p>
											<p class="date">2023.01.01~2023.12.31</p>
										</div>
									</a>
								</div>
							
							<!--// 반복 -->
						<div class="cell swiper-slide swiper-slide-duplicate" data-swiper-slide-index="0" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12621" data-netfunnel="" title="메가박스 오리지널 티켓 Re.15 &lt;타이타닉&gt; 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/ZjyzLdb4Xn0XQdgQK5Yfd405HgngiJqz.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">메가박스 오리지널 티켓 Re.15 &lt;타이타닉&gt;</p>
											<p class="date">2023.02.06~2023.03.06</p>
										</div>
									</a>
								</div><div class="cell swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" data-swiper-slide-index="1" style="width: 530px; margin-right: 40px;">
									<a href="/benefits/vipLounge#" class="eventBtn" data-no="12591" data-netfunnel="" title="&lt;교섭&gt; 4주차 첫관람 이벤트! 안 본 눈 삽니다👀 상세보기">
										<p class="img"><img width="530" height="245" src="/resources/benefits/oo73kg65C1g8Ae0UHhdh4Gcvac46wp7T.jpg" alt="" onerror="noImg(this);"></p>
										<div class="cont">
											<p class="tit">&lt;교섭&gt; 4주차 첫관람 이벤트! 안 본 눈 삽니다👀</p>
											<p class="date">2023.02.01~2023.02.19</p>
										</div>
									</a>
								</div></div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				</div>

				<!-- inner-wrap -->
				<div class="inner-wrap">
					<!-- benefit-vip-selection -->
					<div class="benefit-vip-selection">
						<h3 class="tit">VIP 선정 기준</h3>

						<h4 class="tit">2022년 VIP 선정 기준</h4>

						<!-- block -->
						<div class="block">
							<div class="box vip">
								<p class="tit">VIP</p>

								<p class="txt">
										2021년 누적 승급 포인트<br>
										<br>
										2,000 포인트 이상<br>
										(2021년 VIP 회원)<br>
										<br>
										6,000 포인트 이상<br>
											(2021년 일반 회원)<br>
								</p>
							</div>

							<div class="box vip-p">
								<p class="tit">VIP PREMIUM</p>

								<p class="txt vip-p">
									2021년 누적 승급포인트<br>
									11,000 포인트 이상
								</p>
							</div>

							<div class="box vvip">
								<p class="tit">VVIP</p>

								<p class="txt vip-p">
									2021년 누적 승급포인트<br>
									27,000 포인트 이상<br>
										<br>
									또는<br>
										<br>
										서로 다른 영화<br>
										50편 이상 유료 관람
								</p>
							</div>
						</div>
						<!--// block -->

						<div class="period">
							<p>선정기간 : 2021.01.01 ~ 2021.12.31 (상영일 기준)</p>
							<p>자격기간 : 2022.03.02 ~ 2023.02.28 (상영일 기준)</p>
						</div>

						<ul class="dot-list mt15">
							<li>VIP 등급 선정 기준 및 혜택은 매년 상이할 수 있습니다.</li>
							<li>VIP 회원 혜택은 내부 사정에 의하여 변경 또는 종료될 수 있습니다.</li>
							<li>VIP 회원 추가 적립 포인트, 선물 받은 포인트, 이벤트 적립 포인트, 제휴처 적립 포인트 등은 VIP 산정에서 제외됩니다.</li>
							<li>“서로 다른 영화”는  선정 기간 내 멤버십 포인트 적립된 영화 중 서로 다른 영화를 의미합니다. (동일 영화는 1편으로 산정)</li>
						</ul>
					</div>
					<!--// benefit-vip-selection -->

					<!-- benefit-vip-benefit -->
					<div class="benefit-vip-benefit mt70">
						<h3 class="tit">VIP 멤버십 혜택</h3>

						<p class="txt-info">
							<span>VIP 쿠폰북</span>
							<span>회원님의 취향에 따라 원하시는 쿠폰을 선택하시고 다운 받으세요!</span>
						</p>

						<!-- bg-coupon-block -->
						<div class="bg-coupon-block">
							<div class="box">
								<table>
									<colgroup>
										<col style="width:180px;">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<td>
												<i class="iconset ico-benefit-movie"></i>
											</td>
											<td class="a-l">
												<p class="tit">영화</p>
												<p class="txt">VIP 영화관람 쿠폰</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="box">
								<table>
									<colgroup>
										<col style="width:180px;">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<td>
												<i class="iconset ico-benefit-cafeteria"></i>
											</td>
											<td class="a-l">
												<p class="tit">매점</p>
												<p class="txt">VIP 매점이용 쿠폰</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!--// bg-coupon-block -->

						<ul class="dot-list mt15">
							<li>본 혜택은 VIP 등급 유지 기간 중 제공됩니다. 직접 쿠폰을 선택하신 후 다운받으셔야 쿠폰을 이용하실 수 있습니다.</li>
							<li>등급 별 VIP 쿠폰 제공이 상이하오니 VIP 쿠폰북 안내를 통해 확인해주세요.</li>
							<li>쿠폰마다 유효 기간이 상이합니다. 유효기간을 꼭 확인해 주세요!</li>
						</ul>

						<div class="btn-group">
							<a href="#" class="button purple large" title="VIP쿠폰북 안내 페이지로 이동">VIP쿠폰 상세보기</a>
						</div>

						<p class="txt-info mt40">
							<span>5년 연속 VIP 혜택</span>
							<span>축하드립니다! <em class="font-gblue">5년 연속 VIP 회원</em>에게 추가 혜택을 드립니다.</span>
						</p>

						<!-- bg-coupon-block -->
						<div class="bg-coupon-block">
							<div class="box">
								<table>
									<colgroup>
										<col style="width:180px;">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<td>
												<i class="iconset ico-benefit-ticket"></i>
											</td>
											<td class="a-l">
												<p class="tit">스폐셜 쿠폰</p>
												<p class="txt">영화 관람 쿠폰 2매</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!--// bg-coupon-block -->

						<ul class="dot-list mt15">
							<li>지난 VIP 등급 이력은 로그인 후 “나의 메가박스 &gt; 지난 등급 조회”에서 확인 가능합니다.</li>
							<li>스페셜 쿠폰은 2022년 3월 2일 이후 순차적으로 지급됩니다.</li>
							<li>스페셜 쿠폰의 세부 사항은 쿠폰 발급 후, 쿠폰 내 유의 사항을 참고해 주십시오.</li>
						</ul>

						<p class="txt-info mt40">
							<span>VIP 미션 이벤트</span>
							<span>매월 서로 다른 영화 5회 이상 관람 시 미션 성공 쿠폰 제공!</span>
						</p>

						<!-- benefit-mission -->
						<div class="benefit-mission">
							<table>
								<tbody>
									<tr>
										<td>
											<i class="iconset ico-benefit-mission"></i>
										</td>
										<td>
											<div>
												<p class="tit">VIP, VIP PREMIUM</p>
												<p class="txt">영화 2천원 할인 쿠폰 2매</p>
											</div>

											<div class="mt05">
												<p class="tit">VVIP</p>
												<p class="txt">일반 2D 무료관람 쿠폰 1매</p>
											</div>
										</td>
										<td>
											<i class="iconset ico-plus-circle">더하기</i>
											콤보 4천원 할인 쿠폰 1매
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// benefit-mission -->

						<ul class="dot-list mt15">
							<li>영화 유료 관람 후, 포인트가 적립된 티켓 기준으로 서로 다른 영화 관람 편수가 책정됩니다.</li>
							<li>미션 달성 시 제공되는 쿠폰은 매월 2주차 내에 제공됩니다.</li>
							<li>지급되는 쿠폰은 일부 제한 사항이 있을 수 있습니다. 쿠폰 내 유의 사항을 참고 바랍니다.</li>
							<li>이벤트 진행 사항 및 경품 지급 내용은 사정에 따라 변경될 수 있습니다.</li>
						</ul>

						<div class="btn-group">
							<!-- 로그인 전 -->
						
							<button type="button" class="button purple large tooltip click">
								<span>VIP 미션 이벤트 보기</span>
								<span class="ir" data-width="235">
									<span class="cont-area">
										<span class="login-alert-tooltip">
											로그인이 필요한 서비스 입니다.<br>
											<a id="moveLogin" href="/benefits/vipLounge#layer_login_common" class="btn-modal-open" w-data="850" h-data="484" title="로그인하기">로그인 바로가기 <i class="iconset ico-arr-right-green"></i></a>
										</span>
									</span>
								</span>
							</button>
						
							<!-- //로그인전 -->

							<!-- 로그인 후 -->
						

						</div>

						<!-- 스탬프 미션 : 마이페이지와 동일 -->
						<!-- // 스탬프 미션 : 마이페이지와 동일 -->

						<p class="txt-info mt40">
							<span>VIP DAY</span>
							<span>매주 수요일 영화 관람 시 포인트 추가 적립!</span>
						</p>

						<div class="benefit-vip-day">
							<table>
								<tbody>
									<tr>
										<td>
											<i class="iconset ico-benefit-coin"></i>
											<p>
												기본적립
											</p>
										</td>
										<td>
											<i class="iconset ico-plus-gray-big">더하기</i>
										</td>
										<td>
											<i class="iconset ico-benefit-coin"></i>
											<p>
												VIP 추가적립
											</p>
										</td>
										<td>
											<i class="iconset ico-plus-gray-big">더하기</i>
										</td>
										<td>
											<i class="iconset ico-benefit-coin2"></i>
											<p>
												VIP DAY 추가 적립
											</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>

						<ul class="dot-list mt15">
							<li>VIP 회원은 영화 관람 시, “기본 적립 포인트”만큼 추가 적립을 받을 수 있습니다.</li>
							<li>수요일 영화 관람 시, “기본 적립 + VIP 추가 적립 포인트” 만큼  VIP DAY 포인트가 적립됩니다.</li>
							<li>VIP 추가 적립, VIP DAY 적립 포인트는 VIP 선정 포인트에서 제외됩니다.</li>
							<li>VIP 추가 적립, VIP DAY 적립 포인트 관련 사항은 변경될 수 있습니다.</li>
						</ul>

						<p class="txt-info mt40">
							<span>VIP 생일 축하 쿠폰</span>
							<span>생일 축하 콤보 무료 쿠폰 제공</span>
						</p>

						<ul class="dot-list mt15">
							<li>생일을 맞으신 VIP 고객님께 콤보 무료(오리지널 팝콘 L + 탄산음료 R * 2) 쿠폰을 드립니다.</li>
							<li>생일 쿠폰은 1년에 1번 지급되며, 한번 발급되면 추가 발급되지 않습니다.</li>
							<li>생일 쿠폰은 회원정보에 등록된 생일을 기준으로 쿠폰이 발급됩니다.</li>
							<li>생일 2주전 쿠폰이 발행되며, 유효기간은 발행일로부터 4주입니다. (예: 3월 16일이 생일이라면 3월 2일부터 3월 30일까지 이용 가능)</li>
							<li>발행된 쿠폰은 로그인 후 ‘나의 메가박스 &gt; 쿠폰’에서 확인 가능합니다.</li>
							<li>지급되는 쿠폰 혜택은 변경될 수 있습니다.</li>
						</ul>

						<p class="txt-info mt40">
							<span>중앙멤버십 혜택</span>
							<span>리조트 할인, CU 모바일 상품권 등 다양한 혜택을 받을 수 있는 중앙멤버십 카드를 신청하세요!</span>
						</p>

						<!-- benefit-jm-benefit -->
						<div class="benefit-jm-benefit">
							<table>
								<tbody>
									<tr>
										<td>
											<i class="iconset ico-benefit-jm-resort"></i>

											<p>
												리조트회원 우대
											</p>
										</td>
										<td>
											<i class="iconset ico-plus-gray-big">더하기</i>
										</td>
										<td>
											<i class="iconset ico-benefit-jm-sale"></i>

											<p>
												메가박스 최대 9,000원 할인
											</p>
										</td>
										<td>
											<i class="iconset ico-plus-gray-big">더하기</i>
										</td>
										<td>
											<i class="iconset ico-benefit-jm-health-chk"></i>

											<p>
												건강검진 우대
											</p>
										</td>
										<td>
											<i class="iconset ico-plus-gray-big">더하기</i>
										</td>
										<td>
											<i class="iconset ico-benefit-jm-cu"></i>

											<p>
												CU 모바일 상품권 10% 할인
											</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// benefit-jm-benefit -->

						<ul class="dot-list mt15">
							<li>본 혜택은 아래 카드 신청하기에서 중앙멤버십을 별도 신청하신 고객에 한해 적용 됩니다.</li>
							<li>중앙멤버십 카드는 VIP 기신청자의 경우 자동 연장되며 휴대폰 번호당 1개만 발급 가능합니다.</li>
							<li>제휴 혜택은 사정에 따라 변경되거나 종료될 수 있습니다.</li>
						</ul>

						<div class="btn-group">
							<a href="http://jmembership.joins.com/" target="_blank" title="중앙멤버십 홈페이지 새창 열림" class="button large">중앙멤버십 상세 안내</a>

							<!-- 로그인 전 -->
					
							<button type="button" class="button purple large tooltip click">
								<span>카드 신청하기</span>
								<span class="ir" data-width="235">
									<span class="cont-area">
										<span class="login-alert-tooltip">
											로그인이 필요한 서비스 입니다.<br>
											<a id="moveLogin" href="/benefits/vipLounge#layer_login_common" class="btn-modal-open" w-data="850" h-data="484" title="로그인하기">로그인 바로가기 <i class="iconset ico-arr-right-green"></i></a>
										</span>
									</span>
								</span>
							</button>
					
							<!-- 로그인 후 -->
					
						</div>

						<section id="layer_card_request" class="modal-layer"><a href="/benefits/vipLounge" class="focus">레이어로 포커스 이동 됨</a>
							<div class="wrap">
								<header class="layer-header">
									<h3 class="tit">중앙멤버십 신청하기</h3>
								</header>

								<div class="layer-con">
									<!-- layer-joins-membership-request -->
									<div class="layer-joins-membership-request">
										<div class="tit-box">
											<div class="tit">
												<span class="font-purple">MEGABOX</span>
												<i class="iconset ico-x-big"></i>
												<span class="font-gblue">중앙멤버십</span>
											</div>

											<p class="txt">
												항상 메가박스를 사랑해주시는 VIP 고객님들을 위하여  메가박스와 중앙멤버십이 만나 VIP 멤버십 혜택을 강화하였습니다.<br>
												VIP 고객님들을 위한 더욱 풍요롭고 다양한 할인 혜택을 만나보세요.
											</p>
										</div>

										<!-- box-chk -->
										<div class="box-chk mt30">
											<div class="tit">
												<span class="bg-chk">
													<input type="checkbox" id="jggMembershipChk_1" value="">
													<label for="jggMembershipChk_1"><span>중앙멤버십 혜택 신청</span> <em class="font-red">[필수]</em></label>
												</span>
											</div>

											<!-- cont -->
											<div class="cont">
												<p>
													최대 6가지의 더 다양하고 풍성한 VIP 혜택을 받으실 수 있습니다.<br>
													혜택 적용 기간 :  2023년 02월 28일까지
												</p>

												<p class="mt10 font-red font-size-14">
													※ 2021 VIP 중 중앙멤버십 기 신청자는 자동 연장됩니다.<br>
													※ 중앙멤버십 카드는 휴대전화번호당 1개만 발급 가능합니다. 다계정 보유 시 동일한 휴대전화번호로 신청하실 경우 이용에 제한이 있을 수 있습니다.<br>
													! 제휴사와의 사정에 따라 혜택이 변경 또는 종료될 수 있습니다.
												</p>
												<div class="benefit-jm-benefit">
													<table>
														<tbody>
															<tr>
																<td>
																	<i class="iconset ico-benefit-jm-resort"></i>

																	<p>
																		리조트회원<br>우대
																	</p>
																</td>
																<td>
																	<i class="iconset ico-plus-gray-big">더하기</i>
																</td>
																<td>
																	<i class="iconset ico-benefit-jm-sale"></i>

																	<p>
																		메가박스 최대<br>9,000원 할인
																	</p>
																</td>
																<td>
																	<i class="iconset ico-plus-gray-big">더하기</i>
																</td>
																<td>
																	<i class="iconset ico-benefit-jm-health-chk"></i>

																	<p>
																		건강검진<br>우대
																	</p>
																</td>
																<td>
																	<i class="iconset ico-plus-gray-big">더하기</i>
																</td>
																<td>
																	<i class="iconset ico-benefit-jm-cu"></i>

																	<p>
																		CU 모바일<br>
																		상품권 10% 할인
																	</p>
																</td>
															</tr>
														</tbody>
													</table>
												</div>
											</div>
											<!--// cont -->
										</div>
										<!--// box-chk -->

										<!-- box-chk -->
										
										<!--// box-chk -->

										<p class="tit-sub">VIP멤버십 혜택을 받으시기 위해 아래 개인정보 제공에 동의를 해주세요.</p>

										<!-- box-chk -->
										<div class="box-chk">
											<div class="tit">
												<span class="bg-chk">
													<input type="checkbox" id="jggMembershipChk_3">
													<label for="jggMembershipChk_3"><span>제 3자 정보제공에 동의합니다.</span> <em class="font-red">[필수]</em></label>
												</span>
											</div>

											<!-- text-cont 약관내용-->
											<div class="text-cont">
												<div class="scroll" tabindex="0">
													<p>(주)메가박스중앙이 제공하는 중앙 멤버십 혜택을 받을 경우 혜택 제공을 위하여 관련한 정보는<br>
필요한 범위 내에서 아래와 같이 제공됩니다.<br>
<br>
1. 개인정보 제공 동의<br>
메가박스는 정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따라 이용자의 개인정보에 있어<br>
아래와 같이 알리고 동의를 받아 중앙멤버십 서비스 제공자에 제공합니다.<br>
<br>
2. 개인정보 제공 받는 자<br>
(주)중앙일보, 중앙일보 M&amp;P(주)<br>
<br>
3. 개인정보 이용 목적<br>
중앙멤버십 서비스 이용에 따른 본인 식별 및 혜택 제공, 고객 응대<br>
<br>
4. 개인정보 제공 항목<br>
성명, 휴대폰번호<br>
<br>
5. 개인정보 보유 및 이용 기간<br>
개인정보 이용목적 달성 시까지(단, 관계 법령의 규정에 의해 보존의 필요가 있는 경우 및 사전 동의를 득한 경우 해당 보유기간 까지)</p>
												</div>

												<p class="mt20">※ 동의하지 않을 경우 중앙멤버십 혜택이 제공되지 않습니다.</p>
											</div>
											<!--// text-cont -->
										</div>
										<!--// box-chk -->
									</div>
									<!--// layer-joins-membership-request -->
								</div>

								<div class="btn-group-fixed">
									<button type="button" class="button close-layer">닫기</button>
									<button type="button" class="button purple" id="btnJoinMbship">신청하기</button>
								</div>

								<button type="button" class="btn-modal-close">레이어 닫기</button>
							</div>
						</section>

						<p class="txt-info mt40">
							<span>VIP CULTURE EVENT</span>
							<span>MEET PLAY SHARE 메가박스에서 당신의 문화생활을 위해 준비했어요~</span>
						</p>

						<div class="bg-coupon-block">
							<div class="box">
								<table>
									<colgroup>
										<col style="width:180px;">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<td>
												<i class="iconset ico-benefit-kyobo"></i>
											</td>
											<td class="a-l pt10">
												<p class="tit">교보문고</p>
												<p class="txt">10% 할인 쿠폰</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="box">
								<table>
									<colgroup>
										<col style="width:180px;">
										<col>
									</colgroup>
									<tbody>
										<tr>
											<td>
												<i class="iconset ico-benefit-hot-tracks"></i>
											</td>
											<td class="a-l pt10">
												<p class="tit">핫트랙스</p>
												<p class="txt">10% 할인 쿠폰</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>

						<ul class="dot-list mt15">
							<li>VIP 회원 대상 교보문고 &amp; 핫트랙스 10% 할인 쿠폰을 드립니다. (오프라인 / 1만원 이상 결제 시 사용 가능)</li>
							<li>VIP 회원 중 마케팅 정보 수신 동의 회원 대상에 한하여 제공됩니다.</li>
							<li>할인 쿠폰은 매월 초 메가박스APP으로 자동 발급됩니다. (나의 메가박스&gt; 제휴쿠폰)</li>
							<li>할인 쿠폰 사용 전 쿠폰 내 유의 사항을 반드시 확인 바랍니다.</li>
							<li>제휴 혜택은 사정에 따라 내용이 변경되거나 종료될 수 있습니다.</li>
						</ul>

<!-- 						<div class="btn-group"> -->
<!-- 							<a href="#" class="button purple large" title="이벤트 상세보기">이벤트 상세보기</a> -->
<!-- 						</div> -->
					</div>
					<!--// benefit-vip-benefit -->
				</div>
				<!--// inner-wrap -->
			</div>
			<!--// contents -->

		<!--// container -->
<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/benefits/vipLounge" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/benefits/vipLounge" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/benefits/vipLounge#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div><div class="tooltip-layer" style="display: block; min-width: 200px; z-index: 501; opacity: 0;"><div class="wrap" style="min-width: 200px;"><div class="tit-area" style="display: none;"></div><div class="cont-area"></div></div><button class="btn-close-tooltip" style="display: none;">툴팁 닫기</button></div><div class="tipPin" style="position: absolute; top: 0px; left: 0px; width: 22px; height: 12px; opacity: 0; z-index: 501;"></div><span class="tempspan4wth" style="position: absolute; display: block; font-size: 15px; opacity: 0;"></span></body></html>