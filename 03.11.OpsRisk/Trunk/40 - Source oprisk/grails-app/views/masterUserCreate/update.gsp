<%@page import="msb.platto.dna.*"%>


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
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opRisk',action:'getErrorDisplay'),title:'Quản lý lỗi',label:'Quản lý lỗi']]
					]}"/>
          </div>
         
			<div class="clear"></div>
			 
		</div>
		<div id="m-melanin-left-sidebar">
			<sec:ifAnyGranted roles="ROLE_CVQLRR">
        		<g:render template="../opError/errorsidebar"/>
        	</sec:ifAnyGranted>
        	<sec:ifAnyGranted roles="ROLE_GDTT_LEVEL3">
        		<g:render template="../opError/errorsidebarLevel2"/>
        	</sec:ifAnyGranted>
		</div>
	<div id="m-melanin-main-content">
	<g:form method="post" name="masterUserUpdateDelete" controller="masterUserCreate" action="update" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Quản lý người gây lỗi</legend>
 
 <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                      </g:if>
	
  <ol class="form form-clear olCenter" id="incidentField">
   <li>
   		  <label for="TenDonVi3" class="lableCenter ">1. Phòng Giao dịch/Phòng Ban/Tổ Nhóm<font color="red">*</font> </label>
   	      
   	      <br>
   	      <g:select class="validate[required] largeControlCombobox" name="TenDonVi3" id="TenDonVi3" from="${allUnitDepart}"
   	       			value="${master?.tenDonVi3}"
				 optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"/>
   </li>
   
    <li>
   	     <label for="TenDonVi2" class="lableCenter ">2.Chi nhánh/Trung tâm/Phòng Ban<font color="red">*</font> </label>
   	     
   	      <br>
   	      				
   	      <g:select class="validate[required] largeControlCombobox" id="TenDonVi2" name="TenDonVi2" from="${allUnitDepart2}"
   	       			value="${master?.tenDonVi2}"
				 	optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"/>
							 
   </li>  
<%--   optionKey="id" optionValue="${{it.code +'-'+it.name}}"--%>
   <li>
   	     <label for="TenDonVi1" class="lableCenter ">3.NH Chuyên doanh/Khối <font color="red">*</font></label>
   	      <br>
 			<g:select class="validate[required] largeControlCombobox" name="TenDonVi1" id="TenDonVi1" from="${unitDepart}"
   	       	value="${master?.tenDonVi1}"
			optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"	/>
   	      
							 
   </li>  
     
   <li>
     <label for="userOutlook" class="lableCenter">4.UserOutlook (VD: hungbm)<font color="red">*</font></label>
      <br>   
      <input type="text" value="${master?.userEmail}"  name ="userOutlook" id="userOutlook"  class="validate[required] text-input largeControlCenter">
    </li>

    <li>
       <label for="fullName" class="lableCenter">5.Họ và tên (VD: Nguyễn Văn A)<font color="red">*</font></label>
       <br>
    	<input type="text" value="${master?.fullName}"  name ="fullName" id="fullName"  class="validate[required] text-input largeControlCenter">
    </li>
   
    <li>
       <label for="title" class="lableCenter">6.Chức danh (VD: Giao dịch viên)<font color="red">*</font></label>
       <br>
    	<input type="text" value="${master?.title}" name ="title"  id="title" class="validate[required] text-input largeControlCenter">
    </li>
   
    <li>
       <label for="bdsUser" class="lableCenter">7.User hệ thống (VD: DD200010)</label>
       <br>
    	<input type="text" value="${master?.bDSUser}"  name ="bdsUser" id="bdsUser"  class="text-input largeControlCenter">
    </li>
 
 	<li>
       <label for="IdNhanSu" class="lableCenter">8.ID nhân sự (VD: MSB00773)</label>
       <br>
    	<input type="text" value="${master?.codeSalary}"   name ="IdNhanSu" id="IdNhanSu"  class="text-input largeControlCenter">
    </li>
    
    <li>
       <label for="department" class="lableCenter">9.Chọn loại báo cáo phù hợp <font color="red">*</font></label>
       <br>
    	<g:select class="largeControlCombobox validate[required]" value="${user?.prop1 }" name="department" from="${departments}" optionValue="name" optionKey ="id"
          noSelection="['':'-Vui lòng chọn-']"/>
    </li>
    
   <li>
 
   	<button class="btn primary" type="submit" id="update" name="update" value="update">Cập nhật</button>
   	<sec:ifAnyGranted roles="ROLE_CVQLRR">
   		<button class="btn primary"  id="delete" name="delete" value="delete">Xóa</button>
   	</sec:ifAnyGranted>
   	<g:hiddenField id="idMaster" name="idMaster" value="${master?.id}"/>
   		<g:hiddenField id="deleteError" name="deleteError" value=""/>
 	
   </li>      
 </ol>
</fieldset>
               
  </g:form>
	
</div>
 
	<script type="text/javascript">
    $("select[name=TenDonVi1]").change(function(){
        
		if ($(this).val()){
			$.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/TenDonVi1',
				$("form[name=masterUserUpdateDelete]").serialize(),function(data){
					$("select[name=TenDonVi2]").html(data);
           	});
		} else{
			$("select[name=TenDonVi2]").html('');
		}
		 $("#TenDonVi2").change(); 
		 
	});
	
	$("select[name=TenDonVi2]").change(function(){
		if ($(this).val()){
			$.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/TenDonVi2',
				$("form[name=masterUserUpdateDelete]").serialize(),function(data){
					$("select[name=TenDonVi3]").html(data);
           	});
		} else{
			$("select[name=TenDonVi3]").html('');
		}
<%--		options--%>
	});


	$("#user-error-management").closest('li').addClass('active');
    set_side_bar(true);
	  $("#masterUserUpdateDelete").validationEngine();
	$("#delete").click( function(){
		 jquery_confirm("Xóa","Anh/chị đồng xóa ?",
                function(){
			 		$("#deleteError").val("delete");
			 		  // $("#actionButton").val("errorDelete");
                      $("#masterUserUpdateDelete").submit();

          });
    return false;
	});
    

	
	$("input[name=userOutlook]").focusout(function() {
		
		var un=$("#userOutlook").val();
		
		if(un!="")
		{
		
		$.getJSON('${createLink(controller:'masterUserCreate',action:'getDisplayName')}?username='+un,function(fullNameOutlook){

			
			if(fullNameOutlook==",")
				alert("Không tồn tại:"+un)
			
						
			$("#fullName").val(fullNameOutlook[0]);
			$("#title").val(fullNameOutlook[1]);
			
		});
		}
		else
			{
			$("#fullName").val("");
			$("#title").val("");
			}
	});
	$("select[name=TenDonVi2]").change(function(){
		
		if ($(this).val()){
		
		$("select[name=TenDonVi1]").html("");
		$("select[name=TenDonVi3]").html("");
			
			
			$.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/TenDonVi2',
				$("form[name=masterUserUpdateDelete]").serialize(),function(data){
					$("select[name=TenDonVi3]").html(data);               	
					});
					
			$.post('${createLink(controller:'unitDepartment',action:'getFirstNodesFromLevel2')}/TenDonVi2',
			$("form[name=masterUserUpdateDelete]").serialize(),function(data){
					$("select[name=TenDonVi1]").html(data); 	
					});
		} 
	
	});
	 //chon don vi cap1 hien ra cap 2 va 1	
		$("select[name=TenDonVi3]").change(function(){
						
						if ($(this).val()){
							
							$("select[name=TenDonVi2]").html("");
							$("select[name=TenDonVi1]").html("");
							
								$.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/TenDonVi3',
								$("form[name=masterUserUpdateDelete]").serialize(),function(data){
									$("select[name=TenDonVi2]").html(data);
			               	});
			               	
			               	
			               	$.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/TenDonVi3',
								$("form[name=masterUserUpdateDelete]").serialize(),function(data){
									$("select[name=TenDonVi1]").html(data);
			               	});
			               	
			               }					
					});

	</script>

  </body>
  
  
  
</html>


