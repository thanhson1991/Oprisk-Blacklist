<%@page import="java.text.Format"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý người gây lỗi</title>
  </head>
  <body>
     <div id="m-melanin-tab-header">
     	<div id="m-melanin-tab-header-inner">
	 		<div id="m-melanin-tab-actions">
            <button class="btn small primary m-melanin-toggle-side-bar" name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>
            
       	
             
           </div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
			model="${[
						items:[[href:createLink(controller:'opError',action:'reportList'),title:'home',label:'Home'],
						[href:createLink(controller:'opError',action:'reportList'),title:'Quản lý người gây lỗi',label:'Quản lý người gây lỗi']]
					]}"/>

			<div class="clear"></div>
		</div>
		
            <div id="m-melanin-left-sidebar">
            
            <sec:ifAllGranted roles="ROLE_GDTT">
				<g:render template="../opError/errorsidebarLevel1"/>			 
			</sec:ifAllGranted>
			<sec:ifAnyGranted roles="ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3">
				<g:render template="../opError/errorsidebarLevel2"/> 
			</sec:ifAnyGranted>
			 <sec:ifAnyGranted roles="ROLE_CVQLRR">
			 	<g:render template="../opError/errorsidebar"/>
			 </sec:ifAnyGranted>
	
            	
               
			</div>
		</div>
     <div id="m-melanin-main-content">
      <g:form name="masterUserCreate" class="form" action="viewInsert" style="margin-bottom:-15px">
  				 
		 <button  name="addComment" class="btn primary float-right">Nhập thông tin</button>
		</g:form>	
		
		<br>
		<Br>
     <g:form name="reportForm" class="form" action="getErrorDisplay" style="">
     <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
      </g:if>
      
    <g:if test="${messageCode != null}">
    <div class ="message">
      <g:message code="errorMessage${messageCode}" />
    </div>
  	</g:if>
     </g:form>
  		
	      <table  class="sortDatatablesExport">
	        <thead>
	          <tr>
	          <th class="center">Mã</th>	            
	            <th class ="center" width="">Outlook</th>                      
	            <th class ="center" >Họ và tên</th>
	            <th class ="center" >Vị trí</th>	            
	            <th class ="center" >User hệ thống</th>
	            <th class ="center" >ID nhân sự</th>
	            <th class ="center" width="">NH Chuyên doanh/Khối</th>
	            <th class ="center" width="">CN/Trung tâm/Phòng</th>          
	            <th class ="center" width="">PGD/Phòng ban/Tổ nhóm</th>
	            <sec:ifAnyGranted roles="ROLE_CVQLRR">
		            <th class ="center" width="">Người nhập</th>
		            <th class ="center" width="">Người sửa</th>
		            <th class ="center" width="">Trạng thái</th>
		            <th class ="center" width="">Thời gian nhập</th>
		            <th class ="center" width="">Thời gian sửa</th>
	            </sec:ifAnyGranted>
	             <sec:ifAnyGranted roles="ROLE_CVQLRR,ROLE_GDTT_LEVEL3">
	            <th class ="center" >Xem</th>
	            </sec:ifAnyGranted>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${masterUserCreate}" var="e" status="i">

	        <tr>
	       <td class ="center">${e.id}  </td>	          
	          <td class ="">${e.userEmail}</td>	            
              <td class ="">${e.fullName}</td>
              <td class="">${e.title} </td>
              <td class ="" > ${e.bDSUser} </td>
              <td class ="" > ${e.codeSalary} </td>
              <td class ="" >${UnitDepart.get(e.tenDonVi1)?.code+'-'+UnitDepart.get(e.tenDonVi1)?.name} </td>
              <td class ="" >${UnitDepart.get(e.tenDonVi2)?.code+'-'+UnitDepart.get(e.tenDonVi2)?.name}  </td>
              <td class ="" >${UnitDepart.get(e.tenDonVi3)?.code+'-'+UnitDepart.get(e.tenDonVi3)?.name} </td>
              <sec:ifAnyGranted roles="ROLE_CVQLRR">
	              <td class ="" > ${e.nguoiNhap} </td>
	              <td class ="" > ${e.nguoiSua} </td>
	              <td class ="" > ${e.trangThai} </td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${e.ngayNhap}"/></td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${e.ngaySua}"/></td>
              </sec:ifAnyGranted>
              <sec:ifAnyGranted roles="ROLE_CVQLRR,ROLE_GDTT_LEVEL3">
              <td class ="" ><a href="${createLink(controller:'masterUserCreate',action:'viewUpdate',params:[id:e.id])}" >Xem</a></td>
              </sec:ifAnyGranted>
                  
	        </tr>
	        </g:each>
	      </tbody>
	    </table>

			
					
				
      </div>

 <script class="jsbin" src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
    <script type="text/javascript">
       $(document).ready(function(){   	  
        set_active_tab('error-management');
        $("#user-error-management").closest('li').addClass('active');
        set_side_bar(true);
       });

       TableToolsInit.sTitle = "QuanLyNguoiGayLoi";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
                  
    </script> 
  </body>
</html>
