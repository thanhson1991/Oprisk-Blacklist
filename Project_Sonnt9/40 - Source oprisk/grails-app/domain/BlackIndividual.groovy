
class BlackIndividual {
	 
	UnitDepart donvi_1
	UnitDepart donvi_2
	UnitDepart donvi_3
	String tenCnBL
	Date ngaysinhCnBL
	String cmndCnBL
	Date ngaycapCnBL
	String noicapCnBl
	String cmnd2CnBL
	Date ngaycap2CnBL
	String noicap2CnBl
	String diachiCnBL
	String sdtCnBl  
	BlacklistCategory danhsachCnBL // lấy lý do black list
	String lydochitietCnBL
	BlacklistObject doituongCnBL // lấy loại đối tượng
	Date thoihanCnBL // thời gian xác định của 1 user là 10 năm (mặc định 10)	
	String dulieuCnBl // nguồn dữ liệu 
	String tochucCnBL //  tên tổ chức liên quan 
	String masothueCnBL // mã số thuế tổ chức liên quan
	String lydoCnBl // lý do liên quan
	String ghichuCnBL
	Date  ngaynhapCnBL
	String usernhapCnBL
	String phongbanCnBl
	String nguoisua
	Date ngaysua
	int status
//	
	static constraints = {
		
	}
	
}
