<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>

<!DOCTYPE html>
<!-- saved from url=(0031)/movie -->
<html lang="ko" ><!--<![endif]-->
	<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
	<link rel="shortcut icon" href="/resources/common/ico/favicon.ico">


		<title>MEET PLAY SHARE, 메가박스</title>
		<meta property="name"			id="metaTagTitle"	content="MEET PLAY SHARE, 메가박스"/>
		<meta property="description"	id="metaTagDtls"	content="사람들과 공유할 수 있는, 공간경험을 만듭니다."/>
		<meta property="keywords"		id="metaTagKeyword"	content="메가박스,megabox,영화,영화관,극장,티켓,박스오피스,상영예정작,예매,오페라,싱어롱,큐레이션,필름소사이어티,클래식소사이어티,이벤트,Movie,theater,Cinema,film,Megabox"/>

		<meta property="fb:app_id" 		id="fbAppId" 	content="546913502790694"/>
		

		<meta property="og:site_name" 	id="fbSiteName"	content="메가박스"/>
		<meta property="og:type" 		id="fbType"		content="movie"/>
		<meta property="og:url" 		id="fbUrl"		content="" />
		<meta property="og:title" 		id="fbTitle"	content="MEET PLAY SHARE, 메가박스" />
		<meta property="og:description"	id="fbDtls"		content="사람들과 공유할 수 있는, 공간경험을 만듭니다."/>
		<meta property="og:image" 		id="fbImg"		content="/resources/common/ci/begabox_logo.jpg" />

		<link rel="stylesheet" href="/resources/css/megabox.min.css" media="all" />
		<!-- Global site tag (gtag.js) - Google Analytics -->
		<script async src="https://www.googletagmanager.com/gtag/js?id=UA-30006739-3"></script>
		<script>window.dataLayer = window.dataLayer || []; function gtag(){dataLayer.push(arguments);} gtag('js', new Date()); gtag('config', 'UA-30006739-3');</script>
		<script src="/resources/js/megabox.api.min.js"></script>
		<script src="/resources/js/lozad.min.js"></script>
		<script src="/resources/js/megabox.common.min.js"></script>
		<script src="/resources/js/megabox.netfunnel.min.js"></script>
		<script src="/resources/js/persona.js" async></script>
		<script src="/resources/js/ui.common.js"></script>
		<script src="/resources/js/front.js"></script>
		<script src="/resources/js/leVzVmI9mJHrotGMGQAk3u3f1U1EH0RC2PaUuQzpzIaEAM4qWzAZAbZ2ZUE2R2ViZlRGcWgtblFmeDZlb2RBAstB2PmHppu1nQPLQdj5h6abtZ0.js"></script>
		
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumBarunGothic@latest/nanumbarungothicsubset.css">
</head>
	
<body>	
	<div class="skip" title="스킵 네비게이션">
        <a href="#contents" title="본문 바로가기">본문 바로가기</a>
        <a href="#footer" title="푸터 바로가기">푸터 바로가기</a>
    </div>
<div class="body-wrap">

<script src="/resources/js/hmac-sha256.js"></script>
<script src="/resources/js/enc-base64-min.js"></script>

<!-- header -->
<header id="header" class="main-header no-bg">
	<h1 class="ci"><a href="/" title="MEGABOX 메인으로 가기">MEGABOX : Life Theater</a></h1>

    <!-- topGnb -->
    <div class="util-area">
        <div class="left-link">
            <a href="/benefits/vipLounge" title="VIP LOUNGE">VIP LOUNGE</a>
            <a href="/benefits/memberShip" title="멤버십">멤버십</a>
            <a href="/movie/list" title="고객센터">고객센터</a>
        </div>

        <div class="right-link">
            <c:choose>
            	
            	<c:when test="${empty sessionScope.customInfo.id }">
            		<a href="/movie/login" title="로그인">로그인</a>
            		<a href="/movie/join" title="회원가입">회원가입</a>
					<a href="/booking_1">빠른예매</a>
            	</c:when>     	
            	 
            	<c:otherwise>
            		<a href="">${sessionScope.customInfo.id }님</a>
            	 	<a href="/movie/logout" title="로그아웃">로그아웃</a>
            	 	<a href="/movie/mypage" title="마이페이지">마이페이지</a>
					<a href="/booking_1">빠른예매</a>
            	</c:otherwise>	 
            </c:choose>
        </div>
    </div>

    <div class="link-area">
		<a href="#layer_sitemap" class="header-open-layer btn-layer-sitemap" title="사이트맵">사이트맵</a>
		<a href="#layer_header_search" class="header-open-layer btn-layer-search" title="검색">검색</a>
        <a href="/booking/timeTable" class="link-ticket" title="상영시간표">상영시간표</a>
        <a href="/movie/mypage" class="header-open-layer btn-layer-mymega" title="나의 메가박스">나의 메가박스</a>
    </div>

    <!-- gnb -->
    
    <nav id="gnb" class="">
        <ul class="gnb-depth1">
            <li><a href="/movie/movie" class="gnb-txt-movie" title="영화">영화</a>
                <div class="gnb-depth2">
                    <ul>
                        <li><a href="/movie/movie" title="전체영화">전체영화</a></li>


                        <li><a href="/movie/curation" title="큐레이션">큐레이션</a></li>
                        
                        
                        <li><a href="/movie/moviePost" title="무비포스트">무비포스트</a></li>
                    </ul>
                </div>
            </li>
            <li><a href="/booking_1" class="gnb-txt-reserve" title="예매">예매</a>
                <div class="gnb-depth2">
                    <ul>
                        <li><a href="/booking_1" title="빠른예매">빠른예매</a></li>
                        <li><a href="/booking/timeTable" title="상영시간표">상영시간표</a></li>
                        <li><a href="/booking/privateBooking" title="더 부티크 프라이빗 예매">더 부티크 프라이빗 예매</a></li>
                    </ul>
                </div>
            </li>
            <li><a href="/theater/allTheater" class="gnb-txt-theater" title="극장">극장</a>
                <div class="gnb-depth2">
                    <ul>
                        <li><a href="/theater/allTheater" title="전체극장">전체극장</a></li>
                        <li><a href="/theater/specialTheater" title="특별관">특별관</a></li>
                    </ul>
                </div>
            </li>
            <li><a href="/event/event" class="gnb-txt-event" title="이벤트">이벤트</a>
                <div class="gnb-depth2">
                    <ul>
                        <li><a href="/event/event" title="진행중 이벤트">진행중 이벤트</a></li>
                    </ul>
                </div>
            </li>
            <li><a href="/store"  class="gnb-txt-store" title="스토어">스토어</a></li>
            <li><a href="/benefits/memberShip" class="gnb-txt-benefit" title="혜택">혜택</a>
                <div class="gnb-depth2">
                    <ul>
                        <li><a href="/benefits/memberShip" title="메가박스 멤버십">메가박스 멤버십</a></li>
                        <li><a href="/benefits/disCount" title="제휴/할인">제휴/할인</a></li>
                    </ul>
                </div>
            </li>
        </ul>
    </nav>
    <!--// gnb -->

    <!--// topGnb -->

    <!-- 레이어 : 사이트맵 -->
	<div id="layer_sitemap" class="header-layer layer-sitemap">
        <!-- wrap -->
        <div class="wrap">
            <a href="/movie" class="link-acc" title="사이트맵 레이어 입니다.">사이트맵 레이어 입니다.</a>

            <p class="tit">SITEMAP</p>

            <div class="list position-1">
                <p class="tit-depth">영화</p>

                <ul class="list-depth">
                    <li><a href="/movie/movie" title="전체영화">전체영화</a></li>
                    <li><a href="/movie/curation" title="큐레이션">큐레이션</a></li>                    
                    <li><a href="/movie/moviePost" title="무비포스트">무비포스트</a></li>
                </ul>
            </div>

            <div class="list position-2">
                <p class="tit-depth">예매</p>

                <ul class="list-depth">
                    <li><a href="/booking_1" title="빠른예매">빠른예매</a></li>
                    <li><a href="/booking/timeTable" title="상영시간표">상영시간표</a></li>
                    <li><a href="/booking/privateBooking" title="더 부티크 프라빗 예매">더 부티크 프라이빗 예매</a></li>
                </ul>
            </div>

            <div class="list position-3">
                <p class="tit-depth">극장</p>
                <ul class="list-depth">
                    <li><a href="/theater/allTheater" title="전체극장">전체극장</a></li>
                    <li><a href="/theater/specialTheater" title="특별관">특별관</a></li>
                </ul>
            </div>

            <div class="list position-4">
                <p class="tit-depth">이벤트</p>

                <ul class="list-depth">
                    <li><a href="/event/event" title="진행중 이벤트">진행중 이벤트</a></li>
                </ul>
            </div>

            <div class="list position-5">
                <p class="tit-depth">스토어</p>

                <ul class="list-depth">
                    <li><a href="/store" title="새로운 상품">스토어</a></li>
                </ul>
            </div>
			
            <div class="list position-6">
                <p class="tit-depth">나의 메가박스</p>
                <ul class="list-depth mymage">
					<li><a href="#" title="나의 메가박스 홈">나의 메가박스 홈</a></li>
					<li><a href="#" title="예매/구매내역">예매/구매내역</a></li>
					<li><a href="#" title="나의 문의내역">나의 문의내역</a></li>
					<li><a href="/movie/mypage" title="회원정보">회원정보</a></li>
                </ul>
            </div>
			
            <div class="list position-7">
                <p class="tit-depth">혜택</p>

                <ul class="list-depth">
                    <li><a href="/benefits/memberShip" title="멤버십 안내">멤버십 안내</a></li>
                    <li><a href="/benefits/vipLounge" title="VIP LOUNGE">VIP LOUNGE</a></li>
                    <li><a href="/benefits/disCount" title="제휴/할인">제휴/할인</a></li>
                </ul>
            </div>

            <div class="list position-8">
                <p class="tit-depth">고객센터</p>

                <ul class="list-depth">
                    <li><a href="#" title="고객센터 홈">고객센터 홈</a></li>
                    <li><a href="#" title="자주묻는질문">자주묻는질문</a></li>
                    <li><a href="/support/notice" title="공지사항">공지사항</a></li>
                    <li><a href="/support/inquiry" title="1:1문의">1:1문의</a></li>
                    <li><a href="#" title="단체/대관문의">단체/대관문의</a></li>
                    <li><a href="#" title="분실물문의">분실물문의</a></li>
                </ul>
            </div>

            <div class="list position-9">
                <p class="tit-depth">회사소개</p>

                <ul class="list-depth">
                    <li><a href="#" target="_blank" title="메가박스소개">메가박스소개</a></li>
                    <li><a href="#" target="_blank" title="사회공헌">사회공헌</a></li>
                    <li><a href="#" target="_blank" title="홍보자료">홍보자료</a></li>
                    <li><a href="#" target="_blank" title="제휴/부대사업문의">제휴/부대사업문의</a></li>
                    <li><a href="#" target="_blank" title="온라인제보센터">온라인제보센터</a></li>
                    <li><a href="#" target="_blank" title="자료">IR자료</a></li>
                    <li><a href="#" target="_blank" title="인재채용림">인재채용</a></li>
                    <li><a href="#" target="_blank" title="윤리경영">윤리경영</a></li>
                </ul>
            </div>

            <div class="list position-10">
                <p class="tit-depth">이용정책</p>

                <ul class="list-depth">
                    <li><a href="#" title="이용약관">이용약관</a></li>
                    <li><a href="#" title="위치기반서비스 이용약관">위치기반서비스 이용약관</a></li>
                    <li><a href="#" title="개인정보처리방침">개인정보처리방침</a></li>
                    <li><a href="#" title="스크린수배정에관한기준">스크린수배정에관한기준</a></li>
                </ul>
            </div>
            
            <div class="list position-11">
                <p class="tit-depth">관리자 영화관리</p>
                <ul class="list-depth mymage">
					<li><a href="/movieSave" title="영화저장">영화저장</a></li>
					<li><a href="/movieTheaterSave" title="영화상영관저장">영화상영관저장</a></li>
					<li><a href="/movieTotalSave" title="영화통합저장">영화통합저장</a></li>
                </ul>
            </div>

            <div class="ir">
                <a href="/movie/movie" class="layer-close" title="레이어닫기">레이어닫기</a>
            </div>
        </div>
        <!--// wrap -->
    </div>
    <!--// 레이어 : 사이트맵 -->

    <!-- 레이어 : 검색 -->
    <div id="layer_header_search" class="header-layer layer-header-search"></div>
    <!--// 레이어 : 검색 -->
	
	
    <!-- 레이어 : 마이페이지 -->

	<div id="layer_mymega" class="header-layer layer-mymege">
    	<a href="/movie/movie" class="ir" title="나의 메가박스 레이어 입니다.">나의 메가박스 레이어 입니다.</a>

        <!-- wrap -->
        <div class="wrap" style="display:none">

            <div class="login-after">
                <div class="couponpass" style="display: none;">
                    <span>쿠폰패스 이용고객이시군요!!쿠폰패스로 발급된 쿠폰을 확인해보세요~ </span>
                </div>
                <div class="user-info">
                    <p class="txt">안녕하세요!</p>

                    <p class="info">
                        <!--
                            vip 일때만 출력
                            vip 아닐때는 태그 자체 삭제
                        -->
                       <em class="vip">VIP PREMIUM</em>
                        <em class="name"></em>
                        <span>회원님</span>
                    </p>

                    <div class="last-date">마지막 접속일 : <em></em></div>

                    <!-- vip, 멤버십 없을때는 미 출력  -->
                    <div class="membership">
                        <!-- <i class="iconset ico-header-vip"></i>
                        <i class="iconset ico-header-film"></i>
                        <i class="iconset ico-header-classic"></i> -->
                    </div>

                    <div class="btn-fixed">
                        <a href="/mypage" class="button" title="나의  메가박스">나의  메가박스</a>
                    </div>
                </div>

                <div class="box">
                    <div class="point">
                        <p class="tit">Point</p>

                        <p class="count">
                            0
                        </p>

                        <div class="btn-fixed">
                            <a href="/mypage/point-list" class="button" title="멤버십 포인트">멤버십 포인트</a>
                        </div>
                    </div>
                </div>

                <div class="box">
                    <div class="coupon">
                        <p class="tit">쿠폰/관람권 <!-- <i class="iconset ico-header-new"></i> --></p>

                        <p class="count">
                            <em title="쿠폰 수" class="cpon">0</em>
                            <span title="관람권 수" class="movie">0</span>
                        </p>

                        <div class="btn-fixed">
                            <a href="#" class="button" title="쿠폰">쿠폰</a>
                            <a href="#" class="button" title="관람권">관람권</a>
                        </div>
                    </div>
                </div>

                <div class="box">
                    <div class="reserve">
                        <p class="tit">예매 <!-- <i class="iconset ico-header-new"></i> --></p>

                        <p class="txt"></p>

                        <div class="btn-fixed">
                            <a href="/booking_1" class="button" title="예매내역">예매내역 </a>
                        </div>
                    </div>
                </div>

                <div class="box">
                    <div class="buy">
                        <p class="tit">구매 <!-- <i class="iconset ico-header-new"></i> --></p>

                        <p class="count">
                            <em>0</em>
                            <span>건</span>
                        </p>
                    </div>

                    <div class="btn-fixed">
                        <a href="/booking_1" class="button" title="구매내역">구매내역</a>
                    </div>
                </div>
            </div>

        	<!-- 로그인 전 -->
            <div class="login-before">
                <p class="txt">
                    로그인 하시면 나의 메가박스를 만날 수 있어요.<br>
                    영화를 사랑하는 당신을 위한 꼭 맞는 혜택까지 확인해 보세요!
                </p>

                <div class="mb50">
                    <a href="/movie/login" id="moveLogin" title="로그인" class="button w120px btn-modal-open" w-data="850" h-data="484">로그인</a>
                </div>

                <a href="/movie/join" class="link" title="혹시 아직 회원이 아니신가요?">혹시 아직 회원이 아니신가요?</a>
            </div>
        </div>
        <!--// wrap -->

        <div class="ir">
            <a href="/movie/movie" class="layer-close" title="레이어닫기">레이어닫기</a>
        </div>
	</div>
    <!--// 레이어 : 마이페이지 -->

</header>
<!--// header -->

