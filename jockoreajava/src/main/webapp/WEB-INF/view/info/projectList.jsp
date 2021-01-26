<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- D3 -->
<style>
//
click-able rows
   .clickable-rows {tbody tr td { cursor:pointer;
   
}

.el-table__expanded-cell {
   cursor: default;
}
}
</style>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
<script type="text/javascript">
        var pageSizeinf  = 10;
        var pageBlockSizeinquiry  = 5;

      /* onload 이벤트  */
      $(function(){
         comcombo("areaCD", "areasel", "all", "5");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
         comcombo("JOBCD", "jobsel", "all", "53");
         comcombo("industryCD", "industrysel", "all", "53");
         comcombo("areaCD", "areasel2", "all", "5");
         comcombo("JOBCD", "jobsel2", "all", "53");
         comcombo("industryCD", "industrysel2", "all", "53");
         comcombo("SWCD", "swsel", "all", "53");
         
         // 프로젝트 목록 뿌리기
         selectProjectList();
         
         // 버튼 이벤트 등록
         fButtonClickEvent();
         
    	 // chosen load 
 		$(".chosen-select").chosen({
 			width: '-webkit-fill-available',
 			rtl: true
        });
    	 
 		//css 설정
		$('textarea').addClass("ui-corner-all ui-widget-content");
		
      });
      
      /** 버튼 이벤트 등록 */
      function fButtonClickEvent() {
    	
    	  $('a[name=btn]').click(function(e){
  			e.preventDefault();   
  					
  			var btnId = $(this).attr('id');
  			
  			switch(btnId){
  			case 'btnSavePro' : fSaveProject(); // save 안에 저장,수정
  				//alert("저장버튼 클릭!!!이벤트!!");
  				break;
  			case 'btnClose' : gfCloseModal();  // 모달닫기 
  				break;
  			case 'btnApply' : gfApplyProject;  // 만들어야함
				break;
  			case 'searchBtn' : board_search();  // 검색하기
  			break;
  			
  			}
      });
   }
              
            
      /** 프로젝트 정보 목록 불러오기 */
      function selectProjectList(currentPage) {
         
         currentPage = currentPage || 1;
         
         console.log("currentPage : " + currentPage);
         
         var param = {
                  currentPage : currentPage
               ,   pageSize : pageSizeinf
         }
         
         var resultCallback = function(data) { // 데이터를 이 함수로 넘긴다
            projectListResult(data, currentPage);
         };
         
         //Ajax실행 방식
         //callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
         //html로 받을거라 text
         callAjax("/info/projectSList.do", "post", "text", true, param, resultCallback);
      }
      
      
      
      /* 프로젝트 정보 리스트 data를 콜백함수를 통해 뿌린다 */
      function projectListResult(data, currentPage) {
               //alert(data);
         console.log(data);      
         
         // 기존 목록 삭제
         $('#listInf').empty();
         $("#listInf").append(data);
         
         // 총 개수 추출
         var totalCntlistInf = $("#totalCntlistInf").val();
            
      
         // 페이지 네비게이션 생성
         var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf, pageSizeinf, pageBlockSizeinquiry, 'fListInf');
         console.log("paginationHtml : " + paginationHtml);
      
         $("#listInfPagination").empty().append( paginationHtml );
      
      }
      
      
    //검색  
 	 function board_search(currentPage) {
 	      
 	      currentPage = currentPage || 1;
 	         
 	         var sname = $('#sname');
 	         var oname = $('#oname');
 	         
 	         var param = {
 	        		 sname : sname.val()
 	        	   , oname : oname.val()
 	               ,   currentPage : currentPage
 	               ,   pageSize : userPageSize
 	         }
 	         
 	         var resultCallback = function(data) {
 	        	 productListResult(data, currentPage); 
 	         };
 	         
 	         callAjax("/info/projectSList.do", "post", "text", true, param, resultCallback);
 	   } 
	
      // 프로젝트 생성 모달창 ㅇ실행
      function fProjectModal(pro_no) {
    	  
    	  // 신규등록 버튼 클릭시 (값이 null)
    	  if(pro_no == null || pro_no==""){
    		  
    		  $("#action").val("I"); // insert 
  			//frealPopModal(pro_no); //  초기화 
  			
  			//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
  			gfModalPopTop("#project");
  			
  		 }else{
  			$("#action").val("U");  // update
  			fdetailModal(pro_no); //번호로 -> 상품 상세 조회 팝업 띄우기
  			
    	  }
      }


</script>

</head>
<body>
<form id="myForm" action=""  method="">
<input type="hidden" id="selectedInfNo" value="">
   <!-- 모달 배경 -->
   <div id="mask"></div>

   <div id="wrap_area">

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
                  
               <div class="content" style="margin-bottom:20px;">
                       
                  <p class="Location">
                     <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#"
                        class="btn_nav">정보목록</a><span
                        class="btn_nav bold">프로젝트목록</span> <a href="../info/projectlist.do"
                        class="btn_set refresh">새로고침</a>
                  </p>
                  <c:choose>
                      <c:when test="${sessionScope.userType eq 'A'}">
                     <jsp:include
                     page="/WEB-INF/view/dashboard/dashboardScm.jsp"></jsp:include>
                   </c:when>
                   
                   <c:when test="${sessionScope.userType eq 'B'}">
                     <jsp:include
                     page="/WEB-INF/view/dashboard/dashboardDlm.jsp"></jsp:include>
                   </c:when>
                   
                   <c:when test="${sessionScope.userType eq 'C'}">
                     <jsp:include
                     page="/WEB-INF/view/dashboard/dashboardEpc.jsp"></jsp:include>
                   </c:when>
                   
                   <c:when test="${sessionScope.userType eq 'D'}">
                     <jsp:include
                     page="/WEB-INF/view/dashboard/dashboardPcm.jsp"></jsp:include>
                   </c:when>                                 
                   
                   <c:otherwise>
                     <jsp:include
                     page="/WEB-INF/view/dashboard/dashboardGed.jsp"></jsp:include>
                   </c:otherwise>
               </c:choose>
               
               
                  <p class="search" style="margin-bottom: 1%;">
                   프로젝트 조회 &nbsp; &nbsp;
                    <select id="areasel" name="areasel">   </select>
                    <select id="jobsel" name="jobsel">   </select>
                    <select id="industrysel" name="industrysel">   </select>
                    &nbsp; &nbsp;
                    <a href="" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a>
                   </p> 
                  <p class="conTitle" style="margin-bottom: 1%;">
                     <span>프로젝트 목록</span> <span class="fr"> 
                     </span>
                  </p>
                  
                  <span style="float:right; margin-bottom: 1%"> 
                   <a class="btnType blue"href="javascript:fProjectModal(${null });" name="modal"><span>공고 생성</span></a>
                   <a class="btnType blue"href="javascript:fProjectModal(${null });" name="modal"><span>신규 등록</span></a>
                  </span>
                  
             <div class="divComGrpCodList">
                     <table class="col">
                        <caption>caption</caption>
                        <colgroup>
                           <col width="5%">
                           <col width="10%">
                           <col width="10%">
                           <col width="15%">
                           <col width="15%">
                           <col width="15%">
                           <col width="15%">
                           <col width="15%">
                        </colgroup>
   
                        <thead>
                           <tr>
                               <th scope="col"></th>
                              <th scope="col">회사명</th>
                              <th scope="col">지역</th>
                              <th scope="col">직무</th>
                              <th scope="col">산업</th>
                              <th scope="col">작성일</th>
                              <th scope="col">모집마감일</th>
                              <th scope="col">작성 회사</th>
                           </tr>
                        </thead>
                        <tbody id="listInf">
                        </tbody>
                     </table>
                  </div>
                                 
                  <div class="paging_area"  id="listInfPagination"> </div>
                  
               </div> <!--// content -->

               </li>
         </ul>
      </div>
   </div>
               
               
                        <!-- 꾸밀수 있는 거 2 -->
               <!--          <div>
                           <template id="searcharea2">
                                <div class="input-group date" style="width:150px;">
                                         <input id="indate" name="indate" type="text" class="form-control" v-model="date" />
                                        <span class="input-group-addon">asdf<i class="fa fa-calendar"></i></span>
                               </div>                            
                          </template>
                       </div>

                  꾸밀수 있는 거 3
                  <div>
                     <template id="searcharea2">
                     <div class="input-group date" style="width: 150px;">
                        <input id="indate" name="indate" type="text"
                           class="form-control" v-model="date" /> <span
                           class="input-group-addon">iiiii<i class="fa fa-calendar"></i></span>
                     </div>
                     </template>
                  </div>

               </div>
         
      </div>
   </div>

    -->
    
    <!-- 프로젝트 정보 모달 -->
		<div id="project" class="layerPop layerType2" style="width: 900px; height: auto;">
		<input type="hidden" id="" name=""> <!-- 수정시 필요한 num 값을 넘김  -->
           <dl>
			<dt>
				<strong>프로젝트 상세 정보</strong>
			</dt>
			<dd class="content">
		
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					
					<tbody>
						<tr>
							<th scope="row">프로젝트명 </th>
							<td colspan="1"><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px; width:250px;" type="text" name="pro_name" id="pro_name" /></td>
							<th scope="row">회사명 </th>
							<td colspan="3"><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px; width:250px;" type="text" name="pro_company" id="pro_company" /></td>
						</tr>
						<tr>
							<th scope="row">지역 </th>
							<td colspan="1">  
							<select name="areasel2" id="areasel2" style="width:webkit-fill-available; height:20px" data-placeholder="지역 전체" class="chosen-select">
								<c:forEach var="tempCdlist" items="${cdListObj}">
						         	<option value="${tempCdlist.detail_code}">${tempCdlist.detail_name}</option>
						        </c:forEach>
							</select>
							</td>
							<th scope="row">직무 </th>
							<td colspan="3">  
							<select name="jobsel2" id="jobsel2" style="width:webkit-fill-available; height:20px" data-placeholder="직무 전체" class="chosen-select">
								<c:forEach var="tempCdlist" items="${cdListObj}">
						         	<option value="${tempCdlist.detail_code}">${tempCdlist.detail_name}</option>
						        </c:forEach>
							</select>
							</td>
						</tr>	
						
						<tr>
							<th scope="row">산업 </th>
							<td colspan="1">  
							<select name="industrysel2" id="industrysel2" style="width:webkit-fill-available; height:20px" data-placeholder="산업 전체" class="chosen-select">
								<c:forEach var="tempCdlist" items="${cdListObj}">
						         	<option value="${tempCdlist.detail_code}">${tempCdlist.detail_name}</option>
						        </c:forEach>
							</select>
							</td>
							<th scope="row">구분 </th>
							<td colspan="3">  
							<select name="swsel" id="swsel" style="width:webkit-fill-available; height:20px" data-placeholder="구분 전체" class="chosen-select">
								<c:forEach var="tempCdlist" items="${cdListObj}">
						         	<option value="${tempCdlist.detail_code}">${tempCdlist.detail_name}</option>
						        </c:forEach>
							</select>
							</td>
						</tr>	
					   <tr>
							<th scope="row">기술등급 </th>
							<td colspan="3">
								<strong>초급</strong> <input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px; width:40px;" type="text"  name="grd_begin" id="grd_begin" /> 명 &nbsp;&nbsp;&nbsp; 
								<strong>중급</strong> <input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px; width:40px;" type="text"  name="grd_mid" id="grd_mid" /> 명 &nbsp;&nbsp;&nbsp; 
								<strong>고급</strong> <input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px; width:40px;" type="text"  name="grd_high" id="grd_high" /> 명 &nbsp;&nbsp;&nbsp; 
								<strong>특급</strong> <input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px; width:40px;" type="text"  name="grd_extra" id="grd_extra" /> 명 &nbsp;&nbsp;&nbsp; 
							</td>
						</tr>
					   <tr>
							<th scope="row">전문 기술</th>
							<td colspan="3" >
							Language<input type="checkbox"  name="pro_name" id="pro_name" />
							Language<input type="checkbox"  name="pro_name" id="pro_name" />
							Language<input type="checkbox"  name="pro_name" id="pro_name" />
							Language<input type="checkbox"  name="pro_name" id="pro_name" />
							</td>
						</tr>
						
						<tr>
							<th scope="row"> 근무 기간 </th>
							<td>  
							<input type="date" class="ui-widget ui-widget-content ui-corner-all" name="pro_wkstart"
									id="pro_wkstart"  />
							<input type="date" class="ui-widget ui-widget-content ui-corner-all" name="pro_wkend"
									id="pro_wkend"  />		
							</td>
							<th scope="row">접수 기간 </th>
							<td>
							<input type="date" class="ui-widget ui-widget-content ui-corner-all" name="pro_appstart"
									id="pro_appstart" />
									<input type="date" class="ui-widget ui-widget-content ui-corner-all" name="pro_append"
									id="pro_append" />
							</td>					
						</tr>
						
						<tr>
							<th scope="row">상세 설명 </th>
							<td colspan="3">
							<textarea class = "ui-widget ui-widget-content ui-corner-all" id="pro_detail" maxlength="500" name="pro_detail" style="height:130px;outline:none;resize:none;" placeholder="여기에 상세설명을 적어주세요.(500자 이내)"></textarea>
							</td>
						</tr>		
						<tr>
							<th scope="row">필수/우대사항 </th>
							<td colspan="3">
							<textarea class = "ui-widget ui-widget-content ui-corner-all" id="pro_essential" maxlength="500" name="pro_essential" style="height:130px;outline:none;resize:none;" placeholder="여기에 필수/우대사항을 적어주세요.(500자 이내)"></textarea>
							</td>
						</tr>		
						<tr>
							<th scope="row">특이사항 </th>
							<td colspan="3">
							<textarea class = "ui-widget ui-widget-content ui-corner-all" id="pro_specific" maxlength="500" name="pro_specific" style="height:130px;outline:none;resize:none;" placeholder="여기에 특이사항을 적어주세요.(500자 이내)"></textarea>
							</td>
						</tr>		
						<tr>
							<th scope="row">근무장소 </th>
							<td colspan="3"><input class = "ui-widget ui-widget-content ui-corner-all" style="height:20px; width:200px;" type="text" maxlength="500" name="pro_name" id="pro_name" /> 구/읍/면</td>
						</tr>		
						<tr>
							<th scope="row">장비지원 </th>
							<td>  
							 지원 <input type="radio" name="hwApply" value="y" checked="checked"/> 
							 미지원 <input type="radio" name="hwApply" value="n" /> 
							 추후협의 <input type="radio" name="hwApply" value="late" /> 					 
							</td>
							<th scope="row">식사제공 </th>
							<td>  
							 지원 <input type="radio" name="mealApply" value="y" checked="checked"/> 
							 미지원 <input type="radio" name="mealApply" value="n" /> 
							 추후협의 <input type="radio" name="mealApply" value="late" /> 					 
							</td>
						</tr>		
						<tr>
							<th scope="row">숙박제공 </th>
							<td>  
							 지원 <input type="radio" name="stayApply" value="y" checked="checked"/> 
							 미지원 <input type="radio" name="stayApply" value="n" /> 
							 추후협의 <input type="radio" name="stayApply" value="late" /> 					 
							</td>
							<th scope="row">면접형태 </th>
							<td>  
							<input type="checkbox" name="interview" value="tel" > 전화연결
							<input type="checkbox" name="interview" value="nottel" > 직접연결
							</td>
						</tr>				
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSavePro" name="btn"><span>저장</span></a>			
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					<a href=""	class="btnType blue"  id="btnApply" name="btn" style="float:right;"><span>지원하기</span></a>
				</div>
		    </dd>
          </dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
     </div>
</form>
</body>
</html>