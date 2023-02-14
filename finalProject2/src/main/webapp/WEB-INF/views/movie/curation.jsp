<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->

<script type="text/javascript">
	var idx, title, cd;
	var tCd = '';
	var isLogin = '' ? true : false;

	var film = false;
	var classic = false;
	

	$(function() {
		// 탭 버튼
		$('#tab-list li a').on('click', function(e) {
			e.preventDefault();

			var targetClass = $(this).data('target');
			var dataCd = $(this).data('cd');
			var idx = $(this).parent().index() - 1;

			$('#tab-list li.on').removeClass('on');
			$(this).parent().addClass('on');

			$('.content').hide();
			$('.' + targetClass).show();

			$('#specialOrd').val('');
			$('#pageType').val('');
			$('#tabCd').val('');

			if(dataCd) fn_movieSerach('search', dataCd, idx); // 영화 목록 조회

			//탭메뉴 설정
			setTab( idx + 1 );

		});

		// 가입팝업 체크박스 초기화
		$('#contents .btn-modal-open').on('click', function(){
			$($(this).attr('href')).find(':checked').attr('checked', false);
		});

		// 가입하기 버튼
		$('.regBtn').on('click', function(e) {
			e.preventDefault();

			if(isLogin) {

				if( $(this).data('param').type == "film" ){
					if( film ) return gfn_alertMsgBox('이미 가입되어 있습니다.');
				}else{
					if( classic ) return gfn_alertMsgBox('이미 가입되어 있습니다.');
				}

				$(this).prev().click();
			} else {
				gfn_alertMsgBox("로그인 후 이용가능한 서비스입니다.");
			}
		});

		// 큐레이션 정보 가입 버튼
		$('.regActionBtn').on('click', function(e) {
			e.preventDefault();

			cd = $(this).data('cd');
			idx = cd == 'SMT01' ? 0 : 1;
			title = cd == 'SMT01' ? '필름 소사이어티' : '클래식 소사이어티';

			if(!isLogin) {
				gfn_alertMsgBox("로그인 후 이용가능한 서비스입니다.");
			}

			var options = {};
			options.msg = title + '에 가입 하시겠습니까?';
			options.confirmFn = fn_regAction;
			gfn_confirmMsgBox(options);
		});

		// 예매하기 버튼 클릭시
		$('.goBokdBtn').on('click', function(e) {
			e.preventDefault();

			cd = $(this).data('cd');
			if(cd == 'SMT01') { // 필름소사이어티
				$('#tab-list li').eq(1).addClass('on');
				$('#tab-list li.on a').click();
			} else if(cd == 'SMT02') { // 클래식소사이어티
				$('#tab-list li').eq(2).addClass('on');
				$('#tab-list li.on a').click();
			}
		});

		// 필름 정렬 버튼 클릭
		$('#sortFilmTab button').on('click', function() {
			$('#sortFilmTab button.on').removeClass('on');
			$(this).addClass('on');

			$('#pageType').val($(this).attr('sort-type'));
			//$('#specialOrd').val($(this).data('ord'));
			$('#tabCd').val($(this).data('cd'));

			fn_movieSerach('search', 'film', 0);
		});

		// 클래식 정렬 버튼 클릭
		$('#sortClassicTab button').on('click', function() {
			$('#sortClassicTab button.on').removeClass('on');
			$(this).addClass('on');

			$('#pageType').val($(this).attr('sort-type'));
			//$('#specialOrd').val($(this).data('ord'));
			$('#tabCd').val($(this).data('cd'));

			fn_movieSerach('search', 'classic', 1);
		});

		// 필름 더보기 버튼 클릭
		$('#btnFilmAddMovie').on('click', function() {
			fn_movieSerach('add', 'film', 0);
		});

		// 클릭식 더보기 버튼 클릭
		$('#btnClassicAddMovie').on('click', function() {
			fn_movieSerach('add', 'classic', 1);
		});

		if('specialcontent' == 'filmsociety') { // 필름소사이어티
			$('#tab-list li').eq(1).addClass('on');
			$('#tab-list li.on a').click();
		} else if('specialcontent' == 'classicsociety') { // 클래식소사이어티
			$('#tab-list li').eq(2).addClass('on');
			$('#tab-list li.on a').click();
		} else {
			$('#tab-list li').eq(0).addClass('on');// 큐레이션 소개
		}
	});

	/**
	* 탭메뉴 설정
	*/
	function setTab( idx ){

		switch( idx ) {
			default :
				url 	= "/curation/specialcontent";
				metaFormat = {
						'scnTitle'			: '큐레이션소개 | MEET PLAY SHARE, 메가박스'
						, 'metaTagTitle'	: '큐레이션소개 | MEET PLAY SHARE, 메가박스'
						, 'metaTagDtls'		: '메가박스의 특별콘텐트 큐레이션 브랜드를 만나보세요.'
						, 'metaTagUrl'		: url
						};
				break;
			case 1  :
				url 	= "/curation/filmsociety";
				metaFormat = {
						'scnTitle'			: '필름소사이어티 < 큐레이션 | MEET PLAY SHARE, 메가박스'
						, 'metaTagTitle'	: '필름소사이어티 < 큐레이션 | MEET PLAY SHARE, 메가박스'
						, 'metaTagDtls'		: '메가박스 필름소사이어티를 통해 오래도록 기억되는 인생영화를 만나보세요.'
						, 'metaTagUrl'		: url
						};
				break;
			case 2  :
				url 	= "/curation/classicsociety";
				metaFormat = {
						'scnTitle'			: '클래식소사이어티 < 큐레이션 | MEET PLAY SHARE, 메가박스'
						, 'metaTagTitle'	: '클래식소사이어티 < 큐레이션 | MEET PLAY SHARE, 메가박스'
						, 'metaTagDtls'		: '메가박스 클래식소사이어티를 통해  클래식의 울림과 감동을 느껴보세요.'
						, 'metaTagUrl'		: url
						};
				break;
		}

		//URL 변경
		history.replaceState( null, null, url );

		//메타태그 설정
		settingMeta(metaFormat);

		//더보기 초기화
    	$(".container .btn-more").hide();
	}

	// 스페셜 맴버십 가입 처리
	function fn_regAction(param) {
		$.ajaxMegaBox({
	        url: '/on/oh/oha/Movie/mergeSpecialMember.do',
			data: JSON.stringify({
				svcTyCd: cd,
				smsMarketInfoRcvAt: 'Y',
				emailMarketInfoRcvAt: 'Y'
			}),
            clickLmtChk: true, //중복클릭 방지 실행
	        success: function(d) {
				var resultMap = d.resultMap;

				if(resultMap.msg == 'sessionFail')
					return gfn_alertMsgBox('로그인 후 이용가능한 서비스입니다.');
				else if(resultMap.msg == 'trmnatFail')
					return gfn_alertMsgBox('탈퇴후 30일이 경과해야 가입하실수 있습니다.');
				else if(resultMap.msg == 'dataFail')
					return gfn_alertMsgBox('이미 가입되어 있습니다.');

				gfn_alertMsgBox({ msg: title + ' 멤버로 가입되었습니다.', callback: fn_regEndAction });
            },complete: function(xhr){
            	clearLmt(); //중복제한 초기화
            }
	    });
	};

	// 스페셜 맴버십 가입 완료 후 실행
	function fn_regEndAction() {
		location.reload();
	};

	//큐레이션 필름소사이어티, 클래식소사이어티 하단 배너 생성
	function fn_curationBannerSet(curationBannerList, imgSvrUrl) {
		let html = '';

		curationBannerList.forEach(function(item){
			html+='<li>';
			html+='<a href="/event/detail?eventNo='+item.eventNo+'" className="eventBtn" data-no="'+item.eventNo+'" data-netfunnel="'+item.netfunnelAt+'" title="'+item.eventTitle+' 상세보기">';
			html+='<img src="'+imgSvrUrl+item.pcFilePathNm+'" onError="noImg(this);" alt="'+item.pcRplWordCn+'"></a>';
			html+='</li>';
		});

		return html;
	};

	// 영화목록 가져오기
	function fn_movieSerach(searchtype, specialType, idx) {
		var currentPage = $('#currentPage').val();

		if(searchtype == 'search') currentPage = 1;
		else if(searchtype == 'add') currentPage = parseInt(currentPage) + 1;

		$('#currentPage').val(currentPage);

		$.ajaxMegaBox({
	        url: '/on/oh/oha/Movie/selectMovieList.do',
			data: JSON.stringify({
				currentPage: currentPage + '',
				recordCountPerPage: $('#recordCountPerPage').val() + '',
				pageType: $('#pageType').val(),
				ibxMovieNmSearch: $('#ibxMovieNmSearch').val(),
				//specialOrd: $('#specialOrd').val(),
				specialCd: $('#tabCd').val(),
				onairYn: $('#onairYn').val(),
				specialType: specialType
			}),
	        success: function (d) {
	        	var pagingType = searchtype == 'search' ? false : true;
	        	var target = $('.movieList').eq(idx);

				//큐레이션 배너 생성
				let curationList = d.curationBannerList.curationBannerList;

				if(curationList.length > 0){
					let htmlData = fn_curationBannerSet(curationList, d.imgSvrUrl);
					$('.curationList').html(htmlData);
				}

	        	// 영화 목록 생성
	        	MegaboxUtil.Movie.setImgSvrUrl(d.imgSvrUrl); // 이미지 서버 URL 설정
				MegaboxUtil.Movie.createHtml(d.movieList, target, pagingType);

	        	if(d.movieList.length > 0) {
					var totalCnt = d.movieList[0].totCnt;
					var recordCountPerPage = d.movieList[0].recordCountPerPage;

	                var pageNo = Math.ceil(parseInt(totalCnt) / parseInt(recordCountPerPage));
	                if(parseInt(currentPage) < pageNo) {
	                    target.parent().next().show();
	                } else {
	                    target.parent().next().hide();
	                }

					target.show();
					target.parent().next().next().hide();

					//if(totalCnt > recordCountPerPage) target.parent().next().show();
	        	} else {
	        		target.hide();
	        		target.parent().next().hide();
	        		target.parent().next().next().show();
	        	}
	        }
	    });
	};
</script>

<input type="hidden" id="currentPage" name="currentPage" value="0">
<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="20">
<input type="hidden" id="pageType" name="pageType" value="ticketing">
<input type="hidden" id="specialOrd" value="">
<input type="hidden" id="tabCd" name="tabCd" value="">

<!-- container -->
<div class="container">
	<!-- page-tit-area -->
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="/movie" title="영화 페이지로 이동">영화</a>
				<a href="/curation/specialcontent" title="큐레이션 페이지로 이동">큐레이션</a>
			</div>


		</div>
	</div>
	<!--// page-tit-area -->

	<!-- contents -->
	<div id="contents">
		<!-- inner-wrap -->
		<div class="inner-wrap">
			<h2 class="tit">큐레이션</h2>

			<!-- 2019-06-28 : 수정 -->
			<ul class="dot-list mb40">
			<!--// 2019-06-28 : 수정 -->
				<li>
					감동을 주는 한 편의 영화가 행복한 삶에 영감이 되듯이,가치를 지닌 문화 콘텐트를 함께 나누고 소통하는 공간을 창조하여 메가박스는 관객 여러분과 함께, 더 행복한 세상을 만들어가겠습니다.
				</li>
			</ul>

			<div class="tab-list mb30">
				<ul id="tab-list">
					<li class="on"><a href="/curation/specialcontent#" data-target="infoContent" data-cd="" title="큐레이션소개 탭으로 이동">큐레이션소개</a></li>
					<li><a href="/curation/specialcontent#" data-target="filmContent" data-cd="film" title="필름소사이어티 탭으로 이동">필름소사이어티</a></li>
					<li><a href="/curation/specialcontent#" data-target="classicContent" data-cd="classic" title="클래식소사이어티 탭으로 이동">클래식소사이어티</a></li>
				</ul>
			</div>

			<div class="qr-box content infoContent">
				<div class="qr-top-info">
					<p class="tit-pr">MEGABOX SOCIETY</p>

					<p>메가박스의 <span class="font-orange">특별콘텐트 큐레이션 브랜드</span>를 소개합니다.</p>

					<ul class="dot-list">
						<li>소사이어티는 메가박스가 추천하는 좋은영화, 명작 클래식 공연을 큐레이션하여 다양한 기획프로그램과 멤버십 서비스를 제공합니다.</li>
						<li>소사이어티 멤버가 되세요! 메가박스 회원이라면 누구나 무료로 쉽게 가입하고 멤버만의 특별한 혜택을 누릴 수 있습니다.</li>
						<li>상영 및 이벤트 안내 등 소사이어티 관련 정보는 마케팅 동의 후에 수신이 가능하며, 거부하시더라도 불이익은 없습니다.</li>
						<li>마케팅 정보 수신 동의 방법 : 나의 메가박스 &gt; 내 정보 관리 &gt; 마케팅 정보 수신 동의 &gt; PUSH / SMS / 이메일 동의</li>
						<li>스페셜 멤버십 탈퇴 후, 30일 경과 후 재가입할 수 있습니다.</li>
					</ul>
				</div>
			</div>

			<!-- qr-decal -->
			<div class="qr-decal content infoContent">
				<!-- film-con -->
				<div class="film-con">
					<div class="con-headtext">
						<!-- 2019-06-28 : 수정 -->
						<img src="/resources/movie/mem-sp-img01.png" alt="MEGABOX FILM SOCIETY">

						<p>
							<span>메가박스</span>
							<strong>필름 소사이어티</strong>
						</p>
					</div>

					<!-- 2019-06-28 : 수정 -->
					<!-- con-inner -->
					<div class="con-inner">
						<p>
							<strong>인생의 영화를 만나는 방법</strong>
							필름소사이어티는 좋은 영화를 선별해 상영하고 깊이있는 영화 연계<br>
							프로그램을 제공하는 메가박스의 좋은 영화 큐레이션 브랜드 입니다.
						</p>

						<!-- mebership-con -->
						<div class="mebership-con">
							<p class="tit">FILM SOCIETY MEMBERSHIP</p>

							<ul class="decimal-list">
								<li>
									멤버십 회원 전용 온라인 10%할인 쿠폰 발행
									<a href="/curation/specialcontent#member_special_tool_layer01" class="btn-member-special-tool" title="클래식 및 기획전 할인 안내 팝업 보기"><i class="iconset ico-exclamation">아이콘</i></a>
								</li>
								<!--
								<li>
									계단아래 만화방 무료 입장
									<a href="#member_special_tool_layer02" class="btn-member-special-tool" title="계단아래 만화방 무료 입장 안내 팝업 보기"><i class="iconset ico-exclamation">아이콘</i></a>
								</li>-->
								<li>회원 전용 gv 및 시사회 초대</li>
							</ul>
						</div>
						<!--// mebership-con -->

						<ul class="dot-list gray">
							<li>상기 멤버십 서비스 혜택은 변경 및 종료 될 수 있습니다.</li>
							<li>할인율은 상이하오니 해당 이벤트 페이지에서 확인해 주세요.</li>
						</ul>

						<!-- 2019-03-05 : 레이어 이벤트 합침. 팝업 사이즈 추가 -->
						<div class="btn-group center pt23">
							
							
								
								
									<a href="/curation/specialcontent#" class="button regActionBtn" data-cd="SMT01" title="가입하기">가입하기</a>
								
							
						</div>

						<!-- 레이어 : 클래식 및 기획전 할인 -->
						<div id="member_special_tool_layer01" class="member-special-tool-layer">
							<div class="wrap">
								<div class="tit-area">
									<p class="tit">멤버십 회원 전용 온라인 10%할인 쿠폰 발행</p>
								</div>

								<div class="cont-area">
									삶에 질문을 던지는 좋은 영화를 다양한 각도에서  조명하는 영화 연계 기획전 및 클래스를 진행합니다. <br>
									프로그램에 대한 자세한 사항은 추후 이벤트 페이지를 통해 고지됩니다.<br>
									할인 쿠폰 발행은 가입 기준 익일 발행.
								</div>

								<button type="button" class="btn-close-tooltip">툴팁 닫기</button>
							</div>
						</div>
						<!--// 레이어 : 클래식 및 기획전 할인 -->

						<!-- 레이어 : 계단아래 만화방 무료 입장 -->
						<div id="member_special_tool_layer02" class="member-special-tool-layer">
							<div class="wrap">
								<div class="tit-area">
									<p class="tit">계단아래 만화방 무료 입장</p>
								</div>

								<div class="cont-area">
									상영작의 원작 만화와 화집은 물론,<br>
									그 외에 스크린이 탐낼만한 다양한 장르의 만화까지! <br>
									무궁한 만화의 시계를 만날 수 있는 계단아래 만화방을 방문해보세요

									<div class="box-gray v2 mt05">
										쿠폰:월 2회 / <span class="font-orange">매표소 혹은 티켓판매기</span>에서<br>
										출력 후 만화방 안내데스크 제시 <br>
										(1일 1회 2시간 이용 가능)
									</div>

									<div class="mt05">
										※ 매월 첫째주 월요일 휴무<br>
										※ 회원가입 후 익일 쿠폰 자동발급
									</div>
								</div>

								<button type="button" class="btn-close-tooltip">툴팁 닫기</button>
							</div>
						</div>
						<!--// 레이어 : 계단아래 만화방 무료 입장 -->
					</div>
					<!--// con-inner -->
					<!--// 2019-06-28 : 수정 -->
				</div>
				<!--// film-con -->

				<!-- classic-con -->
				<div class="classic-con">
					<div class="con-headtext">
						<!-- 2019-06-28 : 수정 -->
						<img src="/resources/movie/mem-sp-img02.png" alt="MEGABOX CLASSIC SOCIETY">

						<p>
							<span>메가박스</span>
							<strong>클래식 소사이어티</strong>
						</p>
					</div>

					<!-- 2019-06-28 : 수정 -->
					<div class="con-inner">
						<p>
							<strong>스크린으로 만나는 세계의 모든 클래식</strong>
							클래식소사이어티는 전 세계의 클래식 명작을 영화관에서 감상할 수 있는<br>
							메가박스의 클래식 공연 큐레이션 브랜드 입니다.
						</p>

						<div class="mebership-con">
							<p class="tit">CLASSIC SOCIETY MEMBERSHIP</p>

							<ul class="decimal-list">
								<li>
									멤버십 회원 전용 온라인 10% 할인 쿠폰 발행 <span>(클래식 라이브 제외)</span>
									<a href="/curation/specialcontent#member_special_tool_layer03" class="btn-member-special-tool" title="멤버십 회원 전용 온라인 10% 할인 쿠폰 발행 (클래식 라이브 제외) 안내 팝업 보기"><i class="iconset ico-exclamation"></i></a>
								</li>
								<li>
									클래식 소사이어티 프로그램 10% 할인 <span>(팝콘 클래식)</span>
									<a href="/curation/specialcontent#member_special_tool_layer04" class="btn-member-special-tool" title="클래식 소사이어티 프로그램 10% 할인 (팝콘 클래식) 안내 팝업 보기"><i class="iconset ico-exclamation"></i></a>
								</li>
								<li>SMS 미리알림 서비스</li>
							</ul>
						</div>

						<ul class="dot-list gray">
							<li>상기 멤버십 서비스 혜택은 변경 및 종료될 수 있습니다.</li>
							<li>할인율은 상이하오니 해당 이벤트 페이지에서 확인해 주세요. </li>
						</ul>

						<div class="btn-group">
							
									<a href="/curation/specialcontent#" class="button regActionBtn" data-cd="SMT02" title="가입하기">가입하기</a>
							
						</div>

						<!-- 레이어 : 멤버십 회원 전용 온라인 10% 할인 쿠폰 발행 -->
						<div id="member_special_tool_layer03" class="member-special-tool-layer">
							<div class="wrap">
								<div class="tit-area">

									<p>클래식 소사이어티 상영작 온라인 10% 할인쿠폰</p>
								</div>

								<div class="cont-area">
									<div>


										- 최고의 아티스트들이 선보이는 뉴욕 메트로폴리탄<br>&nbsp;&nbsp;&nbsp;&nbsp;극장의 오페라<br>
										- 유럽 오페라의 정수를 만끽하는 유니텔 오페라<br>
										- 그 외 다양한 클래식 공연 콘텐트<br>
										<br>할인 쿠폰은 가입일 기준 익일 발행<br>
										클래식 라이브는 할인에서 제외
									</div>

								</div>

								<button type="button" class="btn-close-tooltip">툴팁 닫기</button>
							</div>
						</div>
						<!--// 레이어 : 멤버십 회원 전용 온라인 10% 할인 쿠폰 발행 -->

						<!-- 레이어 : 클래식 소사이어티 프로그램 10% 할인 -->
						<div id="member_special_tool_layer04" class="member-special-tool-layer">
							<div class="wrap">
								<div class="tit-area">
									<p class="tit">클래식 소사이어티 프로그램 10% 할인</p>
								</div>

								<div class="cont-area">
									<strong>팝콘 클래식</strong><br>
									더 가볍게, 더 즐겁게 영화관에서 처음 만나는 클래식 미니팝콘과 함께 즐기는 렉쳐 콘서트<br>
									※ 상세 프로그램은 추후 홈페이지를 통해 확인하실 수  있습니다.
								</div>

								<button type="button" class="btn-close-tooltip">툴팁 닫기</button>
							</div>
						</div>
						<!--// 레이어 : 클래식 소사이어티 프로그램 10% 할인 -->
					</div>
					<!--// 2019-06-28 : 수정 -->
				</div>
				<!--// classic-con -->
			</div>
			<!--// qr-decal -->

			<div class="qr-wrap content film filmContent" style="display: none;">
				<span class="badge-img"><img src="/resources/movie/img-film-society-badge.png" alt="MEGABOX FILM SOCIET"></span>

				<p class="tit">MEGABOX FILM SOCIETY</p>
				<div class="text">
					수많은 영화가 상영되는 오늘날 우리가 잊지 않아야 할 것은 한편의 영화가 가진 가치입니다.<br>
					위로를 건네고 아름다움을 보여주며 진실을 밝히는 한 편의 영화.<br>
					이로써 누군가에게 인생의 영화가 될 그 한편의 영화를 소개합니다.
				</div>
				<div class="text">
					소사이어티는 메가박스가 추천하는 좋은영화, 명작 클래식 공연을 큐레이션하여 다양한 기획프로그램과 멤버십 서비스를 제공합니다. <br>
					소사이어티 멤버가 되세요! 메가박스 회원이라면 누구나 무료로 쉽게 가입하고 멤버만의 특별한 혜택을 누릴 수 있습니다.
				</div>
			</div>

			<!-- movie-list-util -->
			<div class="movie-list-util mt40 content filmContent" style="display: none;">
				<!-- 검색결과 있을 때, 검색 하기 전  -->
				<div class="movie-sorting" id="sortFilmTab">
					<span><button type="button" class="btn on" sort-type="ticketing" data-ord="" data-cd="">전체</button></span>
					
						<span>
							<button type="button" class="btn" data-cd="MVCT01">일반콘텐트</button>
						</span>
					
						<span>
							<button type="button" class="btn" data-cd="MVCT05">렉처</button>
						</span>
					
				</div>
			</div>
			<!--// movie-list-util -->

			<!-- movie-list -->
			<div class="movie-list content filmContent" style="display: none;">
				<ol class="list movieList"></ol>
			</div>
			<!--// movie-list -->

			<!--
				to 개발 :
				웹접근성 이슈 : 더보기 클릭시 새로 생성되는 목록의 첫번째 li 로 focus 가 이동되어야 합니다. (tabindex="0")
			 -->
			<div class="btn-more" id="addMovieDiv" style="display: none;">
				<button type="button" class="btn" id="btnFilmAddMovie">더보기 <i class="iconset ico-btn-more-arr"></i></button>
			</div>

			<!-- 검색결과 없을 때 -->
			<div class="movie-list-no-result content filmContent" id="noDataDiv" style="display: none;">
				<p>현재 상영중인 영화가 없습니다.</p>
<!--
				<p>
					<strong>영화검색 <i class="iconset ico-tip">Tip</i></strong>
					하나의 단어만 입력해도 검색이 가능합니다.
				</p> -->
			</div>

			
				<h3 class="tit mt60 content filmContent" style="display: none;">관련이벤트</h3>
				<div class="event-box content filmContent" style="display: none;">
					<ul class="curationList">
					</ul>
				</div>
			

			<div class="qr-wrap classic content classicContent" style="display: none;">
				<span class="badge-img"><img src="/resources/movie/img-classic-society-badge.png" alt="MEGABOX CLASSIC SOCIETY"></span>

				<p class="tit">MEGABOX CLASSIC SOCIETY</p>
				<div class="text">
					영화관이 전세계의 오페라와 클래식 페스티벌을 생생하게 감상할 수 있는 공연장이 됩니다. <br>
					스크린으로 국경없는 문화생활을 만나보세요.<br>
					메가박스 클래식 소사이어티는 당신에게 클래식한 영화같은 순간들을 제안합니다.
				</div>
				<div class="text">
					누구나 쉽고 가볍게 클래식과 가까워 질 수 있습니다. <br>
					클래식의 울림과 감동이 여러분에게 전해지길 바랍니다.
				</div>
			</div>

			<!-- movie-list-util -->
			<div class="movie-list-util mt40 content classicContent" style="display: none;">
				<!-- 검색결과 있을 때, 검색 하기 전  -->
				<div class="movie-sorting" id="sortClassicTab">
					<span><button type="button" class="btn on" sort-type="ticketing" data-ord="" data-cd="">전체</button></span>
					
						<span>
							<button type="button" class="btn" data-cd="MVCT06">클래식콘텐트</button>
						</span>
					
				</div>
			</div>
			<!--// movie-list-util -->

			<!-- movie-list -->
			<div class="movie-list content classicContent" style="display: none;">
				<ol class="list movieList"></ol>
			</div>
			<!--// movie-list -->

			<!--
				to 개발 :
				웹접근성 이슈 : 더보기 클릭시 새로 생성되는 목록의 첫번째 li 로 focus 가 이동되어야 합니다. (tabindex="0")
			 -->
			<div class="btn-more" id="addMovieDiv" style="display: none;">
				<button type="button" class="btn" id="btnClassicAddMovie">더보기 <i class="iconset ico-btn-more-arr"></i></button>
			</div>

			<!-- 검색결과 없을 때 -->
			<div class="movie-list-no-result content classicContent" id="noDataDiv" style="display: none;">
				<p>현재 상영중인 영화가 없습니다.</p>
<!--
				<p>
					<strong>영화검색 <i class="iconset ico-tip">Tip</i></strong>
					하나의 단어만 입력해도 검색이 가능합니다.
				</p> -->
			</div>

			
				<h3 class="tit mt60 content classicContent" style="display: none;">관련이벤트</h3>
				<div class="event-box content classicContent" style="display: none;">
					<ul class="curationList">
					</ul>
				</div>
			
		</div>
		<!--// inner-wrap -->

		<!-- 필름 소사이어티 멤버십 가입 POPUP -->
		<!-- 2019-06-28 : 수정 : 대부분 class 변경 및 이미지 경로 변경, 테이블 caption 값 추가 -->
		<section id="film_join" class="modal-layer member-join"><a href="/curation/specialcontent" class="focus">레이어로 포커스 이동 됨</a>
			<div class="wrap">
				<header class="layer-header">
					<h3 class="tit">스페셜멤버십 회원가입</h3>
				</header>

				<div class="layer-con film">
					<div class="layer-sm-join">
						<div class="con-head">
							<img src="/resources/movie/img-film-society-pop.png" alt="MEGABOX FILM SOCIETY">

							<p>
								<strong class="font-orange">필름 소사이어티 멤버십 가입</strong>
								<span>
									필름소사이어티 멤버십 가입은 이용안내 및 다양한 정보제공을 위한<br>
									SMS 및 이메일 수신동의 후 이용하실 수 있습니다.
								</span>
							</p>
						</div>
					</div>

					<p class="tit">
						<b>멤버십 카드 등록하기</b>

						<span class="font-orange">* 필수</span>
					</p>

					<div class="table-wrap">
						<table class="board-form">
							<caption>SMS 수신동의, 이메일 수신동의 항목을 가진 필름 소사이어티 멤버십 가입 신청 표</caption>
							<colgroup>
								<col style="width:140px;">
								<col>
								<col style="width:80px;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">
										<label for="sms01">SMS 수신동의</label>
										<em class="font-orange">*</em>
									</th>
									<td>
										<input type="text" id="sms01" class="input-text w530px x-small" placeholder="010-0000-0000" title="핸드폰번호 입력" value="" disabled="">
									</td>
									<td>
										<input type="checkbox" id="chk03" class="smsChk"> <label for="chk03">동의</label>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="email01">이메일 수신동의</label>
										<em class="font-orange">*</em>
									</th>
									<td>
										<input type="text" id="email01" class="input-text w150px x-small" title="이메일 아이디부분 입력" value="" disabled="">
										<span class="mg05">@</span>
										<input type="text" class="input-text w350px x-small" title="이메일 뒷 주소입력" value="" disabled="">
									</td>
									<td>
										<input type="checkbox" id="chk04" class="mailChk"><label for="chk04">동의</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<p class="mt10">휴대폰 번호/이메일 정보변경을 원하시면 <span class="font-gblue">나의메가박스&gt;개인정보관리</span> 에서 변경할 수 있습니다.</p>

					<p class="join-txt"><span class="font-orange">필름소사이어티</span> 멤버십 서비스에 가입하겠습니까?</p>

					<div class="box-border v1 use-guide">
						<p class="tit">이용안내</p>

						<ul class="dot-list">
							<li>메가박스 필름소사이어티는 상영작 안내와 고객님이 참여하실 수 있는 특별 이벤트 외의 불필요한 정보는 제공하지 않습니다.</li>
							<li>동의하지 않으시면 멤버십에 가입되지 않으며, 거부하시더라도 불이익은 없습니다.</li>
						</ul>
					</div>
				</div>

				<div class="btn-group-fixed">
					<button type="button" class="button small close-layer">닫기</button>
					<a href="/curation/specialcontent#" class="button purple small regActionBtn" data-cd="SMT01" title="가입">가입</a>
				</div>

				<button type="button" class="btn-modal-close">레이어 닫기</button>
			</div>
		</section>
		<!--// 2019-06-28 : 수정 : 대부분 class 변경 및 이미지 경로 변경, 테이블 caption 값 추가 -->
		<!--// 필름 소사이어티 멤버십 가입 POPUP -->

		<!-- 클래식 소사이어티 멤버십 가입 POPUP -->
		<!-- 2019-06-28 : 수정 : 대부분 class 변경 및 이미지 경로 변경, 테이블 caption 값 추가 -->
		<section id="classic_join" class="modal-layer member-join"><a href="/curation/specialcontent" class="focus">레이어로 포커스 이동 됨</a>
			<div class="wrap">
				<header class="layer-header">
					<h3 class="tit">스페셜멤버십 회원가입</h3>
				</header>

				<div class="layer-con classic">
					<div class="layer-sm-join">
						<div class="con-head">
							<img src="/resources/movie/img-classic-society-pop.png" alt="MEGABOX FILM SOCIETY">

							<p>
								<strong class="font-dblue">클래식 소사이어티 멤버십 가입</strong><!-- 2019-01-30 클래스 변경 -->
								<span>
									클래식소사이어티 멤버십 가입은 이용안내 및 다양한 정보제공을 위한<br>
									SMS 및 이메일 수신동의 후 이용하실 수 있습니다.
								</span>
							</p>
						</div>
					</div>

					<p class="tit">멤버십 카드 등록하기 <span class="font-orange">* 필수</span></p>

					<div class="table-wrap">
						<table class="board-form">
							<caption>SMS 수신동의, 이메일 수신동의 항목을 가진 클래식 소사이어티 멤버십 가입 신청 표</caption>
							<colgroup>
								<col style="width:140px;">
								<col>
								<col style="width:80px;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">
										<label for="sms02">SMS 수신동의</label>
										<em class="font-orange">*</em>
									</th>
									<td>
										<input type="text" id="sms02" class="input-text w530px x-small" title="핸드폰번호 입력" value="" disabled="">
									</td>
									<td>
										<input type="checkbox" id="classicSmsChk" class="smsChk">
										<label for="classicSmsChk">동의</label>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="email02">이메일 수신동의</label>
										<em class="font-orange">*</em>
									</th>
									<td>
										<input type="text" id="email02" class="input-text w150px x-small" title="이메일 아이디부분 입력" value="" disabled="">
										<span class="mg05">@</span>
										<input type="text" class="input-text w350px x-small" title="이메일 뒷주소 입력" value="" disabled="">
									</td>
									<td>
										<input type="checkbox" id="classicMailChk" class="mailChk">
										<label for="classicMailChk">동의</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<p class="mt10">휴대폰 번호/이메일 정보변경을 원하시면 <span class="font-gblue">나의메가박스&gt;개인정보관리</span> 에서 변경할 수 있습니다.</p>

					<p class="join-txt"><span class="font-orange">클래식소사이어티</span> 멤버십 서비스에 가입하겠습니까?</p>

					<div class="box-border v1 use-guide">
						<p class="tit">이용안내</p>

						<ul class="dot-list">
							<li>메가박스 클래식소사이어티는 상영작 안내와 고객님이 참여하실 수 있는 특별 이벤트 외의 불필요한 정보는 제공하지 않습니다.</li>
							<li>동의하지 않으시면 멤버십에 가입되지 않으며, 거부하시더라도 불이익은 없습니다.</li>
						</ul>
					</div>
				</div>

				<div class="btn-group-fixed">
					<button type="button" class="button close-layer small">닫기</button>
					<a href="/curation/specialcontent#" class="button purple small regActionBtn" data-cd="SMT02" title="가입">가입</a>
				</div>

				<button type="button" class="btn-modal-close">레이어 닫기</button>
			</div>
		</section>
		<!--// 2019-06-28 : 수정 : 대부분 class 변경 및 이미지 경로 변경, 테이블 caption 값 추가 -->
		<!--// 클래식 소사이어티 멤버십 가입 POPUP -->
	</div>
	<!--// contents -->
</div>
<!--// container -->
<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/curation/specialcontent" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/curation/specialcontent" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/curation/specialcontent#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>