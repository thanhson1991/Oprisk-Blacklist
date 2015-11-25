import msb.platto.fingerprint.*
class RiskResponse {
    String headline
    String description
    String content
    User createdBy
    Date dateCreated
    static hasMany = [responseComments:ResponseComment]
    SortedSet responseComments
    Department department
    static mapping = {
        headline type: 'text'
        description type: 'text'
        content type: 'text'
        responseComments cascade:'all-delete-orphan'
    }

    static constraints = {
    }
}
