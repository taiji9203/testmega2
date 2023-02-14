<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->
<script type="text/javascript">
// Tab Index
var prdtClCd = '';

$(function(){
    
//상세페이지 이동
function fn_storeDetail(prdtNo){

	var contentUrl = "/store/detail?prdtClCd="+prdtClCd+"&prdtNo="+prdtNo;

    //$("#storeForm").append("<input type='hidden' name='cmbndKindNo' value='" + cmbndKindNo + "' />");
    $("#storeForm").append("<input type='hidden' name='postAt' value='Y' />");
    //$("#storeForm").attr("action",contentUrl+"?cmbndKindNo="+cmbndKindNo);
    $("#storeForm").attr("action",contentUrl);
    //$("#storeForm").submit();
	//넷퍼넬 적용
	NetfunnelChk.formSubmit("STORE_DTL", $("#storeForm"),function(){});
}
</script>


<!-- container -->
<div class="container">

    <div class="page-util">
        <div class="inner-wrap">
            <div class="location">
                <span>Home</span>
                <a href="javascript:void(0)" onclick="localhost/store" title="스토어">스토어</a>
            </div>

        </div>
    </div>

    <div id="storeMainList">



<!-- contents -->
<div id="contents">

    <!-- inner-wrap -->
    <div class="inner-wrap">

        <h2 class="tit">스토어</h2>

        <div class="tab-list fixed">
            <ul>
                <!-- li class="on" id="storeTab_"><a href="javascript:fn_chgStoreTab('')">새로운 상품 [  ]</a></li-->
                <li class="on" id="storeTab_"><a href="javascript:fn_storeTabMove(&#39;&#39;)" title="새로운 상품 탭으로 이동">새로운 상품</a></li>
                
                    <!-- li id="storeTab_CPC09"><a href="javascript:fn_chgStoreTab('CPC09')">기프트카드</a></li-->
		                    <li id="storeTab_CPC09" class=""><a href="#" title="기프트카드 탭으로 이동"><span class="pointmall">기프트카드</span></a></li>
                    <!-- li id="storeTab_CPC02"><a href="javascript:fn_chgStoreTab('CPC02')">메가티켓</a></li-->
		                    <li id="storeTab_CPC02" class=""><a href="#" title="메가티켓 탭으로 이동">메가티켓</a></li>
                    <!-- li id="storeTab_CPC05"><a href="javascript:fn_chgStoreTab('CPC05')">팝콘/음료/굿즈</a></li-->
		                    <li id="storeTab_CPC05" class=""><a href="#" title="팝콘/음료/굿즈 탭으로 이동">팝콘/음료/굿즈</a></li>
                    <!-- li id="storeTab_CPC07"><a href="javascript:fn_chgStoreTab('CPC07')">포인트몰</a></li--> <li id="storeTab_CPC07" class="">
							<a href="#" title="포인트몰 탭으로 이동"><span class="pointmall">포인트몰</span></a></li>
            </ul>
        </div>
    
        <!-- 새로운 상품 -->
        <div id="divNewPrdtArea">
            <!-- store-main -->
            <div class="store-main">
                        <!-- best-goods -->
                        <div class="best-goods">
                            <a href="#" title="메가박스 기프트카드 3만원권 상세보기">
                                <div class="slogun">
                                            <p class="font-gblue">메가박스 기프트카드 런칭!</p>
                                            <p class="font-purple">소중한 분께 선물하세요!</p>
                                </div>
                                <div class="goods">
                                    <p class="name">메가박스 기프트카드 3만원권</p>
                                    <p class="txt">메가박스 기프트카드 3만원권</p>
                                </div>
                                <div class="price">
                                </div>
                                <p class="img"><img src="/resources/store/UhUaGPc8CkaIn0wdjvdz6yhunnOzYdaP_280.png" alt="" onerror="noImg(this);"></p>
                            </a>
                        </div>
                        <!--// best-goods -->
                <!-- brn-store -->
                <!--// brn-store -->
            </div>
            <!--// store-main -->                      
                <div class="tit-util mt70 mb15">
                    <h3 class="tit">기프트카드</h3>

                    <div class="right">
                        <a href="#" title="더보기">더보기 <i class="iconset ico-arr-right-gray"></i></a>
                    </div>
                </div>
                <!-- store-list -->
                <div class="store-list">
                    <ul class="list">
						<li class="">
                                    <a href="#" title="메가박스 기프트카드 2만원권 상세보기">
                                        <div class="soldout">SOLD OUT</div>
                                                <div class="label new">NEW</div>
                                        <div class="img"><img src="/resources/store/OLQpuZPJ5wuIR9BqZK4sDRKN0t2O3sWV_280.png" alt="메가박스 기프트카드 2만원권" onerror="noImg(this);"></div>
                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">메가박스 기프트카드 2만원권</p>
                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">메가박스 기프트카드 2만원권</p>
                                            </div>
                                            <div class="price">  
		                                                <p class="sale">
		                                                    <em>20,000</em>
		                                                    <span>원</span>
		                                                </p>
	                                                <p class="ea">	                                                    
	                                                </p>                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="">
                                    <a href="#" title="메가박스 기프트카드 3만원권 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										<div class="label new">NEW</div>
										<div class="img"><img src="/resources/store/UhUaGPc8CkaIn0wdjvdz6yhunnOzYdaP_280.png" alt="메가박스 기프트카드 3만원권" onerror="noImg(this);"></div>
                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">메가박스 기프트카드 3만원권</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">메가박스 기프트카드 3만원권</p>
                                            </div>

                                            <div class="price">    
		                                                <p class="sale">
		                                                    <em>30,000</em>
		                                                    <span>원</span>
		                                                </p>
	                                                <p class="ea">
	                                                </p>                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="">
                                    <a href="#" title="메가박스 기프트카드 5만원권 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										<div class="label new">NEW</div>
                                        <div class="img"><img src="/resources/store/SvDPUHovAC2t5VdkHNby25qYMYGNp3tN_280.png" alt="메가박스 기프트카드 5만원권" onerror="noImg(this);"></div>
                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">메가박스 기프트카드 5만원권</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">메가박스 기프트카드 5만원권</p>
                                            </div>
                                            <div class="price">
												<p class="sale">
		                                                    <em>50,000</em>
		                                                    <span>원</span>
		                                                </p>
		                                              <p class="ea">
	                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                         </ul>
                </div>
                <!--// store-list --><div class="tit-util mt70 mb15">
                    <h3 class="tit">메가티켓</h3>
                    <div class="right">
                        <a href="#" title="더보기">더보기 <i class="iconset ico-arr-right-gray"></i></a>
                    </div>
                </div>
			<!-- store-list -->
                <div class="store-list">
                    <ul class="list">
						<li class="">
                                    <a href="#" title="일반관람권(2D) 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										<div class="label hot">대표상품</div>
                                        <div class="img"><img src="/resources/store/OzjTPmOIAocfyQnas3x8Vo9JDRRnHeKf_280.png" alt="일반관람권(2D)" onerror="noImg(this);"></div>
                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">일반관람권(2D)</p>
                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">일반 관람권</p>
                                            </div>
                                            <div class="price">                                            	
	                                                <p class="original">	                                                    
	                                                        13,000원	                                                    
	                                                </p>
		                                                <p class="sale">
		                                                    <em>12,000</em>
		                                                    <span>원</span>
		                                                </p>
	                                                <p class="ea">	                                                    
	                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </li><li class="">
                                    <a href="#" title="더 부티크 전용관람권 상세보기">
                                        <div class="soldout">SOLD OUT</div>

                                                <div class="label"></div>
                                        
                                        <div class="img"><img src="/resources/store/rxCDUuqHT9RostRRQYeu1mr1knFyHxWr_280.png" alt="더 부티크 전용관람권" onerror="noImg(this);"></div>

                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">더 부티크 전용관람권</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">2D 더 부티크 전용 관람권</p>
                                            </div>

                                            <div class="price">
                                            	
	                                                <p class="original">
	                                                    
	                                                        16,000원
	                                                    
	                                                </p>
                                                
	                                       		
		                                            
		                                            
		                                                <p class="sale">
		                                                    <em>15,000</em>
		                                                    <span>원</span>
		                                                </p>
		                                            
                                       		 	
							                    
	                                                <p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>  

                                <li class="">
                                    <a href="#" title="MX 전용관람권 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										<div class="label"></div>
										<div class="img"><img src="/resources/store/Yk3B0T93JXWbbjrrwVxbmTT9Iij5Tszv_280.png" alt="MX 전용관람권" onerror="#"></div>

                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">MX 전용관람권</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">2D MX 전용 관람권</p>
                                            </div>

                                            <div class="price">
                                            	
	                                                <p class="original">
	                                                    
	                                                        17,000원
	                                                </p>
		                                                <p class="sale">
		                                                    <em>16,000</em>
		                                                    <span>원</span>
		                                                </p>
	                                                <p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="">
                                    <a href="#" title="Dolby Cinema 전용관람권 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										<div class="label push">추천</div>
										<div class="img"><img src="/resources/store/XxKX38rQAArz5GGaFCs7KwvYyUz5oQFC_280.png" alt="Dolby Cinema 관람권" onerror="#"></div>

                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">Dolby Cinema 전용관람권</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">Dolby Cinema 전용 관람권(2D)</p>
                                            </div>

                                            <div class="price">
                                            	
	                                                <p class="original">
	                                                    
	                                                        18,000원
	                                                    
	                                                </p>  <p class="sale">
		                                                    <em>17,000</em>
		                                                    <span>원</span>
		                                                </p>
		                                            
                                       		 	
							                    
	                                                <p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                    </ul>
                </div>
                <!--// store-list -->
				  <div class="tit-util mt70 mb15">
                    <h3 class="tit">팝콘/음료/굿즈</h3>

                    <div class="right">
                        <a href="#" title="더보기">더보기 <i class="iconset ico-arr-right-gray"></i></a>
                    </div>
                </div>
                     <!-- store-list -->
                <div class="store-list">
                    <ul class="list">
						 <li class="">
                                    <a href="#" title="러브콤보 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										 <div class="label hot">대표상품</div>
                                            <div class="img"><img src="/resources/store/qB1IVqlOLCV7hOOEAJp4J9iG3J5oVWjv_280.png" alt="러브콤보" onerror="noImg(this);"></div>

                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">러브콤보</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">팝콘(L) 1 + 탄산음료(R) 2</p>
                                            </div>

                                            <div class="price"> <p class="sale">
		                                                    <em>10,000</em>
		                                                    <span>원</span>
		                                                </p> <p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
						<li class="">
                                    <a href="#" title="더블콤보 상세보기">
                                        <div class="soldout">SOLD OUT</div>

                                        
                                            
                                                <div class="label event">BEST</div>
                                             <div class="img"><img src="/resources/store/ERDC5wGVMC0YZPIRUsuuaJuAGRyqeDjC_280.png" alt="더블콤보" onerror="noImg(this);"></div>

                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">더블콤보</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">팝콘(R) 2 + 탄산음료(R) 2</p>
                                            </div>

                                            <div class="price">
                                            	<p class="sale">
		                                                    <em>13,000</em>
		                                                    <span>원</span>
		                                                </p>
		                                             <p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                             </ul>
                </div>
                <!--// store-list --> <div class="tit-util mt70 mb15">
                    <h3 class="tit">포인트몰</h3>

                    <div class="right">
                        <a href="#" title="더보기">더보기 <i class="iconset ico-arr-right-gray"></i></a>
                    </div>
                </div>    
                 <!-- store-list -->
                <div class="store-list">
                    <ul class="list">
						 <li class="">
                                    <a href="#" title="[100P럭키티켓] 타이타닉 25주년 한정판 LP 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										<div class="label"></div>
                                        <div class="img"><img src="/resources/store/BkCeTQCJ6ktf4opLZShzHj62ICMZUByZ_280.jpg" alt="[100P럭키티켓] 타이타닉 25주년 한정판 LP" onerror="noImg(this);"></div>
										<div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">[100P럭키티켓] 타이타닉 25주년 한정판 LP</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">&lt;타이타닉: 25주년&gt; 유료 관람 시 응모 가능</p>
                                            </div>

                                            <div class="price">
                                            	
	                                                <p class="original">
	                                                    
	                                                </p>
                                                
	                                       		
		                                            
		                                                <p class="sale">
		                                                    <em>100</em>
		                                                    <span>Point</span>
		                                                </p>
		                                            
		                                            
                                       		 	
							                    
	                                                <p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            <li class="">
                                    <a href="#" title="[100P럭키티켓] 타이타닉 1/400 프라모델 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										<div class="label"></div>
										<div class="img"><img src="/resources/store/LmqKhONchufqW2h7S5RBV4CljV1ofqlB_280.jpg" alt="[100P럭키티켓] 타이타닉 1/400 프라모델" onerror="#"></div>

                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">[100P럭키티켓] 타이타닉 1/400 프라모델</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">&lt;타이타닉: 25주년&gt; 유료 관람 시 응모 가능</p>
                                            </div>

                                            <div class="price">
                                            	
	                                                <p class="original">
	                                                    
	                                                </p>
                                                
	                                       		
		                                            
		                                                <p class="sale">
		                                                    <em>100</em>
		                                                    <span>Point</span>
		                                                </p>
		                                            
		                                            
                                       		 	
							                    
	                                                <p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                             <li class="">
                                    <a href="#" title="[100P럭키티켓] 제임스 카메론 작품 화보집  상세보기">
                                        <div class="soldout">SOLD OUT</div>
 <div class="label"></div>
                                           <div class="img"><img src="/resources/store/2qpJBv42TUgSCFzm2xlHTVveWeSdZ0e6_280.jpg" alt="[100P럭키티켓] 제임스 카메론 작품 화보집 " onerror="#"></div>

                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">[100P럭키티켓] 제임스 카메론 작품 화보집 </p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">&lt;타이타닉: 25주년&gt; 유료 관람 시 응모 가능</p>
                                            </div>

                                            <div class="price">
                                            	
	                                                <p class="original">
	                                                    
	                                                </p>
                                                
	                                       		
		                                            
		                                                <p class="sale">
		                                                    <em>100</em>
		                                                    <span>Point</span>
		                                                </p>
		                                            
		                                            
                                       		 	
							                    
	                                                <p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            <li class="">
                                    <a href="#" title="[100P럭키티켓] 돌비 시네마 2D 관람권 상세보기">
                                        <div class="soldout">SOLD OUT</div>
										<div class="label"></div>
										<div class="img"><img src="/resources/store/Cvjz4itcvecpO2B19SKu7PO7yfarWwBH_280.jpg" alt="[100P럭키티켓] 돌비 시네마 2D 관람권" onerror="#"></div>

                                        <div class="info">
                                            <div class="tit">
                                                <!-- 제품명 최대 2줄 -->
                                                <p class="name">[100P럭키티켓] 돌비 시네마 2D 관람권</p>

                                                <!-- 제품구성 최대 2줄 -->
                                                <p class="bundle">&lt;타이타닉: 25주년&gt; 유료 관람 시 응모 가능</p>
                                            </div>

                                            <div class="price">
                                            	
	                                                <p class="original">
	                                                    
	                                                </p>
												<p class="sale">
		                                                    <em>100</em>
		                                                    <span>Point</span>
		                                                </p>
												<p class="ea">
	                                                    
	                                                </p>
                                       		 	
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                </div>
                <!--// store-list -->

            
        </div>
        <!--// 새로운 상품 -->
    

    
        <!-- 카테고리 별 상품 -->
        
            <div id="divCategoryPrdtArea_CPC09" style="display:none">
                <!-- store-list -->
                <div class="store-list mt30">
                    <ul class="list">
						<li class="">
		                                    <a href="#" title="메가박스 기프트카드 2만원권 상세보기">
		                                        <div class="soldout">SOLD OUT</div>
												<div class="label new">NEW</div>
		                                             <div class="img"><img src="/resources/store/OLQpuZPJ5wuIR9BqZK4sDRKN0t2O3sWV_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">메가박스 기프트카드 2만원권</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">메가박스 기프트카드 2만원권</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		
				                                            
				                                            
				                                                <p class="sale">
				                                                    <em>20,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
						<li class="">
		                                    <a href="#" title="메가박스 기프트카드 3만원권 상세보기">
		                                        <div class="soldout">SOLD OUT</div>
												<div class="label new">NEW</div>
		                                        <div class="img"><img src="/resources/store/UhUaGPc8CkaIn0wdjvdz6yhunnOzYdaP_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">메가박스 기프트카드 3만원권</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">메가박스 기프트카드 3만원권</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		<p class="sale">
				                                                    <em>30,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                             <p class="ea">
			                                                    
			                                                </p>	                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            <li class="">
		                                    <a href="#" title="메가박스 기프트카드 5만원권 상세보기">
		                                        <div class="soldout">SOLD OUT</div>
 												<div class="label new">NEW</div>
		                                        <div class="img"><img src="/resources/store/SvDPUHovAC2t5VdkHNby25qYMYGNp3tN_280.png" alt="" onerror="#"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">메가박스 기프트카드 5만원권</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">메가박스 기프트카드 5만원권</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		 <p class="sale">
				                                                    <em>50,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                             <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            
                    </ul>
                </div>
                <!--// store-list -->
            </div>
        
            <div id="divCategoryPrdtArea_CPC02" style="display:none">
                <!-- store-list -->
                <div class="store-list mt30">
                    <ul class="list">
                    	 <li class="">
		                    <a href="#" title="일반관람권(2D) 상세보기">
		                  <div class="soldout">SOLD OUT</div>
							<div class="label hot">대표상품</div>
		                     <div class="img"><img src="/resources/store/OzjTPmOIAocfyQnas3x8Vo9JDRRnHeKf_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">일반관람권(2D)</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">일반 관람권</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                    13,000원
		                                                
		                                                </p> <p class="sale">
				                                                    <em>12,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
						<li class="">
		                                    <a href="#" title="더 부티크 전용관람권 상세보기">
		                                        <div class="soldout">SOLD OUT</div>
												 <div class="label"></div>
		                                            
		                                        

		                                        
		                                        <div class="img"><img src="/resources/store/rxCDUuqHT9RostRRQYeu1mr1knFyHxWr_280.png" alt="" onerror="#"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">더 부티크 전용관람권</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">2D 더 부티크 전용 관람권</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                    16,000원
		                                                
		                                                </p>
			                                       		
				                                            
				                                            
				                                                <p class="sale">
				                                                    <em>15,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                             <li class="">
		                                    <a href="#" title="MX 전용관람권 상세보기">
		                                        <div class="soldout">SOLD OUT</div>
												<div class="label"></div>
		                                        <div class="img"><img src="/resources/store/Yk3B0T93JXWbbjrrwVxbmTT9Iij5Tszv_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">MX 전용관람권</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">2D MX 전용 관람권</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                    17,000원
		                                                
		                                                </p>
			                                       		<p class="sale">
				                                                    <em>16,000</em>
				                                                    <span>원</span>
				                                          </p>
				                                            <p class="ea">
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            <li class="">
		                                    <a href="#" title="Dolby Cinema 전용관람권 상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                        <div class="label push">추천</div>
		                                        <div class="img"><img src="/resources/store/XxKX38rQAArz5GGaFCs7KwvYyUz5oQFC_280.png" alt="" onerror="#"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">Dolby Cinema 전용관람권</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">Dolby Cinema 전용 관람권(2D)</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                    18,000원
		                                                
		                                                </p>
			                                       		<p class="sale">
				                                                    <em>17,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                            <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                             <li class="">
		                                    <a href="#" title="더 부티크 스위트 전용관람권 상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                         <div class="label push">추천</div>
		                                         <div class="img"><img src="/resources/store/M8qiScDr6orSchgFPCRCcCtLPVenv6tm_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">더 부티크 스위트 전용관람권</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">더 부티크 스위트 전용 관람권</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		<p class="sale">
				                                                    <em>40,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                          <p class="ea">
			                                              </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            <li class="">
		                                    <a href="#" title="싱글패키지 상세보기">
		                                        <div class="soldout">SOLD OUT</div>
												 <div class="label event">BEST</div>
		                                         <div class="img"><img src="/resources/store/LcfHznA71yOkp20xbVjUBC1AhUCPzDz3_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">싱글패키지</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">2D 일반관람권 1매 + 팝콘(R)1 + 탄산음료(R)1</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                    21,000원
		                                                
		                                                </p>
														<p class="sale">
				                                                    <em>18,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                             <li class="">
		                                    <a href="#" title="러브콤보패키지 상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                         <div class="label event">BEST</div>
		                                          <div class="img"><img src="/resources/store/ZVX4FRDP8NLYto5HL0gAtxr6u4ZCmwOP_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">러브콤보패키지</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">2D 일반관람권 2매 + 러브콤보 [팝콘(L)1 + 탄산음료(R)2]</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                    36,000원
		                                                
		                                                </p>
			                                       		 <p class="sale">
				                                                    <em>30,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                         <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            <li class="">
		                                    <a href="#" title="패밀리패키지 상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                        <div class="label"></div>
		                                         <div class="img"><img src="/resources/store/iw12z1zrsm4xQUDQsSjBcEoPMiFFRkEl_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">패밀리패키지</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">2D 일반관람권 3매 + 팝콘(R)2 + 탄산음료(R)2</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                    52,000원
		                                                
		                                                </p>
			                                       		
				                                            
				                                            
				                                                <p class="sale">
				                                                    <em>43,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                 </ul>
                </div>
                <!--// store-list -->
            </div>
        
            <div id="divCategoryPrdtArea_CPC05" style="display:none">
                <!-- store-list -->
                <div class="store-list mt30">
                    <ul class="list">
                    	 <li class="">
		                                    <a href="javascript:fn_storeDetail(&#39;1728&#39;);" title="러브콤보 상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                           <div class="label hot">대표상품</div>
		                                           <div class="img"><img src="/resources/store/qB1IVqlOLCV7hOOEAJp4J9iG3J5oVWjv_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">러브콤보</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">팝콘(L) 1 + 탄산음료(R) 2</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		
				                                            
				                                            
				                                                <p class="sale">
				                                                    <em>10,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            <li class="">
		                                    <a href="#" title="더블콤보 상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                                <div class="label event">BEST</div>
		                                        <div class="img"><img src="/resources/store/ERDC5wGVMC0YZPIRUsuuaJuAGRyqeDjC_280.png" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">더블콤보</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">팝콘(R) 2 + 탄산음료(R) 2</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		
				                                            
				                                            
				                                                <p class="sale">
				                                                    <em>13,000</em>
				                                                    <span>원</span>
				                                                </p>
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		            </ul>
                </div>
                <!--// store-list -->
            </div>
        
            <div id="divCategoryPrdtArea_CPC07" style="display:none">
                <!-- store-list -->
                <div class="store-list mt30">
                    <ul class="list">
                    	<li class="">
		                                    <a href="#" title="[100P럭키티켓] 타이타닉 25주년 한정판 LP 상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                        <div class="label"></div>
		                                            
		                                        <div class="img"><img src="/resources/store/BkCeTQCJ6ktf4opLZShzHj62ICMZUByZ_280.jpg" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">[100P럭키티켓] 타이타닉 25주년 한정판 LP</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">&lt;타이타닉: 25주년&gt; 유료 관람 시 응모 가능</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		
				                                            
				                                                <p class="sale">
				                                                    <em>100</em>
				                                                    <span>Point</span>
				                                                </p>
				                                            
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            
		                        <li class="">
		                                    <a href="#" title="[100P럭키티켓] 타이타닉 1/400 프라모델 상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                         <div class="label"></div>
		                                        <div class="img"><img src="/resources/store/LmqKhONchufqW2h7S5RBV4CljV1ofqlB_280.jpg" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">[100P럭키티켓] 타이타닉 1/400 프라모델</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">&lt;타이타닉: 25주년&gt; 유료 관람 시 응모 가능</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		
				                                            
				                                                <p class="sale">
				                                                    <em>100</em>
				                                                    <span>Point</span>
				                                                </p>
				                                            <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            <li class="">
		                                    <a href="#" title="[100P럭키티켓] 제임스 카메론 작품 화보집  상세보기">
		                                        <div class="soldout">SOLD OUT</div>

		                                        <div class="label"></div>
		                                            
		                                        <div class="img"><img src="/resources/store/2qpJBv42TUgSCFzm2xlHTVveWeSdZ0e6_280.jpg" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">[100P럭키티켓] 제임스 카메론 작품 화보집 </p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">&lt;타이타닉: 25주년&gt; 유료 관람 시 응모 가능</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		
				                                            
				                                                <p class="sale">
				                                                    <em>100</em>
				                                                    <span>Point</span>
				                                                </p>
				                                            
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            
		                        <li class="">
		                                    <a href="#" title="[100P럭키티켓] 돌비 시네마 2D 관람권 상세보기">
		                                        <div class="soldout">SOLD OUT</div>
 								<div class="label"></div>
		                           <div class="img"><img src="/resources/store/Cvjz4itcvecpO2B19SKu7PO7yfarWwBH_280.jpg" alt="" onerror="noImg(this);"></div>

		                                        <div class="info">
		                                            <div class="tit">
		                                                <!-- 제품명 최대 2줄 -->
				                                        <p class="name">[100P럭키티켓] 돌비 시네마 2D 관람권</p>

		                                                <!-- 제품구성 최대 2줄 -->
		                                                <p class="bundle">&lt;타이타닉: 25주년&gt; 유료 관람 시 응모 가능</p>
		                                            </div>

		                                            <div class="price">
		                                                <p class="original">
		                                                
		                                                </p>
			                                       		
				                                            
				                                                <p class="sale">
				                                                    <em>100</em>
				                                                    <span>Point</span>
				                                                </p>
				                                            
				                                            
			                                       		
									                    
			                                                <p class="ea">
			                                                    
			                                                </p>
		                                                
		                                            </div>
		                                        </div>
		                                    </a>
		                                </li>
		                            
                    </ul>
                </div>
                <!--// store-list -->
            </div>
        
    
        <!--// 카테고리 별 상품 -->
    </div>
    <!--// inner-wrap -->

</div>
<!--// contents -->

</div>


</div>
<!--// container -->


<!-- 		</div> -->
        





<div class="quick-area">
	<a href="/store" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/store#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>