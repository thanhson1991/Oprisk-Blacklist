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
						[href:createLink(controller:'opError',action:'reportList'),title:'Danh sách Hành động',label:'Danh sách Hành động']]
					]}"/>

			<div class="clear"></div>
		</div>
		
            <div id="m-melanin-left-sidebar"><g:render template="riskActionSidebar"/></div>
		</div>
     <div id="m-melanin-main-content">
  
     
     <g:form name="reportForm" id="reportForm" class="form float-left" action="list" >
     	<g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
      	</g:if>
      	<br>
       	<g:render template="riskActionSearch"/>
       	<g:hiddenField name="search" value="search"/>
		<g:hiddenField id="actionbutton" name="exportExcel"/>

      </g:form>
      <br clear="both"/>
      	<g:form name="actionRisk" class="form float-right" action="detail">	
  				<button  name="addComment" class=" btn primary" style=" position: relative;float:right; margin-top:15px">Thêm mới hành động</button>
   			</g:form>		
	      <table  class="sortDatatablesExport">
	        <thead>
	          <tr>
	          <th class="center">Mã hành động</th>
	
                <th class = "center">Mô tả hành động</th>
                <th class = "center">Tên rủi ro</th>
                <th class = "center">Mức độ rủi ro</th>
	            <th class ="center" >Người chịu trách nhiệm</th>
	            <th class ="center" >Phòng ban</th>
	            <th class ="center" >Người giám sát hành động</th>
	            <th class ="center" >Phòng ban</th>		            
	            <th class ="center" >Thời hạn</th>
	            <th class ="center" >Trạng thái</th>	            	           
	            <th class ="center" >Xem chi tiết</th>
	            
	          </tr>
	        </thead>
	        		 
		 		
		
	        <tbody>

	        <g:each in="${riskActions}" var="e" status="i">

	        <tr>
	       <td class ="center">${e.id}  </td>
              <td class = "">${e.description }</td>
              <td>${e.riskName }</td>
              <td>${e.riskLevel }</td>
              <td class ="" >
              	<g:each in="${e.responsibleUsers}" var="u" >
              		${u?.userEmail}<br>
              	</g:each>
              </td>
              <td class ="" >
              	<g:each in="${e.responsibleUsers}" var="u" >
              		${u?UnitDepart.get(u?.tenDonVi3).code+' - '+UnitDepart.get(u?.tenDonVi3).name:''}<br>
              	</g:each>
              </td>
              <td class ="" >
              	<g:each in="${e.supervisors}" var="u" >
              		${u?.userEmail}<br>
              	</g:each>
              </td>
              <td class ="" >
              	<g:each in="${e.supervisors}" var="u" >
              		${u?UnitDepart.get(u?.tenDonVi3).code+' - '+UnitDepart.get(u?.tenDonVi3).name:''}<br>
              	</g:each>
              </td>
              
              <td class =""><g:formatDate format="dd/MM/yyyy" date="${e?.actionDueDate}" /></td>    
              <td class = "">${e.actionStatus }</td>
              
              <td class ="center"><a href="${createLink(controller:'riskAction',action:'detail',params:[riskActionId:e.id])}" >Xem</a></td>
				  
	        </tr>
	        </g:each>
	      </tbody>
	    </table>	
	    
		<button class="btn primary" id="exportExcel" name="exportExcel"> Xuất ra excel </button>
	    <br>
	    <br>			
			
					
				
      </div>

 <script class="jsbin" src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
    <script type="text/javascript">
       $(document).ready(function(){
	        set_active_tab('riskAction');//top
	        $("#riskAction-management").closest('li').addClass('active');//leftMenu
	        set_side_bar(true);
       });
       $.each([ 'responsible_', 'supervisor_' ], function( index, value ) {
		
		
       $("select[name="+value+"donvi1]").change(function(){
           $("select[name="+value+"donvi2]").html("");
           $("select[name="+value+"donvi3]").html("");

           if ($(this).val()){
               $.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/'+value+'donvi1',
                       $("form[name=reportForm]").serialize(),function(data){
                           $("select[name="+value+"donvi2]").html(data);
                       });
           } else{
               $("select[name="+value+"donvi2]").html("");
           }
           $("select[name="+value+"donvi2]").change()
       });

       $("select[name="+value+"donvi2]").change(function(){

           if ($(this).val()){

               $("select[name="+value+"donvi1]").html("");
               $("select[name="+value+"donvi3]").html("");


               $.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/'+value+'donvi2',
                       $("form[name=reportForm]").serialize(),function(data){
                           $("select[name="+value+"donvi3]").html(data);               	});

               $.post('${createLink(controller:'unitDepartment',action:'getFirstNodesFromLevel2')}/'+value+'donvi2',
                       $("form[name=reportForm]").serialize(),function(data){
                           $("select[name="+value+"donvi1]").html(data); 	});
           }

       });
       $("select[name="+value+"donvi3]").change(function(){

           if ($(this).val()){

               $("select[name="+value+"donvi2]").html("");
               $("select[name="+value+"donvi1]").html("");

               $.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/'+value+'donvi3',
                       $("form[name=reportForm]").serialize(),function(data){
                           $("select[name="+value+"donvi2]").html(data);
                       });


               $.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/'+value+'donvi3',
                       $("form[name=reportForm]").serialize(),function(data){
                           $("select[name="+value+"donvi1]").html(data);
                       });

           }
       });

       });
		$("#exportExcel").click(function(){
				$("#actionbutton").val("ExportExcel");
				$("#reportForm").submit();	
				$("#actionbutton").val("");
			});
       TableToolsInit.sTitle = "DanhSachHanhDongRuiRo";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
       
   

        
    </script>
 
  </body>
</html>
