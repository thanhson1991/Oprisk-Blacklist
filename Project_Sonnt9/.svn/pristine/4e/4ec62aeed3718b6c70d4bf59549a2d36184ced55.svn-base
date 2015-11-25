import msb.platto.fingerprint.*
class NewsComment implements Comparable {
    User createdBy
    String content
    static belongsTo = [riskNews:RiskNews]
    Date dateCreated

    static constraints = {
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
