<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->
<link rel="stylesheet" href="/resources/mypage/style.css">


<!-- 주소API연결 -->
<script type="text/javascript">
// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. 
// (＂팝업 API 호출 소스"도 동일하게 적용시켜야 합니다.)
//document.domain = "abc.go.kr";
function goPopup(){
//경로는 시스템에 맞게 수정하여 사용
//호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를
//호출하게 됩니다.
var pop = window.open("jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
//** 2017년 5월 모바일용 팝업 API 기능 추가제공 **/
// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서
// 실제 주소검색 URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
// var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr){
 // 2017년 2월 제공항목이 추가되었습니다. 원하시는 항목을 추가하여 사용하시면 됩니다.
 document.form.roadFullAddr.value = roadFullAddr;

}
</script>

		<!-- 회원가입 빈칸 검증 -->
		<script type="text/javascript">
    
    function sendIt() {
		
    	var f = document.form;
		//비밀번호
		if(!f.pwd.value) {
		
			alert("비밀번호입력!");
			f.pwd.focous();
			return;
		}
		
		//비밀번호 길이
		if(f.pwd.value.length<6 || f.pwd.value.length>12) {
		
			alert("비밀번호는 6~12자 사이로 입력가능합니다.!");
			f.pwd.focous();
			return;
		}
		
		// 비밀번호 검증(비교하기)
		if(f.pwd.value != f.pwd2.value) {
			alert("비밀번호가 일치하지않습니다. 다시 확인해주세요.");
			f.pwd.focous();
			return;
		}
    	
		//이메일 입력
		if(!f.email1.value) {
			
			alert("이메일을 입력하세요!");
			document.form.email.focous();
			return;
		}
		//이메일 입력
		if(!f.email2.value) {
			
			alert("이메일을 입력하세요!");
			document.form.email.focous();
			return;
		}
		
		//생년월일
		if(!f.birth_year.value) {
			
			alert("생일 입력!");
			document.form.birth_year.focous();
			return;
		}
		
		//생년월일
		if(!f.birth_month.value) {
			
			alert("생일 입력!");
			document.form.birth_month.focous();
			return;
		}
		
		//생년월일
		if(!f.birth_day.value) {
			
			alert("생일 입력!");
			document.form.birth_day.focous();
			return;
		}
		
		alert("회원정보 수정 성공!!!!!");
		
		f.action="<%=cp%>/movie/mypage_ok";
		f.submit();
		
	}
    
</script>

		<!-- 여기부터 마이페이지 UI -->
		<div class="container has-lnb">
			
			<div class="page-util">
				<div class="inner-wrap">
					<div class="location">
						<span>Home</span>
						<a href="/movie/movie" title="영화 페이지로 이동">나의 메가박스</a>
						<a href="/movie/movie" title="전체영화 페이지로 이동">회원정보</a>					
						<a class="no-link">개인정보 수정</a>
					</div>
				</div>
			</div>
			<!--왼쪽메뉴-->
			<div class="inner-wrap">
				<div class="lnb-area">
					<nav id="lnb">
						<p class="tit"><a href="mypage" title="나의 메가박스">나의 메가박스</a></p>
						<ul>
							<li>
								<a href="/movie/mypage" title="회원정보">회원정보</a>
								<ul class="depth3">
									<li><a href="/movie/mypage" title="개인정보 수정">개인정보 수정</a></li>
								</ul>
							</li>
						</ul>
					</nav>
				</div>
			
			<!--//왼쪽메뉴-->
			
			<!-- contents -->
			<div id="contents" class="">			
				<h2 class="tit">개인정보 수정</h2>
				<ul class="dot-list mb10">
              		<li>회원님의 정보를 정확히 입력해주세요.</li>
          		</ul>
					
						<form action="" method="post" name="form">
							<div class="table_join">
								<table>
									<colgroup>
										<col width="170px">
										<col width="auto">
									</colgroup>
									<tbody>
										<tr>
											<th>아이디</th>
											<td>${dto.id } <!-- <input type="text" name="id" id="id" class="type01"> -->
											</td>
										</tr>
										<tr>
											<th>이름</th>
											<td>${dto.name }</td>
										</tr>
										<tr>
											<th>패스워드</th>
											<td><input type="password" name="pwd" id="pwd"
												value="${dto.pwd }" class="type01"></td>
										</tr>
										<tr>
											<th>패스워드 재확인</th>
											<td><input type="password" name="pwd2" id="pwd2" value=""
												class="type01"></td>
										</tr>
										<tr>
											<th>이메일</th>
											<td class="txt_color"><input type="text" name="email1"
												value="${dto.email1 }" class="type01"> @ <input
												type="text" name="email2" id="email2" value="${dto.email2 }"
												class="type01"> <select name="email_domain"
												id="email_domain" class="type02"
												onchange="javascript: document.getElementById(&#39;email2&#39;).value=this.value;">
													<option value="" selected="selected">선택</option>
													<option value="naver.com">naver.com</option>
													<option value="daum.net">daum.net</option>
													<option value="nate.com">nate.com</option>
													<option value="gmail.com">gmail.com</option>
													<option value="" selected="selected">직접입력</option>
											</select></td>
										</tr>
										<tr>
											<th>주소</th>
											<td></br> <input type="text" id="roadFullAddr"
												name="roadFullAddr" value="${dto.roadFullAddr }" size="60" />
												<button type="button" class="button2" onClick="goPopup();">주소검색</button>
												</br> </br></td>
										</tr>
										<tr>
											<th>생년월일</th>
											<td class="txt_color"><select name="birth_year"
												id="birth_year" class="type01">
													<option value="1922">1922</option>
													<option value="1923">1923</option>
													<option value="1924">1924</option>
													<option value="1925">1925</option>
													<option value="1926">1926</option>
													<option value="1927">1927</option>
													<option value="1928">1928</option>
													<option value="1929">1929</option>
													<option value="1930">1930</option>
													<option value="1931">1931</option>
													<option value="1932">1932</option>
													<option value="1933">1933</option>
													<option value="1934">1934</option>
													<option value="1935">1935</option>
													<option value="1936">1936</option>
													<option value="1937">1937</option>
													<option value="1938">1938</option>
													<option value="1939">1939</option>
													<option value="1940">1940</option>
													<option value="1941">1941</option>
													<option value="1942">1942</option>
													<option value="1943">1943</option>
													<option value="1944">1944</option>
													<option value="1945">1945</option>
													<option value="1946">1946</option>
													<option value="1947">1947</option>
													<option value="1948">1948</option>
													<option value="1949">1949</option>
													<option value="1950">1950</option>
													<option value="1951">1951</option>
													<option value="1952">1952</option>
													<option value="1953">1953</option>
													<option value="1954">1954</option>
													<option value="1955">1955</option>
													<option value="1956">1956</option>
													<option value="1957">1957</option>
													<option value="1958">1958</option>
													<option value="1959">1959</option>
													<option value="1960">1960</option>
													<option value="1961">1961</option>
													<option value="1962">1962</option>
													<option value="1963">1963</option>
													<option value="1964">1964</option>
													<option value="1965">1965</option>
													<option value="1966">1966</option>
													<option value="1967">1967</option>
													<option value="1968">1968</option>
													<option value="1969">1969</option>
													<option value="1970">1970</option>
													<option value="1971">1971</option>
													<option value="1972">1972</option>
													<option value="1973">1973</option>
													<option value="1974">1974</option>
													<option value="1975">1975</option>
													<option value="1976">1976</option>
													<option value="1977">1977</option>
													<option value="1978">1978</option>
													<option value="1979">1979</option>
													<option value="1980">1980</option>
													<option value="1981">1981</option>
													<option value="1982">1982</option>
													<option value="1983">1983</option>
													<option value="1984">1984</option>
													<option value="1985">1985</option>
													<option value="1986">1986</option>
													<option value="1987">1987</option>
													<option value="1988">1988</option>
													<option value="1989">1989</option>
													<option value="1990">1990</option>
													<option value="1991">1991</option>
													<option value="1992">1992</option>
													<option value="1993">1993</option>
													<option value="1994">1994</option>
													<option value="1995">1995</option>
													<option value="1996">1996</option>
													<option value="1997" selected="">1997</option>
													<option value="1998">1998</option>
													<option value="1999">1999</option>
													<option value="2000">2000</option>
													<option value="2001">2001</option>
													<option value="2002">2002</option>
													<option value="2003">2003</option>
													<option value="2004">2004</option>
													<option value="2005">2005</option>
													<option value="2006">2006</option>
													<option value="2007">2007</option>
													<option value="2008">2008</option>
													<option value="2009">2009</option>
													<option value="2010">2010</option>
													<option value="2011">2011</option>
													<option value="2012">2012</option>
													<option value="2013">2013</option>
													<option value="2014">2014</option>
													<option value="2015">2015</option>
													<option value="2016">2016</option>
													<option value="2017">2017</option>
													<option value="2018">2018</option>
													<option value="2019">2019</option>
													<option value="2020">2020</option>
													<option value="2021">2021</option>
													<option value="2022">2022</option>
											</select> 년 <select name="birth_month" id="birth_month" class="type01">
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
											</select> 월 <select name="birth_day" id="birth_day" class="type01">
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
													<option value="13">13</option>
													<option value="14">14</option>
													<option value="15">15</option>
													<option value="16">16</option>
													<option value="17">17</option>
													<option value="18">18</option>
													<option value="19">19</option>
													<option value="20">20</option>
													<option value="21">21</option>
													<option value="22">22</option>
													<option value="23">23</option>
													<option value="24">24</option>
													<option value="25">25</option>
													<option value="26">26</option>
													<option value="27" selected="">27</option>
													<option value="28">28</option>
													<option value="29">29</option>
													<option value="30">30</option>
													<option value="31">31</option>
											</select> 일</td>
										</tr>
									</tbody>
								</table>
							</div>
							</br>
							<div class="btn-group mt40">							
								<button type="button" onclick="sendIt();" id="" class="button purple large" >수정 완료</button>
								<button type="button" onclick="javascript:history.back();" class="button large">취소</button>
							</div>
						</form>
				
					</div>
				</div>
		</div>


		<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!-- //footer -->

		<!-- 모바일 때만 출력 -->
		<div class="go-mobile" style="display: none;">
			<a href="booking#"
				data-url="https://m.megabox.co.kr">모바일웹으로 보기 <i
				class="iconset ico-go-mobile"></i></a>
		</div>
	</div>
	<form id="mainForm"></form>
	<script type="text/javascript">
		(function(w, d, a){
		    w.__beusablerumclient__ = {
		        load : function(src){
		            var b = d.createElement("script");
		            b.src = src; b.async=true; b.type = "text/javascript";
		            d.getElementsByTagName("head")[0].appendChild(b);
		        }
		    };w.__beusablerumclient__.load(a);
		})(window, document, "//rum.beusable.net/script/b200617e104748u388/bc4af2fa1e");
	</script>
			
		</div>
	</div>
</body>
</html>