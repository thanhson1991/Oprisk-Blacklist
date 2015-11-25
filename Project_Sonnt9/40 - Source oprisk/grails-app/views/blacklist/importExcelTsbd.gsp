<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Import blacklist tài sản đảm bảo</title>
</head>
<body>
<div id="m-melanin-tab-header">
    <div id="m-melanin-tab-header-inner">
        <div id="m-melanin-tab-actions">
            <button class="btn small primary m-melanin-toggle-side-bar"
                    name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>
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
    <g:if test="${flash.message}">
        <div id="flash-message" class="message info">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div id="flash-error" class="alert-message error">${flash.error}</div>
    </g:if>
    <g:uploadForm id="formImportTsbd" name="formImportTsbd" action="doUploadTsbd" controller="importExcel">
        <ol class="form form-clear error-form" style="margin-top:0px">
            <li>
                <input type="file" style="width: 250px" id="uploadField" name="uploadField" onchange="ValidateSingleInput(this);" class="validate[required]"/>
            </li>
            <li>
                <a name="templateupload" id="templateupload" href="${resource(dir: 'excelTemplate', file: 'importTSBD_Template.xlsx')}">Mẫu file upload</a>
            </li>
            <li>
                <button type="button" name="uploadExcelTsbd" class="btn primary" id="uploadExcelTsbd">Upload</button>
                <g:if test="${importTsbd}">
                    <button type="button" class="btn primary" name="btnTransfer" id="btnTransfer">Lấy dữ liệu từ bảng tạm</button>
                    <button type="button" class="btn primary" name="btnDeleteAll" id="btnDeleteAll">Xóa dữ liệu</button>
                </g:if>
            </li>
        </ol>
    </g:uploadForm>

    <table class="sortDatatablesExport">
        <thead>
        <tr>
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
					<th class="center">User nhập</th>
					<th class="center">Phòng/Ban nhập</th>
					<th class="center">Người cập nhập</th>
					<th class="center">Thời gian cập nhập</th>
        </tr>

        </thead>
        <tbody>
        <g:each in="${importTsbd}" var="p" status="i">
            <tr>
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
	              <td>${p.usernhapTsBL}</td>
	           	  <td>${p.phongbanTsBl }</td>
	           	  <td>${p.nguoisua }</td>
	           	  <td><g:formatDate format="dd-MM-yyyy" date="${p.ngaysua}" /></td> 
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script class="jsbin"
        src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
<script type="text/javascript">
    var _validFileExtensions = [".xlsx"];
    function ValidateSingleInput(oInput) {
        if (oInput.type == "file") {
            var sFileName = oInput.value;
            if (sFileName.length > 0) {
                var blnValid = false;
                for (var j = 0; j < _validFileExtensions.length; j++) {
                    var sCurExtension = _validFileExtensions[j];
                    if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
                        blnValid = true;
                        break;
                    }
                }

                if (!blnValid) {
                    jquery_alert("Sai định dạng file","Chỉ chấp nhận định dạng : " + _validFileExtensions.join(", "));
                    oInput.value = "";
                    return false;
                }
            }
        }
        return true;
    }
    $(document).ready(function(){
        set_active_tab('blacklist-management');//top
        $("#blacklist-phapnhan-management").closest('li').addClass('active');//leftMenu
        set_side_bar(true);
    });
    $("#uploadExcelTsbd").live('click',function(e){
        e.preventDefault();
        if ($("form[name=formImportTsbd]").validationEngine('validate')) {
            jquery_open_load_spinner();
            $('#formImportTsbd').submit();
            jquery_close_load_spinner();
        }
    });
    $('#btnDeleteAll').live('click',function(e){
        e.preventDefault();
        jquery_confirm("Xóa bảng tạm","Anh/chị đồng ý xóa dữ liệu trong bảng tạm?",
                function(){
                    document.location = "${createLink(controller:'importExcel',action:'deleteImportTsbd')}";
                });
        return false;
    });
    $('#btnTransfer').live('click',function(e){
        e.preventDefault();
        jquery_confirm("Chuyển dữ liệ","Anh/chị đồng ý chuyển dữ liệu từ bảng tạm vào hệ thống?",
                function(){
                    document.location = "${createLink(controller:'importExcel',action:'transferImportTsbd')}";
                });
        return false;
    });
    TableToolsInit.sTitle = "DanhSachLoiRutGon";
    TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
</script>

</body>
</html>
