<ol class="form form-clear error-form" style="margin-top:-15px">
     <%def today = new Date();
            today.setMonth(today.month-6);
            %>
   
   <li>
   	<label class="label-left" style="width:152px" for="PGD">PGD/Tổ/Nhóm nhập</label>

   	<label class="label-left" style="width:150px" for="NguoiNhap">User nhập</label>

   	<label class="label-left" style="width:140px" for="PGDLoi">PGD/Tổ/Nhóm lỗi</label>
   	<label class="label-left" style="width:140px" for="LoaiNghiepVu">Loại nghiệp vụ</label>
   	<label class="label-left" style="width:100px" for="NguoiGayLoi">User lỗi</label>
   
   </li>
   <li>
   
<%--   <sec:ifAllGranted roles="ROLE_GDTT1">--%>
<%--	   	<g:select name="PGD" id="PGD" style="width:155px" from="${UnitDepart.executeQuery('from UnitDepart t where t.status>0 and t.ord=3 order by t.code+0') }" --%>
<%--				disabled="true"--%>
<%--				optionKey="id"--%>
<%--   				value="${TenDonVi3_GDTT}" --%>
<%--   				optionValue="${{it.code+'-'+it.name}}" noSelection="${['':''] }"/>--%>
<%--   				--%>
<%--   				--%>
<%----%>
<%--		</sec:ifAllGranted>--%>
<%--		<sec:ifAllGranted roles="ROLE_GDTT_LEVEL21">--%>
<%--	   		<g:select name="PGD" id="PGD" style="width:155px" from="${unitDepart}"--%>
<%--				--%>
<%--				optionKey="id"--%>
<%--   				value="${tenDonVi3}" --%>
<%--   				optionValue="${{it.code+'-'+it.name}}" --%>
<%--   				noSelection="${['':''] }"/>--%>
<%--		</sec:ifAllGranted>--%>
<%--		<sec:ifAllGranted roles="ROLE_GDTT_LEVEL31">--%>
<%--	   		<g:select name="PGD" id="PGD" style="width:155px" from="${unitDepart}"--%>
<%--				--%>
<%--				optionKey="id"--%>
<%--   				value="${tenDonVi3}" --%>
<%--   				optionValue="${{it.code+'-'+it.name} }" --%>
<%--   				noSelection="${['':''] }"/>--%>
<%--		</sec:ifAllGranted>--%>
		
	 	<sec:ifAnyGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_CVQLRR">
   		<g:select name="PGD" id="PGD" style="width:155px" from="${UnitDepart.executeQuery('from UnitDepart t where t.status>0 and t.ord=3 order by t.code+0') }" 				
				optionKey="id"
   				value="${tenDonVi3}" 
   				optionValue="${{it.code+'-'+it.name} }" noSelection="${['':''] }"/>
		</sec:ifAnyGranted>
    	
    	
    	
		
					
   		<input type="text" name="NguoiNhap" style="width:145px" value="${NguoiNhap}">
		<g:select name="PGDLoi" id="PGDLoi" style="width:145px" from="${UnitDepart.executeQuery(' from UnitDepart t where t.status>0 and t.ord = 3 order by t.code+0') }" 
				optionKey="id"
				value="${tenDonVi3Loi }" 
				optionValue="${{it.code+'-'+it.name} }" 
				noSelection="${['':''] }"/>
   		<g:select style="width:145px" name="LoaiNghiepVu" from="${ErrorCategory.executeQuery(' from ErrorCategory t where t.status>0 order by t.code+0')}" value="${LoaiNghiepVu }" 
   					 	optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}" /> 
   		<input type="text" name="NguoiGayLoi" style="width:120px" value="${NguoiGayLoi }" /> 

   </li>
   
   <li>
   		
   			<label class="label-left" style="width:72px" for="fromDate">Từ ngày</label>
   			<label class="label-left"  style="width:72px" for="toDate">Đến ngày</label>
   			<label  class="label-left" style="width:150px" for="KieuNgay">Kiểu ngày</label>

   			<label class="label-left" style="width:140px" for="LoiCap3">Nhóm lỗi mức 3</label>
   			<label class="label-left" style="width:140px" for="TrangThai">Trạng thái</label>
   			 
   		
  </li> 
  		
   <li>		
   			<input style="width:65px" name="fromDate" id="fromDate" class=" datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/></label>
   			<input name="toDate" id="toDate" style="width:65px" class=" datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/></label>
   			
   			<select name="KieuNgay" style="width:155px" class="disableCombobox">
				  <option value="1" ${kieuNgay=='1'?'selected="true"':'' }>1-Ngày xảy ra</option>
				  <option value="2" ${kieuNgay=='2'?'selected="true"':'' }>2-Thời hạn khắc phục</option>
				  <option value="3" ${kieuNgay=='3'?'selected="true"':'' }>3-Thời gian nhập hệ thống</option>
				  
			</select>
		  <g:select name="LoiCap3" id="LoiCap3" style="width:145px" from="${ErrorList.executeQuery('from ErrorList t where t.status>=0 and t.ord=3 order by t.code+0') }" 
		  					value="${LoiCap3 }"	optionKey="id" optionValue="${{it.code+'-'+it.name} }" noSelection="${['':''] }"/>			
		  <g:select style="width:145px" name="TrangThai" value="${TrangThai }" id="TrangThai" from="${ErrorStatus.executeQuery('from ErrorStatus t where t.status>=0 order by t.code+0')}"
							optionKey="id" optionValue="${{it.code+'-'+it.nameStatus} }" noSelection="${['':'']}"/>
							 
			<label class="error-label-left" style="width:130px !important"><g:submitButton class="searchButtons btn primary" style="margin-left:0px;margin-top:0px;width:132px" name="search" value="Lọc thông tin" /></label>					
							
							
   			
   </li>			


   				
   </ol>
   
 
 
 		<script type="text/javascript">
 	
	$("document").ready( function(){
		$(".disableCombobox").attr('disabled','true');
	});

	

	</script>