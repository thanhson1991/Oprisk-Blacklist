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
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opError',action:'reportList'),title:'Danh sách lỗi',label:'Danh sách lỗi']]
					]}"/>

			<div class="clear"></div>
		</div>
		
            <div id="m-melanin-left-sidebar">
            <sec:ifAllGranted roles="ROLE_GDTT">
				<g:render template="errorsidebarLevel1"/>			 
			</sec:ifAllGranted>
			<sec:ifAnyGranted roles="ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3">
				<g:render template="errorsidebarLevel2"/> 
			</sec:ifAnyGranted>
			</div>
		</div>
     <div id="m-melanin-main-content">
  
     
     <g:form name="reportForm" id="reportForm" class="form float-left" action="getErrorDisplayLevelAssign" >
	    <g:if test="${flash.message}">
			<div id="flash-message" class="message info">${flash.message}</div>
	    </g:if>
       	<g:render template="../opError/errorSReportRutgon"/>
       	<g:hiddenField name="search" value="maxresults30"/>
		<g:hiddenField id="actionbutton" name="exportExcel"/>	
	
      </g:form>
      	<g:form name="opError" class="form float-right" action="errorManagementList">	
  				<button  name="addComment" class=" btn primary" style=" position: relative;float:right; margin-top:15px">Nhập thông tin</button>
   		</g:form>		
	      <table  class="sortDatatablesExport">
	        <thead>
	          <tr>
	          <th class="center">Mã</th>
	            <!--  <th class ="center" width="130px" >NHCD/Khối</th> -->
<%--	            <th class ="center" width="150px">Tên đơn vị</th> 
                     --%>
                <th class = "center">Tên Đơn Vị</th>
	            <th class ="center" >Lỗi cấp 3</th>
	            <th class ="center" >Mô tả lỗi</th>	            
	            <th class ="center" >User lỗi</th>
	            <th class ="center" >Cấp độ lỗi</th>
	            <th class ="center" width="90px">Trạng thái</th>
	            <th class ="center" width="80px">Ngày xảy ra</th>	            
	            <th class ="center" width="80px">Thời hạn khắc phục</th>
	            <th class ="center" width="80px">Ngày giờ nhập</th>	           
	            <th class ="center" >Xem</th>
	            
	          </tr>
	        </thead>
	        		 
		 		
		
	        <tbody>

	        <g:each in="${errorManagement}" var="e" status="i">

	        <tr>
	       <td class ="center">${e.id}  </td><%--
	          
	          <td class ="">${e.unitDepart.name}</td>	            
              --%>
              <td class = "">${e?UnitDepart.get(e.tenDonVi3)?.name:null }</td>
              <td class ="">${e?ErrorList.get(e.loiCap3)?.name:null}</td>
              <td class=""><span style="text-align:left">${e.motaChiTiet}</span> </td>
              <td class ="" >
              	<g:each in="${e.errorUserCreate}" var="u" >
              		${u?.userEmail}<br>
              	</g:each>
              </td>
              <td class ="" >
              	<g:each in="${e.errorUserCreate}" var="u" >
              		${u?.levelError}<br>
              	</g:each>
              </td>
              <td class ="">${ErrorStatus.get(e.trangThai).nameStatus}</td>
              <td class =""><g:formatDate format="yyyy-MM-dd" date="${e?.ngayXayRa}" /></td>    
              <td class =""><g:formatDate format="yyyy-MM-dd" date="${e?.thoiHanKhacPhuc}" /></td>
              <td class =""><g:formatDate format="yyyy-MM-dd hh:mm" date="${e?.thoiGianNhapVaoHeThong}" /></td>              
    <%--          <td class ="center">
                  	${ErrorManagement.get(e.id).errorsComments.size()}
              </td>
              <td class ="center"> <g:formatDate format="yyyy-MM-dd" date="${e?.errorsComments?e?.errorsComments.dateCreated.last():null}"/>  </td>
              --%>
                  	<sec:ifAnyGranted roles="ROLE_CVQLRR">
			      		<td class ="center"><a href="${createLink(controller:'opError',action:'getErrorDetail',params:[id:e.id])}" >Xem</a></td>
					</sec:ifAnyGranted>
					
					<sec:ifNotGranted roles="ROLE_CVQLRR">
						<td class ="center"><a href="${createLink(controller:'opError',action:'viewErrorDetail',params:[id:e.id])}" >Xem</a></td>
					</sec:ifNotGranted>
                  
	        </tr>
	        </g:each>
	      </tbody>
	    </table>
      		<button class="btn primary" id="exportExcel" name="exportExcel" >Xuất ra excel</button>   
<%--	    	<br> <br>--%>
<%--	    	<sec:ifNotGranted roles="ROLE_CVQLRR">--%>
<%--			 <g:form name="opError" class="form" action="errorManagementList">--%>
<%--				<g:submitButton name="addComment" value="Tạo mới"  />--%>
<%--			</g:form>--%>
<%--			</sec:ifNotGranted>--%>
					
			
					
				
      </div>

 <script class="jsbin" src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
    <script type="text/javascript">
       $(document).ready(function(){
    	  	set_active_tab('error-managementLevel1');//top         
	        $("#error-management-Assign").closest('li').addClass('active');//Left Menu
	        set_side_bar(true);
       });
		$("#exportExcel").click(function(){
				$("#actionbutton").val("ExportExcel");
				$("#reportForm").submit();
				$("#actionbutton").val("");
			});
       TableToolsInit.sTitle = "DanhSachLoiBiGan";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
       
   

        
    </script>
 
  </body>
</html>
