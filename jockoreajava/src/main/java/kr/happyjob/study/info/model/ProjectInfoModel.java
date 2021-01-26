package kr.happyjob.study.info.model;

public class ProjectInfoModel{

	private int pro_no; // 프로젝트 번호
	private String login_ID; // 로그인 아이디
	private String pro_area_cd; // 지역 코드
	private String pro_area_detail; // 지역 상세
	private String pro_job_cd; // 직무 코드
	private String pro_job_detail; // 직무 상세
	private String pro_industry_cd; // 산업 코드
	private String pro_industry_detail; // 산업 상세
	private String pro_appstart; // 작성일 (지원시작일)
	private String pro_append; // 지원마감일
	private String user_company; // 회사명
	private String areaname; // 지역 이름
	private String jobname; // 직무 이름
	private String industryname; // 산업 이름
	
	public String getAreaname() {
		return areaname;
	}
	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}
	public String getJobname() {
		return jobname;
	}
	public void setJobname(String jobname) {
		this.jobname = jobname;
	}
	public String getIndustryname() {
		return industryname;
	}
	public void setIndustryname(String industryname) {
		this.industryname = industryname;
	}
	public int getPro_no() {
		return pro_no;
	}
	public void setPro_no(int pro_no) {
		this.pro_no = pro_no;
	}
	public String getLogin_ID() {
		return login_ID;
	}
	public void setLogin_ID(String login_ID) {
		this.login_ID = login_ID;
	}
	public String getPro_area_cd() {
		return pro_area_cd;
	}
	public void setPro_area_cd(String pro_area_cd) {
		this.pro_area_cd = pro_area_cd;
	}
	public String getPro_area_detail() {
		return pro_area_detail;
	}
	public void setPro_area_detail(String pro_area_detail) {
		this.pro_area_detail = pro_area_detail;
	}
	public String getPro_job_cd() {
		return pro_job_cd;
	}
	public void setPro_job_cd(String pro_job_cd) {
		this.pro_job_cd = pro_job_cd;
	}
	public String getPro_job_detail() {
		return pro_job_detail;
	}
	public void setPro_job_detail(String pro_job_detail) {
		this.pro_job_detail = pro_job_detail;
	}
	public String getPro_industry_cd() {
		return pro_industry_cd;
	}
	public void setPro_industry_cd(String pro_industry_cd) {
		this.pro_industry_cd = pro_industry_cd;
	}
	public String getPro_industry_detail() {
		return pro_industry_detail;
	}
	public void setPro_industry_detail(String pro_industry_detail) {
		this.pro_industry_detail = pro_industry_detail;
	}
	public String getPro_appstart() {
		return pro_appstart;
	}
	public void setPro_appstart(String pro_appstart) {
		this.pro_appstart = pro_appstart;
	}
	public String getPro_append() {
		return pro_append;
	}
	public void setPro_append(String pro_append) {
		this.pro_append = pro_append;
	}
	public String getUser_company() {
		return user_company;
	}
	public void setUser_company(String user_company) {
		this.user_company = user_company;
	}
	
}
