<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Cập nhật thông tin cá nhân</title>
  </head>
  <body>

   <div class="clear"></div>
    <div id="m-melanin-main-content">
      <div style="width:605px;margin:auto">
      <fieldset>
      
      <form method="post" controller="start" action="checkAndAddRole" id="updateForm" name="updateForm" >
       <ol class="form form-clear form-wide" style="padding-left:25px">
       <center><legend style="background:none">Cập nhật thông tin</legend></center>
        <li>
        	<label class="label-left e-xxl" for="name"><font color="red">*</font> User đăng nhập:</label>
		    <label class="label-left e-xxl" for="name"><font color="red">*</font> Nhập họ và tên (Ví dụ: Nguyễn Văn A):</label>
		    
        </li>
        <li>
        	<g:if test="${user?.username != null }">
        		<input type="text" value="${user?.username}"  readonly="readonly" class="validate[required] e-xxl" id="userOutlook" name="userOutlook"/>
        	</g:if>
        	<g:else>
        		<input type="text" value="${userName}"  readonly="readonly" class="validate[required] e-xxl" id="userOutlook" name="userOutlook"/>
        	</g:else>
          	<input type="text" class="validate[required] e-xxl" id="name" name="name"/>
          
        </li>
        
<%--        <li><label class="label-left e-xxl" for="branchName"><font color="red">*</font> Chi nhánh:</label>--%>
<%--        </li>--%>
<%--        <li>--%>
<%--          <input type="text" class="validate[required] e-xxl" id="branchName" name="branchName"/>--%>
<%--        </li>--%>
        <li>
        	<label class="label-left e-xxl" for="branch"><font color="red">*</font> Tên đơn vị (Ví dụ: TT KHCN Láng Hạ):</label>
          	<label class="label-left e-xxl" for="departmentId"><font color="red">*</font> Chọn loại báo cáo phù hợp:</label>
        </li>
        <li>
        	<input type="text" class="validate[required] e-xxl" id="branch" name="branch"/>
          	<g:select class="se-xxl validate[required]" name="department" from="${departments}" optionValue="name" optionKey ="id"
          noSelection="['':'-Vui lòng chọn-']"/>
        </li>
        <li>
        <br><br>
        <center><legend style="background:none">Cập nhật thông tin chi tiết</legend></center>
        <br>
        <li>
          <label for="TenDonVi" class="label-left e-xxl"><font color="red">*</font> Phòng Giao dịch/Phòng Ban/Tổ Nhóm </label>
   	      
   	      <label for="TenDonVi" class="label-left e-xxl"><font color="red">*</font> Chi nhánh/Trung tâm/Phòng Ban </label>
   	      <br>
   	      <g:select name="PGD" id="PGD" class="validate[required] se-xxl" from="${allUnitDepart3}"
		   	      				value="" optionKey="id" optionValue="${{it?.code+'-'+it?.name} }" noSelection="${['':'']}"/> 
   	       
			<g:select  name="CN" id="CN" class="validate[required] se-xxl" from="${allUnitDepart2}"
		   	      				value="" optionKey="id" optionValue="${{it?.code+'-'+it?.name} }" noSelection="${['':'']}"/>
		   </li>
		   
		   	
		   <li>
		   	     <label for="NHCD" class="label-left e-xxl"><font color="red">*</font> NH Chuyên doanh/Khối </label>
		   	     <label for="title" class="lableCenter e-xxl"><font color="red">*</font> Chức danh (VD: Giao dịch viên)</label>
		   	      <br>
				  <g:select class="validate[required] se-xxl" name="NHCD" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0')}"
					optionKey="id" optionValue="${{it?.code +' - '+it?.name}}" noSelection="${['':'']}"	/>
		   	      <input type="text" value="${masterUser?.title }"  name ="title"    id="title" class="validate[required] text-input e-xxl">
		   </li> 
		 
	   
	    <li>
	       <label for="bdsUser" class="lableCenter e-xxl">User hệ thống (VD: DD20010)</label>
	       <label for="IdNhanSu" class="lableCenter e-xxl">ID nhân sự (VD: MSB00073)</label>
	       <br>
	    	<input type="text" value="${masterUser?.bDSUser }"  name ="bdsUser" id="bdsUser"  class="text-input e-xxl">
	    	<input type="text" value="${masterUser?.codeSalary }"  name ="IdNhanSu" id="IdNhanSu"  class="text-input e-xxl">
	    </li>
	 
	 	
        
        <center> <input class="btn primary" type="submit" id="save" name="save" value="Lưu"/></center>
        </li>       
        
      </ol>
    </form>
        </fieldset>
      </div>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
          $("#updateForm").validationEngine();
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
          	$("select[name=CN]").html("");
  			 
        		options = "<option ></option>";
        		var index=$(this).val();
        	 	if(index != ''){		
	        		$.getJSON('${createLink(controller:'unitDepartment',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart2){
	        				for(var i=0;i<unitDepart2.length;i++)
	        					{			
	        							options += "<option value='" + unitDepart2[i].id  + "'>" +unitDepart2[i].code+'-'+ unitDepart2[i].name + "</option>";											 
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
	    	      	$.getJSON('${createLink(controller:'unitDepartment',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart3){
	    	      			for(var i=0;i<unitDepart3.length;i++)
	    	      				{												
	    	      						options += "<option value='" + unitDepart3[i].id  + "'>" +unitDepart3[i].code+'-'+ unitDepart3[i].name + "</option>";											 
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
    				$("form[name=updateForm]").serialize(),function(data){
    					$("select[name=PGD]").html(data);               	});
    					
    			$.post('${createLink(controller:'unitDepartment',action:'getFirstNodesFromLevel2')}/CN',
    			$("form[name=updateForm]").serialize(),function(data){
    					$("select[name=NHCD]").html(data); 	});
    		} 
    	
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
