<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->
<%
    def RiskService = grailsApplication.classLoader.loadClass('RiskService').newInstance()	
%>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Báo cáo</title>
  </head>
  <body>
     <div id="m-melanin-tab-header">
           <div id="m-melanin-tab-header-inner">
           <div id="m-melanin-tab-actions">
             <button class="btn small primary m-melanin-toggle-side-bar" name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>
           </div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opRisk',action:'quizRreport'),title:'Tổng hợp kiểm tra rủi ro hoạt động',label:'Tổng hợp kiểm tra rủi ro hoạt động']]
					]}"/>
           </div>
			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="quizsidebar"/>
		</div>
    <div id="m-melanin-main-content">
     <g:form name="reportForm" class="form" action="quizReport">
        <g:render template="searchReport"/>
      </g:form>

    <table class="datatablesExport">
	        <thead>
	          <tr>
	            <th class ="center">Đơn vị</th>
	            <th class ="center" >1</th>
	            <th class ="center" >2</th>
	            <th class ="center" >3</th>
	            <th class ="center" >4</th>
	            <th class ="center" >5</th>
	            <th class ="center" >6</th>
                    <th class ="center" >7</th>
                    <th class ="center" >8</th>
                    <th class ="center" >9</th>
                    <th class ="center" >10</th>
                    <th class ="center" >11</th>
	            <th class ="center" >12</th>
	            <th class ="center" >13</th>
	            <th class ="center" >14</th>
	            <th class ="center" >15</th>
	            <th class ="center" >16</th>
                    <th class ="center" >17</th>
                    <th class ="center" >18</th>
                    <th class ="center" >19</th>
                    <th class ="center" >20</th>
                    <th class ="center" >Trung bình</th>
                    <th class ="center" >Trạng thái</th>
                    <th class ="center" >Thời gian còn lại</th>
                    <th class ="center" >Thao tác</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${process}" var="p" status="i">
	        <tr>
	          <td >${p.branchName}</td>
	           <g:each var="g" in="${0..19}">
                  <td class ="center">${RiskService.getAnswerScore(p.surveyInstance.answers.id[g],'quiz')}</td>                 
               </g:each>
                  <%def totalScore = 0%>
                  <g:each var="k" in="${0..(p.surveyInstance.answers.size()-1)}">
                    <g:if test="${p.surveyInstance.answers.answer[k]!=null}">
                      <%totalScore = totalScore + RiskService.getAnswerScore(p.surveyInstance.answers.id[k],'quiz').toInteger();%>
                     </g:if>
                  </g:each>

                  <td class ="center"><g:formatNumber number="${totalScore/p.surveyInstance.answers.size()}" type="number" maxFractionDigits="2" /></td>
                  <td class ="center"><g:message code="status${p.status}"/></td>
                  <td class="center">${p.timeLeft}</td>
                  <td class ="center"><a href="${createLink(controller:'opRisk',action:'createQuiz',params:[id:p.id])}" >Xem</a></td>
                  </g:each>

	        </tr>

	      </tbody>
	    </table>
      <br>
      </div>

    <script type="text/javascript">
    $(document).ready(function(){
       $("#quiz-report").closest('li').addClass('active');
      set_side_bar(true);
      set_active_tab('quiz-management');
        });
        TableToolsInit.sTitle = "Bao cao kiem tra RRHD";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
    
  </body>
</html>
