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

import kr.happyjob.study.supportD.model.NoticeDModel;
import kr.happyjob.study.supportD.service.NoticeDService;

@Controller
@RequestMapping("info/")
public class EngineerController {
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();

   @RequestMapping("engineerlist.do")
   public String initEngineerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      
      logger.info("+ Start " + className + ".initEngineerList");
      /* ############## set input data################# */
      paramMap.put("loginId", session.getAttribute("loginId")); // 제목
      paramMap.put("userType", session.getAttribute("userType")); // 오피스 구분 //
                                                   // 코드
      paramMap.put("reg_date", session.getAttribute("reg_date")); // 등록 일자
      logger.info("   - paramMap : " + paramMap);

      String returnType = "/info/engineerList";

      logger.info("+ end " + className + ".initEngineerList");

      return returnType;
   }



}