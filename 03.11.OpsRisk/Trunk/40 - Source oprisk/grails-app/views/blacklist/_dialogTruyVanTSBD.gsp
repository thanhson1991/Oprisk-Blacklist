<ol class="form form-clear error-form" style="margin-top:-15px">
     <%def today = new Date();
            today.setMonth(today.month-1);
            %>
   
   <li>
   	<label class="label-left" style="width:152px;margin-right: 20px;margin-top: 10px" for="loaiTsBL">Loại tài sản</label>
   	<label class="label-left"  style="width:180px;margin-right: -6px;" for="thongtinTsBL">Thông tin nhân diện tài sản</label>
   	<label class="label-left" style="width:140px;margin-right: 33px" for="motaTsBL">Mô tả tài sản</label>
   </li>
   <li>
	<g:select style="width:160px;margin-right: 20px;" name="loaiTsBL" id="loaiTsBL" 
						from="${BlacklistTaiSan.executeQuery('from BlacklistTaiSan ts where ts.status>=0 order by ts.code+0') }" 
						optionKey="id" 
						optionValue="${{it.code+'-'+it.name}}"
						value="${loaiTsBLId}" 
						noSelection="${['':'Tất cả']}"
						/>
						
   	<input type="text" data-toggle="tooltip" name="thongtinTsBL" style="width:145px;margin-right: 20px;" value=""
   					title="- Đối với BĐS: seri sổ đỏ, số quyết định
- Đối với phương tiện vận tải: Số đăng ký xe, số khung, số máy
- Đối với Tiền gửi/GTCG: số seri thẻ tiết kiệm
- Đối với công cụ chuyển nhượng: số seri trên công cụ chuyển nhượng
- Đối với hàng hóa: tên hàng hóa
- Đối với bảo lãnh ngân hàng: bảo lãnh của Ngân hàng “(Tên Ngân hàng)”
   		"	
   						>
   	<input type="text" name="motaTsBL" style="width:145px;margin-right: 20px;" value="">
   	
   </li>
   <li>
   	<label class="label-left" style="width:140px;margin-right: 35px" for="cmtcshTsBL">CMND chủ sỡ hữu</label>
   	<label class="label-left" style="width:140px" for="sohuuTsBL">Chủ sở hữu</label>
   </li>
   <li>
   	<input type="text" name="cmtcshTsBL" style="width:150px;margin-right: 20px" value="">
   	<input type="text" name="sohuuTsBL" style="width:325px" value="">
   	<sec:ifAnyGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
   	<label class="error-label-left"><g:submitButton class="searchButtons btn primary" style="margin-left:20px;margin-top:0px;width:132px" name="search" value="Tra cứu Blacklist" /></label>
   	</sec:ifAnyGranted>
   </li>
   </ol>
<script type="text/javascript">
	
	$("document").ready( function(){
		 set_side_bar(true);
	});
</script>