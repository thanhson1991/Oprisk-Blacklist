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
<style type="text/css">
option.white {
	background-color: white;
	color: black;
}

option.green {
	background-color: green;
	color: green;
}

option.orange {
	background-color: orange;
	color: orange;
}

option.red {
	background-color: red;
	color: red;
}

option.black {
	background-color: black;
	color: black;
}
</style>
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
                                 [href:createLink(controller:'kris',action:'krisDisplay'),title:'Danh sách Blacklist',label:'Danh sách Blacklist']]
                  ]}" />

			<div class="clear"></div>
		</div>
		<%-- Để gọi đến dialog --%>
		<div id="m-melanin-left-sidebar">
			<g:render template="blacklistSidebar" />
		</div>
	</div>
	<div id="m-melanin-main-content"></div>
	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			set_active_tab('blacklist-management');//top
			$("#blacklist-management").closest('li').addClass('active');//leftMenu
			set_side_bar(true); // ẩn hiển thanh menu trái

		});
	</script>

</body>
</html>
