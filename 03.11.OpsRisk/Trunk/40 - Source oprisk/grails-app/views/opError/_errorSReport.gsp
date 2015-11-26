   
      
   <ol class="form form-clear error-form" style="margin-top:-15px">
     <%def today = new Date();
            today.setMonth(today.month-1);
            %>
   <!-- Lable Hàng 1 -->
   <li>
   	<label class="label-left" style="width:72px" for="fromDate">Từ ngày</label>
   	<label class="label-left"  style="width:72px" for="toDate">Đến ngày</label>
   	<label  class="label-left" style="width:115px" for="nguoigayloi">Kiểu ngày</label>
   	<label class="label-left" style="width:115px" for="NhomMucLoi1">Nhóm lỗi mức 1</label>
   	<label class="label-left" style="width:115px" for="NhomMucLoi2">Nhóm lỗi mức 2</label>
   	<label class="label-left" style="width:100px" for="NhomMucLoi3">Nhóm lỗi mức 3</label>   	      
   </li>   
   <li>
   		<input style="width:65px" name="fromDate" id="fromDate" class=" datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/></label>
   		<input name="toDate" id="toDate" style="width:65px" class=" datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/></label>
   			
   		<select name="KieuNgay" style="width:120px">
			<option value="1" ${kieuNgay=='1'?'selected="true"':'' }>1-Ngày xảy ra</option>
			<option value="2" ${kieuNgay=='2'?'selected="true"':'' }>2-Thời hạn khắc phục</option>
			<option value="3" ${kieuNgay=='3'?'selected="true"':'' }>3-Thời gian nhập hệ thống</option>
				  
		</select>
		<g:select style="width:120px" name="LoiCap1" from="${ErrorList.executeQuery('from ErrorList e where e.ord=1 and e.status>=0 order by e.code+0')}"
							optionKey="id" optionValue="name" value="${LoiCap1}"
                            noSelection="${['':'']}" />
							
   	    <g:select style="width:120px" name="LoiCap2" id="LoiCap2" from="${ErrorList.executeQuery('from ErrorList e where e.ord=2 and e.status>=0 order by e.code+0')}"
                            optionKey="id"
   	    					optionValue="name" value="${LoiCap2}"
   	     					noSelection="${['':'']}" />
   	    
   	    <g:select name="LoiCap3" id="LoiCap3" from="${ErrorList.executeQuery('from ErrorList e where e.ord=3 and e.status>=0 order by e.code+0')}"
							optionKey="id" optionValue="name" value="${LoiCap3}" noSelection="${['':'']}"/>
   	    	
<%--		<g:select name="LoiCap3" id="LoiCap3" style="width:120px" from="${allErrorList3}"--%>
<%--							optionKey="id" />--%>
		<label class="error-label-left" style="width:90px !important"><g:submitButton class="searchButtons btn primary" style="margin-left:0px;margin-top:0px;width:100px" name="search" value="Lọc thông tin" /></label>
	</li>
<!-- Lable Hàng 2 -->
   <li>
   		<label class="label-left" style="width:152px" for="NHCD">NHCD/Khối Nhập</label>
   		<label class="label-left" style="width:115px" for="CN">CN/Trung tâm nhập</label>
   		<label class="label-left" style="width:118px" for="PGD">PGD/Tổ/Nhóm nhập</label>
   		<label class="label-left" style="width:115px" for="HTPH">Hình thức phát hiện</label>
   		<label class="label-left" style="width:115px" for="LoaiNghiepVu">Loại nghiệp vụ</label>
   		<label class="label-left" style="width:80px" for="NguoiNhap">User nhập</label>
   		
 	
  </li> 
  		
   <li>
   		<sec:ifAllGranted roles="ROLE_GDTT">
	   	<g:select style="width:155px"  name="NHCD" from="${unitDepart1Nhap}"
	   						disabled="true"
							value="${tenDonVi1 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}" />
  		
  		<g:select  name="CN" id="CN" style="width:120px" from = "${unitDepart2Nhap }" value="${tenDonVi2 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']} disabled="true"/>			
   		<g:select name="PGD" id="PGD" style="width:120px" from = "${unitDepart3Nhap }" value="${tenDonVi3 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']} disabled="true"/>   
		</sec:ifAllGranted>
		<sec:ifAnyGranted roles="ROLE_GDTT_LEVEL2">
	   	<g:select style="width:155px"  name="NHCD" from="${unitDepart1Level2}"
							value="${tenDonVi1 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}" disabled="true"/>
  		<g:select  name="CN" id="CN" style="width:120px" from="${unitDepart2Level2 }" value="${tenDonVi2 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}" disabled="true"/>			
   		<g:select name="PGD" id="PGD" style="width:120px" from="${unitDepart3Level2}" value="${tenDonViNhap3}" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}"/>   
		</sec:ifAnyGranted>
		<sec:ifAllGranted roles="ROLE_GDTT_LEVEL3">
	   	<g:select style="width:155px"  name="NHCD" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0  order by e.code+0')}"
	   						disabled="true"
							value="${tenDonVi1 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}" />
  		<g:select  name="CN" id="CN" style="width:120px" from="${unitDepart2Level3 }" value="${tenDonViNhap2 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}"/>			
   		<g:select name="PGD" id="PGD" style="width:120px" from="${unitDepart3Level3 }" value="${tenDonViNhap3 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}"/>   
		</sec:ifAllGranted>
		
	 	<sec:ifNotGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4">
   		<g:select style="width:155px" name="NHCD" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0')}"
							value="${tenDonVi1 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}" />


							
  		<g:select  name="CN" id="CN" style="width:120px" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')}"
  				 value="${tenDonVi2}" optionKey="id" optionValue="${{it.code +' - '+it.name }}"  noSelection="${['':'']}" />			

   		<g:select name="PGD" id="PGD" style="width:120px" from="${allUnitDepart3}" value="${tenDonVi3 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}"/>
    	</sec:ifNotGranted>
    	
    	<sec:ifAllGranted roles="ROLE_GDTT_LEVEL4">
   		<g:select style="width:155px" name="NHCD" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0')}"
							value="${tenDonViNhap1}" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}" />
  		<g:select  name="CN" id="CN"   style="width:120px" from="${ unitDepart2Level4}" value="${tenDonViNhap2}" optionKey="id" optionValue="${{it.code +' - '+it.name } }"/>			
   		<g:select name="PGD" id="PGD" style="width:120px" from="${unitDepart3Level4}" value="${tenDonViNhap3 }" optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}"/>
    	</sec:ifAllGranted>
   
     	<g:select style="width:120px" name="HTPH" from="${ErrorCheck.executeQuery('from ErrorCheck e where e.status>=0 order by e.code+0 ')}"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}" value="${HTPH}" />
		<g:select style="width:120px" name="LoaiNghiepVu" value = "${LoaiNghiepVu }" id="LoaiNghiepVu" from="${ErrorCategory.executeQuery('from ErrorCategory e where e.status>=0 order by e.code+0')}"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"/>	
   		<input type="text" name="NguoiNhap" style="width:90px" value="${NguoiNhap}">

							
   			
   </li>
<!-- Lable Hàng3 -->   	
   <li>
   		<label class="label-left" style="width:152px" for="NHCDLoi">NHCD/Khối lỗi</label>
   		<label class="label-left" style="width:115px" for="CNLoi">CN/Trung tâm lỗi</label>
   		<label class="label-left" style="width:115px" for="PGDLoi">PGD/Tổ/Nhóm lỗi</label>
   		<label class="label-left" style="width:115px" for="NguoiGayLoi">User lỗi</label>
   		<label class="label-left" style="width:115px" for="TrangThai">Trạng thái</label>   			
   		<label class="label-left" style="width:80px" for="IdNhanSu">ID nhân sự</label>
   </li>
   <li>   		   
   		<g:select style="width:155px" name="NHCDLoi" id= "NHCDLoi" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0')}" 
							value="${tenDonVi1Loi}" optionKey="id" optionValue="${{it.code+'-'+it.name} }" noSelection="${['':'']}" />						
			 				
<%--   		<g:select   name="CNLoi" id="CNLoi" form="${errorManagement}" value="${ tenDonVi2Loi }" optionKey="id"  style="width:120px"/> --%><%--
			
			<g:select name="CNLoi" id="CNLoi" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')}" 
							optionKey="id" value="${tenDonVi2Loi }"  optionValue="${{it.code+'-'+it.name}}" style="width:120px" noSelection="${['':'']}"/>
 
   		--%>
   		
   		<g:select name="CNLoi" id="CNLoi" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')}" 
   				optionKey="id" value="${tenDonVi2Loi }"  optionValue="${{it.code+'-'+it.name}}"  noSelection="${['':'']}" style="width:120px"/>
   		
   		
   		<g:select  name="PGDLoi" id="PGDLoi" style="width:120px" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')}"  
   	      					value = "${tenDonVi3Loi }"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}" />
   		
   		 
   		
   		
   		<input type="text" name="NguoiGayLoi" style="width:110px" value="${NguoiGayLoi }" />		
		<g:select style="width:120px" name="TrangThai" value="${TrangThai }" id="TrangThai" from="${ErrorStatus.executeQuery('from ErrorStatus e where e.status>=0 order by e.code+0')}"
							optionKey="id" optionValue="${{it.code+'-'+it.nameStatus}}" noSelection="${['':'']}"/>
	 
		<input type="text" name="IdNhanSu" style="width:90px" value="${IdNhanSu}">	
   </li>		
 
   </ol>
   
 
 
 		<script type="text/javascript">
 	
	$("document").ready( function(){

 
		var quantity = 0;
		var options = '';
		 
			  $("#LoiCap1").change(function(){
				$("select[name=LoiCap2]").html("");
				$("select[name=LoiCap3]").html("");
				var options = "<option ></option>";
				var index=$(this).val();	
				var loi2=${LoiCap2?LoiCap2:'2354'};		
				$.getJSON('${createLink(controller:'opError',action:'getErrorList2')}?parent_id='+index,function(errorList2){
					
					if(errorList2!=-1)
						{						
							for(var i=0;i<errorList2.length;i++)
							{	 
	 
									if(errorList2[i].id.toString()==loi2)
									{
									 		 
											options += "<option selected='selected' value='" + errorList2[i].id  + "'>" +errorList2[i].code+'-'+errorList2[i].name + "</option>";
									}
									else
										options += "<option value='" + errorList2[i].id  + "'>" +errorList2[i].code+'-'+ errorList2[i].name + "</option>";
							 
							}
										
						}
					$("select#LoiCap2").html(options);});													
				
			    });
			  
				
  			    $("#LoiCap2").change(function(){
					
  			    	var options = "<option ></option>";
  			    	var index=$(this).val();
  			  		if(index==null)
						index=${LoiCap2?LoiCap2:'9999'};
				
					var loi3=${LoiCap3?LoiCap3:'9999'};	
					
					$.getJSON('${createLink(controller:'opError',action:'getErrorList3')}?parent_id='+index,function(errorList3){	
						
						if(errorList3!=-1)
							{				
									
								for(var i=0;i<errorList3.length;i++)
								{
								
									if(loi3!=null)
										{
											if(errorList3[i].id.toString()==loi3)
											{
													options += "<option selected='selected' value='" + errorList3[i].id  + "'>" +errorList3[i].code+'-'+ errorList3[i].name + "</option>";
											}
											else
												options += "<option value='" + errorList3[i].id  + "'>" + errorList3[i].code+'-'+errorList3[i].name + "</option>";
										}
								}
											
							}
						$("select#LoiCap3").html(options); });
										
				    });
  				 
  			  $("select[name=LoiCap2]").change(function(){
					
					if ($(this).val()){
					
					
						$.post('${createLink(controller:'errorAdmin',action:'getChildNodes')}/LoiCap2',
							$("form[name=reportForm]").serialize(),function(data){
								$("select[name=LoiCap3]").html(data);
		               	});
		               	
		               		$.post('${createLink(controller:'errorAdmin',action:'getFirstNodesFromLevel2')}/LoiCap2',
							$("form[name=reportForm]").serialize(),function(data){
								$("select[name=LoiCap1]").html(data);
		               	});
		               	
					} else{
						//$("select[name=PGDLoi]").html("");
					}
					
				});
  	//chon loi cap3 se tu dong chon cap 1 va 2
  				$("select[name=LoiCap3]").change(function(){
					 
					if ($(this).val()){
						$.post('${createLink(controller:'errorAdmin',action:'getParentNodes')}/LoiCap3',
							$("form[name=reportForm]").serialize(),function(data){
								$("select[name=LoiCap2]").html(data);
		               	});
		               	
		               	$.post('${createLink(controller:'errorAdmin',action:'getFirstNodes')}/LoiCap3',
							$("form[name=reportForm]").serialize(),function(data){
								$("select[name=LoiCap1]").html(data);
		               	});
					} 
					
			});

					
				$("#NHCD").change(function(){
					//$("select[name=CN]").html("");
					$("select[name=PGD]").html("");
							var options = "<option ></option>";
							var index=$(this).val();
							var tenDV2=${tenDonVi2?tenDonVi2:'1345353'};						
				 								
							$.getJSON('${createLink(controller:'opError',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart2){
									for(var i=0;i<unitDepart2.length;i++)
									{
									
										if(unitDepart2[i].id.toString()==tenDV2)
										{
											
											options += "<option selected='selected' value='" + unitDepart2[i].id + "'>" +unitDepart2[i].code +'-'+ unitDepart2[i].name + "</option>";
										}
										else												
											options += "<option value='" + unitDepart2[i].id + "'>" +unitDepart2[i].code +'-'+ unitDepart2[i].name + "</option>";											 
									}													
									
								$("select#CN").html(options); });
								
															
						});
<%--						$("#NHCD").change();--%>

					$("#CN").change(function(){
						
						var options = "<option ></option>";
						var index=$(this).val();
						if(index==null)
							index=${tenDonVi2?tenDonVi2:'12312312'};
																								
						var tenDV3 = ${tenDonVi3?tenDonVi3:'123456'};	
						var tenDV2="123456";
						$.getJSON('${createLink(controller:'opError',action:'getIdUnitDepart1')}?parent_id='+index,function(currIdLevel1){
							tenDV2=currIdLevel1;


							var options1= "<option ></option>";
							$.getJSON('${createLink(controller:'opError',action:'getUnitDepart1')}?parent_id='+index,function(unitDepart1){
								for(var i=0;i<unitDepart1.length;i++)
									{		
										
										if(unitDepart1[i].id.toString()==tenDV2)
										{
											
											options1 += "<option  selected = 'selected' value='" + unitDepart1[i].id  + "'>" +unitDepart1[i].code+'-'+ unitDepart1[i].name + "</option>";
										}
										else																
										options1 += "<option value='" + unitDepart1[i].id  + "'>" +unitDepart1[i].code+'-'+ unitDepart1[i].name + "</option>";
									}													
								
							$("select#NHCD").html(options1); });//END JSON
							
						
						});//END JSON getIdUnitDepart1
						

						
										
						$.getJSON('${createLink(controller:'opError',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart3){
								for(var i=0;i<unitDepart3.length;i++)
									{		
															
										if(unitDepart3[i].id.toString()==tenDV3)
										{	
											
											options += "<option selected = 'selected' value = '"+unitDepart3[i].id+"'>"+unitDepart3[i].code+'-'+unitDepart3[i].name+"</option>";																						 
										}else
											options += "<option value='" + unitDepart3[i].id  + "'>" +unitDepart3[i].code+'-'+ unitDepart3[i].name + "</option>";
									}													
								
							$("select#PGD").html(options); });		
						 					
					});
<%--					$("#CN").change();--%>
					$("select[name=CN]").change(function(){
						
						if ($(this).val()){
						
						$("select[name=NHCD]").html("");
						$("select[name=PGD]").html("");
							
							
							$.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/CN',
								$("form[name=reportForm]").serialize(),function(data){
									$("select[name=PGD]").html(data);               	});
									
							$.post('${createLink(controller:'unitDepartment',action:'getFirstNodesFromLevel2')}/CN',
							$("form[name=reportForm]").serialize(),function(data){
									$("select[name=NHCD]").html(data); 	});
						} 
					
					});
//chon don vi nhap cap3 hien ra cap 2 va 1	
					$("select[name=PGD]").change(function(){
				
					 if ($(this).val()){
					
						$("select[name=CN]").html("");
						$("select[name=NHCD]").html("");
					
						$.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/PGD',
							$("form[name=reportForm]").serialize(),function(data){
								$("select[name=CN]").html(data);
	               		});
	               	
	               	
	               		$.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/PGD',
						$("form[name=reportForm]").serialize(),function(data){
							$("select[name=NHCD]").html(data);
	               		});
	               	
	               	 } 					
			 		});

					  $("#NHCDLoi").change(function(){
						  	$("select[name=CNLoi]").html("");
							$("select[name=PGDLoi]").html("");	
						  	var options = "<option ></option>";
							var index=$(this).val();
							var tenDV2=${tenDonVi2Loi?tenDonVi2Loi:'1345353'};						
											
							$.getJSON('${createLink(controller:'opError',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart2){
									for(var i=0;i<unitDepart2.length;i++)
									{
									
										if(unitDepart2[i].id.toString()==tenDV2)
										{
											
											options += "<option selected='selected' value='" + unitDepart2[i].id + "'>" + unitDepart2[i].code+'-'+unitDepart2[i].name + "</option>";
										}
										else												
											options += "<option value='" + unitDepart2[i].id + "'>" +unitDepart2[i].code+'-'+ unitDepart2[i].name + "</option>";											 
									}													
									
								$("select#CNLoi").html(options); });//END JSON						
								
						});//END FUNCTIOn
					 
						
					  $("#CNLoi").change(function(){

						  var options = "<option ></option>";
						  
							var index=$(this).val();
							if(index==null)
								index=${tenDonVi2Loi?tenDonVi2Loi:'12312312'};

																								
							var tenDV3 = ${tenDonVi3Loi?tenDonVi3Loi:'123456'};	
							var tenDV2="123456";

							$.getJSON('${createLink(controller:'opError',action:'getIdUnitDepart1')}?parent_id='+index,function(currIdLevel1){
								tenDV2=currIdLevel1;


								var options1= "<option ></option>";
								$.getJSON('${createLink(controller:'opError',action:'getUnitDepart1')}?parent_id='+index,function(unitDepart1){
									for(var i=0;i<unitDepart1.length;i++)
										{		

											
											if(unitDepart1[i].id.toString()==tenDV2)
											{
												
												options1 += "<option  selected = 'selected' value='" + unitDepart1[i].id  + "'>" +unitDepart1[i].code+'-'+ unitDepart1[i].name + "</option>";
											}
											else																
											options1 += "<option value='" + unitDepart1[i].id  + "'>" +unitDepart1[i].code+'-'+ unitDepart1[i].name + "</option>";
										}													
									
								$("select#NHCDLoi").html(options1); });//END JSON
								
							
							});//END JSON getIdUnitDepart1
																	
							
							
							
											
							$.getJSON('${createLink(controller:'opError',action:'getUnitDepart2')}?parent_id='+index,function(unitDepart3){
									for(var i=0;i<unitDepart3.length;i++)
										{		
																
											if(unitDepart3[i].id.toString()==tenDV3)
											{	
												
												options += "<option selected = 'selected' value = '"+unitDepart3[i].id+"'>"+unitDepart3[i].code+'-'+unitDepart3[i].name+"</option>";																						 
											}else
												options += "<option value='" + unitDepart3[i].id  + "'>" +unitDepart3[i].code+'-'+ unitDepart3[i].name + "</option>";
										}//End-for													

								$("select#PGDLoi").html(options); });//END JSON
								
														
					


							});//END FUNCTION
				
				
					//chon Don vi loi cap3 se tu dong chon cap 1,2
					$("select[name=PGDLoi]").change(function(){
					
					if ($(this).val()){
						
						$("select[name=CNLoi]").html("");
						$("select[name=NHCDLoi]").html("");
						
							$.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/PGDLoi',
							$("form[name=reportForm]").serialize(),function(data){
								$("select[name=CNLoi]").html(data);
		               	});
		               	
		               	
		               	$.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/PGDLoi',
							$("form[name=reportForm]").serialize(),function(data){
								$("select[name=NHCDLoi]").html(data);
		               	});
		               	
		               }					
				});					

   //						
 	  
	});
	</script>