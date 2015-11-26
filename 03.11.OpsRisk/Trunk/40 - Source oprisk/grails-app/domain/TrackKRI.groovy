

class TrackKRI {
    Kris kriObj
    Date kridateVal
    String kriVal
    Date inputDate
    String inputUser
    String userNote
    String active_status
    static mapping = {
        userNote type: 'text'
    }
    static constraints = {
        kridateVal nullable:true
        kriVal nullable:true
        inputDate nullable:true
        inputUser nullable:true
        userNote nullable:true
    }
}
