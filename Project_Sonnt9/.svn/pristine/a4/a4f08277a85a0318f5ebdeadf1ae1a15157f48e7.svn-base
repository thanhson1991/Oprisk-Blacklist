<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Import blacklist pháp nhân</title>
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
    <g:uploadForm id="formImportCop" name="formImportCop" action="doUploadCop" controller="importExcel">
        <ol class="form form-clear error-form" style="margin-top:0px">
            <li>
                <input type="file" style="width: 250px" id="uploadField" name="uploadField" onchange="ValidateSingleInput(this);" class="validate[required]"/>
            </li>
            <li>
                <a name="templateupload" id="templateupload" href="${resource(dir: 'excelTemplate', file: 'importCOP_Template.xlsx')}">Mẫu file upload</a>
            </li>
            <li>
                <button type="button" name="uploadExcelCop" class="btn primary" id="uploadExcelCop">Upload</button>
                <g:if test="${importCop}">
                    <button type="button" class="btn primary" name="btnTransfer" id="btnTransfer">Lấy dữ liệu từ bảng tạm</button>
                    <button type="button" class="btn primary" name="btnDeleteAll" id="btnDeleteAll">Xóa dữ liệu</button>
                </g:if>
            </li>
        </ol>
    </g:uploadForm>

    <table class="sortDatatablesExport">
        <thead>
        <tr>
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
            <th class="center">Người cập nhập</th>
            <th class="center">Thời gian cập nhập</th>
        </tr>

        </thead>
        <tbody>
        <g:each in="${importCop}" var="p" status="i">
            <tr>
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
                <td class =""><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${p.ngaynhapPnBL}" /></td>
                <td>${p.usernhapPnBL}</td>
                <td>${p.phongbanPnBL }</td>
                <td>${p.nguoisua }</td>
                <td><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${p.ngaysua}" /></td>
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
    $("#uploadExcelCop").live('click',function(e){
        e.preventDefault();
        if ($("form[name=formImportCop]").validationEngine('validate')) {
            jquery_open_load_spinner();
            $('#formImportCop').submit();
            jquery_close_load_spinner();
        }
    });
    $('#btnDeleteAll').live('click',function(e){
        e.preventDefault();
        jquery_confirm("Xóa bảng tạm","Anh/chị đồng ý xóa dữ liệu trong bảng tạm?",
                function(){
                    document.location = "${createLink(controller:'importExcel',action:'deleteImportCop')}";
                });
        return false;
    });
    $('#btnTransfer').live('click',function(e){
        e.preventDefault();
        jquery_confirm("Chuyển dữ liệu","Anh/chị đồng ý chuyển dữ liệu từ bảng tạm vào hệ thống?",
                function(){
                    document.location = "${createLink(controller:'importExcel',action:'transferImportCop')}";
                });
        return false;
    });
    TableToolsInit.sTitle = "DanhSachLoiRutGon";
    TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
</script>

</body>
</html>
