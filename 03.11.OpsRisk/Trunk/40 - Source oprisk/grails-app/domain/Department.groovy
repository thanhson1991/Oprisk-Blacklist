class Department {
    String name
    int status=0
    static hasMany = [risks:Risk]
    SortedSet risks
    String code
    static constraints = {
        code nullable:true
    }
}
