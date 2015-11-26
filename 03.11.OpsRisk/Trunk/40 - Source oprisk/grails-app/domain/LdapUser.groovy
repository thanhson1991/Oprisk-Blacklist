import gldapo.schema.annotation.GldapoNamingAttribute

class LdapUser {
 
@GldapoNamingAttribute
 String cn
 Set memberOf
 String sAMAccountName
 String userPassword
 String displayName
 String lastLogonTimestamp
}