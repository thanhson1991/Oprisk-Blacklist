<%pac %>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
  <meta name="layout" content="m-melanin-layout" />
    <title>Lỗi</title>
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
			<sec:ifAnyGranted roles="ROLE_GDTT_LEVEL4">
            	<g:render template="errorsidebarLevel2"/>
            </sec:ifAnyGranted>
            <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL3">
            	<g:render template="errorsidebarLevel2"/>
            </sec:ifAnyGranted>
            
            <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL2">
            	<g:render template="errorsidebarLevel2"/>
            </sec:ifAnyGranted>
 
            <sec:ifNotGranted roles="ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4">
            	<g:render template="errorsidebar"/>
            </sec:ifNotGranted>
            
            
		</div>
	<div id="m-melanin-main-content">
	<g:form method="post" name="errorManaListForm" controller="opError" action="saveErrorManaList" enctype="multipart/form-data">
  	
   <fieldset class="info">
     <legend>Nhập thông tin lỗi</legend>
 
  <ol class="form form-clear olCenter" id="incidentField">
  <g:if test="${flash.message}">
		<li>
			<div class="${flash.messageType}">${flash.message}</div>
		</li>
	</g:if>  

	<sec:ifAnyGranted roles="ROLE_GDTT">
		 <g:hiddenField name="ROLES" value="GDTT"/>				
   </sec:ifAnyGranted>
   <sec:ifAllGranted roles="ROLE_GDTT_LEVEL2">
   		<g:hiddenField name="ROLES" value="GDTTL2"/>
   </sec:ifAllGranted>
	<sec:ifAllGranted roles="ROLE_GDTT_LEVEL3">
   		<g:hiddenField name="ROLES" value="GDTTL3"/>
   </sec:ifAllGranted>
   	<sec:ifAllGranted roles="ROLE_GDTT_LEVEL4">
   		<g:hiddenField name="ROLES" value="GDTTL4"/>
   </sec:ifAllGranted>
   
   
   <table class="tableControlCenter" style="border:0px !important">
	   	<tr style="border:0px ;">
	   		<td style ="border:0px"><label for="TenDonVi3" class=" lableTableCenter">PGD/Phòng/Nhóm gây lỗi<font color="red">*</font> </label></td>
			<td style ="border:0px"><label for="TenDonVi2" class=" lableTableCenter">CN/Trung tâm/Phòng<font color="red">*</font> </label></td>	   
	   	    <td style ="border:0px"><label for="TenDonVi1" class=" lableTableCenter">NH Chuyên doanh/Khối<font color="red">*</font> </label></td>
	   	</tr>
	   	<tr style="border:0px ;">
	   	      <td style ="border:0px"><g:select name="TenDonVi3" from="${unitDepart3}" 
	   	      							optionKey="id" optionValue="${{it.code+'-'+it.name}}"  noSelection="${['':'']}" 
	   	      							id="TenDonVi3" class="validate[required]  controlComboboxTableCenter" /></td>	
	   	         	       	     
	   	      <td style ="border:0px"><g:select name="TenDonVi2" id="TenDonVi2" from="${unitDepart2}" class=" validate[required]  controlComboboxTableCenter"
	   	      						 optionKey="id" optionValue="${{it.code +'-'+it.name}}" noSelection="${['':'']}" /></td>		
			  <td style ="border:0px"><g:select  name="TenDonVi1" from="${unitDepart}" class="  validate[required] controlComboboxTableCenter"
								optionKey="id" optionValue="${{it.code +'-'+it.name}}" noSelection="${['':'']}" /></td>			   	       	
		</tr>	
	</table>	
	<li>
 		<table class="tableControlCenter" style="border:0px !important">
 			<tr style ="border:0px">
 				<td style ="border:0px"><label for="errorCheck" class="lableTableCenter ">Hình thức phát hiện<font color="red">*</font> </label></td>
 				<td style ="border:0px"><label for="SoLuongKiemTra" class="lableTableCenter">Số lượng sai phạm</label></td>
 				<td style ="border:0px"><label for="TongSoChonMau" class="lableTableCenter">Tổng số chọn mẫu</label></td>
 				
 			</tr>
 			<tr style="border:0px ">
 				<td><g:select class="controlComboboxTableCenter validate[required]" name="errorCheck" from="${errorCheck}"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"/></td>
 				<td style="border:0px "><input type= "text" id = "SoLuongKiemTra" name="SoLuongKiemTra" value="1" class = "controlTableCenter  onlyNumber2 textRight"></input></td>
 				<td style="border:0px "><input type= "text" id = "TongSoChonMau" name="TongSoChonMau" class = "controlTableCenter price"></input></td>
 				
 			</tr>
 		</table>
 	</li>
  <%-- <sec:ifNotGranted roles="ROLE_GDTT">			
   
    <li>
   	      <label for="TenDonVi" class="lableCenter ">Nhập tên đơn vị<font color="red">*</font> </label>
   	      <br>
   	      <g:select  name="TenDonVi" from="${unitDepart}" class="largeControlCenter largeControlCenterSelect validate[required]"
							optionKey="id" optionValue="${{it.code +' - '+it.name}}" noSelection="${['':'']}" />
   </li>  
   </sec:ifNotGranted>
    <li>
   	      <label for="errorType" class="lableCenter ">Kiểu lỗi </label>
   	      <br>
   	      <g:select  name="errorType" from="${errorType}" class="largeControlCenter largeControlCenterSelect"
							optionKey="id" optionValue="name" noSelection="${['':'']}" />
   </li>  
   --%><li>
	   	<label for="TTKH" class="lableCenter">Thông tin khách hàng</label>	   
	   	<table class="tableControlCenter" style="border:0px !important">
	   		<tr style="border:0px ;">
	   			<td style="border:0px "><label for="MaGiaoDich" class="lableTableCenter" style="border:0px" >Mã giao dịch</label></td>
	   			<td style="border:0px "><label for="GiaTriGiaoDich" class="lableTableCenter">Giá trị giao dịch (VD:1,036.5)</label></td>
	   			<td style="border:0px "><label for="LoaiTien" class="lableTableCenter">Loại tiền</label></td>
	   		</tr>
	   		<tr style="border:0px">
	   			<td style="border:0px "><input type="text" id="MaGiaoDich" name="MaGiaoDich" class="controlTableCenter"></input></td>
	   			<td style="border:0px "><input type="text" id="GiaTriGiaoDich" name="GiaTriGiaoDich" class="controlTableCenter onlyNumber textRight" ></input></td>
<%--	   			<td style="border:0px "><g:textField name="GiaTriGiaoDich" type="text" class="controlTableCenter price onlyNumber"/></td>--%>
	   			<td style="border:0px "><input type="text" id="LoaiTien" name="LoaiTien" value="${errorManagement?.loaiTien }" class="controlTableCenter"></input></td>
	   		</tr>
	   		
	   		<tr style="border:0px">
	   			<td style="border:0px " ><label for="SoCifKhachHang" class="lableTableCenter">Số CIF của Khách hàng</label></td>
	   			<td style="border:0px "><label for="TenKhachHang" class="lableTableCenter">Tên Khách hàng</label></td>
	   			<td style="border:0px "><label for="HoSoVaTenHoSo" class="lableTableCenter">Số hồ sơ và tên hồ sơ</label></td>
	   		</tr>
	   		<tr style="border:0px">
	   			<td style="border:0px "><input type="text" id="SoCifKhachHang" name="SoCifKhachHang" class="controlTableCenter"></input>    </td>
	   			<td style="border:0px "><input type="text" id="TenKhachHang" name="TenKhachHang" class="controlTableCenter"></input></td>
	   			<td style="border:0px " > <input type="text" id="HoSoVaTenHoSo" name="HoSoVaTenHoSo" class="controlTableCenter"></input></td>
	   		</tr>
	   	</table>

   </li>
   <li style="display:none">
  		<label for="loaiNghiepVu" class="lableCenter">Chọn loại nghiệp vụ</label></br>
  		<select id="loaiNghiepVu" class="largeControlCenter largeControlCenterSelect"></select>
  		
  		
   </li>
 	
   
    
   <li>
   	      <label for="errorCategory" class="lableCenter">Chọn loại nghiệp vụ<font color="red">*</font></label>
   	      <br>
   	      	<g:select class="largeControlCenter largeControlCenterSelect validate[required]" name="errorCategory" from="${errorCategory}"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"
							 />
   </li> 
   
   
    <%--<li>
   	      <label for="LoiCap1" class="lableCenter">Chọn loại lỗi cấp 1<font color="red">*</font></label>
   	      <br>
   	      	<g:select class="largeControlCenter validate[required] largeControlCenterSelect" name="LoiCap1" from="${errorlist1}"
							optionKey="id" optionValue="name" noSelection="${['':'']}"
							value="${errorlist?.id}" />
   </li> 
   
   
   
   --%>
   <table class="tableControlCenter" style="border:0px !important">
   	<tr style ="border:0px">
   		<td style ="border:0px"><label for="LoiCap3" class="lableTableCenter">Nhóm lỗi mức 3<font color="red">*</font></label></td>
   		<td style ="border:0px"><label for="LoiCap2" class="lableTableCenter">Nhóm lỗi mức 2<font color="red">*</font></label></td>
   		<td style ="border:0px"><label for="LoiCap1" class="lableTableCenter">Nhóm lỗi mức 1<font color="red">*</font></label></td>
   	</tr>
   	<tr style ="border:0px">
		
		<td style ="border:0px"><g:select name="LoiCap3" id="LoiCap3"
							from="${errorList3}"
							optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"
							class="largeControlCenter validate[required] controlComboboxTableCenter" />   		
		<td style ="border:0px">
							<g:select name="LoiCap2" id="LoiCap2"  class="largeControlCenter validate[required] controlComboboxTableCenter" from="${errorList2 }" 
								optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"  /></td>	
							
		<td style ="border:0px"><g:select class="largeControlCenter validate[required] controlComboboxTableCenter" name="LoiCap1" from="${errorlist1}"
							optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"
							value="${errorlist?.id}" /></td>					

						</select></td>													
   	</tr>
   </table>
   
    <li>
      <label for="ngayxayra" class="lableCenter">Ngày xảy ra <font color="red">*</font></label>
      <br>      
      <input type="text" name ="dateNgayXayRa" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}"  readonly="true" id="ngayxayra" class="validate[required] text-input datetime incident-field-number largeControlCenter">
    </li>
    
  	<table class="tableControlCenter" style="border:0px !important">
  		<tr style ="border:0px">
  			<td style ="border:0px"><label for="MotaChiTiet" class="lableTableCenter">Mô tả chi tiết lỗi<font color="red">*</font></label></td>
  			<td style ="border:0px"><label for="MotaAnhHuong" class="lableTableCenter">Mô tả ảnh hưởng</label></td>		
  		</tr>
  		<tr style ="border:0px">
  			<td style ="border:0px"><g:textArea name="MotaChiTiet"  class="largeControlTextCenter validate[required]" rows="2" id="MotaChiTiet"/></td>
  			<td style ="border:0px"><g:textArea name="MoTaAnhHuong"  class="controlTableCenter" rows="2" id="MotaAnhHuong"/></td>
  		</tr>
  	</table>
    
     <li>
      <label for="BienPhapKhacPhuc" class="lableCenter">Biện pháp khắc phục</label>
    <br>
      <g:textArea name="BienPhapKhacPhuc"   rows="2" class="largeControlCenter" id="BienPhapKhacPhuc"/>
    </li>
     <li>
      <label for="ThoiHanKhacPhuc" class="lableCenter">Thời hạn khắc phục</label>
      <br>
      <input type="text" name ="ThoiHanKhacPhuc"  value="${currDate }" readonly="true" id="dateThoiHanKhacPhuc" class="text-input datetime incident-field-number largeControlCenter">
    </li>
    
     <li>
   	      <label for="TrangThai" class="lableCenter">Trạng thái</label>
   	      <br>
   	      <g:select class="validate[required] largeControlCenter largeControlCenterSelect" name="TrangThai" from="${errorStatus}" 
							optionKey="id" optionValue="${{it.code+'-'+it.nameStatus}}"/> 
							 
							 
   </li>
   
    <li>
    	<label  class="incident_label ">Thông tin người gây lỗi</label> <input type="button" class="btn" value="Thêm" name="addRunDate"/>
    </li>
    
    <li id="runDate_1" >
    
    	<table class="tableControlCenter">
    		<tr>
    			<td> <label for="OutLook_1" class="nguoiso">UserOutlook 1</label> </td>
    			<td> <label for="HoVaTen_1" class="hovaten">Họ và tên 1</label></td>
    			<td> <label for="ChucDanh_1" class="chucdanh">Chức danh 1</label></td>
    			<td rowspan="4">
    				  <a class="deleteDate deleteUncreatedDate  set-edit" tid="1" title="Xoa ngay" href="#body"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.PNG')}" height="15" alt="" /></a>
    			</td>
    		</tr>
    		<tr>
    			<td><input style="width:177px !important" class="errorManagement"  tid="1" name ="OutLook_1" id="OutLook_1" value="" /> </td>
    			<td> <input class="errorHoVaTen"  name ="HoVaTen_1" id="HoVaTen_1" readonly="readonly" value="" width="100px" /></td>
    			<td> <input class="errorChucDanh"  name ="ChucDanh_1" id="ChucDanh_1" value="" readonly="readonly" width="100px" /></td>
    			
    		</tr>
    		
    		<tr>
    			<td> <label for="Mucdoloi_1" class="mucdoloi">Cấp độ lỗi </label></td>
    			<td> <label for="BdsUser_1" class="BdsUser">User hệ thống 1 </label></td>
    			<td> <label for="IdNhanSu_1" class="IdNhanSu">ID nhân sự 1</label></td>
    			
    		</tr>
    		
    		<tr>
    			<td><input class="errorMucDoLoi"  name ="Mucdoloi_1" id="Mucdoloi_1" value="" width="100px" style="!important" /></td>
    			<td><input class="errorBDSUser"  name ="BdsUser_1" id="BdsUser_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td><input class="errorNhanSu"  name ="IdNhanSu_1" id="IdNhanSu_1" value="" width="100px" readonly="readonly"  />   </td>    			
    		</tr>
    		
    		<tr>
    			<td> <label for="NHCD" class="NHCD">NH Chuyên doanh/Khối 1</label></td>
    			<td> <label for=TenDonVi class="TenDonVi">CN/Trung tâm/Phòng 1</label></td>    		
    			<td> <label for=PGD class="PGD">PGD/Phòng ban/Tổ Nhóm 1</label></td>
    			
    		</tr>
    		
    		<tr>
    			<td><input class="errorNHCD"  name ="NHCD_1" id="NHCD_1" value="" width="100px" style="!important" readonly="readonly" /></td>
    			<td><input class="errorTenDonVi"  name ="TenDonVi_1" id="TenDonVi_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td><input class="errorPGD"  name ="PGD_1" id="PGD_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td>
    			<g:hiddenField class="errorNHCDId" id="NHCD_Id_1" name="NHCD_Id_1" />
    			<g:hiddenField class="errorTenDonViId"  id="TenDonVi_Id_1" name="TenDonVi_Id_1" />
    			<g:hiddenField class="errorPGDId"  id="PGD_Id_1" name="PGD_Id_1" />
    			</td>    
    			<td></td>			
    		</tr>
    		
    		
    		
    	</table>
                                    
   </li>
  
   
    
    
    
    
    <div style="display:none">
   <li>
   	      <label for="NguoiNhap" class="NguoiNhap_lable "><font color="red"></font> Người nhập:</label>
   	      <input type="text" name="NguoiNhap" value="${user.username}" readonly="readonly"></input>
   </li>  
   <li>
   	      <label for="ThoiGianNhapVaoHeThong" class="ThoiGianNhapVaoHeThong_lable "><font color="red"></font> Thời gian nhập vào hệ thống:</label>
   	      <input type="text" readonly="readonly" id="ThoiGianNhapVaoHeThong" value="${currDate }"></input>
   </li>
   </div>
  
   
   
   
    <li>
   	      <label for="uploadFile" class="lableCenter ">Hồ sơ đính kèm:</label>
   	      <br>
   	      <input type="file" id="uploadFile" name="uploadFile" size="79px"></input>
   </li>
     <li>
      <label for="YKienCacDonViKhac" class="incident_label">Ghi chú:</label>
    </li>
    <li>
      <g:textArea name="YKienCacDonViKhac"   class="largeControlCenter" rows="1"  id="YKienCacDonViKhac"/>
   </li>
   <li>
     
   </li>
   
    
   <li>
   	<button value="Tạo mới" class="btn primary"  id ="submit_ErrorManagementList" name="saveErrorManagement">Tạo mới</button>
   </li>
                

  </ol>
 	
</fieldset>
    <g:hiddenField id="dateCount" name="dateCount" value="${1}"/>
  </g:form>
	
	</div>
	
 	
	<script type="text/javascript">
	$(".onlyNumber").blur(function(){
		 
		 $(this).parseNumber({format:"#,###.###", locale:"us"});
   		 $(this).formatNumber({format:"#,###.###", locale:"us"});		
	  
	  });
	  $(".onlyNumber2").blur(function(){
		 
		 $(this).parseNumber({format:"#######", locale:"us"});
   		 $(this).formatNumber({format:"#######", locale:"us"});		
	  
	  });
	$("input[name=OutLook_1]").focusout(function() {
		var count = Number($(this).attr('tid'));
		var un=$("#OutLook_"+count).val();
		if(un!="")
		{
		
		$.getJSON('${createLink(controller:'opError',action:'getDisplayName')}?username='+un,function(fullNameOutlook){

			
			if(fullNameOutlook==",")
				
			alert("Chua ton tai user '"+un+"' .Anh/chi can vao menu 'Quan ly nguoi dung' o menu trai de khai bao thong tin ve user nay.")
			$("#HoVaTen_"+count).val(fullNameOutlook[0]);
			$("#ChucDanh_"+ count).val(fullNameOutlook[1]);
			$("#BdsUser_"+ count).val(fullNameOutlook[2]);
			$("#IdNhanSu_"+ count).val(fullNameOutlook[3]);
			
			$("#NHCD_"+ count).val(fullNameOutlook[4]);
			$("#TenDonVi_"+ count).val(fullNameOutlook[5]);
			$("#PGD_"+ count).val(fullNameOutlook[6]);				
			
			$("#NHCD_Id_"+ count).val(fullNameOutlook[7]);
			$("#TenDonVi_Id_"+ count).val(fullNameOutlook[8]);
			$("#PGD_Id_"+ count).val(fullNameOutlook[9]);
			
			});
		}
		else
			{
				$("#HoVaTen_"+count).val("");
				$("#ChucDanh_"+ count).val("");
				$("#ChucDanh_"+ count).val("");
				$("#IdNhanSu_"+ count).val("");
				$("#NHCD_"+ count).val("");
				$("#TenDonVi_"+ count).val("");
				$("#PGD_"+ count).val("");
				$("#NHCD_Id_"+ count).val("");
				$("#TenDonVi_Id_"+ count).val("");
				$("#PGD_Id_"+ count).val("");
			
			}

	});
	
	   $("#errorManaListForm").validationEngine();
       $("button[name=saveErrorManagement]").click(function(){
    	   $("#errorManaListForm").submit();

        });
        
	$("input[name=addRunDate]").click(function(){

        
        count = $(".errorManagement").length;
        $("#dateCount").val(count+1);
        $('#runDate_1').clone(true).insertAfter('#runDate_'+count).attr('id','runDate_'+(count+1));        
        //BdsUser_1
        
        $('#runDate_'+(count+1)).find("label.nguoiso").html('UserOutlook '+(count+1)+'');
        $('#runDate_'+(count+1)).find("label.mucdoloi").html('Cấp độ lỗi ');
        $('#runDate_'+(count+1)).find("label.BdsUser").html('User hệ thống '+(count+1)+'');
        $('#runDate_'+(count+1)).find("label.hovaten").html('Họ và tên '+(count+1)+'');
        $('#runDate_'+(count+1)).find("label.chucdanh").html('Chức danh '+(count+1)+'');
        $('#runDate_'+(count+1)).find("label.IdNhanSu").html('ID nhân sự '+(count+1)+'');
        $('#runDate_'+(count+1)).find("label.NHCD").html(' NH Chuyên doanh/Khối '+(count+1)+'');
        $('#runDate_'+(count+1)).find("label.TenDonVi").html('CN/Trung tâm/Phòng  '+(count+1)+'');
        $('#runDate_'+(count+1)).find("label.PGD").html('PGD/Phòng ban/Tổ Nhóm '+(count+1)+'');
        
        
        $('#runDate_'+(count+1)).find("label.nguoiso").attr('for','OutLook_'+(count+1));
        $('#runDate_'+(count+1)).find("label.mucdoloi").attr('for','Mucdoloi_'+(count+1));
        $('#runDate_'+(count+1)).find("label.BdsUser").attr('for','BdsUser_'+(count+1));
        $('#runDate_'+(count+1)).find("label.hovaten").attr('for','hovaten_'+(count+1));
        $('#runDate_'+(count+1)).find("label.chucdanh").attr('for','chucdanh_'+(count+1));
        $('#runDate_'+(count+1)).find("label.IdNhanSu").attr('for','IdNhanSu_'+(count+1));
        $('#runDate_'+(count+1)).find("label.NHCD").attr('for','NHCD_'+(count+1));
        $('#runDate_'+(count+1)).find("label.TenDonVi").attr('for','TenDonVi_'+(count+1));
        $('#runDate_'+(count+1)).find("label.PGD").attr('for','PGD_'+(count+1));
                
               
        $('#runDate_'+(count+1)).find("input").val("");       
        $('#runDate_'+(count+1)).find("a").attr('href','#body');
        $('#runDate_'+(count+1)).find("a").attr('tid',count+1);
        $('#runDate_'+(count+1)).find("a").addClass('deleteUncreatedDate');
        $('#runDate_'+(count+1)).find("input.errorManagement").attr('id','OutLook_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorManagement").attr('name','OutLook_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorManagement").attr('tid',count+1);
       
        $('#runDate_'+(count+1)).find("input.errorMucDoLoi").attr('id','Mucdoloi_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorMucDoLoi").attr('name','Mucdoloi_'+(count+1));
        
        $('#runDate_'+(count+1)).find("input.errorHoVaTen").attr('id','HoVaTen_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorHoVaTen").attr('name','HoVaTen_'+(count+1));
        
        $('#runDate_'+(count+1)).find("input.errorChucDanh").attr('id','ChucDanh_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorChucDanh").attr('name','ChucDanh_'+(count+1));

        $('#runDate_'+(count+1)).find("input.errorBDSUser").attr('id','BdsUser_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorBDSUser").attr('name','BdsUser_'+(count+1));

        $('#runDate_'+(count+1)).find("input.errorNhanSu").attr('id','IdNhanSu_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorNhanSu").attr('name','IdNhanSu_'+(count+1));
        
        $('#runDate_'+(count+1)).find("input.errorNHCD").attr('id','NHCD_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorNHCD").attr('name','NHCD_'+(count+1));
        
        $('#runDate_'+(count+1)).find("input.errorTenDonVi").attr('id','TenDonVi_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorTenDonVi").attr('name','TenDonVi_'+(count+1));
        
        $('#runDate_'+(count+1)).find("input.errorPGD").attr('id','PGD_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorPGD").attr('name','PGD_'+(count+1));
        
        
		$('#runDate_'+(count+1)).find("input.errorNHCDId").attr('id','NHCD_Id_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorNHCDId").attr('name','NHCD_Id_'+(count+1));
        	
        $('#runDate_'+(count+1)).find("input.errorTenDonViId").attr('id','TenDonVi_Id_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorTenDonViId").attr('name','TenDonVi_Id_'+(count+1));

        $('#runDate_'+(count+1)).find("input.errorPGDId").attr('id','PGD_Id_'+(count+1));
        $('#runDate_'+(count+1)).find("input.errorPGDId").attr('name','PGD_Id_'+(count+1));
        
        //formatExecutionDate();

      });


	  $(".deleteDate").click(function(){        
		  	
	        var dateCount = $(".errorManagement").length;	        
	        var dateId = Number($(this).attr('tid'))+1;
	        if (dateCount > 1){
	          $('#runDate_'+ (dateId -1)).remove();
	          var temp;
	          for(var i=dateId;i<=dateCount;i++){
	            if(i == 1)
	              temp = i;
	            else
	              temp = i - 1;

	            $('#runDate_'+i).find("label.nguoiso").html('Người số '+temp+':');
	            $('#runDate_'+i).find("label.mucdoloi").html('Mức độ lỗi '+temp+':');  
	            $('#runDate_'+i).find("label.BdsUser").html('User hệ thống '+temp+':');
	            $('#runDate_'+i).find("label.hovaten").html('Họ và tên '+temp+':');
   	            $('#runDate_'+i).find("label.chucdanh").html('Chức danh '+temp+':');  
   	            $('#runDate_'+i).find("label.IdNhanSu").html('ID nhân sự '+temp+':');
   	            $('#runDate_'+i).find("label.NHCD").html('NHCD/Khối hỗ trợ '+temp+':');
   	            $('#runDate_'+i).find("label.TenDonVi").html('Tên đơn vị '+temp+':');
   	            $('#runDate_'+i).find("label.PGD").html('PGD/Phòng ban/Tổ Nhóm '+temp+':');
	                
	            
	            $('#runDate_'+i).find("label").attr('for','executionDate_'+temp);
	            
	            $('#runDate_'+i).find("a").attr('tid',temp);
	            
	            $('#runDate_'+i).find("input.errorManagement").attr('id','OutLook_'+temp);
	            $('#runDate_'+i).find("input.errorManagement").attr('name','OutLook_'+temp);
	            $('#runDate_'+i).find("input.errorManagement").attr('for','OutLook_'+temp);
	            $('#runDate_'+i).find("input.errorManagement").attr('tid',temp);

	            $('#runDate_'+i).find("input.errorMucDoLoi").attr('id','Mucdoloi_'+temp);
	            $('#runDate_'+i).find("input.errorMucDoLoi").attr('name','Mucdoloi_'+temp);
	            $('#runDate_'+i).find("input.errorMucDoLoi").attr('for','Mucdoloi_'+temp);

	            $('#runDate_'+i).find("input.errorHoVaTen").attr('id','HoVaTen_'+temp);
	            $('#runDate_'+i).find("input.errorHoVaTen").attr('name','HoVaTen_'+temp);
	            $('#runDate_'+i).find("input.errorHoVaTen").attr('for','HoVaTen_'+temp);


	            $('#runDate_'+i).find("input.errorChucDanh").attr('id','ChucDanh_'+temp);
	            $('#runDate_'+i).find("input.errorChucDanh").attr('name','ChucDanh_'+temp);
	            $('#runDate_'+i).find("input.errorChucDanh").attr('for','ChucDanh_'+temp);

	            $('#runDate_'+i).find("input.errorBDSUser").attr('id','BdsUser_'+temp);
	            $('#runDate_'+i).find("input.errorBDSUser").attr('name','BdsUser_'+temp);
	            $('#runDate_'+i).find("input.errorBDSUser").attr('for','BdsUser_'+temp);
	            
	            $('#runDate_'+i).find("input.errorNHCD").attr('id','NHCD_'+temp);
	            $('#runDate_'+i).find("input.errorNHCD").attr('name','NHCD_'+temp);
	            $('#runDate_'+i).find("input.errorNHCD").attr('for','NHCD_'+temp);
	            
	            
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('id','TenDonVi_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('name','TenDonVi_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('for','TenDonVi_'+temp);


   
	            $('#runDate_'+i).find("input.errorPGD").attr('id','PGD_'+temp);
	            $('#runDate_'+i).find("input.errorPGD").attr('name','PGD_'+temp);
	            $('#runDate_'+i).find("input.errorPGD").attr('for','PGD_'+temp);
	            	            
	            
	             $('#runDate_'+i).find("input.errorNHCD").attr('id','NHCD_'+temp);
	            $('#runDate_'+i).find("input.errorNHCD").attr('name','NHCD_'+temp);
	            $('#runDate_'+i).find("input.errorNHCD").attr('for','NHCD_'+temp);
	            
	            
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('id','TenDonVi_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('name','TenDonVi_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('for','TenDonVi_'+temp);
	            
	          
	            	            
	            $('#runDate_'+i).attr('id','runDate_'+temp);

	            
	           //formatExecutionDate();



	          }
	          $("#dateCount").val($(".errorManagement").length);
	          
	        }

	      });
      
	
	$("document").ready( function(){

		var quantity = 0;
		var options = '';
		 
			  $("#LoiCap1").change(function(){
				$("select[name=LoiCap2]").html("");
				$("select[name=LoiCap3]").html("");
				options = "<option ></option>";
				var index=$(this).val();
				
				$.getJSON('${createLink(controller:'opError',action:'getErrorList2')}?parent_id='+index,function(errorList2){	
					
					if(errorList2!=-1)
						{						
							for(var i=0;i<errorList2.length;i++)
							{								
								options += "<option value='" + errorList2[i].id  + "'>"+errorList2[i].code+'-'+errorList2[i].name + "</option>";					
							}
										
						}
					$("select#LoiCap2").html(options);
					 $("select[name=LoiCap2]").val("${unitDepart.id}");
					
				});
				$("select[name=LoiCap2]").change()		
			});
			
			$("select[name=LoiCap2]").change(function(){
					
					if ($(this).val()){
						$.post('${createLink(controller:'errorAdmin',action:'getChildNodes')}/LoiCap2',
							$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=LoiCap3]").html(data);
		               	});
		               	
		               		$.post('${createLink(controller:'errorAdmin',action:'getFirstNodesFromLevel2')}/LoiCap2',
							$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=LoiCap1]").html(data);
		               	});
		               	
					} else{
						//$("select[name=LoiCap3]").html("");
					}
					
			});
	//chon loi cap3 hien loi cap 1 va 2		
			$("select[name=LoiCap3]").change(function(){
					 
					if ($(this).val()){
						$.post('${createLink(controller:'errorAdmin',action:'getParentNodes')}/LoiCap3',
							$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=LoiCap2]").html(data);
		               	});
		               	
		               	$.post('${createLink(controller:'errorAdmin',action:'getFirstNodes')}/LoiCap3',
							$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=LoiCap1]").html(data);
		               	});
					} 
					
			});
			
						
		
				$("select[name=TenDonVi1]").change(function(){
					$("select[name=TenDonVi2]").html("");
					$("select[name=TenDonVi3]").html("");
				
					if ($(this).val()){
						$.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/TenDonVi1',
							$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=TenDonVi2]").html(data);
		               	});
					} else{
						$("select[name=TenDonVi2]").html("");
					}
					$("select[name=TenDonVi2]").change()
				});
				
				$("select[name=TenDonVi2]").change(function(){
					
					if ($(this).val()){
					
					$("select[name=TenDonVi1]").html("");
					$("select[name=TenDonVi3]").html("");
						
						
						$.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/TenDonVi2',
							$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=TenDonVi3]").html(data);               	});
								
						$.post('${createLink(controller:'unitDepartment',action:'getFirstNodesFromLevel2')}/TenDonVi2',
						$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=TenDonVi1]").html(data); 	});
					} 
				
				});
	//chon don vi cap 3 hien cap 1 va cap 2				
				$("select[name=TenDonVi3]").change(function(){
					
					if ($(this).val()){
						
						$("select[name=TenDonVi2]").html("");
						$("select[name=TenDonVi1]").html("");
						
							$.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/TenDonVi3',
							$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=TenDonVi2]").html(data);
		               	});
		               	
		               	
		               	$.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/TenDonVi3',
							$("form[name=errorManaListForm]").serialize(),function(data){
								$("select[name=TenDonVi1]").html(data);
		               	});
		               	
		               }					
				});
			  
	});
	 
	      	
	        set_active_tab('error-management');
	        //$("#error-management").closest('li').addClass('active');
	        set_side_bar(true);
	 
	       TableToolsInit.sTitle = "Bao cao lỗi";
	        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
	
</script>

  </body>
  
  
  
</html>


