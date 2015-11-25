import java.util.Date;


class BlacklistTsbdImport {
	
	UnitDepart donvi_1
	UnitDepart donvi_2
	UnitDepart donvi_3
	BlacklistTaiSan  loaiTsBL // loại tài sản
	String thongtinTsBL // thông tin nhận diện tài sản
	String motaTsBL // mô tả tài sản
	String sohuuTsBL // chủ sỡ hữu
	String cmtcshTsBL // CMT chủ sỡ hữu
	String masothueTsBL // mã số thuế của chủ sỡ hữu
	String canhanTsBL  // Cá nhân tổ chức liên quan
	String cmtlqTsBL // cmt của người liên quan
	String lydoTsBL // lý do liên quan
	String diachiTsBL
	Date ngaycapTsBL // ngày phát hành TSBĐ
	String giatriTsBL
	String lichsuGdTsBL
	BlacklistRiskTSBD riskTsdbTsBL // lý do thuộc danh sách rủi ro
	String lydoCtTsBL 		// lý do chi tiết
	BlacklistObject doituongTsBL // phân loại đối tượng
	Date thoihanTsBL
	String dulieuTsBL // nguồn dữ liệu
	String ghichuTsBL
	Date ngaynhapTsBL
	String usernhapTsBL
	String phongbanTsBl
	String nguoisua
	Date ngaysua
	String status
	
	static constraints = {
		
	}
}
