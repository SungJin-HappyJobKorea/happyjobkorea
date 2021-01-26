package kr.happyjob.study.sample.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.sample.service.SampleComnCodService;

@Controller
@RequestMapping("/sample/")
public class SampleComnCodController {
   
   @Autowired
   SampleComnCodService sampleComnCodService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 공통코드 관리 초기화면
    */
   @RequestMapping("comnCodMgr.do")
   public String comnCodMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".initComnCod");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".initComnCod");

      return "sample/sample_comncod";
   }
     

   /**
    * 그룹코드 목록조회
    */
   @RequestMapping("gouppcodelist.do")
   public String gouppcodelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".gouppcodelist");
      logger.info("   - paramMap : " + paramMap);
      
      int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));   // 현재 페이지 번호
      int pageSize = Integer.parseInt((String)paramMap.get("grouppageSize"));         // 페이지 사이즈
      int pageIndex = (currentPage-1)*pageSize;                                    // 페이지 시작 row 번호
         
      paramMap.put("pageIndex", pageIndex);
      paramMap.put("pageSize", pageSize);
      
      List<ComnGrpCodModel> groupcodelist = sampleComnCodService.gouppcodelist(paramMap);
      
      int groupcodecount = sampleComnCodService.gouppcodecount(paramMap);
      
      model.addAttribute("groupcodelist",groupcodelist);
      model.addAttribute("groupcodecount",groupcodecount);
      model.addAttribute("groupcodecurrentPage",currentPage);
      model.addAttribute("pageSize",pageSize);
      
      logger.info("+ End " + className + ".gouppcodelist");

      return "sample/sample_comnGrpCodList";
   }   
   
   /**
    * 상세코드 목록조회
    */
   @RequestMapping("detailcodelist.do")
   @ResponseBody
   public Map<String,Object> detailcodelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".detailcodelist");
      logger.info("   - paramMap : " + paramMap);
      
      int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));   // 현재 페이지 번호
      int pageSize = Integer.parseInt((String)paramMap.get("detailpagesize"));         // 페이지 사이즈
      int pageIndex = (currentPage-1)*pageSize;                                    // 페이지 시작 row 번호
         
      paramMap.put("pageIndex", pageIndex);
      paramMap.put("pageSize", pageSize);
      
      List<ComnDtlCodModel> detailcodelist = sampleComnCodService.detailcodelist(paramMap);
      
      int totalCntComndetailCod = sampleComnCodService.detailcodecount(paramMap);
      
      Map<String,Object> returnmap = new HashMap<String,Object>();
      returnmap.put("detailcodelist", detailcodelist); 
      returnmap.put("totalCntComndetailCod", totalCntComndetailCod);
      
      logger.info("+ End " + className + ".detailcodelist");

      return returnmap;
   }      
   
}