<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 사용자 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script>

	// 사용자관리 페이징 설정
	var pageSize = 5;
	var pageBlock = 5;

	/** OnLoad event */ 
	$(function() {
	
		// 사용자 목록 뿌리기
		fUserMgmtList();
		
		// 버튼 이벤트 등록
		fButtonClickEvent();
	});
	

	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
	function fButtonClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault(); // ?? 
					
			var btnId = $(this).attr('id');
			
			switch(btnId){
			case 'btnSaveUserMgmt' : fSaveUserMgmt(); // save 안에 저장,수정
				//alert("저장버튼 클릭!!!이벤트!!");
				break;
			case 'btnDeleteUserMgmt' : fDeleteUserMgmt();	// 만들자 
				//alert("삭제버튼 클릭!!!이벤트!!");		
				break;
			case 'btnClose' : gfCloseModal();  // 모달닫기 
									fUserMgmtList(); // 첫페이지 다시 로딩 
				break;
			case 'btnUpdateUserMgmt' : fUpdateUserMgmt();  // 수정하기
				break;
			case 'btnSearchUser' : fUserMgmtList();  // 검색해서 리스트 뿌리기
				break;
				
			}
		});
	}
	
	/* 사용자 목록 불러오기 + 사용자 검색  */
	function fUserMgmtList(currentPage){
		
		currentPage = currentPage || 1;   // or		
		
		//var sname = $("#sname");
	   // var searchKey = document.getElementById("searchKey");
	    var sname = $("#sname").val();
	    var oname = $("#searchKey").val();
	    
	    console.log("sname : " + sname);
	    console.log("oname : " + oname);
	    
		//var oname = searchKey.options[searchKey.selectedIndex].value;
		
		var param = {
				sname : sname , 
				oname : oname ,
				currentPage : currentPage ,
				pageSize : pageSize , 
		}

		
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
			userMgmtListResult(data, currentPage); 
		}
		
		callAjax("/system/userMgmtList.do","post","text", true, param, resultCallback);
		
	}
	
	
	 /* 사용자 목록 data를 콜백함수를 통해 뿌려봅시당   */
	 function userMgmtListResult(data, currentPage){
		 
		 console.log(data);
		 
		 // 일단 기존 목록을 삭제합니다. (변경시 재부팅 용)
		 $('#listUser').empty();
		 
		 $('#listUser').append(data);
	
		 
		 // 리스트의 총 개수를 추출합니다. 
		 //var totalCnt = $data.find("#totalCnt").text();
		 var totalCnt = $("#totcnt").val();  // qnaRealList() 에서보낸값 
		 
		 // * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
	     var list = $("#tmpList").val();
		 //var listnum = $("#tmpListNum").val();
	     var pagingnavi = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlock, 'fUserMgmtList',[list]);
		 
	     console.log("pagingnavi : " + pagingnavi);
		 // 비운다음에 다시 append 
	     $("#pagingnavi").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
		 
		 // 현재 페이지 설정 
	    $("#currentPage").val(currentPage);
		 
	 }
	


	/* 회원가입 폼 불러오는 화면 */


</script>

</head>






<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="tmpList" value="">
	<input type="hidden" id="tmpListNum" value="">
	<input type="hidden" name="action" id="action" value="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

					<p class="Location">
						<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
							class="btn_nav bold">시스템관리</span> <span class="btn_nav bold">사용자
							관리</span> <a href="../system/userMgmt.do" class="btn_set refresh">새로고침</a>
					</p>
						
					<p class="conTitle">
						<span> 사용자 관리 </span> 
					</p>
						
					<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="20" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                      이 름 &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="width: 250px; height: 25px;" id="sname" name="sname">  &nbsp;&nbsp;&nbsp;&nbsp;                
     	                      <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
     	                            <option value="">전체</option>
									<option value="B">일반회원</option>
									<option value="C" >기업회원</option>
							</select> 
                           </td> 
							<td width="100" height="70" style="font-size: 120%">
	                           <a href="" class="btnType blue" id="btnSearchUser" name="btn"><span>검  색</span></a>
                           </td>
                        </tr>
                     </table> 
					
						<div class="divUserList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="30%">
									<col width="20%">
									<col width="25%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">구분</th>
										<th scope="col">이름</th>
										<th scope="col">아이디</th>
										<th scope="col">가입일자</th>
									</tr>
								</thead>
 								<tbody id="listUser">
 									<tr>
										<td colspan="12">회원명으로 검색해 주세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="pagingnavi"> </div>
						
						
						

       					
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">

		<!-- 회원가입 폼 화면 insert 예정 -->

		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</body>
</html>