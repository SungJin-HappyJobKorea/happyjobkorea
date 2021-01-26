package kr.happyjob.study.sample.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface SampleComnCodDao {

   /** 그룹코드 목록 조회 */
   //gouppcodelist 가 쿼리문 ID가 됌.
   public List<ComnGrpCodModel> gouppcodelist(Map<String, Object> paramMap);
   
   /** 그룹코드 목록 카운트 조회 */
   public int gouppcodecount(Map<String, Object> paramMap);
   
   /** 상세코드 목록 조회 */
   public List<ComnDtlCodModel> detailcodelist(Map<String, Object> paramMap) throws Exception;
   
   /** 상세코드 목록 카운트 조회 */
   public int detailcodecount(Map<String, Object> paramMap) throws Exception;
      
   
}