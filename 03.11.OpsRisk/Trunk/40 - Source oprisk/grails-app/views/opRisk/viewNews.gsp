<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Danh sách báo cáo</title>
    <style type="text/css" media="screen">
      .even{
        background:none !important;
      }
      .odd{
        background:none !important;
      }
      li{
        color:black !important;
      }

      table,td{
        border:none !important;
        border-bottom: 1px solid #CCCCCC !important;
      }

    </style>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'opRisk',action:'viewNews'),title:'Bản tin rủi ro',label:'Bản tin rủi ro']]
					]}"/>

			<div class="clear"></div>
		</div>

      

          <div id="m-melanin-main-content">
             <g:form name="newsForm" class="form" action="viewNews">
         <g:render template="searchReport"/>
      </g:form>
            <div class="float-left" style="width:300px;margin-right:10px">
            <table class="commentTable">
              <thead class="hidden">
                <td></td>
              </thead>
              <tbody>
              <g:each in="${allNews}" var="i">
                <tr>
                  <td><a style="color:black" href="${createLink(controller:'opRisk',action:'viewNews',params:[newsId:i.id,fromDate:fromDate,toDate:toDate,departmentId:departmentId])}">
                    <b>${i.headline}</b> - <g:formatDate format="dd/MM/yyyy" date="${i.dateCreated}"/><br><br>
                    ${i.description}</a>
                  </td>

                </tr>
              </g:each>
              </tbody>

            </table>
            </div>
            <g:if test="${currentNews}">
              <fieldset>
                <ol class="form-clear">
                  <li><h3>${currentNews.headline}</h3></li><br>
                  <li><b>${currentNews.description}</b></li><br>
                  <li>${currentNews.content}</li><br>
                  <g:if test="${currentNews.newsComments.size()>0}">
                  <li><b>Các ý kiến đã gửi:</b></li>
                  <li>
                     <table class="commentTable">
                        <thead class="hidden">
                          <td></td>
                        </thead>
                        <tbody>
                        <g:each in="${currentNews.newsComments}" var="i">
                          <tr>
                            <td>
                              ${i.content}<br/>
                              <span class="red">Người viết: ${i.createdBy.username}</span>
                              <span>${formatDate(date:i.dateCreated)}</span>
                            </td>

                          </tr>
                        </g:each>
                        </tbody>

                      </table>

                  </li>
                  </g:if>
                  <g:form method="post" id="saveForm" name="saveForm" controller="opRisk" action="addNewsComment">
                  <g:hiddenField name="newsId" value="${currentNews?.id}"/>
                  <g:hiddenField name="addFromDate" value="${fromDate}"/>
                  <g:hiddenField name="addToDate" value="${toDate}"/>
                  <g:hiddenField name="addDepartmentId" value="${departmentId}"/>
                  <li>
                    <label for="content">Ý kiến của anh chị</label>
                  </li>                  
                  <li><g:textArea style="width:515px" name="content"  rows="3" cols="100" class="validate[required]" id="content"/></li><br>
                  <li >
                    <button class="btn primary" type="submit" id="saveComment" name="saveComment" value="saveNews">Gửi ý kiến</button>

                  </li>
                  </g:form>

                </ol>              

              </fieldset>
            </g:if>
            <div class="clear"></div>
      </div>


    <script type="text/javascript">
      $(document).ready(function(){
        set_active_tab('view-news');
        $("#saveForm").validationEngine();

      });


    </script>

  </body>
</html>
