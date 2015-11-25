<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@page import="java.lang.Exception"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Báo cáo</title>
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
						[href:createLink(controller:'opError',action:'reportErrorList'),title:'',label:'Danh sách lỗi đầy đủ']]
					]}"/>
           </div>
			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="../opError/errorsidebarLevel2"/>
		</div>
    <div id="m-melanin-main-content">
     <g:form name="reportForm" id="reportForm" class="form" action="getErrorDisplayLevelAllLevel2">     	
     	<g:render template="../opError/errorSReport"/>
     	<g:hiddenField name="search" value="maxresults30"/>
        <g:hiddenField id="actionbutton" name="exportExcel"/>
      </g:form>

    <table class="sortDatatablesExport">
	        <thead>
	        <tr>
	        	<th colspan="12">THÔNG TIN MÔ TẢ LỖI</th>
	        	<th colspan="9">THÔNG TIN NGƯỜI GÂY LỖI</th>
	        	<th colspan="8">THÔNG TIN NGƯỜI NHẬP LỖI</th>
	        	<th colspan="6">THÔNG TIN KHÁCH HÀNG</th>
	        	<th colspan="11">THÔNG TIN KHÁC</th>
	       </tr>
	          <tr>
	          	
			<!-- Mô tả thông tin lỗi -->
	            <th class ="center">Mã</th> 					<!--1-->
	            <th class ="center" >Loại nghiệp vụ</th>		<!--2-->
	            <th class ="center" >Nhóm lỗi mức 1</th> 		<!--3-->
	            <th class ="center" >Nhóm lỗi mức 2</th>		<!--4-->
	            <th class ="center" >Nhóm lỗi mức 3</th>		<!--5-->
	            <th class ="center" >Hình thức phát hiện</th>	<!--6-->		            
	            <th class ="center" >Ngày xảy ra</th>			<!--7-->
	            <th class ="center" >Mô tả chi tiết lỗi</th>	<!--8-->
	            <th class ="center" >Mô tả ảnh hưởng</th>		<!--9-->
	            <th class ="center" >Kiến nghị khắc phục</th>	<!--10-->
	            <th class ="center" >Thời hạn khắc phục</th>	<!--11-->
	            <th class ="center" >Trạng thái</th>			<!--12-->
		
	        <!-- Thông tin người gây lỗi -->
	      
	            <th class ="center" >User Outlook</th> 			<!--13-->
	            <th class ="center" >Cấp độ lỗi</th>			<!--14-->
	            <th class ="center" >Họ và tên</th>				<!--15-->
	            <th class ="center" >Chức danh</th>	            <!--16-->
	            <th class ="center" >NHCD/Khỗi</th>	            <!--17-->
	            <th class ="center" >CN/Trung tâm/Phòng</th>	            <!-- +17-->
	            <th class ="center" >PGD/Phòng ban/Tổ nhóm</th>			<!--18-->
	            <th class ="center" >User hệ thống</th>      	<!--19-->
	            <th class ="center" >ID Nhân sự</th>	        <!--20-->
	  
	       <!-- Update Thông tin người nhập lỗi -->

	       		<th class ="center" >User Outlook</th> 			<!--01-->
	            <th class ="center" >Họ và tên</th>				<!--02-->
	            <th class ="center" >Chức danh</th>	            <!--03-->
	            <th class ="center" >NHCD/Khỗi</th>	            <!--04-->
	            <th class ="center" >CN/Trung tâm/Phòng</th>	            <!-- +04-->
	            <th class ="center" >PGD/Phòng ban/Tổ nhóm</th>	<!-- 05 -->
	            <th class ="center" >User hệ thống</th>      	<!--06-->
	            <th class ="center" >ID Nhân sự</th>			<!--07-->
	  
	       <!-- Thông tin khách hàng -->
	    		
	            <th class ="center" >Mã giao dịch</th>  		<!--21-->
	            <th class ="center" >Giá Trị giao dịch</th>		<!--22-->
	            <th class ="center" >Loại tiên</th>	 	 		<!--23-->
	            <th class ="center" >Số CIF KH</th>				<!--24-->
	            <th class ="center" >Tên khách hàng</th>   		<!--25-->
	            <th class ="center" >Hồ sơ và tên hồ sơ</th>	<!--26-->
	     
	       <!-- Thông tin khác -->
	      		<th class ="center" >NHCD/Khỗi</th>	            <!--001-->
	            <th class ="center" >CN/Trung tâm/Phòng</th>			<!--002-->
	            <th class ="center" >PGD/Tổ/Nhóm</th>			<!--003-->
	            <th class ="center" >Số Lượng Sai Phạm</th>		<!--27-->
	            <th class ="center" >Tổng số chọn mẫu</th>		<!--28-->           
	            <th class ="center" >File đính kèm</th>			<!--29-->
	           	<!--  <th class ="center" >Ghi chú</th>	-->			<!--30-->
	         	<th class ="center" >Người cập nhật</th>        <!--31-->    
	            <th class ="center" >TG cập nhật</th>	        <!--32-->            
	            <th class ="center" >TG khắc phục</th>			<!--33-->
				<th class ="center" >Ý kiến</th><!-- 34 -->
	            <th class ="center" >Thao tác</th>

	         </tr>
	        </thead>
	        <tbody>

	     <g:each in="${errorManagement}" var="e" status="i">
	
	        <tr>
	        <!--MÔ TẢ THÔNG TIN LỖI -->
	          <td>${e.id} </td><!--1--> 
	          <td class ="">${e.errorCategory?.name}</td><!--2-->	
	          <td class ="" style="width:90px">${ErrorList.get(e.loiCap1)?.name}</td><!--3-->
              <td class ="" style="width:200px">${ErrorList.get(e.loiCap2)?.name}</td>  <!--4-->
              <td class ="" style="width:200px">${ErrorList.get(e.loiCap3)?.name}</td>  <!--5-->
              <td class="" >${e.errorCheck?.name }</td><!--6-->    
	          <td class ="center"><g:formatDate format="dd-MM-yyyy" date="${e.ngayXayRa}"/></td><!--7-->
	          <td style="width:200px">${e.motaChiTiet}</td><!--8-->
	          <td class="" style="width:150px">${e.moTaAnhHuong }</td><!--9-->
	          <td class ="" style="width:150px">${e.bienPhapKhacPhuc}</td><!--10-->	 
	          <td class =""><g:formatDate format="dd-MM-yyyy" date="${e.thoiHanKhacPhuc}"/>  </td><!--11-->
	          <td>${ErrorStatus.get(e.trangThai).nameStatus}</td><!--12-->
	         <!-- THÔNG TIN NGƯỜI GÂY LỖI -->
	          <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
              		${u.userEmail}              		
              		</g:each>
              </td ><!--13-->
              <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
              		${u.levelError}      </br>        		
              		</g:each>
              </td ><!-- 14 -->
              
               <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
              		${u.fullName} </br>              		
              		</g:each>
              </td ><!--15-->
              <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
              		${u.title} </br>        		
              		</g:each>
              </td ><!-- 16 -->
              
	          <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
              		 ${UnitDepart.get(u.tenDonVi1)?.name}   </br>        		
              		</g:each>
              </td ><!-- 17 -->
               <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
              		 ${UnitDepart.get(u.tenDonVi2)?.name}   </br>        		
              		</g:each>
              </td ><!-- +17 -->
              
              <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
                		
                		
                		<g:if test="${u.tenDonVi3.length()>4}">
						     <br>
						</g:if>
						<g:else>
						 ${UnitDepart.get(u.tenDonVi3)?.name}  </br>    
						</g:else>


                	
              			         		
              		</g:each>
              </td ><!-- 18 -->
	          <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
              		${u.bDSUser} </br>      		
              		</g:each>
              </td ><!-- 19 -->
              
              <td >
                	<g:each in="${e.errorUserCreate}" var="u" >
              		${u.codeSalary}   </br>      		
              		</g:each>
              </td ><!-- 20 -->
            <!-- THÔNG TIN NGƯỜI NHẬP LỖI -->
              <td>
              		${e.nguoiNhap}
              </td><!-- 01 -->
              <td>
              		${ErrorMasterUserCreate.findByUserEmail(e.nguoiNhap)?.fullName}
              		        	
              </td><!-- 02 -->
              <td>
              		${ErrorMasterUserCreate.findByUserEmail(e.nguoiNhap)?.title}
              		        	
              </td><!-- 03 -->
              <td>
              		${UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(e.nguoiNhap)?.tenDonVi1)?.name}
              		        	
              </td><!-- 04 -->
              <td>
              		${UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(e.nguoiNhap)?.tenDonVi2)?.name}
              		        	
              </td><!-- 04 -->
              <td>
              		${UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(e.nguoiNhap)?.tenDonVi3)?.name}
              		        	
              </td><!-- 05 -->
              <td>
              		${ErrorMasterUserCreate.findByUserEmail(e.nguoiNhap)?.bDSUser}
              		        	
              </td><!-- 06 -->
              <td>
              		${ErrorMasterUserCreate.findByUserEmail(e.nguoiNhap)?.codeSalary}
              		        	
              </td><!-- 07 -->
              
			<!-- THÔNG TIN KHÁCH HÀNG -->
	          <td class ="">${e.maGiaoDich}</td><!-- 21 -->     
              <td class ="" >${e.giaTriGiaoDich}</td><!-- 22 -->
              <td class ="">${e.loaiTien}</td><!-- 23 -->
              <td class ="">${e.soCifKhachHang}</td><!-- 24 -->
              <td class ="" style="width:150px">${e.tenKhachHang}</td><!-- 25 -->
              <td class ="" style="width:150px">${e.hoSoVaTenHoSo}</td><!-- 26 -->
            <!-- THÔNG TIN KHÁC -->
              <td class ="">${UnitDepart.get(e.tenDonVi1)?.name}</td><!-- 001 -->
			  <td class ="">${UnitDepart.get(e.tenDonVi2)?.name}</td><!-- 002 -->
			  <td class ="">${UnitDepart.get(e.tenDonVi3)?.name}</td><!-- 003 -->
              <td class="" >${e.soLuongKiemTra }</td><!-- 27 -->
              <td class="" >${e.tongSoChonMau }</td><!-- 28 -->                
              <td class ="">
              	<a  href="${resource(dir:'errorFiles',file:e.fileName)}">${e.fileName}</a>
              </td><!-- 29 -->
            
               
             <!-- <td >
                	<g:each in="${e.errorsComments}" var="u" >
              		${u.content} </br>   		
              		</g:each>
              </td > -->  <!-- 30 -->
              
              
             <td >${e.nguoiSua}</td> <!-- 31 -->   
             <g:if test="${e.thoiGianSua==null }">
             		<td class =""><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${e.thoiGianNhapVaoHeThong}"/> </td>	             		
             </g:if>
             <g:else test="${e.thoiGianSua!=null }">
             		<td class =""><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${e.thoiGianSua}"/> </td>
             </g:else><!-- 32 -->
           
             <td class =""><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${e.thoiGianCapNhapTrangThai}"/> </td>	<!-- 33 -->
             
             <td class="" style="width:300px">
             	<g:each in="${e.errorsComments }" var ="u">
             		${"["+u.dateCreated+"]"+" "+"["+u.createdUserUpload+"]:"+" "+u.content}<br>
             	</g:each>
             </td> <!-- 34 -->           
             
              	<sec:ifAnyGranted roles="ROLE_CVQLRR">
			      		<td class ="center"><a href="${createLink(controller:'opError',action:'getErrorDetail',params:[id:e.id])}" >Xem chi tiết</a></td>
				</sec:ifAnyGranted>
					
				<sec:ifNotGranted roles="ROLE_CVQLRR">
						<td class ="center"><a href="${createLink(controller:'opError',action:'viewErrorDetail',params:[id:e.id])}" >Xem chi tiết</a></td>
				</sec:ifNotGranted>

	        </tr>
	        </g:each>

	      </tbody>
	    </table>
      		<button class="btn primary" id="exportExcel" name="exportExcel">Xuất ra excel</button>   
      		<br><br>
      <br>
      </div>
      
        	<%--
               <td class ="center">${ErrorStatus.get(e.trangThai).nameStatus}</td> style="margin-left:1140px;width:100px"
              
              	--%>

    <script type="text/javascript">
    $(document).ready(function(){
    	  set_active_tab('error-managementFull');//top
          $("#error-management-Full").closest('li').addClass('active');//leftMenu
      	set_side_bar(false);
        });
    $("#exportExcel").click(function(){
			$("#actionbutton").val("ExportExcel");
			$("#reportForm").submit();
			$("#actionbutton").val("");
        });
        TableToolsInit.sTitle = "Bao cao loi";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
    
  </body>
</html>
