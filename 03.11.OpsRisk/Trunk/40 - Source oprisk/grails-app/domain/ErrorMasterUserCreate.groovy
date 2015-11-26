

class ErrorMasterUserCreate implements Comparable{

	String userEmail
	String fullName	
	String title	
	int status=0
	String bDSUser=""
	String codeSalary=""
	//Department department
	//UnitDepart unitDepart
	String tenDonVi1
	String tenDonVi2
	String tenDonVi3	
	Date ngayNhap
	Date ngaySua
	String trangThai
	String nguoiNhap
	String nguoiSua
	static belongsTo = RiskAction
	static hasMany = [riskActions:RiskAction]	
	//
	
    static constraints = {
		
		userEmail unique:true
		fullName nullable:true
		bDSUser nullable:true
		codeSalary nullable:true
		ngaySua nullable:true
		nguoiSua nullable:true
		trangThai nullable:true
		ngayNhap nullable:true
		nguoiNhap nullable:true
    }
	
	int compareTo(o) {
		if(!id) return 1
		return this.id.compareTo(o.id)
	}
	
}
