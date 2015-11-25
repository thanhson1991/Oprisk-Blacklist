class DateUtil{

	static def convertToDate7(def date){
		return date.getAt(Calendar.YEAR) * 1000 + date.getAt(Calendar.DAY_OF_YEAR)
	}

	static def convertFromDate7(def date){
		date = date.toInteger()
		def d = new GregorianCalendar()
		d.set(Calendar.YEAR,Math.round(date/1000i).toInteger() )
		d.set(Calendar.DAY_OF_YEAR,date%1000i )
		def d1 =  d.getTime()
		d1.clearTime()
		return d1
	}

	static def compareDate7(def d1, def d2){
		convertFromDate7(d1) - convertFromDate7(d2)
	}

	static def convertInputToDate7(def date){
		return convertToDate7(parseInputDate(date))
	}
	static def parseInputDate(def date){
		return Date.parse("dd/MM/yyyy hh:mm:ss",date)
	}

        static def formatDate (def date){
                return date.getAt(Calendar.DAY_OF_MONTH) + '/' + (date.month+1) + '/' + date.getAt(Calendar.YEAR)
        }

        static def formatDetailDate (def date){
                return String.format("%02d", date.getAt(Calendar.DAY_OF_MONTH)) + '/' + String.format("%02d", date.month+1) + '/' + date.getAt(Calendar.YEAR) + ' ' + String.format("%02d", date.getAt(Calendar.HOUR_OF_DAY)) + ':' + String.format("%02d", date.getAt(Calendar.MINUTE)) + ':' + String.format("%02d", date.getAt(Calendar.SECOND))
        }
        static def getTimeDifference(Date fromDate, Date toDate){
                Long timeDiff = toDate.time - fromDate.time
                return timeDiff
        }
}