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
						[href:createLink(controller:'opError',action:'getErrorDisplay'),title:'Quản lý lỗi',label:'Quản lý lỗi']]
					]}"/>
          </div>
         
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
	<div id="m-melanin-main-content">
	<g:form method="post" name="masterUserCreateInsert" controller="masterUserCreate" action="insert" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Quản lý người dùng</legend>
 
 <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                      </g:if>
                        
  <ol class="form form-clear olCenter" id="incidentField">
   <li>
   	      <label for="TenDonVi" class="lableCenter ">1. Phòng Giao dịch/Phòng Ban/Tổ Nhóm<font color="red">*</font> </label>
   	      <br>
   	       <g:select name="PGD" id="PGD" class="validate[required] largeControlCombobox" from="${allUnitDepart}"
		   	      				value="" optionKey="id" optionValue="${{it.code+'-'+it.name} }" noSelection="${['':'']}"/> 
   	       
   </li>
   
    <li>
   	     <label for="TenDonVi" class="lableCenter ">2.Chi nhánh/Trung tâm/Phòng Ban<font color="red">*</font> </label>
   	      <br>
   	      <g:select  name="CN" id="CN" class="validate[required] largeControlCombobox" from="${allUnitDepart2}"
			optionKey="id" optionValue="${{it.code +' - '+it.name}}" noSelection="${['':'']}"	/>
   </li>  
   
     <li>
     	 <label for="NHCD" class="lableCenter ">3. NH Chuyên doanh/Khối <font color="red">*</font></label>
   	     
   	      <br>
   	      <g:select class="validate[required] largeControlCombobox" name="NHCD" from="${unitDepart1}"
			optionKey="id" optionValue="${{it.code +' - '+it.name}}" noSelection="${['':'']}"	/>
   </li>  
   
   
     
   <li>
     <label for="userOutlook" class="lableCenter">4.UserOutlook (VD: hungbm) <font color="red">*</font></label>
      <br>   
      <input type="text" value=""  name ="userOutlook" id="userOutlook"   class="validate[required] text-input largeControlCenter">
    </li>

    <li>
       <label for="fullName" class="lableCenter">5.Họ và tên (VD: Nguyễn Văn A)<font color="red">*</font></label>
       <br>
    	<input type="text" value=""  name ="fullName" id="fullName"  class="validate[required] text-input largeControlCenter">
    </li>
   
    <li>
       <label for="title" class="lableCenter">6.Chức danh (VD: Giao dịch viên)<font color="red">*</font></label>
       <br>
    	<input type="text" value=""  name ="title"    id="title" class="validate[required] text-input largeControlCenter">
    </li>
   
    <li>
       <label for="bdsUser" class="lableCenter">7.User hệ thống (VD: DD200010)</label>
       <br>
    	<input type="text" value=""  name ="bdsUser" id="bdsUser"  class="text-input largeControlCenter">
    </li>
 
 	<li>
       <label for="IdNhanSu" class="lableCenter">8.ID nhân sự (VD: MSB00773)</label>
       <br>
    	<input type="text" value=""  name ="IdNhanSu" id="IdNhanSu"  class="text-input largeControlCenter">
    </li>
    <li>
       <label for="department" class="lableCenter">9.Chọn loại báo cáo phù hợp <font color="red">*</font></label>
       <br>
    	<g:select class="largeControlCombobox validate[required]" name="department" from="${departments}" optionValue="name" optionKey ="id"
          noSelection="['':'-Vui lòng chọn-']"/>
    </li>
    
   <li> 
   	<button class="btn primary" type="submit" id="saveComment" name="saveComment" value="saveError">Tạo mới</button>
   </li>
   
   <li>
 </ol>
</fieldset>
    
    
    
    
  </g:form>
	
</div>
 
	<script type="text/javascript">
	$("#user-error-management").closest('li').addClass('active');
    set_side_bar(true);
	   $("#masterUserCreateInsert").validationEngine();
	   
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

	$("#NHCD").change(function(){
		
		options = "<option ></option>";
		var index=$(this).val();
		if(index != ''){
			$.getJSON('${createLink(controller:'opError',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart2){
					for(var i=0;i<unitDepart2.length;i++)
						{												
								options += "<option value='" + unitDepart2[i].id  + "'>" + unitDepart2[i].code +'-'+ unitDepart2[i].name + "</option>";											 
						}													
					
				$("select#CN").html(options); });
		}
		else
			$("select#CN").html(options);	
										
	});



	$("#CN").change(function(){
		
		options = "<option ></option>";
		var index=$(this).val();						
		if(index != ''){				
			$.getJSON('${createLink(controller:'opError',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart3){
				for(var i=0;i<unitDepart3.length;i++)
					{												
							options += "<option value='" + unitDepart3[i].id  + "'>" + unitDepart3[i].code +'-'+ unitDepart3[i].name + "</option>";											 
					}													
				
			$("select#PGD").html(options); });
		}else
			$("select#PGD").html(options);						
	});
	$("select[name=CN]").change(function(){
		
		if ($(this).val()){
		
		$("select[name=NHCD]").html("");
		$("select[name=PGD]").html("");
			
			
			$.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/CN',
				$("form[name=masterUserCreateInsert]").serialize(),function(data){
					$("select[name=PGD]").html(data);               	});
					
			$.post('${createLink(controller:'unitDepartment',action:'getFirstNodesFromLevel2')}/CN',
			$("form[name=masterUserCreateInsert]").serialize(),function(data){
					$("select[name=NHCD]").html(data); 	});
		} 
	
	});
//chon don vi cap3 hien ra cap 2 va 1	
	$("select[name=PGD]").change(function(){
<%--					alert("fdsfsfs");--%>
					if ($(this).val()){
						
						$("select[name=CN]").html("");
						$("select[name=NHCD]").html("");
						
							$.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/PGD',
							$("form[name=masterUserCreateInsert]").serialize(),function(data){
<%--								alert("1");--%>
								$("select[name=CN]").html(data);
		               	});
		               	
		               	
		               	$.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/PGD',
							$("form[name=masterUserCreateInsert]").serialize(),function(data){
<%--							alert("2");--%>
								$("select[name=NHCD]").html(data);
		               	});
		               	
		               }					
				});

	</script>

  </body>
  
  
  
</html>


