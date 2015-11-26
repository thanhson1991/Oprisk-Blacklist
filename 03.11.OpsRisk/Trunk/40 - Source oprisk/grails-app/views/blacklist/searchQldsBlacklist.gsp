<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="comboboxList"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Danh sách danh sách Blacklist</title>
</head>
<body>
	<div id="m-melanin-tab-header">
		<div id="m-melanin-tab-header-inner">
			<div id="m-melanin-tab-actions">
				<button class="btn small primary m-melanin-toggle-side-bar"
					name="m-test-button-3" value="Toggle sidebar">Toggle
					sidebar</button>
			</div>
			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
                          items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
                                 [href:createLink(controller:'opError',action:'reportList'),title:'Blacklist quản lý danh sách',label:'Blacklist quản lý danh sách']]
                  ]}" />

			<div class="clear"></div>
		</div>
		<%-- Để gọi đến dialog --%>
		<div id="m-melanin-left-sidebar">
			<g:render template="/blacklist/blacklistSidebar" />
		</div>
	</div>
	<div id="m-melanin-main-content">
		<%def today = new Date();
            	today.setMonth(today.month-1);
            %>
		<g:form name="dialogTruyVanQLDS" id="dialogTruyVanQLDS"	class="form float-left" 
						action="detailQLDanhSach">
			<g:if test="${flash.message}">
				<div id="flash-message" class="message info">
					${flash.message}
				</div>
			</g:if>
			<g:if test="${flash.error}">
       				 <div id="flash-error" class="alert-message error">${flash.error}</div>
   			 </g:if>
			<g:render template="../blacklist/dialogTruyVanQLDS" />
			<g:hiddenField name="search" value="search" />
			<g:hiddenField id="actionbutton" name="exportExcel"/>
		</g:form>
		<%--BEGIN GIRD KẾT QUẢ LỌC --%>
		<g:if test="${loaiDsBL == '1' }">
		<table class="sortDatatablesExport">
			<thead>
				<tr>
					<th class="center">ID</th>
					<th class="center">Họ và tên</th>
					<th class="center">Ngày sinh</th>
					<th class="center">CMND/Hộ chiếu</th>
					<th class="center">Ngày cấp</th>
					<th class="center">Nơi cấp</th>
					<th class="center" width="300px">CMND/Hộ chiếu 2 (Nếu có)</th>
					<th class="center">Ngày cấp</th>
					<th class="center">Nơi cấp</th>
					<th class="center">Địa chỉ</th>
					<th class="center">Số điện thoại</th>
					<th class="center">Lý do thuộc danh sách</th>
					<th class="center">Lý do chi tiết (Nếu có)</th>
					<th class="center">Phân loại đối tượng</th>
					<th class="center">Thời hạn</th>
					<th class="center">Nguồn dữ liệu</th>
					<th class="center">Tên tổ chức có liên quan</th>
					<th class="center">ĐKKD/mã số thuế tổ chức liên quan</th>
					<th class="center">Lý do liên quan</th>
					<th class="center">Ghi chú</th>
					<th class="center">Ngày nhập</th>					
					<th class="center">NHCD/Khối nhập</th>
					<th class="center">Phòng/Ban nhập</th>
					<th class="center">User nhập</th>				
					<th class="center">Người cập nhật</th>
					<th class="center">Thời gian cập nhật</th>
					 
				</tr>

			</thead>
			
				<tbody>
        <g:each in="${dsBlacklist}" var="b" status="i">
	        <tr>
	        	  <td >${b.id}</td>
		      	  <td >${b.tenCnBL}</td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${b.ngaysinhCnBL}" /></td> 
	              <td >${b.cmndCnBL}</td>   
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${b.ngaycapCnBL}" /></td>
	              <td >${b.noicapCnBl}</td>
	              <td >${b.cmnd2CnBL}</td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${b.ngaycap2CnBL}" /></td>
	              <td >${b.noicap2CnBl}</td>
	              <td >${b.diachiCnBL}</td>
	              <td >${b.sdtCnBl}</td>
	              <td >${b.danhsachCnBL?.name}</td>
	              <td >${b.lydochitietCnBL}</td>
	              <td >${b.doituongCnBL?.name}</td> 
	              <td class =""><g:formatDate format="dd-MM-yyyy " date="${b.thoihanCnBL}" /></td>
	              <td >${b.dulieuCnBl}</td>
				  <td >${b.tochucCnBL}</td>
	              <td >${b.masothueCnBL}</td>
	              <td>${b.lydoCnBl}</td>               
	              <td >${b.ghichuCnBL}</td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${b.ngaynhapCnBL}" /></td>
	              <td class="" style="text-align: left">
							${(b.donvi_1)?.name}
				  </td>
	              <td>${b.phongbanCnBl }</td>
	              <td>${b.usernhapCnBL}</td>  
	           	  <td>${b.nguoisua }</td>
	           	  <td><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${b.ngaysua}" /></td>
	           	             		 						
	        </tr>
	        </g:each>
			</tbody>
			</table>
		</g:if>
		<g:if test="${loaiDsBL == '2' }">
		<table class="sortDatatablesExport">
			<thead>
				<tr>
					<th class="center">ID</th>
					<th class="center">Tên doanh nghiệp</th>
					<th class="center">Số ĐKKD/Giấy phép đầu tư</th>
					<th class="center">Ngày cấp ĐKKD</th>
					<th class="center">Nơi cấp ĐKKD</th>
					<th class="center">Địa chỉ DN (Nếu có)</th>
					<th class="center">Mã số thuế/Mã số DN (Nếu có)</th>
					<th class="center">Người đại diện theo pháp luật</th>
					<th class="center">CMTND/Hộ chiếu người đại diện</th>
					<th class="center">Lý do thuộc danh sách</th>
					<th class="center">Lý do chi tiết (Nếu có)</th>
					<th class="center">Phân loại đối tượng</th>
					<th class="center">Thời hạn</th>
					<th class="center">Nguồn dữ liệu</th>
					<th class="center">Cá nhân liên quan</th>
					<th class="center">CMTND/Hộ chiếu cá nhân có liên quan</th>
					<th class="center">Lý do liên quan</th>
					<th class="center">Ghi chú</th>
					<th class="center">Ngày nhập</th>
					<th class="center">NHCD/Khối nhập</th>
					<th class="center">Phòng/Ban nhập</th>
					<th class="center">User nhập</th>					
					<th class="center">Người cập nhật</th>
					<th class="center">Thời gian cập nhật</th>
				
					 
				</tr>

			</thead>
			
				<tbody>
        <g:each in="${dsBlacklist}" var="p" status="i">
	        <tr>
	        	  <td >${p.id}</td>
		      	  <td >${p.tenPnBL}</td>
	              <td >${p.giayphepPnBL}</td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${p.ngaycapPnBL}" /></td> 
	              <td >${p.noicapPnBL}</td>   
	              <td >${p.diachiPnBL}</td>
	              <td >${p.masothuePnBL}</td>
	              <td >${p.phapluatPnBL}</td>
	              <td >${p.cmndPnBL}</td>
	              <td >${p.danhsachPnBL?.name}</td>
	              <td >${p.lydoPnBL}</td>
	              <td >${p.doituongPnBL?.name}</td> 
	              <td class =""><g:formatDate format="dd-MM-yyyy " date="${p.thoihanPnBL}" /></td>
	              <td >${p.dulieuPnBL}</td>                    
	              <td >${p.tochucPnBL}</td>
	              <td >${p.hochieuPnBL}</td>
	              <td>${p.lydoLqPnBL}</td>
	              <td >${p.ghichuPnBL}</td>                  
	              <td class =""><g:formatDate format="dd-MM-yyyy " date="${p.ngaynhapPnBL}" /></td>
	               <td class="" style="text-align: left">
							${(p.donvi_1)?.name}
				  </td>
	              <td>${p.phongbanPnBL }</td>
	              <td>${p.usernhapPnBL}</td>	           	 
	           	  <td>${p.nguoisua }</td>
	           	  <td><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${p.ngaysua}" /></td>
	           	             		 						
	        </tr>
	        </g:each>
			</tbody>
			</table>
		</g:if>
		<g:if test="${loaiDsBL == '3' }">
		<table class="sortDatatablesExport">
			<thead>
				<tr>
					<th class="center">ID</th>
					<th class="center">Loại tài sản</th>
					<th class="center">Thông tin nhận diện</th>
					<th class="center">Mô tả tài sản</th>
					<th class="center">Chủ sở hữu</th>
					<th class="center">CMT/HC chủ sở hữu (Cá nhân)</th>
					<th class="center">ĐKKD/mã số thuế chủ sỡ hữu (Tổ chức)</th>
					<th class="center">Cá nhâ tổ chổ chức liên quan</th>
					<th class="center">CMT/HC/ĐKKD/MST người liên quan</th>
					<th class="center">Lý do liên quan</th>
					<th class="center">Giá trị tài sản</th>
					<th class="center">Lịch sử giao dịch của TSĐB</th>
					<th class="center">Lý do thuộc danh sách</th>
					<th class="center">Lý do chi tiết (nếu có)</th>
					<th class="center">Phân loại đối tượng</th>
					<th class="center">Thời hạn</th>
					<th class="center">Nguồn dữ liệu</th>
					<th class="center">Ghi chú</th>
					<th class="center">Ngày nhập</th>
					<th class="center">NHCD/Khối nhập</th>
					<th class="center">Phòng/Ban nhập</th>
					<th class="center">User nhập</th>				
					<th class="center">Người cập nhật</th>
					<th class="center">Thời gian cập nhật</th>
					 
				</tr>

			</thead>
			
				<tbody>
        <g:each in="${dsBlacklist}" var="p" status="i">
	        <tr>
	        	  <td >${p.id}</td>
		      	  <td >${p.loaiTsBL?.name}</td>
	              <td >${p.thongtinTsBL}</td> 
	              <td >${p.motaTsBL}</td>   
	              <td >${p.sohuuTsBL}</td>
	              <td >${p.cmtcshTsBL}</td>
	              <td >${p.masothueTsBL}</td>
	              <td >${p.canhanTsBL}</td>
	              <td >${p.cmtlqTsBL}</td>
	              <td >${p.lydoTsBL}</td>
	              <td >${p.giatriTsBL}</td>
	              <td >${p.lichsuGdTsBL}</td>
	              <td >${p.riskTsdbTsBL?.name}</td>
	              <td >${p.lydoCtTsBL}</td>
	              <td >${p.doituongTsBL?.name}</td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${p.thoihanTsBL}" /></td> 
	              <td >${p.dulieuTsBL}</td>                    
	              <td >${p.ghichuTsBL}</td>                  
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${p.ngaynhapTsBL}" /></td>
	               <td class="" style="text-align: left">
							${(p.donvi_1)?.name}
				  </td>
	              <td>${p.phongbanTsBl }</td>
	              <td>${p.usernhapTsBL}</td>
	           	  <td>${p.nguoisua }</td>
	           	  <td><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${p.ngaysua}" /></td>
	           	             		 						
	        </tr>
	        </g:each>
			</tbody>
			</table>
		</g:if>
		<button class="btn primary" id="exportExcel" name="exportExcel">
			Xuất ra excel</button>
		
			<br> <br>
		<%--END GIRD KẾT QUẢ LỌC --%>
	</div>
	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			set_active_tab('blacklist-management');//top
			$("#blacklist-quanly-management").closest('li').addClass('active');//leftMenu
			set_side_bar(true); // ẩn hiển thanh menu trái

		});
		$("#exportExcel").click(function(){
			$("#actionbutton").val("ExportExcel");
			$("#dialogTruyVanQLDS").submit();	
			$("#actionbutton").val("");
		});
		 $("select[name=donvi1]").change(function(){
	            $("select[name=donvi2]").html("");
	            if ($(this).val()){
	                $.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/donvi1',
	                        $("form[name=dialogTruyVanQLDS]").serialize(),function(data){
	                            $("select[name=donvi2]").html(data);
	                        });
	            } else{
	                $("select[name=donvi2]").html("");
	            }
	            $("select[name=donvi2]").change()
		 });
		 $("select[name=donvi1]").change(function(){
			 
		 });
	</script>
</body>
</html>
