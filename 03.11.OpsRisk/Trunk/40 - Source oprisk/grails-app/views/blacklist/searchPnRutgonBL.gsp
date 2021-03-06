<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Quản lý Blacklist pháp nhân</title>
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
						[href:createLink(controller:'opError',action:'reportList'),title:'Danh sách blacklist pháp nhân',label:'Danh sách blacklist pháp nhân']]
					]}" />

			<div class="clear"></div>
		</div>

		<div id="m-melanin-left-sidebar">
				<g:render template="/blacklist/blacklistSidebar" />
		</div>
	</div>
	<div id="m-melanin-main-content">
		<%def today = new Date();%>
		<g:form name="dialogTruyVanPn" id="dialogTruyVanPn" class="form float-left" action="detailPhapNhan">
			<g:if test="${flash.message}">
				<div id="flash-message" class="message info">
					${flash.message}
				</div>
			</g:if>
			 <g:if test="${flash.error}">
       				 <div id="flash-error" class="alert-message error">${flash.error}</div>
   			 </g:if>
			<g:render template="../blacklist/dialogTruyVanPn"/>
			<g:hiddenField name="search" value="search"/>
			<g:hiddenField id="actionbutton" name="exportExcel"/>
		</g:form>
        <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
            <button type="button" name="uploadExcelCop" class=" btn primary" id="uploadExcelCop"
                    style="position: relative; float: right; margin-top: 15px;margin-left: 5px">Upload Excel</button>
        </sec:ifAnyGranted>
		<g:form name="blacklist" class="form float-right"
			action="addPnBlacklist">
			<sec:ifAnyGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
			<button name="addComment" class=" btn primary"
				style="position: relative; float: right; margin-top: 15px">Nhập
				thông tin</button>
				</sec:ifAnyGranted>
		</g:form>
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
					<th class="center">User nhập</th>
					<th class="center">Phòng/Ban nhập</th>
					<th class="center">Người cập nhật</th>
					<th class="center">Thời gian cập nhật</th>
					<th class="center">Xem </th>
				</tr>

			</thead>
			<tbody>
			 <g:each in="${blackListPn}" var="p" status="i">
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
	              <td>${p.usernhapPnBL}</td>
	           	  <td>${p.phongbanPnBL }</td>
	           	  <td>${p.nguoisua }</td>
	           	  <td><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${p.ngaysua}" /></td>           		 
	              <td class ="center"><a href="${createLink(controller:'blackList',action:'viewBlacklistPn',params:[blacklistId:p.id])}" >Xem </a></td>						
	        </tr>
	        </g:each>
			</tbody>
		</table>
		<button class="btn primary" id="exportExcel" name="exportExcel">
			Xuất ra excel</button>
	
		<br> <br>

		<%--	    	<sec:ifNotGranted roles="ROLE_CVQLRR">--%>
		<%--			 <g:form name="opError" class="form" action="errorManagementList">--%>
		<%--				<g:submitButton name="addComment" value="Tạo mới"  />--%>
		<%--			</g:form>--%>
		<%--			</sec:ifNotGranted>--%>
	</div>

	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
       $(document).ready(function(){
    	  
	        set_active_tab('blacklist-management');//top
	        $("#blacklist-phapnhan-management").closest('li').addClass('active');//leftMenu
	        set_side_bar(true);
       });
		$("#exportExcel").click(function(){
				$("#actionbutton").val("ExportExcel");
				$("#dialogTruyVanPn").submit();	
				$("#actionbutton").val("");
			});
       $("#uploadExcelCop").live('click',function(e){
           document.location = "${createLink(controller:'importExcel',action:'showImportCop')}";
       });
       TableToolsInit.sTitle = "DanhSachLoiRutGon";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
	</script>

</body>
</html>
