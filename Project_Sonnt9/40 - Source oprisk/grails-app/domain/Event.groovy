
class Event implements Comparable{
    String name
    int status = 0
    int ord = 0
    static belongsTo = [parent:Event]
    static hasMany = [children:Event]
    SortedSet children

    static constraints = {
    }

    static mapping = {
        sort 'id'
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
