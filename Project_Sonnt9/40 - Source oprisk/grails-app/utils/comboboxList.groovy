/**
 * Created by Anhnnt on 5/14/2015.
 */
public enum comboboxList {
    CKP("Chưa khắc phục"),
    DKP("Đã khắc phục"),
    CKPD("Chưa khắc phục được"),
    KKPD("Không khắc phục được"),
    KP1P("Khắc phục được một phần"),
    DTD("Để theo dõi"),

    VND("VND"),
    USD("USD"),

    NB("Nội bộ"),
    BN("Bên ngoài"),
    PTKB("Phân tích kịch bản"),
    KH("Khác"),

    RRHD("Rủi ro hoạt động"),
    RRTD("RR hoạt động liên quan đến RR tín dụng"),
    RRTT("RR hoạt động liên quan đến RR thị trường"),

    DangTD("Đang theo dõi"),
    KhongTD("Không theo dõi"),

    TH("Toàn hàng"),
    CT("Cụ thể"),
	
	//Loai hanh dong rui ro
	HRHD("Hành động từ Hội đồng"),
	HRBC("Hành động từ báo cáo rủi ro"),
	HRKB("Hành động từ kịch bản"),
	HRDN("Hành động tự định nghĩa"),
	HRRR("Hành động cho rủi ro đã có"),
	HRKH("Khác")
	
	
    final String value
    comboboxList(String value) { this.value = value }

    String toString() { value }
    String getKey() { name() }
    static listIncidentStatus(){
        [CKP,DKP,CKPD,KKPD,KP1P,DTD]
    }
    static listMoneyType(){
        [VND,USD]
    }
    static listSourceType(){
        [NB,BN,PTKB,KH]
    }
    static listStatus(){
        [DangTD,KhongTD]
    }

    static listKRIType(){
        [TH,CT]
    }
	
	static listActionType() {
		[HRHD,HRBC,HRKB,HRDN,HRRR,HRKH]
	}
}