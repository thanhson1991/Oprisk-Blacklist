<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Quản lý người dùng</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'admin',action:'userManagement'),title:'Quản lý người dùng',label:'Quản lý người dùng']]
					]}"/>
			<div class="clear"></div>
		</div>
		
    <div id="m-melanin-left-sidebar">                 
      <ul class="m-melanin-vertical-navigation">
              
              <g:render template="sidebar"/>

      </ul>
	</div>
    <div id="m-melanin-main-content">
       <g:form name="userForm" class="form" action="userManagement">
             <ol class="form form-clear">
         <li>
             <label for="departments" style="float:none" class="label-left">Loại nghiệp vụ:</label>
          </li>
          <li>
            <label class="label-left"><g:select class="se-xl" name="department" id="department" from="${departments}" optionKey="id" optionValue="name" value="${departmentId}" noSelection="${['':'Tất cả']}"/></label>
            <label style="margin-left:50px"><g:submitButton class="btn primary" name="search" value="Xem" /></label>
          </li>

   </ol>
      </g:form>

    <table class="datatablesExport">    
	        <thead>
	          <tr>
                    <th class ="center">STT</th>
                    <th class ="center">Họ và tên</th>
	            <th class ="center">Đơn vị</th>
                    <th class ="center">Username</th>
	            <th class ="center" >Thời gian truy cập</th>
	            <th class ="center" >Thời gian thoát</th>

	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${users}" var="r" status="i">
	        <tr>
	          <td >${i+1}</td>
                  <td >${r.fullname}</td>
                  <td >${r.prop2}</td>
                  <td class="center" >${r.username}</td>
                  <td class="center"><g:formatDate format="dd-MM-yyyy HH:mm:ss" date="${r.lastLogin}"/></td>
                  <td class="center"><g:formatDate format="dd-MM-yyyy HH:mm:ss" date="${r.lastLogout}"/></td>
	        </tr>
                </g:each>
	      </tbody>
	    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
        set_side_bar(true);
        set_active_tab('management');
        $("#user-management").closest('li').addClass('active');
      })
        TableToolsInit.sTitle = "Quản lý người dùng";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
