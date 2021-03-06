<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="comboboxList"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Danh sách Blacklist</title>
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
                                 [href:createLink(controller:'blackList',action:'detailQLTaiSan'),title:'Blacklist quản lý danh sách',label:'Blacklist quản lý danh sách']]
                  ]}" />

			<div class="clear"></div>
		</div>
		<%-- Để gọi đến dialog --%>
		<div id="m-melanin-left-sidebar">
			<g:render template="/blacklist/blacklistSidebar" />
		</div>
	</div>
	<div id="m-melanin-main-content">
			<g:form method="post" name="detailCaNhanBlacklist"
			controller="blackList" action="saveCaNhanBlackList"
			enctype="multipart/form-data">
			<fieldset>
				<legend>Nhập thông tin blacklist</legend>
				<ol class="form form-clear olCenter" id="incidentField">
					<g:if test="${flash.message}">
						<li>
							<div class="${flash.messageType}">
								${flash.message}
							</div>
						</li>
					</g:if>
					<table class="tableControlCenter" style="border:0px !important">
						 <tr style="border:0px ;">
		        			<td style ="border:0px"><label for="khoinhapDsDsBL" class=" lableTableCenter">NHCD/Khối nhập <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="donviDsBL" class=" lableTableCenter">Đơn vị nhập <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="usernhapDsBL" class=" lableTableCenter">User nhập <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="loaiDsBL" class=" lableTableCenter">Loại blacklist <font color="red">*</font> </label></td>    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style= "margin-right: 20px" type= "text" id = "khoinhapDsDsBL" name="khoinhapDsDsBL" value=""  class = "controlTableCenter validate[required]"/></td>
        					<td style ="border:0px"><input style= "margin-right: 20px" type= "text" id = "donviDsBL" name="donviDsBL" value="" class = "controlTableCenter validate[required]"/></td>
        					<td style ="border:0px"><input style= "margin-right: 20px" type= "text" id = "usernhapDsBL" name="usernhapDsBL" value="" class = "controlTableCenter validate[required]"/></td>
        					<td style ="border:0px"><input type= "text" id = "loaiDsBL" name="loaiDsBL" value="" class = "controlTableCenter validate[required]"/></td>
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label for="tungayDsBL" class=" lableTableCenter">Từ ngày nhâp/cập nhập<font color="red">*</font> </label></td>
		        			<td style ="border:0px"><label for="dengayDsBL" class=" lableTableCenter">Đến ngày nhập/cập nhập<font color="red">*</font> </label></td>
		        			<td style ="border:0px"><label for="phanloaiDsBl" class=" lableTableCenter">Phân loại đối tượng <font color="red">*</font> </label></td>    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;" type= "text" id = "tungayDsBL" name="tungayDsBL" value=""  class = "controlTableCenter validate[required]"/></td>
        					<td style ="border:0px"><input style="margin-right: 20px"  type= "text"  id = "dengayDsBL" name="dengayDsBL" value="" class = "controlTableCenter validate[required]"/></td>
        					<td style ="border:0px"><input style="margin-right: 24px"  type= "text"  id= "phanloaiDsBl" name="phanloaiDsBl" value="" class = "controlTableCenter validate[required]"/></td>
        					<td style ="border:0px"><g:submitButton style="margin-left:20px;margin: -1px; width:190px" class="searchButtons btn primary" name="search" value="Lọc thông tin" /></td>
    					</tr>
					</table>
					<%--BEGIN GIRD KẾT QUẢ LỌC --%>
					
					<%--END GIRD KẾT QUẢ LỌC --%>
				</ol>
			</fieldset>
		</g:form>
	</div>
	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			set_active_tab('blacklist-management');//top
			$("#blacklist-quanly-management").closest('li').addClass('active');//leftMenu
			set_side_bar(true); // ẩn hiển thanh menu trái

		});
	</script>
</body>
</html>
