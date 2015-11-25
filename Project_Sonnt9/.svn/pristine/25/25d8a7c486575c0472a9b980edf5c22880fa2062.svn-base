<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Cập nhật thông tin đơn vị</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'opRisk',action:'updateInformation'),title:'Cập nhật thông tin đơn vị',label:'Cập nhật thông tin đơn vị']]
					]}"/>

			<div class="clear"></div>
		</div>
   
    <div id="m-melanin-main-content">
      <div style="width:605px;margin:auto">
      <fieldset>      
       <g:if test="${flash.message}">
					<div id="flash-message" class="message">${flash.message}</div>
				</g:if>
	  			
      <form method="post" controller="opRisk" action="updateInformation" id="updateForm" name="updateForm" >
      <ol class="form form-clear form-wide" style="padding-left:25px">
      <center><legend style="background:none">Cập nhật thông tin</legend></center>
      	<li>
      		<label class="label-left e-xxl" for="name"><font color="red">*</font> User đăng nhập:</label>
      		<label class="label-left e-xxl" for="name"><font color="red">*</font> Nhập họ và tên (Ví dụ: Nguyễn Văn A):</label>
        </li>
        <li>
          	<input type="text" value="${user.username}"  readonly="readonly" class="validate[required] e-xxl" id="userOutlook" name="userOutlook"/>
           <input type="text" value="${user.fullname}" class="validate[required] e-xxl" id="name" name="name"/>
        </li>
        
        <li>
        </li>
        <li>
         
        </li><%--
        
        
        <li><label class="label-left e-xxl" for="name"><font color="red">*</font> Chức danh (Ví dụ: Giao dịch viên):</label>
        </li>
        <li>
          <input type="text" value="${masterUser.title}" class="validate[required] e-xxl" id="title" name="title"/>
        </li>  
        
        <li><label class="label-left e-xxl" for="name">User hệ thống(Ví dụ: BDS, Kondor...):</label>
        </li>
        <li>
          <input type="text" value="${masterUser.bDSUser}" class="validate[required] e-xxl" id="bdsUser" name="bdsUser"/>
        </li>  
        
         <li><label class="label-left e-xxl" for="name">ID nhân sự(Ví dụ: MSB-00773):</label>
        </li>
        <li>
          <input type="text" value="${masterUser.codeSalary}" class="validate[required] e-xxl" id="IdNhanSu" name="IdNhanSu"/>
        </li>  
        
              
        --%><li><label class="label-left e-xxl" for="branch"><font color="red">*</font> Tên đơn vị (Ví dụ: TT KHCN Láng Hạ):</label>
        <label class="label-left e-xxl" for="departmentId"><font color="red">*</font> Chọn loại báo cáo phù hợp:</label>
        </li>
        <li>
          <input type="text" value="${user.prop2}" class="validate[required] e-xxl" id="branch" name="branch"/>
          <g:select class="se-xxl" name="departmentId" from="${departments}" value="${user.prop1}" optionValue ="name" optionKey="id"/>
        </li>
           
<%--        <li><label class="label-left e-xxl" for="branchName"><font color="red">*</font> Chi nhánh:</label>--%>
<%--        </li>--%>
<%--        <li>--%>
<%--          <input type="text" value="${user.prop3}" class="validate[required] e-xxl" id="branchName" name="branchName"/>--%>
<%--        </li>--%>
        
        
        <br><br>
        <center><legend style="background:none">Cập nhật thông tin chi tiết</legend></center>
        <br>
        <li>
   	      <label for="TenDonVi" class="label-left e-xxl"><font color="red">*</font> Phòng Giao dịch/Phòng Ban/Tổ Nhóm</label>
   	      <label for="TenDonVi" class="label-left e-xxl"><font color="red">*</font> Chi nhánh/Trung tâm/Phòng Ban </label>
   	      <br>
   	      <g:select name="PGD" id="PGD" class="validate[required] se-xxl" from="${allUnitDepart3}"
   	       			value="${masterUser?.tenDonVi3}"
				 	optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"/>
   	       
			 <g:select  name="CN" id="CN" class="validate[required]  se-xxl" from="${unitDepart2}"
   	       			value="${masterUser?.tenDonVi2}"
				 	optionKey="id" optionValue="name" noSelection="${['':'']}"/>
		   </li>
		   <li>
		   		<label for="NHCD" class="label-left e-xxl"><font color="red">*</font> NH Chuyên doanh/Khối</label>
		   	     <label for="title" class="lableCenter e-xxl"><font color="red">*</font> Chức danh (VD: Giao dịch viên)</label>
		   	      <br>
		   	      	<g:select class="validate[required]  se-xxl" name="NHCD" from="${unitDepart}"
						optionKey="id" optionValue="${{it.code +' - '+it.name}}" noSelection="${['':'']}"	value="${masterUser?.tenDonVi1 }"/>
				 	<input type="text" value="${masterUser?.title }"  name ="title"    id="title" class="validate[required] text-input e-xxl">
		   </li> 	
	   
	    <li>
	       <label for="bdsUser" class="lableCenter e-xxl">User hệ thống (VD: BDS, Kondor...)</label>
	       <label for="IdNhanSu" class="lableCenter e-xxl">ID nhân sự (VD: MSB-00073)</label>
	       <br>
	    	<input type="text" value="${masterUser?.bDSUser }"  name ="bdsUser" id="bdsUser"  class="text-input e-xxl">
	    	<input type="text" value="${masterUser?.codeSalary }"  name ="IdNhanSu" id="IdNhanSu"  class="text-input e-xxl">
	    </li>
	 
        
       
        <li id="addMoreControl">
        	  <input type="text" value="" class="validate[required] e-xxl" id="otherUnitDepart" name="otherUnitDepart" style="width:180px !important;"/>
        	  <input class="btn primary" type="submit" id="AddNewUnitDepart" name="AddNewUnitDepart" value="Tạo mới"/>
        </li>
        
        <li>
        <center> <input class="btn primary" type="submit" id="save" name="save" value="Lưu"/></center>
        </li>
      </ol>
    </form>
        </fieldset>
      </div>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
           set_active_tab('update-information');
          $("#updateForm").validationEngine();

          $("#addMoreControl").hide('fast')

          $("#unitDepartmentId").change(function(){
				
				options = "<option ></option>";
				var index=$(this).val();

				if($("#unitDepartmentId option:selected").text()=='...')
				{
					$("#addMoreControl").show('slow')					
				}
				else
				{
					$("#addMoreControl").hide('fast')
					$("#otherUnitDepart").val('')
					
					}
				
				
			    });
          $("#NHCD").change(function(){
        	//$("select[name=PGD]").html("");
			 
      		options = "<option ></option>";
      		var index=$(this).val();
      						
      		$.getJSON('${createLink(controller:'opError',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart2){
      				for(var i=0;i<unitDepart2.length;i++)
      					{												
      							options += "<option value='" + unitDepart2[i].id  + "'>" +unitDepart2[i].code+'-'+ unitDepart2[i].name + "</option>";											 
      					}													
      				
      			$("select#CN").html(options); });
      			
      										
      	});



  	      $("#CN").change(function(){
  	      	
  	      	options = "<option ></option>";
  	      	var index=$(this).val();						
  	      					
  	      	$.getJSON('${createLink(controller:'opError',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart3){
  	      			for(var i=0;i<unitDepart3.length;i++)
  	      				{												
  	      						options += "<option value='" + unitDepart3[i].id  + "'>" +unitDepart3[i].code+'-'+ unitDepart3[i].name + "</option>";											 
  	      				}													
  	      			
  	      		$("select#PGD").html(options); });						
  	      });
  	  //chon don vi cap1 hien ra cap 2 va 1	
  		$("select[name=PGD]").change(function(){
  						
  						if ($(this).val()){
  							
  							$("select[name=CN]").html("");
  							$("select[name=NHCD]").html("");
  							
  								$.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/PGD',
  								$("form[name=updateForm]").serialize(),function(data){
  									$("select[name=CN]").html(data);
  			               	});
  			               	
  			               	
  			               	$.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/PGD',
  								$("form[name=updateForm]").serialize(),function(data){
  									$("select[name=NHCD]").html(data);
  			               	});
  			               	
  			               }					
  					});
  		
		 
      })
      
      
    </script>
  </body>
</html>
