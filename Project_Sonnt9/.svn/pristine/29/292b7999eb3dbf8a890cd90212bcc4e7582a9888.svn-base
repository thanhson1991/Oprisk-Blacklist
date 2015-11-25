class Risk implements Comparable{
    String name
    String control
    Date dateCreated
    int status = 0
    int ord = 0
    static belongsTo = [parent:Risk,department:Department]
    static hasMany = [children:Risk]
    SortedSet children
    boolean enabled = true
    SelfEvaluationProcess process
    static constraints = {
        process nullable:true
        control nullable:true
    }

    static mapping = {
        sort 'id'
        control type: 'text'
    }

    int compareTo(o) {
        if(!id) return 1
        return this.id.compareTo(o.id)
    }

    def beforeInsert() {
        updateOrd()
    }

    def beforeUpdate() {
        updateOrd()
    }

    protected void updateOrd() {
            if (this.parent){
                    this.ord = parent.ord + 1
            } else {
                    ord = 0
            }
    }
}
