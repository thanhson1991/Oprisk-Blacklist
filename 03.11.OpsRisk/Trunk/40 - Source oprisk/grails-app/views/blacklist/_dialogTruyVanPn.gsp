<ol class="form form-clear error-form" style="margin-top:-15px">
     <%def today = new Date();
            today.setMonth(today.month-1);
            %>
   
   <li>
   	<label class="label-left" style="width:180px;margin-right: -5px;margin-top: 10px" for="giayphepPnBL">Số ĐKKD/Giấy phép đầu tư</label>
   	<label class="label-left" style="width:150px;margin-right: 20px;" for="tenPnBL">Tên doanh nghiệp</label>
   	<label class="label-left" style="width:180px;margin-right: 10px;" for="ngaycapPnBL">Ngày cấp(DD/MM/YYYY)</label>
   </li>
   <li>
   	<input type="text" name="giayphepPnBL" style="width:150px;margin-right: 20px;" value="${params.giayphepPnBL }">
   	<input type="text" name="tenPnBL" style="width:145px;margin-right: 20px;" value="${params.tenPnBL }">
   	 <input class="datetime" name="ngaycapPnBL" style="width:145px" value="${params.ngaycapPnBL}" readonly="readonly">
   </li>
   <li>
   <label class="label-left" style="width:190px;margin-right: -10px;" for="cmndPnBL">CMND/Hộ chiếu người đại diện</label>
    <label class="label-left" style="width:180px;margin-right: -10px;margin-top: 10px" for="phapluatPnBL">Người đại diện pháp luật</label>
   </li>
   <li>
   	<input type="text" name="cmndPnBL" style="width:150px;margin-right: 20px;" value="${params.cmndPnBL }">
   	<input type="text" name="phapluatPnBL" style="width:325px;margin-right: 10px;" value="${params.phapluatPnBL }">
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