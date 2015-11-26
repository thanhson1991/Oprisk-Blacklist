
class RiskService {

    static transactional = true

    def importRisk(Department department) {
        RiskImporter importer = new RiskImporter('/tmp/risk-import.xls')
        def risks = importer.getRisk()
        //def vt = TreeNode.findByName('Vertical Tree')
        def lv1, lv2, lv3
        String txtLv1,txtLv2,txtLv3
        def newlv1, newlv2
        risks.each{riskData->
                if (riskData['lv1']){
                        txtLv1 = riskData['lv1'].trim()
                }
                
                if (riskData['lv2']){
                        txtLv2 = riskData['lv2'].trim()
                }
                newlv1 = Risk.findByNameAndDepartment(txtLv1,department)
                if (!newlv1){                        
                        newlv1 = new Risk(name:txtLv1)
                        newlv1.save(flush:true)
                        department.addToRisks(newlv1)                        
                        lv1 = newlv1                        
                }
                
                newlv2 = Risk.executeQuery('from Risk r where r.name=? and r.ord=1 and r.department=?',txtLv2,department)
                
                if (!newlv2){
                        newlv2 = new Risk(name:txtLv2,parent:lv1)
                        newlv2.save(flush:true)
                        department.addToRisks(newlv2)                        
                        lv2 = newlv2
                        
                }
                if (riskData['lv3']){
                    
                        lv3 = new Risk(name:riskData['lv3'].trim(),parent:lv2)
                        lv3.save(flush:true)
                        department.addToRisks(lv3)
                }
                department.save(flush:true)
        }

    }
    def importCause() {
        Importer importer = new Importer('/tmp/cause-import.xls')
        def causes = importer.getData()
        //def vt = TreeNode.findByName('Vertical Tree')
        def lv1, lv2
        String txtLv1,txtLv2
        def newlv1, newlv2
        causes.each{causeData->
                if (causeData['lv1']){
                        txtLv1 = causeData['lv1'].trim()
                }

                if (causeData['lv2']){
                        txtLv2 = causeData['lv2'].trim()
                }
                newlv1 = Cause.findByName(txtLv1)
                if (!newlv1){                        
                        newlv1 = new Cause(name:txtLv1)
                        newlv1.save(flush:true)                        
                        lv1 = newlv1
                }

                newlv2 = Cause.executeQuery('from Cause c where c.name=? and c.ord=1',txtLv2)

                if (!newlv2){
                        newlv2 = new Cause(name:txtLv2,parent:lv1)
                        newlv2.save(flush:true)                        
                        lv2 = newlv2

                }
              
        }

        //import event
        importer = new Importer('/tmp/event-import.xls')
        def events = importer.getData()
        events.each{eventData->
                if (eventData['lv1']){
                        txtLv1 = eventData['lv1'].trim()
                }

                if (eventData['lv2']){
                        txtLv2 = eventData['lv2'].trim()
                }
                newlv1 = Event.findByName(txtLv1)
                if (!newlv1){
                        newlv1 = new Event(name:txtLv1)
                        newlv1.save(flush:true)
                        lv1 = newlv1
                }

                newlv2 = Event.executeQuery('from Event e where e.name=? and e.ord=1',txtLv2)

                if (!newlv2){
                        newlv2 = new Event(name:txtLv2,parent:lv1)
                        newlv2.save(flush:true)
                        lv2 = newlv2

                }

        }


    }

    def calculateScore (RiskInstance riskInstance){
        def impactScore = riskInstance.impact.score
        def controlEffectScore = riskInstance.controlEffect.score
        def possibilityScore = riskInstance.possibility.score
        def mixScore = impactScore * possibilityScore

        def mixScoreCalculation = '''
        def y = 0
        if(mixScore > 10) y = 0
        else if(mixScore >= 8) y = 1
        else if(mixScore >= 5) y = 2
        else if(mixScore >= 3) y = 3
        else y = 4
        return y
        '''


        GroovyShell shell = new GroovyShell(new Binding([mixScore:mixScore]))
        def y = shell.evaluate(mixScoreCalculation)



        def matrixScore = '''
            return [
                ['C','B','B','A','A'],
                ['C','C','B','B','A'],
                ['C','C','C','B','B'],
                ['D','C','C','C','B'],
                ['D','D','C','C','C']
                ]
        '''

        def matrix = new GroovyShell().evaluate(matrixScore)        
        return matrix[y][controlEffectScore-1]

    }

    def getRisklv3(Risk risk,int processId){
        def process=SelfEvaluationProcess.get(processId)
        def risks = Risk.executeQuery(' from Risk r where (r.process is null or r.process=?) and r.enabled=true and r.status >= 0 and r.ord=2 and r.parent.parent =? ',process,risk)

        return risks
    }
	
	def getAnswerScore(def answerId,def type = 'opRisk'){		
		def answerWeight,score,answer
		score = 0
		if (answerId){	
			
			if (type =='quiz')
				answer = QuizAnswer.get(answerId)
			else			
				answer = Answer.get(answerId)		
				
			if (!answer.answer){
				return 0	
			}
			try{
				if(answer.question.answerWeight != null && answer.question.answerWeight != '' ){				
					answerWeight = answer.question.answerWeight.split(",")		
					score = answerWeight[answer.answer.toInteger()-1]				
				}else{
					score = answer.answer
				}
			}catch(Exception e){
				return 0
			}
		}		
		return score	
		
	}
	
	def convertEmail(def email) {
		def sendEmail
		if (email == '') {
			return 'default'
		} else {
			if (email.contains('@'))
				sendEmail = email
			else sendEmail = email+'@msb.com.vn'
			return sendEmail
		}
	}



}
