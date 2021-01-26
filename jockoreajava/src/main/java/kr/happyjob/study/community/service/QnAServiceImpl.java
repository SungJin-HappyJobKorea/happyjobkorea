package kr.happyjob.study.community.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.community.dao.QnADao;
import kr.happyjob.study.community.model.QnAByNoModel;
import kr.happyjob.study.community.model.QnAModel;
import kr.happyjob.study.community.service.QnAService;
import kr.happyjob.study.community.dao.QnADao;
import kr.happyjob.study.community.model.QnAModel;

@Service
public class QnAServiceImpl implements  QnAService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	QnADao QnADao;
	
	/** 1:1문의 목록 조회 */
	public List<QnAModel> listQnA(Map<String, Object> paramMap) throws Exception {
		
		List<QnAModel> istQnA = QnADao.listQnA(paramMap);
		
		return istQnA;
	}
	
	/** 1:1문의 목록 카운트 조회 */
	public int countListQnA(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = QnADao.countListQnA(paramMap);
		
		return totalCount;
	}

	@Override
	public QnAByNoModel selectQnAByInqNo(int inq_no) throws Exception {
		return QnADao.selectQnAByInqNo(inq_no);
	}

	@Override
	public int insertQnAAns(Map<String, Object> paramMap) throws Exception {
		return QnADao.insertQnAAns(paramMap) ;
	}

	@Override
	public int answerONX(Map<String, Object> paramMap) throws Exception {
		return QnADao.answerONX(paramMap);
	}

	@Override
	public int inqAnsDel(Map<String, Object> paramMap) throws Exception {
		return QnADao.inqAnsDel(paramMap);
	}
	
}