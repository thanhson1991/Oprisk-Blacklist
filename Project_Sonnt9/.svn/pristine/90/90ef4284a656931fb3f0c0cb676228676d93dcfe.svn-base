import msb.platto.fingerprint.*
class ErrorsComment implements Comparable {
    User createdBy
    String content
    static belongsTo = [errorsManagements:ErrorManagement]
    Date dateCreated
	String createdUserUpload//when upload

    static constraints = {
		createdBy nullable:true
		createdUserUpload nullable:true
		content nullable:true;
    }
    static mapping = {
        content type: 'text'
        sort id:"desc"
    }
    int compareTo(o) {
        if(!id) return 1
        return o.id.compareTo(this.id)
    }
}
