
<%@ page import="Survey" %>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Conf </title>
    </head>
    <body>
      <g:form name="table_Question" action="setQuestionTable" method="post">
        <g:render template="//flow/menu"/>
        <br/>
        <span class="button"><button name="save" class="save" value="save">Lưu</button></span>
        
        <br/><br/>
        
        <table>
          <thead>
	    <tr>
	      <th>Câu hỏi</th>
	      <th>Trọng số</th>
              <th>Trung bình</th>
              <th>Std deviation</th>
	    </tr>
	  </thead>
	  <tbody>
            <g:each in="${questionTable}" var="w">
              <g:if test="${!w.reference.contains('QT')}">
	      <tr>

                <td>${w.reference}</td>
                <td><g:textField name="weight" class=" validate[required]" value="${w?.weight}" /></td>
	        <td><g:textField name="param1" class=" validate[required]" value="${w?.param1}" /></td>
	        <td><g:textField name="param2" class=" validate[required]" value="${w?.param2}" /></td>

	      </tr>
              </g:if>
	    </g:each>
          </tbody>
        </table>
        <br/>
        
      </g:form>
    </body>
</html>