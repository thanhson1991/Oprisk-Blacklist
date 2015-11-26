<ol class="form form-clear error-form" style="margin-top:-15px">
     <%def today = new Date();
            today.setMonth(today.month-1);
            %>
   
   <li>
    <%--<label class="label-left" style="width:70px;margin-right: 20px" for="fromDate">Từ ngày:</label>
    <label class="label-left"  style="float:none;width:70px;margin-right: 20px" for="toDate">Đến ngày:</label>
   	--%><label class="label-left" style="width:152px;margin-right: 10px;margin-top: 10px" for="cmndCn">CMND/Hộ chiếu</label>
   	<label class="label-left" style="width:150px;margin-right: 10px;" for="tenCn">Họ và tên</label>
   	<label class="label-left" style="width:140px" for="ngaysinhCnBL">Ngày sinh</label>
   </li>
   <li> 
 	<input type="text" name="cmndCnBL" style="width:145px;margin-right: 10px;" value="${params.cmndCn }">
   	<input type="text" name="tenCnBL" style="width:145px;margin-right: 10px;" value="${params.tenCnBL }">
   	<input class="datetime" name="ngaysinhCnBL" style="width:145px" value="${params.ngaysinhCnBL}" readonly="readonly">
   	<sec:ifAnyGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
   	<label class="error-label-left">
   	<g:submitButton class="searchButtons btn primary" style="margin-left:10px;margin-top:0px;width:132px" name="search" value="Tra cứu Blacklist" /></label>
   	</sec:ifAnyGranted>
   </li>
   </ol>
<script type="text/javascript">
	
	$("document").ready( function(){
		 set_side_bar(true);
	});
</script>