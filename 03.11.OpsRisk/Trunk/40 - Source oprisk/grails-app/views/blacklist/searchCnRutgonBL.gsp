<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Quản lý blacklist cá nhân</title>
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
						[href:createLink(controller:'opError',action:'reportList'),title:'Danh sách blacklist cá nhân',label:'Danh sách blacklist cá nhân']]
					]}" />

			<div class="clear"></div>
		</div>

		<div id="m-melanin-left-sidebar">
				<g:render template="/blacklist/blacklistSidebar" />
		</div>
	</div>
	<div id="m-melanin-main-content">
		<%def today = new Date();%>
		<g:form name="dialogTruyVanCn" id="dialogTruyVanCn" class="form float-left"
			action="detailCaNhan">
			<g:if test="${flash.message}">
				<div id="flash-message" class="message info">
					${flash.message}
				</div>
			</g:if>
			 <g:if test="${flash.error}">
       				 <div id="flash-error" class="alert-message error">${flash.error}</div>
   			 </g:if>
			<g:render template="../blacklist/dialogTruyVanCn" />
			<g:hiddenField name="search" value=""/>
			<g:hiddenField id="actionbutton" name="exportExcel"/>
		</g:form>
        <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
            <button type="button" name="uploadExcelCN" class=" btn primary" id="uploadExcelCN"
                    style="position: relative; float: right; margin-top: 15px;margin-left: 5px">Upload Excel</button>
        </sec:ifAnyGranted>
        <g:form name="blacklist" class="form float-right"
			action="addCnBlacklist">
		<sec:ifAnyGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
			<button name="addComment" class=" btn primary" id="addComment"
				style="position: relative; float: right; margin-top: 15px">Nhập
				thông tin</button>
				</sec:ifAnyGranted>	
		</g:form>
		
		<table class="sortDatatablesExport">
			<thead>
				<tr>
				    <th class="center">ID</th>
					<th class="center">Họ và tên</th>
					<th class="center">Ngày sinh</th>
					<th class="center">CMND/Hộ chiếu</th>			
					<th class="center">Địa chỉ</th>					
					<th class="center">Lý do thuộc danh sách</th>				
					<th class="center">Phân loại đối tượng</th>			
					<th class="center">Ngày nhập</th>
					<th class="center">User nhập</th>
					<th class="center">Phòng/Ban nhập</th>
					<th class="center">Người cập nhật</th>
					<th class="center">Thời gian cập nhật</th>
					<th class="center">Xem </th>
				</tr>

			</thead>
			<tbody>
        <g:each in="${blackListCn}" var="b" status="i">
	        <tr>
	        	  <td >${b.id}</td>
		      	  <td >${b.tenCnBL}</td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${b.ngaysinhCnBL}" /></td> 
	              <td >${b.cmndCnBL}</td>         	           
	              <td >${b.diachiCnBL}</td>	         
	              <td >${b.danhsachCnBL?.name}</td>	       
	              <td >${b.doituongCnBL?.name}</td> 	         
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${b.ngaynhapCnBL}" /></td>
	              <td>${b.usernhapCnBL}</td>
	           	  <td>${b.phongbanCnBl }</td>
	           	  <td>${b.nguoisua }</td>
	           	  <td><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${b.ngaysua}" /></td>           		 
	              <td class ="center"><a id="detail" href="${createLink(controller:'blackList',action:'viewBlacklistCn',params:[blacklistId:b.id])}" >Xem </a></td>						
	        </tr>
	        </g:each>
			</tbody>
		</table>

		<button type="button" class="btn primary" id="exportExcel" name="exportExcel">
			Xuất ra excel</button>
		<br> <br>
	</div>

	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
       $(document).ready(function(){
	        set_active_tab('blacklist-management');//top
	        $("#blacklist-canhanrg-management").closest('li').addClass('active');//leftMenu
	        set_side_bar(true);        
       });
       $("#detail").click( function(){
			$(".hidden").show();	
			});
		
		$("#exportExcel").click(function(){
				$("#actionbutton").val("ExportExcel");
				$("#dialogTruyVanCn").submit();	
				$("#actionbutton").val("");
				
			});
       $("#uploadExcelCN").live('click',function(e){
           document.location = "${createLink(controller:'importExcel',action:'showImportCN')}";
           });

       TableToolsInit.sTitle = "DanhSachLoiRutGon";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
	</script>
</body>
</html>
