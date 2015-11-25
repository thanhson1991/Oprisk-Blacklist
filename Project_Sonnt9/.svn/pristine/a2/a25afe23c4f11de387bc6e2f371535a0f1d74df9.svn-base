

class ErrorUserCreate implements Comparable{

	String userEmail
	String fullName
	String levelError
	String title
		
	int status=0
	String bDSUser=""
	static belongsTo  = [errorManagement:ErrorManagement]		
	String codeSalary=""
	String tenDonVi1
	String tenDonVi2
	String tenDonVi3
	//Do nghipe vu yeu cau phuc tap, join cac object nhieu khi ko ra dc ket qua minh mon muon
	//them nua may deliver, bo xung them don vi bi gay loi vao trong nay de lam report cho no de
	//3 don vi lien quan bao gom 3 don vi loi trong errorManagement 
	
	String errorDonVi1
	String errorDonVi2
	String errorDonVi3
	//String unitDepartError
    static constraints = {
		userEmail nullable:true
		fullName nullable:true
		bDSUser nullable:true
		codeSalary nullable:true
		
		//unitDepartError nullable:true
    }
	
	int compareTo(o) {
		if(!id) return 1
		return this.id.compareTo(o.id)
	}
	
}
