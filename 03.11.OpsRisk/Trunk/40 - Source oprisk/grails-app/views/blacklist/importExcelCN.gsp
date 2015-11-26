<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Import blacklist cá nhân</title>
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
    <g:uploadForm id="formImportCN" name="formImportCN" action="doUploadCN" controller="importExcel">
        <ol class="form form-clear error-form" style="margin-top:0px">
            <li>
                <input type="file" style="width: 250px" id="uploadField" name="uploadField" onchange="ValidateSingleInput(this);" class="validate[required]"/>
            </li>
            <li>
                <a name="templateupload" id="templateupload" href="${resource(dir: 'excelTemplate', file: 'importCN_Template.xlsx')}">Mẫu file upload</a>
            </li>
            <li>
                <button type="button" name="uploadExcelCN" class="btn primary" id="uploadExcelCN">Upload</button>
                <g:if test="${importCN}">
                    <button type="button" class="btn primary" name="btnTransfer" id="btnTransfer">Lấy dữ liệu từ bảng tạm</button>
                    <button type="button" class="btn primary" name="btnDeleteAll" id="btnDeleteAll">Xóa dữ liệu</button>
                </g:if>
            </li>
        </ol>
    </g:uploadForm>

    <table class="sortDatatablesExport">
        <thead>
        <tr>
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
            <th class="center">User nhập</th>
            <th class="center">Phòng/Ban nhập</th>
            <th class="center">Người cập nhập</th>
            <th class="center">Thời gian cập nhập</th>
        </tr>

        </thead>
        <tbody>
        <g:each in="${importCN}" var="b" status="i">
            <tr>
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
                <td class =""><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${b.ngaynhapCnBL}" /></td>
                <td>${b.usernhapCnBL}</td>
                <td>${b.phongbanCnBl }</td>
                <td>${b.nguoisua }</td>
                <td><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${b.ngaysua}" /></td>
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
                if(oInput.files[0].size > 1024 * 1024 * 2){
                    jquery_alert("File quá lớn","Chỉ chấp nhận file <= 2MB");
                    oInput.value = "";
                    return false;
                }
            }
        }
        return true;
    }
    $(document).ready(function(){
        set_active_tab('blacklist-management');//top
        $("#blacklist-canhan-management").closest('li').addClass('active');//leftMenu
        set_side_bar(true);
    });
    $("#exportExcel").click(function(){
        $("#actionbutton").val("ExportExcel");
        $("#reportForm").submit();
        $("#actionbutton").val("");
    });
    $("#uploadExcelCN").live('click',function(e){
        e.preventDefault();
        if ($("form[name=formImportCN]").validationEngine('validate')) {
            jquery_open_load_spinner();
            $('#formImportCN').submit();
            jquery_close_load_spinner();
        }
    });
    $('#btnDeleteAll').live('click',function(e){
        e.preventDefault();
        jquery_confirm("Xóa bảng tạm","Anh/chị đồng ý xóa dữ liệu trong bảng tạm?",
                function(){
                    document.location = "${createLink(controller:'importExcel',action:'deleteImportCN')}";
                });
        return false;
    });
    $('#btnTransfer').live('click',function(e){
        e.preventDefault();
        jquery_confirm("Chuyển dữ liệu","Anh/chị đồng ý chuyển dữ liệu từ bảng tạm vào hệ thống?",
                function(){
                    document.location = "${createLink(controller:'importExcel',action:'transferImportCN')}";
                });
        return false;
    });
    TableToolsInit.sTitle = "DanhSachLoiRutGon";
    TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
</script>

</body>
</html>
