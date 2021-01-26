package kr.happyjob.study.info.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.info.model.ProjectInfoModel;
import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.login.model.UsrMnuAtrtModel;
import kr.happyjob.study.login.model.UsrMnuChildAtrtModel;


public interface ProjectDao{
	
	public List<ProjectInfoModel> selectProjectList(Map<String, Object>paramMap);
	
}
