package kr.happyjob.study.info.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import kr.happyjob.study.supportD.model.NoticeDModel;
import kr.happyjob.study.supportD.service.NoticeDService;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Controller
@RequestMapping("info/")
public class ProjectController {
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();

   @RequestMapping("projectlist.do")
   public String initProjectList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      
      logger.info("+ Start " + className + ".initProjectList");
      /* ############## set input data################# */
      paramMap.put("loginId", session.getAttribute("loginId")); // 제목
      paramMap.put("userType", session.getAttribute("userType")); // 오피스 구분 //
      paramMap.put("reg_date", session.getAttribute("reg_date")); // 등록 일자
      logger.info("   - paramMap : " + paramMap);

      String returnType = "/info/projectList";

      logger.info("+ end " + className + ".initProjectList");

      return returnType;
   }
   
   @RequestMapping("checklist.do")
   @ResponseBody
   public Map<String, Object> checklist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start LoginController.checklist.do");
      logger.info("   - ParamMap : " + paramMap);
   
      // 사용자 로그인
      List<ComnCodUtilModel> listlistCod = ComnCodUtil.getComnCod("LanguageCD");
      List<ComnCodUtilModel> weblistCod = ComnCodUtil.getComnCod("webCD");
      List<ComnCodUtilModel> dblistCod = ComnCodUtil.getComnCod("DBCD");
      List<ComnCodUtilModel> wslistCod = ComnCodUtil.getComnCod("WSCD");
      
      Map<String, Object> resultMap = new HashMap<String, Object>();
      resultMap.put("listlistCod", listlistCod);
      resultMap.put("weblistCod", weblistCod);
      resultMap.put("dblistCod", dblistCod);
      resultMap.put("wslistCod", wslistCod);
  
      logger.info("+ End LoginController.checklist.do");
      logger.info("확인 weblistCod:"+weblistCod);
     
      return resultMap;
   }   

}