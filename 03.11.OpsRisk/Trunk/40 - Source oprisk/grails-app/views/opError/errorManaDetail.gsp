

<%@page import="msb.platto.dna.*"%>
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
			<sec:ifAllGranted roles="ROLE_GDTT_LEVEL2">
            	<g:render template="errorsidebarLevel2"/>
            </sec:ifAllGranted>	
            <sec:ifNotGranted roles="ROLE_GDTT_LEVEL2">
            	<g:render template="errorsidebar"/>
            </sec:ifNotGranted>
                     
		</div>                                                                   
	<div id="m-melanin-main-content">
	<fieldset class="info">
	<legend>Quản lý lỗi</legend>
	
	<ol class="form form-clear olCenter" id="incidentField">
	   
	<g:form method="post" name="errorManaListForm" id="errorManaListForm" controller="opError" action="updateErrorManaList" enctype="multipart/form-data">
  
   
     
 
 <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                      </g:if>
                        
  
<%--   <li>--%>
<%--   	        <label for="NHCD" class="lableCenter ">Chọn Ngân  hàng Chuyên doanh hoặc Khỗi Hỗ trợ <font color="red">*</font></label>--%>
<%--   	      <br>--%>
<%--   	       <g:select class="validate[required] largeControlCenter largeControlCenterSelect" name="NHCD" from="${department}"--%>
<%--   	       value="${errorManagement?.department.id}"--%>
<%--			optionKey="id" optionValue="${{it.code +' - '+it.name}}" noSelection="${['':'']}"	/>--%>
<%--   </li>--%>
<%--   --%>
<%--    <li>--%>
<%--   	     <label for="TenDonVi" class="lableCenter ">Nhập tên đơn vị<font color="red">*</font> </label>--%>
<%--   	      <br>--%>
<%--   	      <g:select class="validate[required] largeControlCenter largeControlCenterSelect" name="TenDonVi" from="${unitDepart}"--%>
<%--   	       					value="${errorManagement?.unitDepart.id}"--%>
<%--							optionKey="id"  optionValue="${{it.code +' - '+it.name}}"  noSelection="${['':'']}"--%>
<%--							 />--%>
<%--   </li> 
      <li>
   	      <label for="errorType" class="lableCenter ">Kiểu lỗi </label>
   	      <br>
   	      <g:select  name="errorType" from="${errorType}" class="largeControlCenter largeControlCenterSelect"
   	      	optionKey="id"
   	      	value="${errorManagement?.errorType.id}" 
   	      	optionValue="name" noSelection="${['':'']}" />
   </li>    
     --%>
   <sec:ifAllGranted roles="ROLE_GDTT_LEVEL2">
   		<g:hiddenField name="ROLES" value="GDTTL2"/>
   </sec:ifAllGranted>
   <li>  
   
     <table class="tableControlCenter" style="border:0px !important">
    	<tr style="border:0px ">
    		<td style="border:0px "><label for="TenDonVi3" class="lableTableCenter ">PGD/Phòng/Nhóm gây lỗi<font color="red">*</font> </label></td>
    		<td style="border:0px "><label for="TenDonVi2" class="lableTableCenter ">CN/Trung tâm/Phòng<font color="red">*</font> </label></td>
    		<td style="border:0px "><label for="TenDonVi1" class="lableTableCenter ">NH Chuyên doanh/Khối<font color="red">*</font> </label></td>		
    	</tr> 
    	<tr style="border:0px ">
			<td style="border:0px "><g:select  name="TenDonVi3" from="${allUnitDepart3}" class="largeControlCenter controlComboboxTableCenter validate[required] disableCombobox "
   	      					value = "${errorManagement?.tenDonVi3 }"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}" /></td>
    		<td style="border:0px "><g:select  name="TenDonVi2" from="${unitDepart2}" class="largeControlCenter controlComboboxTableCenter validate[required] disableCombobox "
   	      					value = "${errorManagement?.tenDonVi2 }"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}" /></td>
			
			<td style="border:0px "><g:select  name="TenDonVi1" from="${unitDepart1}" class="largeControlCenter controlComboboxTableCenter validate[required] disableCombobox "
   	      					value = "${errorManagement?.tenDonVi1}"
							optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}" />
    		</td>														
    	</tr>
     </table>
  	</li>
  	
  	<li>
 		<table class="tableControlCenter" style="border:0px !important">
 			<tr style ="border:0px">
 				<td style ="border:0px"><label for="errorCheck" class="lableTableCenter ">Hình thức phát hiện<font color="red">*</font> </label></td>
 				<td style ="border:0px"><label for="SoLuongKiemTra" class="lableTableCenter">Số lượng sai phạm</label></td>
 				<td style ="border:0px"><label for="TongSoChonMau" class="lableTableCenter">Tổng số chọn mẫu</label></td>
 				
 			</tr>
 			<tr style="border:0px ">
 				<td style="border:0px "><g:select class="largeControlCenter controlComboboxTableCenter validate[required] disableCombobox " name="errorCheck" from="${errorCheck}"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"
							value="${errorManagement?.errorCheck?.id}" 	 /></td>
 				<td style="border:0px "><input type= "text" id = "SoLuongKiemTra" name="SoLuongKiemTra" class = "controlTableCenter onlyNumber2 textRight disableControl " value="${errorManagement?.soLuongKiemTra }"></input></td>
 				<td style="border:0px "><input type= "text" id = "TongSoChonMau" name="TongSoChonMau" class = "controlTableCenter price disableControl " value = "${errorManagement?.tongSoChonMau }"></input></td>
 					
 			</tr>
   	
   	</table>
   	</li>
         
     <li>
	   	<lable  class="lableCenter">Thông tin khách hàng</lable>	   	
	   	 	<table class="tableControlCenter">
	   		<tr>
	   			<td><label for="MaGiaoDich" class="lableTableCenter">Mã giao dịch</label></td>
	   			<td><label for="GiaTriGiaoDich" class="lableTableCenter">Giá trị giao dịch (VD:1,036.5)</label></td>
	   			<td><label for="LoaiTien" class="lableTableCenter">Loại tiền</label></td>
	   		</tr>
	   		<tr>
	   			<td><input type="text" id="MaGiaoDich" name="MaGiaoDich" class="controlTableCenter disableControl " value="${errorManagement?.maGiaoDich}" ></input></td>
	   			<td><input type="text" id="GiaTriGiaoDich" name="GiaTriGiaoDich" class="controlTableCenter onlyNumber textRight disableControl " value="${errorManagement?.giaTriGiaoDich }"></input></td>
	   			<td><input type="text" id="LoaiTien" name="LoaiTien" value="${errorManagement?.loaiTien }" class="controlTableCenter disableControl "></input></td>
	   		</tr>
	   		<tr>
	   			<td><label for="SoCifKhachHang" class="lableTableCenter">Số CIF của Khách hàng</label></td>
	   			<td><label for="TenKhachHang" class="lableTableCenter">Tên Khách hàng</label></td>
	   			<td><label for="HoSoVaTenHoSo" class="lableTableCenter">Số hồ sơ và tên hồ sơ</td>
	   		</tr>
	   		<tr>
	   			<td><input type="text" id="SoCifKhachHang" name="SoCifKhachHang" class="controlTableCenter disableControl " value="${errorManagement?.soCifKhachHang }"></input>    </td>
	   			<td><input type="text" id="TenKhachHang" name="TenKhachHang" class="controlTableCenter disableControl " value="${errorManagement?.tenKhachHang }"></input></td>
	   			<td> <input type="text" id="HoSoVaTenHoSo" name="HoSoVaTenHoSo" class="controlTableCenter disableControl " value="${errorManagement?.hoSoVaTenHoSo}"></input></td>
	   		</tr>
	   	</table>
	   	
	 </li>
	 <li style="display:none">
  		<label for="loaiNghiepVu" class="lableCenter; display:none">Chọn loại nghiệp vụ</label></br>
  		<select id="loaiNghiepVu" class="largeControlCenter largeControlCenterSelect"></select>  		
   	</li>
   	
   	   
   <li>
   	     <label for="errorCategory" class="lableCenter ">Chọn loại nghiệp vụ<font color="red">*</font> </label>
   	      <br>
   	      	<g:select class="largeControlCenter largeControlCenterSelect validate[required] disableCombobox " name="errorCategory" from="${errorCategory}"
							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"
							value="${errorManagement?.errorCategory?.id }"							 
							 />
   </li> 
   	
    <li>
    	<table class="tableControlCenter" style="border:0px !important">
    		<tr style="border:0px ">
    			<td style="border:0px "><label for="LoiCap3" class="lableTableCenter">Nhóm lỗi mức 3<font color="red">*</font></label></td>
    			<td style="border:0px "><label for="LoiCap2" class="lableTableCenter">Nhóm lỗi mức 2 <font color="red">*</font></label></td>
    			<td style="border:0px "><label for="LoiCap1" class="lableTableCenter">Nhóm lỗi mức 1<font color="red">*</font></label></td>					
    		</tr>
    		<tr style="border:0px ">
				<td style="border:0px "><g:select class="largeControlCenter  controlComboboxTableCenter validate[required] disableCombobox " name="LoiCap3" id="LoiCap3"  from="${allErrorList3}" 
   	      					value="${errorManagement?.loiCap3}"
   	      					optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}"/></td>	 
				<td style="border:0px "><g:select class=" largeControlCenter controlComboboxTableCenter validate[required] disableCombobox " name="LoiCap2" id="LoiCap2"  from="${errorlist2}"
   							value="${errorManagement?.loiCap2}"
   							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}" /></td>						
	
				<td style="border:0px "><g:select class=" largeControlCenter controlComboboxTableCenter validate[required] disableCombobox " name="LoiCap1"  from="${errorlist1}"
   							value="${errorManagement?.loiCap1}" 
   							optionKey="id" optionValue="${{it.code+'-'+it.name}}" noSelection="${['':'']}" /> </td> 												
    		</tr>
    	</table>   	        
   </li>
   
   
   
    <li>
     <label for="ngayxayra" class="lableCenter">Ngày xảy ra <font color="red">*</font></label>
      <br>   
      <input type="text" value="${errorManagement.ngayXayRa?DateUtil.formatDate(errorManagement.ngayXayRa):'' }"  name ="dateNgayXayRa" readonly="true" id="dateNgayXayRa" class="validate[required] text-input datetime incident-field-number largeControlCenter">
    </li>

    <li>
    	<table class="tableControlCenter" style="border:0px !important">
    		<tr style="border:0px ">
    			<td style="border:0px "><label for="MotaChiTiet" class="lableTableCenter">Mô tả chi tiết lỗi<font color="red">*</font></label></td>
    			<td style="border:0px "><label for="MoTaAnhHuong" class="lableTableCenter">Mô tả ảnh hưởng</label></td>			
    		</tr>
    		<tr style="border:0px ">
				<td style="border:0px "><g:textArea name="MotaChiTiet" value="${errorManagement?.motaChiTiet}" class="largeControlTextCenter validate[required] disableControl " rows="2" id="MotaChiTiet"/></td>
				<td style="border:0px "><g:textArea name="MoTaAnhHuong" value="${errorManagement?.moTaAnhHuong}" class="controlTableCenter disableControl " rows="2" id="MoTaAnhHuong"/></td>				    			
    		</tr>
    	</table>         
    </li> 
           
     <li>
      <label for="BienPhapKhacPhuc" class="lableCenter">Biện pháp khắc phục</label>
    <br>
      <g:textArea name="BienPhapKhacPhuc"   value="${ errorManagement?.bienPhapKhacPhuc}"   rows="2" class="largeControlCenter disableControl " id="BienPhapKhacPhuc"/>
    </li>
    <li>
      <label for="ThoiHanKhacPhuc" class="lableCenter" class="ThoiHanKhacPhuc_label" readonly="readonly">Thời hạn khắc phục</label>
      <br>
      <input type="text" value="${errorManagement?.thoiHanKhacPhuc?DateUtil.formatDate(errorManagement.thoiHanKhacPhuc):'' }" name ="ThoiHanKhacPhuc" readonly="true" id="dateThoiHanKhacPhuc" class="text-input datetime incident-field-number largeControlCenter">
      
    </li>
    
<%--    <li>--%>
<%--    	<lable for = "ThoiGianCapNhat" class = "lableCenter" readonly="readonly">Thời gian cập nhật trạng thái</lable><br> --%>
<%--    	<input type = "text" value="${errorManagement?.thoiGianCapNhapTrangThai}" name="ThoiGianCapNhat" readonly="true" class="text-input datetime incident-field-number largeControlCenter"/>--%>
<%--    </li>--%>
    
     <li>
   	      <label for="TrangThai" class="lableCenter">Trạng thái</label>
   	      <br>
   	      <g:select class="validate[required] largeControlCenter largeControlCenterSelect" name="TrangThai" from="${errorStatus}"  value="${errorManagement?.trangThai}"
							optionKey="id" optionValue="${{it.code+'-'+it.nameStatus}}"/> 

							 
							 
   </li>
   
   
  <li>
    	<label  class="incident_label ">Thông tin người gây lỗi</label>  <input type="button" class="btn disablebutton" value="Thêm" name="addRunDate"/>
    </li>
     
 
    <li>
      <g:if test="${errorManagement?.errorUserCreate.size()>0}">
       <g:each in="${errorManagement?.errorUserCreate}" var="d" status="t">
	    <li id="runDate_${t+1}" >
	    
	        	<table class="tableControlCenter">
	    		<tr>
	    			<td> <label for="OutLook_${t+1}" class="nguoiso">UserOutlook ${t+1}</label> </td>
	    			<td> <label for="HoVaTen_${t+1}" class="hovaten">Họ và tên ${t+1}</label></td>
	    			<td> <label for="ChucDanh_${t+1}" class="chucdanh">Chức danh ${t+1}</label></td>
	    			<td rowspan="4">
	    				  <a class="deleteDate deleteUncreatedDate disablebutton set-edit" tid="1" title="Xoa ngay" href="#body"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.PNG')}" height="15" alt="" /></a>
	    				  
	    			</td>
	    		</tr>
	    		<tr>
	    			
	    			<td><input style="width:177px !important" class="errorManagement disableControl "  tid="${t+1}" name ="OutLook_${t+1}" id="OutLook_${t+1}" value="${d.userEmail}" /> </td>    			
	    			<td> <input class="errorHoVaTen"  name ="HoVaTen_${t+1}" id="HoVaTen_${t+1}" readonly="readonly" value="${d.fullName}" /></td>
	    				
	    			<td> <input class="errorChucDanh"  name ="ChucDanh_${t+1}" id="ChucDanh_${t+1}" value="${d.title}" readonly="readonly" /></td>
	    			
	    		</tr>
	    		
	    		<tr>
	    			
	    			<td> <label for="Mucdoloi_${t+1}" class="mucdoloi">Cấp độ lỗi</label></td>
	    			
	    			<td> <label for="BdsUser_${t+1}" class="BdsUser">User hệ thống ${t+1} </label></td>
	    			<td> <label for="IdNhanSu_${t+1}" class="IdNhanSu">ID nhân sự ${t+1}</label></td>
	    			
	    		</tr>
	    		
	    		<tr>
	    			
	    			<td><input class="errorMucDoLoi disableControl "  name ="Mucdoloi_${t+1}" id="Mucdoloi_${t+1}" value="${d.levelError}"  /></td>
	    			  
	    			<td><input class="errorBDSUser"  name ="BdsUser_${t+1}" id="BdsUser_${t+1}" value="${d.bDSUser}" readonly="readonly"  />         </td>
	    			<td><input class="errorNhanSu"  name ="IdNhanSu_${t+1}" id="IdNhanSu_${t+1}" value="${d.codeSalary}" readonly="readonly"  />   </td>
	    			
	    		</tr>
	    		
	    		<tr>
    			<td> <label for="NHCD" class="NHCD">NH Chuyên doanh/Khối ${t+1}</label></td>
    			<td> <label for="TenDonVi" class="TenDonVi">CN/Trung tâm/Phòng ${t+1} </label></td>    		
    			<td> <label for="PGD" class="PGD">PGD/Phòng ban/Tổ Nhóm 1</label></td>
    		</tr>
    		
    		<tr>
    			<td><input class="errorNHCD"  name ="NHCD_${t+1}" id="NHCD_${t+1}" value="${UnitDepart.get(d.tenDonVi1)?.name}" width="100px" style="!important" readonly="readonly" /></td>
    			<td><input class="errorTenDonVi"  name ="TenDonVi_${t+1}" id="TenDonVi_${t+1}" value="${UnitDepart.get(d.tenDonVi2)?.name}" width="100px" readonly="readonly"  />         </td>
    			<td><input class="errorPGD"  name ="PGD_${t+1}" id="PGD_${t+1}" value="${UnitDepart.get(d.tenDonVi3)?.name}" width="100px" readonly="readonly"  />         </td>
    			<td>
    			<g:hiddenField class="errorNHCDId" id="NHCD_Id_${t+1}" name="NHCD_Id_${t+1}" value="${d.tenDonVi1}" />
    			<g:hiddenField class="errorTenDonViId"  id="TenDonVi_Id_${t+1}" name="TenDonVi_Id_${t+1}" value="${d.tenDonVi2}"/>
    			<g:hiddenField class="errorPGDId"  id="PGD_Id_${t+1}" name="PGD_Id_${t+1}" value="${d.tenDonVi3}"/>
    			</td>
    			    			
    		</tr>
	    		
	    	</table>
	    	                                    
	                                    
	   </li>
  </g:each>
  </g:if>
  <g:else>

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
    			
    			<td><input  style="width:177px !important" class="errorManagement" tid="1"  name ="OutLook_1" id="OutLook_1" value="" /> </td>    			
    			<td> <input class="errorHoVaTen"  tid="1" name ="HoVaTen_1" id="HoVaTen_1" readonly="readonly" value="" /></td>
    				
    			<td> <input class="errorChucDanh"  tid="1" name ="ChucDanh_1" id="ChucDanh_1" value="" readonly="readonly" /></td>
    			
    		</tr>
    		
    		<tr>
    			
    			<td> <label for="Mucdoloi_1" class="mucdoloi">Cấp độ lỗi 1</label></td>
    			
    			<td> <label for="BdsUser_1" class="BdsUser">User hệ thống 1 </label></td>
    			<td> <label for="IdNhanSu_1" class="IdNhanSu" style="display:none">ID nhân sự 1</label></td>
    			
    		</tr>
    		
    		<tr>
    			
    			<td><input class="errorMucDoLoi" tid="1" name ="Mucdoloi_1" id="Mucdoloi_1" value="" width="100px" style="!important" /></td>
    			  
    			<td><input class="errorBDSUser" tid="1" name ="BdsUser_1" id="BdsUser_1" value="" readonly="readonly"  />         </td>
    			<td><input class="errorNhanSu"  tid="1" name ="IdNhanSu_1" id="IdNhanSu_1" value=""  readonly="readonly"/>   </td>
    			
    		</tr>
    		<tr>
    			<td> <label for="NHCD_1" class="NHCD">NH Chuyên doanh/Khối 1</label></td>
    			<td> <label for="TenDonVi_1" class="TenDonVi">CN/Trung tâm/Phòng 1 </label></td>    		
    			<td> <label for="PGD_1" class="PGD">PGD/Phòng ban/Tổ Nhóm 1</label></td>
    		</tr>
    		
    		<tr>
    			<td><input class="errorNHCD"  name ="NHCD_1" id="NHCD_1" value="" width="100px" style="!important" readonly="readonly" /></td>
    			<td><input class="errorTenDonVi"  name ="TenDonVi_1" id="TenDonVi_1" value="" width="100px" readonly="readonly"  />   </td>
    			<td><input class="errorPGD"  name ="PGD_1" id="PGD_1" value="" width="100px" readonly="readonly"  />   </td>
    			<td>
    			<g:hiddenField class="errorNHCDId" id="NHCD_Id_1" name="NHCD_Id_1" value=""/>
    			<g:hiddenField class="errorTenDonViId"  id="TenDonVi_Id_1" name="TenDonVi_Id_1" value=""/>
    			<g:hiddenField class="errorPGDId"  id="PGD_Id_1" name="PGD_Id_1" value=""/>
    			</td>
    			    			
    		</tr>
    	</table>                      
                                    
   		</li>
	</g:else>
	
  
    

    
     <li>
      
      
    </li>
    
    <div style="display:none">
    
   <li>
   	      <label for="NguoiNhap" class="NguoiNhap_lable "><font color="red"></font> Người nhập:</label>
   	      <input type="text" value="${errorManagement.nguoiNhap }" name="NguoiNhap" readonly="readonly"></input>
   </li>  
   <li>
   	      <label for="ThoiGianNhapVaoHeThong" class="ThoiGianNhapVaoHeThong_lable "><font color="red"></font> Thời gian nhập vào hệ thống:</label>
   	      <input type="text" readonly="readonly" id="ThoiGianNhapVaoHeThong" value="${errorManagement?.thoiGianNhapVaoHeThong?DateUtil.formatDate(errorManagement.thoiGianNhapVaoHeThong):'' }"></input>
   </li>
   
    </div>

  <li>
  		  
          <label class="lableCenter " >Hồ sơ đính kèm:</label>
          <br>
          <div id="fileUploadx" >
 
            <g:if test="${errorManagement.fileName!=null}">
               
                    <label style="width:50px "  class="">Tên file:</label>
                    	 <g:link style="margin-left:0px !important"  id="lblFilename" url="${resource(dir:'errorFiles',file:errorManagement.fileName)}">${errorManagement.fileName }</g:link>
<%--                         <a style="margin-left:-250px !important" id="lblFilename"  href="${resource(dir:'errorFiles',file:errorManagement.fileName)}" >${errorManagement.fileName }</a>--%>

                    <input type="hidden" width="100px" name="fileName" value="${errorManagement.fileName }" />                
                    <button type="button" class="btn primary" id="deleteFile" name="deleteFile" value="deleteFile">Xóa file</button>
                    
                    <br>                    
                 
     		</g:if>
     	</div>
    	<br>
   	      <input type="file" id="uploadFile" size="80px" name="uploadFile"></input>
   </li>
   

   <li>
    </li>
    
    
  
   <g:if test="${isSave=='Save'}">
 <button class="btn primary" type="submit" id="saveComment" name="saveComment" value="saveError">Cập nhật</button>

     <g:hiddenField id="hfDeleteFile" name="hfDeleteFile" value="notDeletefile"/>
    <g:hiddenField id="actionButton" name="actionButton" value="errorUpdate"/>
   
   <button class="btn primary" type="submit" id="dupplicateError" name="dupplicateError" value="dupplicateError">Lưu thành lỗi mới</button>
   <sec:ifNotGranted roles="ROLE_GDTT_LEVEL2">
  		<button class="btn primary"  id="Delete" name="Delete" value="deleteError">Xóa lỗi</button>
   </sec:ifNotGranted>
  </g:if>
  <g:elseif test="${isSaveStatus == 'Yes'}">
  	<button class="btn primary" style="margin-bottom:5px;margin-top:5px" id="saveStatus" name="saveStatus" value="saveStatus">Cập nhật trạng thái</button>
  	<g:hiddenField id="actionButton" name="actionButton" />
  </g:elseif>
  
  <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL2">
  	<g:if test="${isSave != 'Save'&& isSaveStatus !='Yes'}">
  		<button class="btn primary" type="submit" id="saveComment" name="saveComment" value="saveError">Cập nhật</button>

     	<g:hiddenField id="hfDeleteFile" name="hfDeleteFile" value="notDeletefile"/>
    	<g:hiddenField id="actionButton" name="actionButton" value="errorUpdate"/>
   		<button class="btn primary" type="submit" id="dupplicateError" name="dupplicateError" value="dupplicateError">Lưu thành lỗi mới</button>
  	</g:if>
  </sec:ifAnyGranted>
  
  
  
  
   <li>
     	<g:hiddenField id="dateCount" name="dateCount" value="${countErrorUsers}"/>
    	<g:hiddenField id="idErrorManagement" name="idErrorManagement" value="${errorManagement.id}"/>
</g:form>
 <g:form method="post" id="errorCommentList" controller="opError" action="addErrorComment">
    <g:hiddenField id="idErrorComment" name="idErrorComment" value="${errorManagement.id}"/>
    <g:hiddenField id="dateCount" name="dateCount" value="${countErrorUsers}"/>
    <g:hiddenField name="LoiCap3" value="${errorManagement?.loiCap3}"/>
    <g:hiddenField name="MotaChiTiet" value="${errorManagement?.motaChiTiet}"/>
    <g:hiddenField name="getErrorDetail" value="getErrorDetail"/>
    <g:each in="${errorManagement?.errorUserCreate}" var="d" status="t">   
    	<input type="hidden" name ="OutLook_${t+1}" id="OutLook_${t+1}" value="${d.userEmail}" />
    </g:each>
              <fieldset style="width:540px">
                <ol class="form-clear">
                  
                  <g:if test="${errorComment.size()>0}">
                  <li><b>Các ý kiến đã gửi:</b></li>
                  <li>
                     <table class="commentTable" >
                        <thead class="hidden">
                          <td></td>
                        </thead>
                        <tbody>
                        <g:each in="${errorComment}" var="i">
                          <tr>
                            <td>
                              ${i.content}<br/>
                              <span class="red">Người viết: ${i.createdUserUpload}</span>
                              <span>${formatDate(date:i.dateCreated)}</span>
                            </td>

                          </tr>
                        </g:each>
                        </tbody>

                      </table>

                  </li>
                  </g:if>
                  
   </li>
    
      
    <li>
      <label for="YKienCacDonViKhac" class="incident_label"><font color="red"></font>Ý kiến của anh/chị:</label>
    </li>
    <li>
      <g:textArea name="YKienCacDonViKhac" style="width:520px"  cols="140" rows="2"class="incident-field validate[required]" id="YKienCacDonViKhac"/>
      
      <br>
      <br>
      <button class="btn "  id="saveComment" name="saveComment" value="sendComment">Gửi ý kiến</button>
   </li>
   
   
   <li>
   	
   </li>
    
  </ol>
</fieldset>

</g:form>
</ol>
</fieldset>
             
<h3>Nội dung comment</h3>
            <table class="datatables">
                  <thead>
                    <tr>
                      <th>STT</th>
                      <th>Comment</th>
                      <th>Người viết</th>
                      <sec:ifNotGranted roles="ROLE_GDTT_LEVEL2 ">
                      	<th>Chức năng</th>
                      </sec:ifNotGranted>
                    </tr>
                  </thead>
                  <tbody>
                     <g:each in="${errorComment}" var="i" status="k">
                       <tr>
                         <td class="center">${k+1}</td>
                         <td>${i.content}</td>
                         <td class="center">${i.createdUserUpload}</td>
                         <sec:ifNotGranted roles="ROLE_GDTT_LEVEL2">
                         	<td class="center"><span tid="${i.id}" class="ss_sprite ss_cancel set-delete delete_comment" title="Xóa"></td>
                         </sec:ifNotGranted>
                       </tr>
                     </g:each>
                  </tbody>

                </table>
                
                <br><br>
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

	$("#deleteFile").click( function(){
		
		$("#fileUploadx").css("display", "none");   
		$("#hfDeleteFile").val("deleteFile");  
			
		});

	$("#Delete").click( function(){
		 jquery_confirm("Xóa","Anh/chị đồng ý xóa bỏ báo cáo này?",
                 function(){
			 		   $("#actionButton").val("errorDelete");
                       $("#errorManaListForm").submit();

           });
     return false;
     
		
	});


	$("#dupplicateError").click( function(){
		 jquery_confirm("Tạo","Anh/chị lưu thành lỗi mới?",
                function(){
			 		   $("#actionButton").val("dupplicateError");
                      $("#errorManaListForm").submit();

          });
    return false;
    
		
	});

	for(var i=1;i<10;i++)
	{
		$("input[name=OutLook_"+i+"]").focusout(function() {
			var count = Number($(this).attr('tid'));
			var un=$("#OutLook_"+count).val();
			if(un!="")
			{
			
			$.getJSON('${createLink(controller:'opError',action:'getDisplayName')}?username='+un,function(fullNameOutlook){
	
				
				if(fullNameOutlook==",")
					//alert("Không tồn tại:"+un)
									
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
					$("#NHCD_Id_"+ count).val("");
					$("#TenDonVi_Id_"+ count).val("");
					$("#PGD_Id_"+ count).val("");
					$("#PGD_"+ count).val("");
				}
	
				
			
		});
	}
	
	   $("#errorManaListForm").validationEngine();
       $("button[name=saveErrorManagement]").click(function(){
    	   $("#errorManaListForm").submit();

        });
	$("input[name=addRunDate]").click(function(){

        
		 count = $(".errorManagement").length;
	        $("#dateCount").val(count+1);
	        $('#runDate_1').clone(true).insertAfter('#runDate_'+count).attr('id','runDate_'+(count+1));        
	        //BdsUser_1
	        
	        $('#runDate_'+(count+1)).find("label.nguoiso").html('UserOutlook '+(count+1)+':');
	        $('#runDate_'+(count+1)).find("label.mucdoloi").html('Cấp độ lỗi ');
	        $('#runDate_'+(count+1)).find("label.BdsUser").html('User hệ thống '+(count+1)+':');
	        $('#runDate_'+(count+1)).find("label.hovaten").html('Họ và tên '+(count+1)+':');
	        $('#runDate_'+(count+1)).find("label.chucdanh").html('Chức danh '+(count+1)+':');
	        $('#runDate_'+(count+1)).find("label.IdNhanSu").html('ID nhân sự '+(count+1)+':');
	        $('#runDate_'+(count+1)).find("label.NHCD").html('NH Chuyên doanh/Khối '+(count+1)+':');
        	$('#runDate_'+(count+1)).find("label.TenDonVi").html('CN/Trung tâm/Phòng '+(count+1)+':');
        	$('#runDate_'+(count+1)).find("label.PGD").html('PGD/Phòng ban/Tổ Nhóm '+(count+1)+':');
	        
	        
	        $('#runDate_'+(count+1)).find("label.nguoiso").attr('for','OutLook_'+(count+1));
	        $('#runDate_'+(count+1)).find("label.mucdoloi").attr('for','Mucdoloi_'+(count+1));
	        $('#runDate_'+(count+1)).find("label.BdsUser").attr('for','BdsUser_'+(count+1));
	        $('#runDate_'+(count+1)).find("label.hovaten").attr('for','hovaten_'+(count+1));
	        $('#runDate_'+(count+1)).find("label.chucdanh").attr('for','chucdanh_'+(count+1));
	        $('#runDate_'+(count+1)).find("label.IdNhanSu").attr('for','IdNhanSu_'+(count+1));
	       	$('#runDate_'+(count+1)).find("label.NHCD").attr('for','NHCD_'+(count+1));
        	$('#runDate_'+(count+1)).find("label.TenDonVi").attr('for','TenDonVi_'+(count+1));
        	//$('#runDate_'+(count+1)).find("label.PGD").html('for','PGD_'+(count+1)+':');
        	
        	
	                
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
   	            $('#runDate_'+i).find("label.NHCD").html('NH Chuyên doanh/Khối '+temp+':');
   	            $('#runDate_'+i).find("label.TenDonVi").html('CN/Trung tâm/Phòng '+temp+':');
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


	            $('#runDate_'+i).find("input.errorChucDanh").attr('id','ChucDanh_'+temp);
	            $('#runDate_'+i).find("input.errorChucDanh").attr('name','ChucDanh_'+temp);
	            
				$('#runDate_'+i).find("input.errorBDSUser").attr('id','BdsUser_'+temp);
   	            $('#runDate_'+i).find("input.errorBDSUser").attr('name','BdsUser_'+temp);
				$('#runDate_'+i).find("input.errorBDSUser").attr('for','BdsUser_'+temp);
   	            
   	            $('#runDate_'+i).find("input.errorNHCD").attr('id','NHCD_'+temp);
	            $('#runDate_'+i).find("input.errorNHCD").attr('name','NHCD_'+temp);
	            $('#runDate_'+i).find("input.errorNHCD").attr('for','NHCD_'+temp);
	            
	            
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('id','TenDonVi_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('name','TenDonVi_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('for','TenDonVi_'+temp);
	            
	            $('#runDate_'+i).find("input.errorNHCDId").attr('id','NHCD_Id_'+temp);
	            $('#runDate_'+i).find("input.errorNHCDId").attr('name','NHCD_Id_'+temp);
	            
	            $('#runDate_'+i).find("input.errorTenDonViId").attr('id','TenDonVi_Id_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonViId").attr('name','TenDonVi_Id_'+temp);
	            
	                      

	            $('#runDate_'+i).find("input.errorNHCD").attr('id','NHCD_'+temp);
	            $('#runDate_'+i).find("input.errorNHCD").attr('name','NHCD_'+temp);
	            $('#runDate_'+i).find("input.errorNHCD").attr('for','NHCD_'+temp);
	            
	            
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('id','TenDonVi_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('name','TenDonVi_'+temp);
	            $('#runDate_'+i).find("input.errorTenDonVi").attr('for','TenDonVi_'+temp);
	            
	    	    $('#runDate_'+i).find("input.PGD").attr('id','PGD_'+temp);
	            $('#runDate_'+i).find("input.PGD").attr('name','PGD_'+temp);
	            $('#runDate_'+i).find("input.PGD").attr('for','PGD_'+temp);
	            
	            $('#runDate_'+i).attr('id','runDate_'+temp);

	            
	           //formatExecutionDate();



	          }
	          $("#dateCount").val($(".errorManagement").length);
	          
	        }

	      });
      
	
	$("document").ready( function(){	
	$("#errorCommentList").validationEngine();
	$("#saveStatus").click( function(){			
		$("#actionButton").val("updateStatus");
	            $("#errorManaListForm").submit();
 
	});
	if (${isSaveStatus=='Yes' && isSave!='Save'}){			
		$(".disableControl").attr('readonly','readonly');
		$(".disableCombobox").attr('disabled','true');
		$(".disablebutton").attr('disabled','true');
	}
	
		var quantity = 0;
		var options = '';
		 
			countload=1;
		 //On dropdownlist Loi cap 1 change
		 $("#LoiCap1").change(function(){
				
				$("select[name=LoiCap2]").html("");
				$("select[name=LoiCap3]").html("");
				
				var options = "<option ></option>";
				var index=$(this).val();
				
				$.getJSON('${createLink(controller:'opError',action:'getErrorList2')}?parent_id='+index,function(errorList2){	
					
					if(errorList2!=-1)
					{						
							for(var i=0;i<errorList2.length;i++)
							{								
								options += "<option value='" + errorList2[i].id  + "'>" +errorList2[i].code+'-'+ errorList2[i].name + "</option>";			
							 
							}										
						}
					
					$("select#LoiCap2").html(options);
					
					if(countload==1)
						$("select[name=LoiCap2]").val("${errorManagement?.loiCap2}");
					 countload++;
					
				});
				$("#LoiCap2").change();
		    });
			    //$("#LoiCap1").change(); 
			//On dropdownlist loi cap 2 change
		    $("select[name=LoiCap2]").change(function(){
		    
		    	
				if ($(this).val()){
					$.post('${createLink(controller:'errorAdmin',action:'getChildNodes')}/LoiCap2',
						$("form[name=errorManaListForm]").serialize(),function(data){
							
							$("select[name=LoiCap3]").html(data);
	               	});
				} else{
					$("select[name=LoiCap3]").html("");
				}
			});
			 
	//chon loi cap3 hien ra cap 1 va 2
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
			$("select[name=TenDonVi2]").html(options);
		}
		 $("#TenDonVi2").change(); 
	});
	
	$("select[name=TenDonVi2]").change(function(){
		if ($(this).val()){
			$.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/TenDonVi2',
				$("form[name=errorManaListForm]").serialize(),function(data){
					$("select[name=TenDonVi3]").html(data);
           	});
		} else{
			$("select[name=TenDonVi3]").html(options);
		}
		$("#TenDonVi3").change();
	});
	 
//chon don vi cap3 hien ra cap 2 va 1	
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
	
	
 
	 $(document).ready(function(){

		   $(".delete_comment").click(function(){
	              var deleteId = $(this).attr('tid');
	              jquery_confirm("Xóa ý kiến","Anh/chị đồng ý xóa ý kiến này?",
	                            function(){
	                                  document.location = "${createLink(controller:'opError',action:'deleteErrorComment',params:[newsId:news?.id])}&deleteId="+deleteId;

	                      });

	                return false;

	            });
	      	
	        set_active_tab('error-management');
	        //$("#error-management").closest('li').addClass('active');
	        set_side_bar(true);
	       });
	       TableToolsInit.sTitle = "Bao cao lỗi";
	        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
	
</script>

  </body>
  
  
  
</html>


