import java.sql.Types;
import java.util.regex.Pattern.BitClass;

import javax.persistence.Version;



class ErrorMail {
	String code
	String subject
	String content
	String status
	String enableSendEmail
    static constraints = {
		status nullable:true
		
    }
	static mapping = {
		content type:"text"
		
	}
}
