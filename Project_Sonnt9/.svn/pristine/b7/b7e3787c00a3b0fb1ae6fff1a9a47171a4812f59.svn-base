


class ErrorManagement {

	
//	String nHCD=''
//	String tenDonVi=''
	
	String tenDonVi1=''
	String tenDonVi2=''
	String tenDonVi3=''
	
	
	
	Date ngayXayRa
	String loiCap1=''
	String loiCap2=''
	String loiCap3=''
	String motaChiTiet
	String maGiaoDich=''
	String giaTriGiaoDich=''
	String soCifKhachHang=''
	String tenKhachHang=''
	String hoSoVaTenHoSo=''
	String bienPhapKhacPhuc=''
	Date thoiHanKhacPhuc
	//Phan lien quan den thong tin outlook nguoi login
	String nguoiNhap=''
	String nguoiSua=''
	String tenDonViNhap1=''
	String tenDonViNhap2=''
	String tenDonViNhap3=''
	
	Date thoiGianSua
	Date thoiGianNhapVaoHeThong
	Integer  trangThai
	String yKienCacDonViKhac=''	
	String soLuongKiemTra
	String tongSoChonMau
	String moTaAnhHuong
	Date thoiGianCapNhapTrangThai	
	String fileName
	String loaiTien
	
	//Department department
	//UnitDepart unitDepart
	ErrorType errorType
	ErrorCheck errorCheck //Hinh thuc kiem tra
	ErrorCategory errorCategory//Loai nghiep vu
	
	
	static hasMany = [errorUserCreate: ErrorUserCreate,errorsComments:ErrorsComment]
	SortedSet errorUserCreate
	SortedSet errorsComments
	
	static constraints = {
		yKienCacDonViKhac (maxSize:10000)
		motaChiTiet(maxSize:10000)
		bienPhapKhacPhuc(maxSize:10000)
		fileName nullable:true
		motaChiTiet nullable:false
		maGiaoDich nullable:true
		giaTriGiaoDich nullable:true
		soCifKhachHang nullable:true
		tenKhachHang nullable:true
		hoSoVaTenHoSo nullable:true
		bienPhapKhacPhuc nullable:true
		nguoiNhap nullable:true
		yKienCacDonViKhac nullable:true
		trangThai nullable:true
		thoiHanKhacPhuc nullable:true
		loaiTien nullable:true
		errorType nullable:true
		soLuongKiemTra nullable:true
		tongSoChonMau nullable:true
		moTaAnhHuong nullable:true
		thoiGianCapNhapTrangThai nullable:true
		thoiGianNhapVaoHeThong nullable:true
		thoiGianSua nullable:true
		errorCategory nullable:true
		errorCheck nullable:true
		nguoiSua nullable:true
//		tenDonVi nullable:true
		
		
	}
	static mapping = {
		errorUserCreate cascade:'all-delete-orphan'
		errorsComments cascade:'all-delete-orphan'
	}
}
