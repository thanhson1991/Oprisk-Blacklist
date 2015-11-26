<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý lỗi</title>
  </head>
  <body>
     <div id="m-melanin-tab-header">
     	<div id="m-melanin-tab-header-inner">
	 		<div id="m-melanin-tab-actions">
             <button class="btn small primary m-melanin-toggle-side-bar" name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>             
           </div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opError',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opError',action:'reportList'),title:'Danh sách lỗi',label:'Danh sách lỗi']]
					]}"/>

			<div class="clear"></div>
		</div>
		
                    <div id="m-melanin-left-sidebar">
                     <g:render template="errorsidebar"/>
		</div>
		</div>
     <div id="m-melanin-main-content">
     <g:form name="reportForm" class="form" action="getErrorDisplay">
            <ol class="form form-clear olCenter">
         <li>
            <%def today = new Date();
            today.setMonth(today.month-2);
            %>
            <label class="label-left" for="fromDate">Từ ngày:</label>            
            <label class="label-left" style="float:none" for="toDate">Đến ngày:</label>
            
              
          </li>
          <li>
            <label class="label-left"><input name="fromDate" id="fromDate" class="e-m datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/></label>
            <label class="label-left"><input name="toDate" id="toDate" class="e-m datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/></label>
                        
            
            <g:submitButton class="searchButtons btn primary" name="Search" value="Xem" />
          </li>
 
   </ol>
      </g:form>

	      <table  class="sortDatatablesExport">
	        <thead>
	          <tr>
	          	
	            <th class ="center" width="180px" >NHCD/Khối</th>
	            <th class ="center" width="200px">Tên đơn vị</th>
	            <th class ="center" width="80px">Ngày xảy ra</th>	            
	            <th class ="center" >Nhóm lỗi mức 1</th>
	            <th class ="center" >Nhóm lỗi mức 2</th>
	            <th class ="center" >Mô tả chi tiết</th>
	            <th class ="center" >SL ý kiến</th>
	            <th class ="center"> Ngày comment </th>
	            <th class ="center" >Thao tác</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${errorManagement}" var="e" status="i">

	        <tr>
	          <td class ="">${e.department.name}  </td>
	          <td class ="">${e.unitDepart.name}</td>
	          <td class ="center"><g:formatDate format="yyyy-MM-dd" date="${e?.ngayXayRa}" /></td>
                  <td class ="">${e?ErrorList.get(e.loiCap1)?.name:null}</td>
                  <td class ="">${e?ErrorList.get(e.loiCap2)?.name:null}</td>
                  <td class ="center">${e.motaChiTiet}</td>
                  <td class ="center">
                  	${ErrorManagement.get(e.id).errorsComments.size()}
                  </td>
                  <td class ="center"> <g:formatDate format="yyyy-MM-dd" date="${e?.errorsComments?e?.errorsComments.dateCreated.last():null}"/>  </td>
                  	<sec:ifAnyGranted roles="ROLE_CVQLRR">
			      		<td class ="center"><a href="${createLink(controller:'opError',action:'getErrorDetail',params:[id:e.id])}" >Xem chi tiết</a></td>
					</sec:ifAnyGranted>
					
					<sec:ifNotGranted roles="ROLE_CVQLRR">
						<td class ="center"><a href="${createLink(controller:'opError',action:'viewErrorDetail',params:[id:e.id])}" >Xem chi tiết</a></td>
					</sec:ifNotGranted>
                  
 				
 				
 				
	        </tr>
	        </g:each>
	      </tbody>
	    </table>
	    	<sec:ifNotGranted roles="ROLE_CVQLRR">
			 <g:form name="opError" class="form" action="errorManagementList">
				<g:submitButton name="addComment" value="Tạo mới"  />
			</g:form>
			</sec:ifNotGranted>
					
					
			
      </div>

 <script class="jsbin" src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
    <script type="text/javascript">
       $(document).ready(function(){
    	  
        set_active_tab('error-management');
        $("#error-management").closest('li').addClass('active');
        set_side_bar(true);
       });

       TableToolsInit.sTitle = "DanhSachLoiDayDu";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
       
   

        
    </script>
 
  </body>
</html>
