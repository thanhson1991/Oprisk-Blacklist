// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }
// locations to search for config files that get merged into the main config
grails {
	mail {
	  host = "email.msb.com.vn"
	  port = 587
	  username = "qlrr_oprisk@msb.com.vn"
	  password = "msboprisk@123"
	  props = ["mail.smtp.starttls.enable":"true",
			   "mail.smtp.auth":"true",
				   "mail.smtp.port":"587"]
	}
 }
grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

grails.gorm.default.constraints = {
    '*'(nullable: true)
}
// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://www.changeme.com"
    }
    development {
        grails.serverURL = "http://localhost:8080/${appName}"
    }
    test {
        grails.serverURL = "http://localhost:8080/${appName}"
    }

}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'

    warn   'org.mortbay.log'
}

// Added by the Melanin plugin:
//@melanin
//Domain mapping configurations for Spring Security Core
grails.plugins.springsecurity.userLookup.userDomainClassName = 'msb.platto.fingerprint.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'msb.platto.fingerprint.UserRole'
grails.plugins.springsecurity.authority.className = 'msb.platto.fingerprint.Role'
grails.plugins.springsecurity.requestMap.className = 'msb.platto.fingerprint.RequestMap'
grails.plugins.springsecurity.securityConfigType = grails.plugins.springsecurity.SecurityConfigType.Requestmap
grails.plugins.springsecurity.auth.loginFormUrl = '/melanin/login'
grails.plugins.springsecurity.failureHandler.defaultFailureUrl = '/melanin/login/?login_error=1'
grails.plugins.springsecurity.successHandler.defaultTargetUrl = '/start/checkAndAddRole'
grails.plugins.springsecurity.successHandler.alwaysUseDefaultTargetUrl = true

//Spring Security LDAP Plugin Config
grails.plugins.springsecurity.ldap.context.managerDn = 'cn=ADInquiry,OU=MSB Service,DC=msb,DC=com,DC=vn'
grails.plugins.springsecurity.ldap.context.managerPassword = 'ADInquiry'
grails.plugins.springsecurity.ldap.context.server = 'ldap://10.1.16.1:3268'
grails.plugins.springsecurity.ldap.authorities.groupSearchBase = 'cn=ADInquiry,OU=MSB Service,DC=msb,DC=com,DC=vn'
//grails.plugins.springsecurity.ldap.search.base = 'DC=vidgroup,DC=com,DC=vn'
grails.plugins.springsecurity.ldap.search.base = ''


//grails.plugins.springsecurity.ldap.search.filter="sAMAccountName={0}" // for Active Directory you need this
//grails.plugins.springsecurity.ldap.search.filter="(|(mail={0})(&((memberOf=CN=ADInquiry,OU=MSB Service,DC=msb,DC=com,DC=vn)(sAMAccountName={0}))))"
//grails.plugins.springsecurity.ldap.search.filter="(|(mail={0})(sAMAccountName={0}))"
//grails.plugins.springsecurity.ldap.search.filter="(&(mail={0})(ou=MSB Service))"
grails.plugins.springsecurity.ldap.search.filter="(|(mail={0})(mail={0}@msb.com.vn))"


//grails.plugins.springsecurity.ldap.search.filter="(mail={0})"
grails.plugins.springsecurity.ldap.search.searchSubtree = true
grails.plugins.springsecurity.ldap.auth.hideUserNotFoundExceptions = false

// Often all role information will be stored in LDAP,
// but if you want to also assign application-specific roles to users in the database,
// then add this to do an extra database lookup after the LDAP lookup.
grails.plugins.springsecurity.ldap.authorities.retrieveDatabaseRoles = true

// Application settings<br/>

msb.platto.melanin.helpDocument='docs/Huong dan phan mem OpRisk.pdf'
msb.platto.melanin.searchController='' // the search handler for the global search, you should implement this
msb.platto.melanin.searchAction='search' // the search handler for the global search, you should implement this
msb.platto.melanin.appDescription='PHẦN MỀM QUẢN LÝ RỦI RO HOẠT ĐỘNG' // this will appear next to your logo
//msb.platto.melanin.appTimeOut=3600
msb.platto.melanin.appTimeOut=3720
msb.platto.fingerprint.defaultUrlMappings = [ROLE_ADMIN:'/fingerprint',ROLE_DEVELOPER:'/melanin/documentation',ROLE_CVQLRR:'/opRisk/dashboard',ROLE_GDTT:'/opRisk/dashboard',ROLE_GDTT_LEVEL2:'/opRisk/dashboard',ROLE_GDTT_LEVEL3:'/opRisk/dashboard',ROLE_GDTT_LEVEL4:'/opRisk/dashboard'] // default page for each roles
msb.platto.melanin.javascriptFiles = ['application.js','msb.js','ZeroClipboard.js','jquery.tabletools.js','jquery.price_format.js','jquery.validationEngine-vi.js','jquery.countdown.js','jquery.countdown-vi.js']//,'dhtmlxcombo.js','dhtmlxcommon.js'
//--@melanin--

ckeditor {
	config = "/js/myckconfig.js"
        skipAllowedItemsCheck = false
	defaultFileBrowser = "ofm"
	upload {
		basedir = "/uploads/"
	        overwrite = false
	        link {
	            browser = true
	            upload = false
	            allowed = []
	            denied = ['html', 'htm', 'php', 'php2', 'php3', 'php4', 'php5',
	                      'phtml', 'pwml', 'inc', 'asp', 'aspx', 'ascx', 'jsp',
	                      'cfm', 'cfc', 'pl', 'bat', 'exe', 'com', 'dll', 'vbs', 'js', 'reg',
	                      'cgi', 'htaccess', 'asis', 'sh', 'shtml', 'shtm', 'phtm']
	        }
	        image {
	            browser = true
	            upload = true
	            allowed = ['jpg', 'gif', 'jpeg', 'png']
	            denied = []
	        }
	        flash {
	            browser = false
	            upload = false
	            allowed = ['swf']
	            denied = []
	        }
	}
}

/* Gldapo config */

ldap {
  directories {
	msb {
	  url = "ldap://10.1.16.1:3268"
//	  base = "DC=msb,DC=com,DC=vn"
	  base = ""
	  userDn = "cn=ADInquiry,OU=MSB Service,DC=msb,DC=com,DC=vn"
	  password = "ADInquiry"
	  searchControls {
		countLimit = 40
		timeLimit = 600
		searchScope = "subtree"
	  }
	}
  }
  schemas = [
	LdapUser
	
  ]
}

// Added by the Joda-Time plugin:
grails.gorm.default.mapping = {
	"user-type" type: org.joda.time.contrib.hibernate.PersistentDateTime, class: org.joda.time.DateTime
	"user-type" type: org.joda.time.contrib.hibernate.PersistentDuration, class: org.joda.time.Duration
	"user-type" type: org.joda.time.contrib.hibernate.PersistentInstant, class: org.joda.time.Instant
	"user-type" type: org.joda.time.contrib.hibernate.PersistentInterval, class: org.joda.time.Interval
	"user-type" type: org.joda.time.contrib.hibernate.PersistentLocalDate, class: org.joda.time.LocalDate
	"user-type" type: org.joda.time.contrib.hibernate.PersistentLocalTimeAsString, class: org.joda.time.LocalTime
	"user-type" type: org.joda.time.contrib.hibernate.PersistentLocalDateTime, class: org.joda.time.LocalDateTime
	"user-type" type: org.joda.time.contrib.hibernate.PersistentPeriod, class: org.joda.time.Period
}
