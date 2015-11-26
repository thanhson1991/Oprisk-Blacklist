import msb.platto.fingerprint.*
class RiskNews {
    String headline
    String description
    String content
    User createdBy
    Date dateCreated
    static hasMany = [newsComments:NewsComment]
    SortedSet newsComments
    Department department
    static mapping = {
        headline type: 'text'
        description type: 'text'
        content type: 'text'
        newsComments cascade:'all-delete-orphan' 
    }
    
    static constraints = {
    }
}
