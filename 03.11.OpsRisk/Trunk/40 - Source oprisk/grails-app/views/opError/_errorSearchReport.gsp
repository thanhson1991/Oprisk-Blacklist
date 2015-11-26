   
      
   <ol class="form form-clear error-form" style="margin-top:-15px">
     <%def today = new Date();
            today.setMonth(today.month-6);
            %>
   <li>
   		
   			<label class="label-left" style="width:105px" for="fromDate">Từ ngày:</label>
   			<label class="label-left"  style="float:none;width:105px" for="toDate">Đến ngày:</label>
   			  <label  class="error-label-left" style="width:150px !important" for="nguoigayloi">Kiểu ngày:</label>
   			<label  class="error-label-left" style="float:none;width:150px !important" for="unitDepart">Đơn vị:</label>
   			 <label class="error-label-left" style="width:150px !important" for="nguoigayloi">Người gây lỗi:</label>
   		
  </li> 		
   <li>		
   			<label class="label-left" style="width:105px"><input style="margin-right:99px;width:85px" name="fromDate" id="fromDate" class=" datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/></label>
   			<label class="label-left" style="width:105px"><input name="toDate" id="toDate" style="width:85px" class=" datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/></label>
   			<label class="error-label-left" style="width:150px !important">
   			<select name="KieuNgay" style="width:150px">
				  <option value="1" ${kieuNgay=='1'?'selected="true"':'' }>Ngày xảy ra</option>
				  <option value="2" ${kieuNgay=='2'?'selected="true"':'' }>Thời hạn khắc phục</option>
				  <option value="3" ${kieuNgay=='3'?'selected="true"':'' }>Thời gian nhập hệ thống</option>
				  
				</select> 
   			</label>
   			<label class="error-label-left" style="width:150px !important"><g:select class="se-xl" style="width:150px !important" name="unitDepart" id="unitDepart" from="${unitDepart}" optionKey="id" optionValue="${{it.code +'-'+it.name}}" value="${unitD}" noSelection="${['':'Tất cả']}"/></label>
   			<label class="error-label-left" style="width:150px !important"><input style="width:150px !important" class="e-l" name="nguoigayloi" id="nguoigayloi" type="text" value="${nguoigayloi }"/></label>
   </li>			
   <li>		
   		
   		
   		
   			<label class="error-label-left"  for="loailoi1">Loại lỗi cấp 1:</label>
   			<label class="error-label-left" style="width:150px !important"  for="loailoi2">Loại lỗi cấp 2:</label>
   			 <label class="error-label-left" for="trangthai" style="width:150px !important">Trạng thái lỗi:</label>
   			 
   		
   </li>
   <li>		
   		
   		
   			<label class="error-label-left"><g:select class="validate[required]" name="LoiCap1" from="${errorlist1}"
							optionKey="id" optionValue="name" noSelection="${['':'']}"
							value="${loicap1}" /></label>
   			 <label class="error-label-left" style="width:150px !important"> <select style="width:150px !important" name="LoiCap2" id="LoiCap2" class="validate[required]"></select></label>
   			  <label class="error-label-left" style="width:150px !important">  <g:select style="width:150px !important" class="validate[required]" name="trangthai" from="${errorStatus}" 
							optionKey="id" optionValue="nameStatus" noSelection="${['':'Tất cả']}" value="${trangthai }"
							 /></label>
			
   			<label class="error-label-left" style="width:150px !important"><g:submitButton class="searchButtons btn primary" style="margin-left:0px;margin-top:0px" name="search" value="Xem" /></label>
   			
   		
   		
   	
   		
   	
   		
   </li>
   
   
  
   </ol>
   
 
 
 		<script type="text/javascript">
 	
	$("document").ready( function(){

		 
		var quantity = 0;
		var options = '';
		 
			  $("#LoiCap1").change(function(){
				
				options = "<option ></option>";
				var index=$(this).val();
				
				var loi2=${loicap2?loicap2:'123'};
			
				$.getJSON('${createLink(controller:'opError',action:'getErrorList2')}?parent_id='+index,function(errorList2){	
					
					if(errorList2!=-1)
						{
						
							for(var i=0;i<errorList2.length;i++)
							{

								if(loi2!=null)
								{
									if(errorList2[i].id.toString()==loi2)
									{
											options += "<option selected='selected' value='" + errorList2[i].id  + "'>" + errorList2[i].name + "</option>";
									}
									else
										options += "<option value='" + errorList2[i].id  + "'>" + errorList2[i].name + "</option>";
								}
								else
									options += "<option value='" + errorList2[i].id  + "'>" + errorList2[i].name + "</option>";						
								 
							}
										
						}
					$("select#LoiCap2").html(options);
					
					
				});
				
			    });

				  $("#LoiCap1").change(); 
			  
	});
	</script>