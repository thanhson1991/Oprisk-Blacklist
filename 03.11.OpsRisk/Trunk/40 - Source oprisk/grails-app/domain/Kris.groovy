

class Kris {
    String maKRI
    String ttKRI
    String maRR
    String loaiKRI
    String motaKRI
    ErrorMasterUserCreate usernhap
    UnitDepart donvi_1
    UnitDepart donvi_2
    UnitDepart donvi_3
 //   String donvi
    String tstd
    String dvdl
    String ctdl
    String nguonsl
    String donviccsl
    String rrhd1
    String rrhd2
    String rrhd3
    String nguong1
    String nguong2
    String nguong3
    String nguonggh
    String emailcb1
    String emailcb2
    String emailcb3
    String emailcbgh
    ErrorMasterUserCreate user_tn
    ErrorMasterUserCreate user_pd
    Date ngay_pd
    Date ngay_cn
    Date ngay_bd_td
    Date ngay_kt_td
    String trang_thai
    String ghi_chu
    Date ngay_nhap
    String active_status
    String fileName
    static mapping = {
        motaKRI type: 'text'
        ghi_chu type: 'text'
    }
    static constraints = {
        maRR nullable:true
        rrhd3 nullable:true
        ghi_chu nullable:true
        donvi_1 nullable: true
        donvi_2 nullable: true
        donvi_3 nullable: true
        fileName nullable:true
    }
}
