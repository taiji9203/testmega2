<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->

<script type="text/javascript">
	$(function() {

	});
</script>

<!-- container -->
<div class="container">
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="/theater/allTheater" title="극장 페이지로 이동">극장</a>
				<a href="/theater/specialTheater" title="특별관 페이지로 이동">특별관</a>
			</div>

		</div>
	</div>

	<!-- contents -->
	<div id="contents" class="no-padding">
		<div class="theater-special-main">
			<div class="inner-wrap">
				<div class="brn-link">
					<div class="cell tit-area">
						<p class="tit"><img src="/resources/theater/sp-text-tit2.png" alt="MEET PLAY SHARE"></p>
						<p class="txt">
							메가박스<br>
							특별관을<br>
							소개합니다.
						</p>
					</div>

					<div class="cell link-boutique">
						<a href="#" title="THE BOUTIQUE 페이지로 이동">
							<div class="link-txt">
								<p class="tit">THE BOUTIQUE</p>
								<p class="txt">부티크 호텔의 개성을 더한<br>메가박스만의 프리미엄 시네마</p>
							</div>
							<div class="hover">THE BOUTIQUE</div>
						</a>
					</div>

					<div class="cell link-db">
						<a href="#">
							<div class="link-txt">
								<p class="tit">DOLBY CINEMA</p>
								<p class="txt">국내 최초로 메가박스가 선보이는<br>세계 최고 기술력의 몰입 시네마</p>
							</div>

							<div class="hover">MEGABOXTM MX THE TRUE SOUND</div>
						</a>
					</div>

					<div class="cell link-mx">
						<a href="#" title="MX 페이지로 이동">
							<div class="link-txt">
								<p class="tit">MX</p>
								<p class="txt">진정한 영화 사운드를 통한 최고의 영화<br>메가박스의 차세대 표준 상영관</p>
							</div>
							<div class="hover">MEGABOXTM MX THE TRUE SOUND</div>
						</a>
					</div>

					<div class="cell link-kids">
						<a href="#" title="MEGA KIDS 페이지로 이동">
							<div class="link-txt">
								<p class="tit">MEGABOX KIDS</p>
								<p class="txt">아이와 가족이 함께 머물며<br>삶의 소중한 가치를 배우는<br>더 행복한 놀이공간</p>
							</div>
							<div class="hover">MEGABOX KIDS</div>
						</a>
					</div>

					<div class="cell link-comfort">
						<a href="#" title="COMFORT 페이지로 이동">
							<div class="link-txt">
								<p class="tit">COMFORT</p>
								<p class="txt">더욱 편안한 영화 관람을 위한<br>다양한 여유 공간</p>
							</div>
							<div class="hover">COMFORT</div>
						</a>
					</div>

					<div class="cell link-private">
						<a href="#" title="THE BOUTIQUE PRIVATE 페이지로 이동">
							<div class="link-txt">
								<p class="tit">THE BOUTIQUE PRIVATE</p>
								<p class="txt">당신의 특별한 순간을 빛나게 해줄<br>프리미엄 어메니티와 룸서비스</p>
							</div>
							<div class="hover">THE BOUTIQUE PRIVATE</div>
						</a>
					</div>

					<div class="cell link-puppy">
						<a href="#" title="PUPPY CINEMA 페이지로 이동">
							<div class="link-txt">
								<p class="tit">PUPPY CINEMA</p>
								<p class="txt">최초의 반려동물 동반 멀티플렉스<br>영화관람은 물론<br>다양한 부대시설까지</p>
							</div>
							<div class="hover">PUPPY CINEMA</div>
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- special-bg -->
		<div class="special-bg">
			<div class="inner-wrap">

			</div>
		</div>
		<!--// special-bg -->
	</div>
	<!--// contents -->
</div>
<!--// container -->
<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="#" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="#" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->


<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/theater/specialTheater#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>