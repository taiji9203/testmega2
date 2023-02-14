<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->

<script>

	$(function(){

		if ($('.theater-swiper').length > 0) {

			// swiper 전체 count
			var cntAll   = $('.theater-swiper .cell').length;
			var cntDupli = $('.theater-swiper .swiper-slide-duplicate').length;
			var cntReal  = cntAll - cntDupli;
			var cntView  = 3;

			var theater_swiper = new Swiper('.theater-swiper', {
				autoplay: {
					delay: 3000,
					disableOnInteraction: true,
				},
				loop : cntReal >= cntView,
				slidesPerView: cntView,
				spaceBetween: 40,
				pagination: {
					el: '.theater-pagination',
					clickable: false,
				},
				navigation : {
					prevEl : '.theater-prev',
					nextEl : '.theater-next',
				},
				ally : {
					enabled : true
				}
			});

			$('.theater-main .theater-count .total' ).text(cntReal);
			$('.theater-main .theater-count .active').text(theater_swiper.realIndex + 1);

			// 현재 활성화된 swiper
			theater_swiper.on('slideChange', function() {
				$('.theater-main .theater-count .active').text(theater_swiper.realIndex + 1);
			});

			// 자동실행 정지
			$('.theater-util .pause').on('click', function() {
				theater_swiper.autoplay.stop();

				$(this).removeClass('on');
				$('.theater-util .play').addClass('on').focus();
			});

			// 자동실행 시작
			$('.theater-util .play').on('click', function() {
				theater_swiper.autoplay.start();

				$(this).removeClass('on');
				$('.theater-util .pause').addClass('on').focus();
			});

			// 좌우 이동시 자동실행 정지됨
			$(document).on('click','.theater-prev, .theater-next', function() {
				$('.theater-util .pause').removeClass('on');
				$('.theater-util .play').addClass('on');
			});

			$(window).resize(function() {
				theater_swiper.update();
			}).resize();
		}
	});

	$(function() {

		// 이벤트 버블현상 공통 제거
		$('#contents').on('click', 'a', function(e) {

			if (($(this).attr('href') || '').indexOf('/') == -1) {
				e.preventDefault();
			}
		});

		// 전체극장 > 지역 선택
		$('.sel-city').on('click', function() {

			$("div.theater-place li.on").removeClass('on');
			$(this).parent().addClass('on');

			var _h1 = $('.user-theater').outerHeight();
			var _h2 = $('.theater-place').outerHeight();
			var _h0 = $("div.theater-place li.on .theater-list").outerHeight();
			var _hAll = _h0 + _h1 + _h2;

			$('.theater-box').outerHeight(_hAll);
		});

		// 로그인 버튼
		$('#moveLogin').click(function() {

			fn_viewLoginPopup('default','pc');
		});

		// 전체극장 > 선호영화관 관리
		$('.user-theater a.float-r').click(function() {

			// 선호극장 호출 및 콜백
			gfn_favorBrchReg(function(param){

				var $li;

				// 선호극장 목록 삭제
				$('.theater-circle li').remove();

				// 선호극장 class 전체 삭제
				$('.theater-list span.favorit-theater').remove();

				// 선호극장 처리
				$.each(param, function(i, data){

					// 전체극장에서 관련 극장 찾기
					$li = $('.theater-list li[data-brch-no="'+ data.favorCdVal +'"]');

					if ($li.length != 0) {

						// 선호극장 class 추가
						$li.prepend('<span class="favorit-theater"><i class="iconset ico-favo-theater"></i></span>');

						// 선호영화관 추가
						$('ul.theater-circle').append(' '); //기존 줄바꿈이 스페이스 영역이라 추가
						$('ul.theater-circle').append($('<li>').html($li.find('a, input').clone()));
					}
				})
			});
		});
	});

</script>

<div class="container">

	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="/theater/allTheater" title="극장 페이지로 이동">극장</a>
				<a href="/theater/allTheater" title="전체극장 페이지로 이동">전체극장</a>
			</div>
		</div>
	</div>

	<!-- content -->
	<div id="contents" class="no-padding">

		
		<!--// theater-main -->

		<div class="inner-wrap">
			
				
			

			<h2 class="tit mt40">전체극장</h2>

			<div class="theater-box" style="height: 292px;">
				<div class="theater-place">
					<ul>
						
							<li class="on">
								<button type="button" class="sel-city">서울
									
								</button>

								<div class="theater-list">
									<ul>
										
											<li data-brch-no="1372">
												

												<a href="#" title="강남 상세보기">강남</a>

												
											</li>
										
											<li data-brch-no="0023">
												

												<a href="#" title="강남대로(씨티) 상세보기">강남대로(씨티)</a>

												
											</li>
										
											<li data-brch-no="1341">
												

												<a href="#" title="강동 상세보기">강동</a>

												
											</li>
										
											<li data-brch-no="1431">
												

												<a href="#" title="군자 상세보기">군자</a>

												
											</li>
										
											<li data-brch-no="0041">
												

												<a href="#" title="더 부티크 목동현대백화점 상세보기">더 부티크 목동현대백화점</a>

												
											</li>
										
											<li data-brch-no="1003">
												

												<a href="#" title="동대문 상세보기">동대문</a>

												
											</li>
										
											<li data-brch-no="1572">
												

												<a href="#" title="마곡 상세보기">마곡</a>

												
											</li>
										
											<li data-brch-no="1581">
												

												<a href="#" title="목동 상세보기">목동</a>

												
											</li>
										
											<li data-brch-no="1311">
												

												<a href="#" title="상봉 상세보기">상봉</a>

												
											</li>
										
											<li data-brch-no="1211">
												

												<a href="#" title="상암월드컵경기장 상세보기">상암월드컵경기장</a>

												
											</li>
										
											<li data-brch-no="1331">
												

												<a href="#" title="성수 상세보기">성수</a>

												
											</li>
										
											<li data-brch-no="1371">
												

												<a href="#" title="센트럴 상세보기">센트럴</a>

												
											</li>
										
											<li data-brch-no="1381">
												

												<a href="#" title="송파파크하비오 상세보기">송파파크하비오</a>

												
											</li>
										
											<li data-brch-no="1202">
												

												<a href="#" title="신촌 상세보기">신촌</a>

												
											</li>
										
											<li data-brch-no="1561">
												

												<a href="#" title="이수 상세보기">이수</a>

												
											</li>
										
											<li data-brch-no="1321">
												

												<a href="#" title="창동 상세보기">창동</a>

												
											</li>
										
											<li data-brch-no="1351">
												

												<a href="#" title="코엑스 상세보기">코엑스</a>

												
											</li>
										
											<li data-brch-no="1212">
												

												<a href="#" title="홍대 상세보기">홍대</a>

												
											</li>
										
											<li data-brch-no="1571">
												

												<a href="#" title="화곡 상세보기">화곡</a>

												
											</li>
										
											<li data-brch-no="1562">
												

												<a href="#" title="ARTNINE 상세보기">ARTNINE</a>

												
											</li>
										
									</ul>
								</div>
							</li>
						
							<li>
								<button type="button" class="sel-city">경기
									
								</button>

								<div class="theater-list">
									<ul>
										
											<li data-brch-no="4121">
												

												<a href="#" title="고양스타필드 상세보기">고양스타필드</a>

												
											</li>
										
											<li data-brch-no="0029">
												

												<a href="#" title="광명AK플라자 상세보기">광명AK플라자</a>

												
											</li>
										
											<li data-brch-no="0034">
												

												<a href="#" title="광명소하 상세보기">광명소하</a>

												
											</li>
										
											<li data-brch-no="0035">
												

												<a href="#" title="금정AK플라자 상세보기">금정AK플라자</a>

												
											</li>
										
											<li data-brch-no="4152">
												

												<a href="#" title="김포한강신도시 상세보기">김포한강신도시</a>

												
											</li>
										
											<li data-brch-no="0039">
												

												<a href="#" title="남양주 상세보기">남양주</a>

												
											</li>
										
											<li data-brch-no="0019">
												

												<a href="#" title="남양주현대아울렛 스페이스원 상세보기">남양주현대아울렛 스페이스원</a>

												
											</li>
										
											<li data-brch-no="4451">
												

												<a href="#" title="동탄 상세보기">동탄</a>

												
											</li>
										
											<li data-brch-no="4652">
												

												<a href="#" title="미사강변 상세보기">미사강변</a>

												
											</li>
										
											<li data-brch-no="4113">
												

												<a href="#" title="백석 상세보기">백석</a>

												
											</li>
										
											<li data-brch-no="4722">
												

												<a href="#" title="별내 상세보기">별내</a>

												
											</li>
										
											<li data-brch-no="4221">
												

												<a href="#" title="부천스타필드시티 상세보기">부천스타필드시티</a>

												
											</li>
										
											<li data-brch-no="4631">
												

												<a href="/#" title="분당 상세보기">분당</a>

												
											</li>
										
											<li data-brch-no="0030">
												

												<a href="#" title="수원 상세보기">수원</a>

												
											</li>
										
											<li data-brch-no="0042">
												

												<a href="#" title="수원남문 상세보기">수원남문</a>

												
											</li>
										
											<li data-brch-no="0036">
												

												<a href="#" title="수원호매실 상세보기">수원호매실</a>

												
											</li>
										
											<li data-brch-no="4291">
												

												<a href="#" title="시흥배곧 상세보기">시흥배곧</a>

												
											</li>
										
											<li data-brch-no="4253">
												

												<a href="#" title="안산중앙 상세보기">안산중앙</a>

												
											</li>
										
											<li data-brch-no="0020">
												

												<a href="#" title="안성스타필드 상세보기">안성스타필드</a>

												
											</li>
										
											<li data-brch-no="4821">
												

												<a href="#" title="양주 상세보기">양주</a>

												
											</li>
										
											<li data-brch-no="4431">
												

												<a href="#" title="영통 상세보기">영통</a>

												
											</li>
										
											<li data-brch-no="0012">
												

												<a href="#" title="용인기흥 상세보기">용인기흥</a>

												
											</li>
										
											<li data-brch-no="4462">
												

												<a href="#" title="용인테크노밸리 상세보기">용인테크노밸리</a>

												
											</li>
										
											<li data-brch-no="4804">
												

												<a href="#" title="의정부민락 상세보기">의정부민락</a>

												
											</li>
										
											<li data-brch-no="4111">
												

												<a href="#" title="일산 상세보기">일산</a>

												
											</li>
										
											<li data-brch-no="4104">
												

												<a href="#" title="일산벨라시타 상세보기">일산벨라시타</a>

												
											</li>
										
											<li data-brch-no="4112">
												

												<a href="#" title="킨텍스 상세보기">킨텍스</a>

												
											</li>
										
											<li data-brch-no="4132">
												

												<a href="#" title="파주금촌 상세보기">파주금촌</a>

												
											</li>
										
											<li data-brch-no="4115">
												

												<a href="#" title="파주운정 상세보기">파주운정</a>

												
											</li>
										
											<li data-brch-no="4131">
												

												<a href="#" title="파주출판도시 상세보기">파주출판도시</a>

												
											</li>
										
											<li data-brch-no="4651">
												

												<a href="#" title="하남스타필드 상세보기">하남스타필드</a>

												
											</li>
										
									</ul>
								</div>
							</li>
						
							<li>
								<button type="button" class="sel-city">인천
									
								</button>

								<div class="theater-list">
									<ul>
										
											<li data-brch-no="4041">
												

												<a href="#" title="검단 상세보기">검단</a>

												
											</li>
										
											<li data-brch-no="4062">
												

												<a href="#" title="송도 상세보기">송도</a>

												
											</li>
										
											<li data-brch-no="4001">
												

												<a href="#" title="영종 상세보기">영종</a>

												
											</li>
										
											<li data-brch-no="4051">
												

												<a href="#" title="인천논현 상세보기">인천논현</a>

												
											</li>
										
											<li data-brch-no="0027">
												

												<a href="#" title="청라지젤 상세보기">청라지젤</a>

												
											</li>
										
									</ul>
								</div>
							</li>
						
							<li>
								<button type="button" class="sel-city">대전/충청/세종
									
								</button>

								<div class="theater-list">
									<ul>
										
											<li data-brch-no="3141">
												

												<a href="#" title="공주 상세보기">공주</a>

												
											</li>
										
											<li data-brch-no="0018">
												

												<a href="#" title="논산 상세보기">논산</a>

												
											</li>
										
											<li data-brch-no="3021">
												

												<a href="#" title="대전 상세보기">대전</a>

												
											</li>
										
											<li data-brch-no="0028">
												

												<a href="#" title="대전신세계 아트앤사이언스 상세보기">대전신세계 아트앤사이언스</a>

												
											</li>
										
											<li data-brch-no="0009">
												

												<a href="#" title="대전유성 상세보기">대전유성</a>

												
											</li>
										
											<li data-brch-no="3011">
												

												<a href="#" title="대전중앙로 상세보기">대전중앙로</a>

												
											</li>
										
											<li data-brch-no="0017">
												

												<a href="#" title="대전현대아울렛 상세보기">대전현대아울렛</a>

												
											</li>
										
											<li data-brch-no="3391">
												

												<a href="#" title="세종(조치원) 상세보기">세종(조치원)</a>

												
											</li>
										
											<li data-brch-no="3392">
												

												<a href="#" title="세종나성 상세보기">세종나성</a>

												
											</li>
										
											<li data-brch-no="0008">
												

												<a href="#" title="세종청사 상세보기">세종청사</a>

												
											</li>
										
											<li data-brch-no="3631">
												

												<a href="#" title="오창 상세보기">오창</a>

												
											</li>
										
											<li data-brch-no="3651">
												

												<a href="#" title="진천 상세보기">진천</a>

												
											</li>
										
											<li data-brch-no="3301">
												

												<a href="#" title="천안 상세보기">천안</a>

												
											</li>
										
											<li data-brch-no="0013">
												

												<a href="/theater?brchNo=0013" title="청주사창 상세보기">청주사창</a>

												
											</li>
										
											<li data-brch-no="3501">
												

												<a href="/theater?brchNo=3501" title="홍성내포 상세보기">홍성내포</a>

												
											</li>
										
									</ul>
								</div>
							</li>
						
							<li>
								<button type="button" class="sel-city">부산/대구/경상
									
								</button>

								<div class="theater-list">
									<ul>
										
											<li data-brch-no="0040">
												

												<a href="/theater?brchNo=0040" title="경북도청 상세보기">경북도청</a>

												
											</li>
										
											<li data-brch-no="7122">
												

												<a href="/theater?brchNo=7122" title="경산하양 상세보기">경산하양</a>

												
											</li>
										
											<li data-brch-no="0043">
												

												<a href="/theater?brchNo=0043" title="경주 상세보기">경주</a>

												
											</li>
										
											<li data-brch-no="7303">
												

												<a href="/theater?brchNo=7303" title="구미강동 상세보기">구미강동</a>

												
											</li>
										
											<li data-brch-no="7401">
												

												<a href="/theater?brchNo=7401" title="김천 상세보기">김천</a>

												
											</li>
										
											<li data-brch-no="7901">
												

												<a href="/theater?brchNo=7901" title="남포항 상세보기">남포항</a>

												
											</li>
										
											<li data-brch-no="7011">
												

												<a href="/theater?brchNo=7011" title="대구신세계(동대구) 상세보기">대구신세계(동대구)</a>

												
											</li>
										
											<li data-brch-no="0022">
												

												<a href="/theater?brchNo=0022" title="대구이시아 상세보기">대구이시아</a>

												
											</li>
										
											<li data-brch-no="6161">
												

												<a href="/theater?brchNo=6161" title="덕천 상세보기">덕천</a>

												
											</li>
										
											<li data-brch-no="6312">
												

												<a href="/theater?brchNo=6312" title="마산 상세보기">마산</a>

												
											</li>
										
											<li data-brch-no="7451">
												

												<a href="/theater?brchNo=7451" title="문경 상세보기">문경</a>

												
											</li>
										
											<li data-brch-no="6001">
												

												<a href="/theater?brchNo=6001" title="부산극장 상세보기">부산극장</a>

												
											</li>
										
											<li data-brch-no="6906">
												

												<a href="/theater?brchNo=6906" title="부산대 상세보기">부산대</a>

												
											</li>
										
											<li data-brch-no="0025">
												

												<a href="/theater?brchNo=0025" title="북대구(칠곡) 상세보기">북대구(칠곡)</a>

												
											</li>
										
											<li data-brch-no="0032">
												

												<a href="/theater?brchNo=0032" title="사상 상세보기">사상</a>

												
											</li>
										
											<li data-brch-no="6642">
												

												<a href="/theater?brchNo=6642" title="삼천포 상세보기">삼천포</a>

												
											</li>
										
											<li data-brch-no="6261">
												

												<a href="/theater?brchNo=6261" title="양산 상세보기">양산</a>

												
											</li>
										
											<li data-brch-no="6262">
												

												<a href="/theater?brchNo=6262" title="양산라피에스타 상세보기">양산라피에스타</a>

												
											</li>
										
											<li data-brch-no="6811">
												

												<a href="/theater?brchNo=6811" title="울산 상세보기">울산</a>

												
											</li>
										
											<li data-brch-no="6191">
												

												<a href="/theater?brchNo=6191" title="정관 상세보기">정관</a>

												
											</li>
										
											<li data-brch-no="0045">
												

												<a href="/theater?brchNo=0045" title="진주(중안) 상세보기">진주(중안)</a>

												
											</li>
										
											<li data-brch-no="6421">
												

												<a href="/theater?brchNo=6421" title="창원 상세보기">창원</a>

												
											</li>
										
											<li data-brch-no="0014">
												

												<a href="/theater?brchNo=0014" title="창원내서 상세보기">창원내서</a>

												
											</li>
										
											<li data-brch-no="0038">
												

												<a href="/theater?brchNo=0038" title="포항 상세보기">포항</a>

												
											</li>
										
											<li data-brch-no="0046">
												

												<a href="/theater?brchNo=0046" title="해운대(장산) 상세보기">해운대(장산)</a>

												
											</li>
										
									</ul>
								</div>
							</li>
						
							<li>
								<button type="button" class="sel-city">광주/전라
									
								</button>

								<div class="theater-list">
									<ul>
										
											<li data-brch-no="5021">
												

												<a href="/theater?brchNo=5021" title="광주상무 상세보기">광주상무</a>

												
											</li>
										
											<li data-brch-no="5061">
												

												<a href="/theater?brchNo=5061" title="광주하남 상세보기">광주하남</a>

												
											</li>
										
											<li data-brch-no="5302">
												

												<a href="/theater?brchNo=5302" title="목포하당(포르모) 상세보기">목포하당(포르모)</a>

												
											</li>
										
											<li data-brch-no="5401">
												

												<a href="/theater?brchNo=5401" title="순천 상세보기">순천</a>

												
											</li>
										
											<li data-brch-no="5552">
												

												<a href="/theater?brchNo=5552" title="여수웅천 상세보기">여수웅천</a>

												
											</li>
										
											<li data-brch-no="0010">
												

												<a href="/theater?brchNo=0010" title="전대(광주) 상세보기">전대(광주)</a>

												
											</li>
										
											<li data-brch-no="5612">
												

												<a href="/theater?brchNo=5612" title="전주송천 상세보기">전주송천</a>

												
											</li>
										
											<li data-brch-no="0021">
												

												<a href="/theater?brchNo=0021" title="전주혁신 상세보기">전주혁신</a>

												
											</li>
										
											<li data-brch-no="5064">
												

												<a href="/theater?brchNo=5064" title="첨단 상세보기">첨단</a>

												
											</li>
										
									</ul>
								</div>
							</li>
						
							<li>
								<button type="button" class="sel-city">강원
									
								</button>

								<div class="theater-list">
									<ul>
										
											<li data-brch-no="2001">
												

												<a href="/theater?brchNo=2001" title="남춘천 상세보기">남춘천</a>

												
											</li>
										
											<li data-brch-no="2171">
												

												<a href="/theater?brchNo=2171" title="속초 상세보기">속초</a>

												
											</li>
										
											<li data-brch-no="2201">
												

												<a href="/theater?brchNo=2201" title="원주 상세보기">원주</a>

												
											</li>
										
											<li data-brch-no="2202">
												

												<a href="/theater?brchNo=2202" title="원주센트럴 상세보기">원주센트럴</a>

												
											</li>
										
											<li data-brch-no="0037">
												

												<a href="/theater?brchNo=0037" title="춘천석사 상세보기">춘천석사</a>

												
											</li>
										
									</ul>
								</div>
							</li>
						
					</ul>
				</div>

				<div class="user-theater">
					
						
						
							<!-- 로그인 전 -->
							<div>
								<i class="iconset ico-favo-theater"></i> 나의 선호영화관 정보
								<a href="/theater/list" class="button small ml10" id="moveLogin" title="로그인하기">로그인하기</a>
							</div>
						
					
				</div>
			</div>

			
				<div class="tit-util mt70 mb15">
					<h3 class="tit">극장 이벤트</h3>
					<a href="/theater/list" onclick="NetfunnelChk.aTag(&#39;STORE_DTL&#39;,&#39;/event/theater&#39;);return false;" class="more" title="극장 이벤트 더보기">더보기 <i class="iconset ico-arr-right-gray"></i></a>
				</div>

				<div class="event-box">
					<ul>
						
							<li>
								<a href="/theater/list#" class="eventBtn" data-no="12596" data-netfunnel="N" title="[부산경남지역] 인제대학교 재학생, 교직원 할인 상세보기">
									<img src="/resources/theater/Y3MowDRxBC9Zis7PwS1Aav10mUBBjuhQ.jpg" alt="[부산경남지역] 인제대학교 재학생, 교직원 할인" onerror="noImg(this)">
								</a>
							</li>
						
							<li>
								<a href="/theater/list#" class="eventBtn" data-no="12600" data-netfunnel="N" title="[킨텍스] 킨텍스점 전용 관람권 할인! 상세보기">
									<img src="/resources/theater/2SEsv2a5ZuN5DMMvLp56ffpXe68Uyknt.jpg" alt="[킨텍스] 킨텍스점 전용 관람권 할인!" onerror="noImg(this)">
								</a>
							</li>
						
					</ul>
				</div>
			

			<div class="tit-util mt70 mb15">
				<h3 class="tit">극장 공지사항</h3>
				<a href="/support/notice?ti=3" class="more" title="극장 공지사항 더보기">더보기 <i class="iconset ico-arr-right-gray"></i></a>
			</div>

			<div class="table-wrap">
				<table class="board-list">
					<caption>극장, 제목, 지역, 등록일이 들어간 극장 공지사항 목록</caption>
					<colgroup>
						<col style="width:150px;">
						<col>
						<col style="width:150px;">
						<col style="width:120px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">극장</th>
							<th scope="col">제목</th>
							<th scope="col">지역</th>
							<th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
						
							
								
									<tr>
										<td>창원</td>
										<th scope="row">
											<a href="/support/notice/detail?artiNo=10774&amp;bbsNo=9" title="[창원]임시 휴점 안내 상세보기">
												[창원]임시 휴점 안내
											</a>
										</th>
										<td>부산/대구/경상</td>
										<td>2023.02.06</td>
									</tr>
								
									<tr>
										<td>코엑스</td>
										<th scope="row">
											<a href="/support/notice/detail?artiNo=10768&amp;bbsNo=9" title="[코엑스] 코엑스몰 전시회 진행에 따른 주차안내문(2/1~2/3) 상세보기">
												[코엑스] 코엑스몰 전시회 진행에 따른 주차안내문(2/1~2/3)
											</a>
										</th>
										<td>서울</td>
										<td>2023.02.02</td>
									</tr>
								
									<tr>
										<td>신촌</td>
										<th scope="row">
											<a href="/support/notice/detail?artiNo=10766&amp;bbsNo=9" title="&lt;사건 읽는 영화관&gt; 2월 강연자 변경 안내 상세보기">
												&lt;사건 읽는 영화관&gt; 2월 강연자 변경 안내
											</a>
										</th>
										<td>서울</td>
										<td>2023.02.02</td>
									</tr>
								
									<tr>
										<td>하남스타필드</td>
										<th scope="row">
											<a href="/support/notice/detail?artiNo=10765&amp;bbsNo=9" title="[하남스타필드]우대 요금 변경 안내 상세보기">
												[하남스타필드]우대 요금 변경 안내
											</a>
										</th>
										<td>경기</td>
										<td>2023.01.30</td>
									</tr>
								
									<tr>
										<td>춘천석사</td>
										<th scope="row">
											<a href="/support/notice/detail?artiNo=10761&amp;bbsNo=9" title="[춘천석사]강원소방본부 제휴할인 안내 상세보기">
												[춘천석사]강원소방본부 제휴할인 안내
											</a>
										</th>
										<td>강원</td>
										<td>2023.01.20</td>
									</tr>
								
							
							
						
					</tbody>
				</table>
			</div>

		</div>
	</div>
</div>

<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/theater/list" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/theater/list" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->


<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/theater/list#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>