%{--<%pac %>--}%

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="comboboxList" %>
<html>
<head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý KRI</title>
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
                                 [href:createLink(controller:'kris',action:'krisManage'),title:'Quản lý KRIs',label:'Quản lý KRIs']]
                  ]}"/>
    </div>
    <div class="clear"></div>
</div>
<div id="m-melanin-left-sidebar">
    <g:render template="krisSidebar"/>
</div>
<div id="m-melanin-main-content">
    <%def today = new Date();
    def year3later = new Date();
        year3later.setYear(year3later.year+3);
    %>
<g:form method="post" name="KRImanageFrom" id="KRImanageFrom" controller="kris" action="saveKRI" enctype="multipart/form-data">
    <g:if test="${flash.message}">
        <div id="flash-message" class="message info">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div id="flash-error" class="alert-message error">${flash.error}</div>
    </g:if>
<fieldset class="info" style="width: 900px">
<legend>Nhập thông tin KRI</legend>

<ol class="form form-clear olCenter" id="incidentField">

%{--<g:if test="${flash.message}">
    <li>
        <div class="${flash.messageType}">${flash.message}</div>
    </li>
</g:if>--}%
<g:hiddenField name="krisID" id="krisID" value="${kriDetails?.id}"/>
<g:hiddenField id="hfDeleteFile" name="hfDeleteFile" value="notDeletefile"/>
<g:hiddenField id = "delete" name = "delete"/>
<table class="tableControlCenter" style="border:0px !important">
    <tr style="border:0px ;">
        <td style ="border:0px"><label for="maKRI" class=" lableTableCenter">Mã KRI<font color="red">*</font> </label></td>
        <td style ="border:0px"><label for="ttKRI" class=" lableTableCenter">Tiêu đề KRI<font color="red">*</font> </label></td>
        <td style ="border:0px"><label for="maRR" class=" lableTableCenter">Mã/Tên rủi ro<font color="red"></font> </label></td>
    </tr>
    <tr style="border:0px ;">
        <td style ="border:0px"><input type= "text" id = "maKRI" name="maKRI" value="${kriDetails?.maKRI}" class = "controlTableCenter validate[required]"/></td>
        <td style ="border:0px"><input type= "text" id = "ttKRI" name="ttKRI" value="${kriDetails?.ttKRI}" class = "controlTableCenter validate[required]"/></td>
        <td style ="border:0px"><input type= "text" id = "maRR" name="maRR" value="${kriDetails?.maRR}" class = "controlTableCenter"/></td>
    </tr>
</table>
<li>
    <table class="tableControlCenter" style="border:0px !important">
        <tr style ="border:0px">
            <td style ="border:0px"><label for="loaiKRI" class="lableTableCenter">Loại KRI<font color="red">*</font></label></td>
            <td style ="border:0px"><label for="motaKRI" class="lableTableCenter">Mô tả KRI<font color="red">*</font></label></td>
        </tr>
        <tr style="border:0px ">
            <td style="border:0px "><g:select id="loaiKRI" name="loaiKRI" value="${kriDetails?.loaiKRI}" style="width: 187px" class = "controlTableCenter validate[required]" from="${comboboxList.listKRIType()}" optionKey="value" noSelection="${['':'']}"/></td>
            <td style="border:0px "><g:textArea name="motaKRI"  cols="140" rows="1" value="${kriDetails?.motaKRI}" class="controlTableCenter validate[required]" id="motaKRI" style="width: 368px"/></td>
        </tr>
    </table>
</li>
<li>
    <table class="tableControlCenter" style="border:0px">
        <tr style="border:0px ;">
            <td style="border:0px "><label for="donvi1" class="lableTableCenter" style="border:0px" >NH chuyên doanh/ khối</label></td>
            <td style="border:0px "><label for="donvi2" class="lableTableCenter">CN Trung tâm/ Phòng</label></td>
            <td style="border:0px "><label for="donvi3" class="lableTableCenter">PGD/ phòng ban/ tổ nhóm </label></td>
        </tr>
        <tr style="border:0px">
            <td style ="border:0px"><g:select name="donvi1" id="donvi1"
                                              from="${donvi1}"
                                              optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"
                                              class="largeControlCenter controlComboboxTableCenter" value="${kriDetails?.donvi_1?.id?kriDetails?.donvi_1?.id:currentUser?.tenDonVi1}"/></td>
            <td style ="border:0px">
                <g:select name="donvi2" id="donvi2"  class="largeControlCenter controlComboboxTableCenter" from="${donvi2}"
                          optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"  value="${kriDetails?.donvi_2?.id?kriDetails?.donvi_2?.id:currentUser?.tenDonVi2}"/></td>

            <td style ="border:0px"><g:select class="largeControlCenter controlComboboxTableCenter" id="donvi3" name="donvi3" from="${donvi3}"
                                              optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}" value="${kriDetails?.donvi_3?.id?kriDetails?.donvi_3?.id:currentUser?.tenDonVi3}"/></td>
        </tr>

        <tr style="border:0px">
        <td style="border:0px " ><label for="tstd" class="lableTableCenter">Tần suất theo dõi</label></td>
        <td style="border:0px "><label for="dvdl" class="lableTableCenter">Đơn vị đo lường</label></td>
        <td style="border:0px "><label for="ctdl" class="lableTableCenter">Công thức đo lường </label></td>
        </tr>
        <tr style="border:0px">
            <td style="border:0px "><input type="text" id="tstd" name="tstd" value="${kriDetails?.tstd?kriDetails.tstd:'Hàng tháng'}" class="controlTableCenter validate[required]"/></td>
            <td style="border:0px "><input type="text" id="dvdl" name="dvdl" value="${kriDetails?.dvdl}" class="controlTableCenter validate[required]"/></td>
            <td style="border:0px "><input type="text" id="ctdl" name="ctdl" value="${kriDetails?.ctdl}" class="controlTableCenter validate[required]"/></td>
        </tr>
        <tr style="border:0px">
            <td style="border:0px "><label for="nguonsl" class="lableTableCenter">Nguồn số liệu</label></td>
            <td style="border:0px "><label for="donviccsl" class="lableTableCenter">Đơn vị cung cấp số liệu</label></td>
        </tr>
        <tr style="border:0px">
            <td style="border:0px "><input type="text" id="nguonsl" name="nguonsl" value="${kriDetails?.nguonsl}" class="controlTableCenter validate[required]"/></td>
            <td style="border:0px "><input type="text" id="donviccsl" name="donviccsl" value="${kriDetails?.donviccsl}" class="controlTableCenter validate[required]"/></td>
        </tr>

        <tr style="border:0px">
            <td style="border:0px " ><label for="rrhd1" class="lableTableCenter">Phân loại theo sự kiện RRHĐ cấp 1</label></td>
            <td style="border:0px "><label for="rrhd2" class="lableTableCenter">Phân loại theo sự kiện RRHĐ cấp 2</label></td>
            <td style="border:0px "><label for="rrhd3" class="lableTableCenter">Phân loại theo sự kiện RRHĐ cấp 3</label></td>
        </tr>
        <tr style="border:0px">
            <td style="border:0px " ><g:select name="rrhd1" id="rrhd1" from="${Event.executeQuery('from Event e where e.ord=0')}"
                      optionKey="id" optionValue="name"
                      noSelection="${['':'']}" class="controlTableCenter" style="width: 188px" value="${kriDetails?.rrhd1}"/></td>

            <td style="border:0px " ><g:select name="rrhd2" id="rrhd2" from="${Event.executeQuery('from Event e where e.ord=1')}"
                      optionKey="id"
                      optionValue="name"
                      noSelection="${['':'']}" class="controlTableCenter" style="width: 188px" value="${kriDetails?.rrhd2}"/></td>
            <td style="border:0px "><input type="text" id="rrhd3" name="rrhd3" class="controlTableCenter" value="${kriDetails?.rrhd3}"/></td>
        </tr>
        <tr style="border:0px">
            <td style="border:0px " ><label for="nguong1" class="lableTableCenter">Ngưỡng 1<font color="red">*</font></label></td>
            <td style="border:0px "><label for="nguong2" class="lableTableCenter">Ngưỡng 2<font color="red">*</font></label></td>
            <td style="border:0px "><label for="nguong3" class="lableTableCenter">Ngưỡng 3<font color="red">*</font></label></td>
            <td style="border:0px "><label for="nguonggh" class="lableTableCenter">Ngưỡng giới hạn<font color="red">*</font></label></td>
        </tr>
        <tr style="border:0px">
            <td style="border:0px "><input type="text" id="nguong1" name="nguong1" value="${kriDetails?.nguong1}" class="controlTableCenter validate[required,custom[number2]]"/></td>
            <td style="border:0px "><input type="text" id="nguong2" name="nguong2" value="${kriDetails?.nguong2}" class="controlTableCenter validate[required,custom[number2]]"/></td>
            <td style="border:0px "><input type="text" id="nguong3" name="nguong3" value="${kriDetails?.nguong3}" class="controlTableCenter validate[required,custom[number2]]"/></td>
            <td style="border:0px "><input type="text" id="nguonggh" name="nguonggh" value="${kriDetails?.nguonggh}" class="controlTableCenter validate[required,custom[number2]]"/></td>
        </tr>
        <tr style="border:0px">
            <td style="border:0px " ><label for="emailcb1" class="lableTableCenter">Email nhận cảnh báo ngưỡng 1<font color="red">*</font></label></td>
            <td style="border:0px "><label for="emailcb2" class="lableTableCenter">Email nhận cảnh báo ngưỡng  2<font color="red">*</font></label></td>
            <td style="border:0px "><label for="emailcb3" class="lableTableCenter">Email nhận cảnh báo ngưỡng  3<font color="red">*</font></label></td>
            <td style="border:0px "><label for="emailcbgh" class="lableTableCenter">Email nhận cảnh báo ngưỡng  giới hạn<font color="red">*</font></label></td>
        </tr>
        <tr style="border:0px">
            <td style="border:0px "><input type="text" id="emailcb1" name="emailcb1" value="${kriDetails?.emailcb1}" class="controlTableCenter validate[required,custom[email]]"/></td>
            <td style="border:0px "><input type="text" id="emailcb2" name="emailcb2" value="${kriDetails?.emailcb2}" class="controlTableCenter validate[required,custom[email]]"/></td>
            <td style="border:0px "><input type="text" id="emailcb3" name="emailcb3" value="${kriDetails?.emailcb3}" class="controlTableCenter validate[required,custom[email]]"/></td>
            <td style="border:0px "><input type="text" id="emailcbgh" name="emailcbgh" value="${kriDetails?.emailcbgh}" class="controlTableCenter validate[required,custom[email]]"/></td>
        </tr>
    </table>

</li>
<li>
    <label  class="incident_label ">Người chịu trách nhiệm quản lý KRI</label>
</li>

<li>

    <table class="tableControlCenter">
        <tr>
            <td> <label for="OutLook1" class="nguoiso">UserOutlook</label> </td>
            <td> <label for="HoVaTen1" class="hovaten">Họ và tên</label></td>
            <td> <label for="ChucDanh1" class="chucdanh">Chức danh</label></td>

        </tr>
        <tr>
            <td><input style="width:177px !important" class="errorManagement outlooknameBlur validate[required]"  tid="1" name ="OutLook1" id="OutLook1" value="${kriDetails?.user_tn?.userEmail}" /> </td>
            <td> <input class="errorHoVaTen validate[required]"  name ="HoVaTen1" id="HoVaTen1" readonly="readonly" value="${kriDetails?.user_tn?.fullName}" width="100px" /></td>
            <td> <input class="errorChucDanh validate[required]"  name ="ChucDanh1" id="ChucDanh1" readonly="readonly" width="100px" value="${kriDetails?.user_tn?.title}"/></td>
        </tr>
        <tr>
            <td> <label for="NHCD1" class="NHCD">NH Chuyên doanh/Khối</label></td>
            <td> <label for="TenDonVi1" class="TenDonVi">CN/Trung tâm/Phòng</label></td>
            <td> <label for="PGD1" class="PGD">PGD/Phòng ban/Tổ Nhóm</label></td>

        </tr>

        <tr>
            <td><input class="errorNHCD validate[required]"  name ="NHCD1" id="NHCD1" value="${user_tn_dv1?.name}" width="100px" style="!important" readonly="readonly"/></td>
            <td><input class="errorTenDonVi validate[required]"  name ="TenDonVi1" id="TenDonVi1" value="${user_tn_dv2?.name}" width="100px" readonly="readonly"  />         </td>
            <td><input class="errorPGD validate[required]"  name ="PGD1" id="PGD1" value="${user_tn_dv3?.name}" width="100px" readonly="readonly"  />         </td>
            <td>
                <g:hiddenField class="errorNHCDId" id="NHCD_Id1" name="NHCD_Id1" />
                <g:hiddenField class="errorTenDonViId"  id="TenDonVi_Id1" name="TenDonVi_Id1" />
                <g:hiddenField class="errorPGDId"  id="PGD_Id1" name="PGD_Id1" />
            </td>
            <td></td>
        </tr>
    </table>
</li>

<li>
    <label  class="incident_label ">Người phê duyệt KRI</label>
</li>

<li>

    <table class="tableControlCenter">
        <tr>
            <td> <label for="OutLook2" class="nguoiso">UserOutlook</label> </td>
            <td> <label for="HoVaTen2" class="hovaten">Họ và tên</label></td>
            <td> <label for="ChucDanh2" class="chucdanh">Chức danh</label></td>

        </tr>
        <tr>
            <td><input style="width:177px !important" class="errorManagement outlooknameBlur validate[required]"  tid="2" name ="OutLook2" id="OutLook2" value="${kriDetails?.user_pd?.userEmail}" /> </td>
            <td> <input class="errorHoVaTen validate[required]"  name ="HoVaTen2" id="HoVaTen2" readonly="readonly" value="${kriDetails?.user_pd?.fullName}" width="100px" /></td>
            <td> <input class="errorChucDanh validate[required]"  name ="ChucDanh2" id="ChucDanh2" value="${kriDetails?.user_pd?.title}" readonly="readonly" width="100px" /></td>

        </tr>
        <tr>
            <td> <label for="NHCD2" class="NHCD">NH Chuyên doanh/Khối</label></td>
            <td> <label for="TenDonVi2" class="TenDonVi">CN/Trung tâm/Phòng</label></td>
            <td> <label for="PGD2" class="PGD">PGD/Phòng ban/Tổ Nhóm</label></td>

        </tr>

        <tr>
            <td><input class="errorNHCD validate[required]"  name ="NHCD2" id="NHCD2" value="${user_pd_dv1?.name}" width="100px" style="!important" readonly="readonly" /></td>
            <td><input class="errorTenDonVi validate[required]"  name ="TenDonVi2" id="TenDonVi2" value="${user_pd_dv2?.name}" width="100px" readonly="readonly"  />         </td>
            <td><input class="errorPGD validate[required]"  name ="PGD2" id="PGD2" value="${user_pd_dv3?.name}" width="100px" readonly="readonly" />         </td>
            <td>
                <g:hiddenField class="errorNHCDId" id="NHCD_Id2" name="NHCD_Id2" />
                <g:hiddenField class="errorTenDonViId"  id="TenDonVi_Id2" name="TenDonVi_Id2" />
                <g:hiddenField class="errorPGDId"  id="PGD_Id2" name="PGD_Id2" />
            </td>
            <td></td>
        </tr>
    </table>
</li>
<li>
    <table class="tableControlCenter" style="border: 0px">
    <tr style="border:0px">
        <td style="border:0px" ><label for="ngay_pd" class="lableTableCenter">Ngày phê duyệt<font color="red">*</font></label></td>
        <td style="border:0px"><label for="ngay_cn" class="lableTableCenter">Ngày cập nhật<font color="red">*</font></label></td>
        <td style="border:0px"><label class="lableTableCenter"></label></td>
    </tr>
    <tr style="border:0px">
        <td style="border:0px"><input style="width: 177px" type="text" id="ngay_pd" name="ngay_pd" value="${formatDate(format: 'dd/MM/yyyy', date: kriDetails?.ngay_pd)?formatDate(format: 'dd/MM/yyyy', date: kriDetails?.ngay_pd):DateUtil.formatDate(today)}" class="controlTableCenter datetime validate[required]"/></td>
        <td style="border:0px"><input style="width: 177px;" type="text" id="ngay_cn" name="ngay_cn" value="${formatDate(format: 'dd/MM/yyyy', date: kriDetails?.ngay_cn)?formatDate(format: 'dd/MM/yyyy', date: kriDetails?.ngay_cn):DateUtil.formatDate(today)}" class="controlTableCenter datetime validate[required]"/></td>
        <td style="border:0px "><label class="lableTableCenter"></label></td>
    </tr>
    </table>
</li>
<li>
    <table class="tableControlCenter">
    <tr style="border:0px">
        <td style="border:0px "><label for="trang_thai" class="lableTableCenter">Trạng thái<font color="red">*</font></label></td>
        <td style="border:0px "><label for="ngay_bd_td" class="lableTableCenter">Ngày bắt đầu theo dõi<font color="red">*</font></label></td>
        <td style="border:0px "><label for="ngay_kt_td" class="lableTableCenter">Ngày kết thúc theo dõi<font color="red">*</font></label></td>
    </tr>
    <tr style="border:0px">
        <td style="border:0px "><g:select id="trang_thai" name="trang_thai" from="${comboboxList.listStatus()}" optionKey="value" value="${kriDetails?.trang_thai}" style="width:188px"></g:select></td>
        <td style="border:0px "><input type="text" id="ngay_bd_td" name="ngay_bd_td" value="${formatDate(format: 'dd/MM/yyyy', date: kriDetails?.ngay_bd_td)?formatDate(format: 'dd/MM/yyyy', date: kriDetails?.ngay_bd_td):DateUtil.formatDate(today)}" class="controlTableCenter datetime validate[required]"/></td>

    </tr>
    </table>
</li>
<li>
    <label for="ghi_chu" class="lableTableCenter">Ghi chú</label>
</li>
<li>
    <g:textArea name="ghi_chu"  class="largeControlTextCenter" rows="3" id="ghi_chu" value="${kriDetails?.ghi_chu}"/>
</li>
    <li>
        <label for="uploadFile" class="lableCenter ">Hồ sơ đính kèm:</label>
        <br>
        <div id="fileUploadx" >

            <g:if test="${kriDetails?.fileName!=null}">

                <label style="width:50px "  class="">Tên file:</label>
                <g:link style="margin-left:0px !important"  id="lblFilename" url="${resource(dir:'krisFile',file:kriDetails?.fileName)}">${kriDetails?.fileName }</g:link>

                <input type="hidden" width="100px" name="fileName" value="${kriDetails?.fileName }" />
                <button type="button" class="btn primary" id="deleteFile" name="deleteFile" value="deleteFile">Xóa file</button>

                <br>
            </g:if>
        </div>
        <br>
        <input type="file" id="uploadFile" name="uploadFile" size="79px"></input>
    </li>
<li>
    <g:if test="${kriDetails}">
        <sec:ifAnyGranted roles="ROLE_CVQLRR">
        <button value="saveEdit" class="btn primary"  id ="saveEdit" name="saveEdit">Lưu</button>
        <button value="addNewKRI" class="btn primary"  id ="addNewKRI" name="addNewKRI">Lưu mới</button>
        <button type="button" class="btn primary"  id ="deleteKRI" name="deleteKRI">Xóa</button>
        <button type="button" value="cancelEdit" class="btn primary"  id ="cancelEdit" name="cancelEdit">Hủy</button>
        </sec:ifAnyGranted>
        <sec:ifNotGranted roles="ROLE_CVQLRR">
            <g:if test="${kriDetails.loaiKRI == comboboxList.TH.value && kriDetails.usernhap == nowUser}">
            <button type="button" class="btn primary"  id ="deleteKRI" name="deleteKRI">Xóa</button>
            </g:if>
            <g:if test="${kriDetails.loaiKRI == comboboxList.CT.value && (kriDetails.usernhap == nowUser || kriDetails.user_tn == nowUser || kriDetails.user_pd == nowUser)}">
                <button value="saveEdit" class="btn primary"  id ="saveEdit" name="saveEdit">Lưu</button>
                <button value="addNewKRI" class="btn primary"  id ="addNewKRI" name="addNewKRI">Lưu mới</button>
                <button type="button" class="btn primary"  id ="deleteKRI" name="deleteKRI">Xóa</button>
                <button type="button" value="cancelEdit" class="btn primary"  id ="cancelEdit" name="cancelEdit">Hủy</button>
            </g:if>

        </sec:ifNotGranted>

    </g:if>
    <g:else>
        <button value="addNewKRI" class="btn primary"  id ="addNewKRI" name="addNewKRI">Lưu mới</button>
        <button type="button" value="cancelEdit" class="btn primary"  id ="cancelEdit" name="cancelEdit">Hủy</button>
    </g:else>

</li>
</ol>
</fieldset>
</g:form>
</div>


<script type="text/javascript">
   /*$(".onlyNumber").blur(function(){

        $(this).parseNumber({format:"#,###.###", locale:"us"});
        $(this).formatNumber({format:"#,###.###", locale:"us"});

    });
    $(".onlyNumber2").blur(function(){

        $(this).parseNumber({format:"#######", locale:"us"});
        $(this).formatNumber({format:"#######", locale:"us"});

    });*/
   $.fn.validationEngineLanguage = function(){
   };
   $.validationEngineLanguage = {
       newLang: function(){
           $.validationEngineLanguage.allRules = {
               "required": { // Add your regex rules here, you can take telephone as an example
                   "regex": "none",
                   "alertText": "* Xin vui lòng điền vào ô này",
                   "alertTextCheckboxMultiple": "* Xin chọn một option",
                   "alertTextCheckboxe": "* Xin vui lòng chọn checkbox này",
                   "alertTextDateRange": "* Xin vui lòng điền vào ngày."
               },
               "dateRange": {
                   "regex": "none",
                   "alertText": "* Ngày ",
                   "alertText2": "không hợp lệ"
               },
               "dateTimeRange": {
                   "regex": "none",
                   "alertText": "* Giờ ",
                   "alertText2": "không hợp lệ"
               },
               "minSize": {
                   "regex": "none",
                   "alertText": "* Ô này chấp nhận ít nhất ",
                   "alertText2": " ký tự"
               },
               "maxSize": {
                   "regex": "none",
                   "alertText": "* Ô này chấp nhận tối đa ",
                   "alertText2": " ký tự"
               },
               "groupRequired": {
                   "regex": "none",
                   "alertText": "* Bạn cần điền số CMND hoặc Điện thoại"
               },
               "min": {
                   "regex": "none",
                   "alertText": "* Sai giá trị. Tối thiểu: "
               },
               "max": {
                   "regex": "none",
                   "alertText": "* Sai giá trị. Tối đa: "
               },
               "past": {
                   "regex": "none",
                   "alertText": "* Sai giá trị. Ngày nhỏ hơn "
               },
               "future": {
                   "regex": "none",
                   "alertText": "* Sai giá trị. Ngày lớn hơn  "
               },
               "maxCheckbox": {
                   "regex": "none",
                   "alertText": "* Bạn chỉ được chọn tối đa ",
                   "alertText2": " options"
               },
               "minCheckbox": {
                   "regex": "none",
                   "alertText": "* Bạn phải chọn ít nhất ",
                   "alertText2": " options"
               },
               "equals": {
                   "regex": "none",
                   "alertText": "* Dữ liệu nhập lại không chính xác."
               },
               "phone": {
                   // credit: jquery.h5validate.js / orefalo
                   "regex": /^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/,
                   "alertText": "* Sai số điện thoại"
               },
               "email": {
                   // Shamelessly lifted from Scott Gonzalez via the Bassistance Validation plugin http://projects.scottsplayground.com/email_address_validation/
                   "regex": /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,
                   "alertText": "* Email không hợp lệ"
               },
               "integer": {
                   "regex": /^[\-\+]?\d+$/,
                   "alertText": "* Bạn chỉ được phép điền số"
               },
               "number2": {
                   // Number, including positive, negative, and floating decimal. credit: orefalo
                   "regex": /^(([0-9]+)([\.]([0-9]+))?|([\.]([0-9]+))?)$/,
                   "alertText": "* Bạn chỉ được phép điền số thực dương"
               },
               "number": {
                   // Number, including positive, negative, and floating decimal. credit: orefalo
                   "regex": /^[\-\+]?(([0-9]+)([\.,]([0-9]+))?|([\.,]([0-9]+))?)$/,
                   "alertText": "* Bạn chỉ được phép điền số"
               },
               "date": {
                   "regex": /^(0?[1-9]|[12][0-9]|3[01])[\/](0?[1-9]|1[012])[\/]\d{4}$/,
                   "alertText": "* Ngày không hợp lệ, format DD/MM/YYYY"
               },
               "ipv4": {
                   "regex": /^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/,
                   "alertText": "* Invalid IP address"
               },
               "url": {
                   "regex": /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
                   "alertText": "* URL không hợp lệ"
               },
               "onlyNumberSp": {
                   "regex": /^[0-9\ ]+$/,
                   "alertText": "* Bạn chỉ được phép điền số"
               },
               "onlyLetterSp": {
                   "regex": /^[a-zA-Z\ \']+$/,
                   "alertText": "* Bạn chỉ được phép điền chữ"
               },
               "onlyLetterNumber": {
                   "regex": /^[0-9a-zA-Z]+$/,
                   "alertText": "* Bạn chỉ được phép điền chữ hoặc số"
               },
               // --- CUSTOM RULES -- Those are specific to the demos, they can be removed or changed to your likings
               "ajaxUserCall": {
                   "url": "ajaxValidateFieldUser",
                   // you may want to pass extra data on the ajax call
                   "extraData": "name=eric",
                   "alertText": "* This user is already taken",
                   "alertTextLoad": "* Validating, please wait"
               },
               "ajaxUserCallPhp": {
                   "url": "phpajax/ajaxValidateFieldUser.php",
                   // you may want to pass extra data on the ajax call
                   "extraData": "name=eric",
                   // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                   "alertTextOk": "* This username is available",
                   "alertText": "* This user is already taken",
                   "alertTextLoad": "* Validating, please wait"
               },
               "ajaxNameCall": {
                   // remote json service location
                   "url": "ajaxValidateFieldName",
                   // error
                   "alertText": "* This name is already taken",
                   // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                   "alertTextOk": "* This name is available",
                   // speaks by itself
                   "alertTextLoad": "* Validating, please wait"
               },
               "ajaxNameCallPhp": {
                   // remote json service location
                   "url": "phpajax/ajaxValidateFieldName.php",
                   // error
                   "alertText": "* This name is already taken",
                   // speaks by itself
                   "alertTextLoad": "* Validating, please wait"
               },
               "validate2fields": {
                   "alertText": "* Please input HELLO"
               },
               //tls warning:homegrown not fielded
               "dateFormat":{
                   "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/,
                   "alertText": "* Invalid Date"
               },
               //tls warning:homegrown not fielded
               "dateTimeFormat": {
                   "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1})$/,
                   "alertText": "* Invalid Date or Date Format",
                   "alertText2": "Expected Format: ",
                   "alertText3": "mm/dd/yyyy hh:mm:ss AM|PM or ",
                   "alertText4": "yyyy-mm-dd hh:mm:ss AM|PM"
               }
           };

       }
   };
   $.validationEngineLanguage.newLang();
    $(".outlooknameBlur").focusout(function() {
        var count = Number($(this).attr('tid'));
        var un=$("#OutLook"+count).val();
        if(un!="")
        {

            $.getJSON('${createLink(controller:'opError',action:'getDisplayName')}?username='+un,function(fullNameOutlook){


                if(fullNameOutlook==",")

                    alert("Chua ton tai user '"+un+"' .Anh/chi can vao menu 'Quan ly nguoi dung' o menu trai de khai bao thong tin ve user nay.")
                $("#HoVaTen"+count).val(fullNameOutlook[0]);
                $("#ChucDanh"+ count).val(fullNameOutlook[1]);
                $("#BdsUser"+ count).val(fullNameOutlook[2]);
                $("#IdNhanSu"+ count).val(fullNameOutlook[3]);

                $("#NHCD"+ count).val(fullNameOutlook[4]);
                $("#TenDonVi"+ count).val(fullNameOutlook[5]);
                $("#PGD"+ count).val(fullNameOutlook[6]);

                $("#NHCD_Id"+ count).val(fullNameOutlook[7]);
                $("#TenDonViId_"+ count).val(fullNameOutlook[8]);
                $("#PGD_Id"+ count).val(fullNameOutlook[9]);

            });
        }
        else
        {
            $("#HoVaTen"+count).val("");
            $("#ChucDanh"+ count).val("");
            $("#IdNhanSu"+ count).val("");
            $("#NHCD"+ count).val("");
            $("#TenDonVi"+ count).val("");
            $("#PGD"+ count).val("");
            $("#NHCD_Id"+ count).val("");
            $("#TenDonVi_Id"+ count).val("");
            $("#PGD_Id"+ count).val("");

        }

    });
    $("#KRImanageFrom").validationEngine();


    $("document").ready( function(){
        if($("select[name=loaiKRI]").val() == "${comboboxList.TH.value}"){
            $("select[name=donvi1]").val("");
            $("select[name=donvi2]").val("");
            $("select[name=donvi3]").val("");
            $("select[name=donvi1]").prop('disabled',true);
            $("select[name=donvi2]").prop('disabled',true);
            $("select[name=donvi3]").prop('disabled',true);
            $("select[name=donvi1]").removeClass("validate[required]");
        }else{
            $("select[name=donvi1]").prop('disabled',false);
            $("select[name=donvi2]").prop('disabled',false);
            $("select[name=donvi3]").prop('disabled',false);
            $("select[name=donvi1]").addClass("validate[required]");
        };
        var quantity = 0;
        var options = '';
        $(document).on("click","button[name=cancelEdit]",function(){
            document.location = "${createLink(controller:'kris',action:'krisDisplay')}";
        });
        var actualDate = $("input[name=ngay_bd_td]").val().split("/");
        var newDate = new Date(actualDate[2], actualDate[1] - 1, actualDate[0]);
        var minDatePick = new Date(newDate.getFullYear(), newDate.getMonth(), newDate.getDate());
        $("input[name=ngay_kt_td]").datepicker( "option", "minDate",minDatePick );

        $("input[name=ngay_bd_td]").change( function() {
            actualDate = $("input[name=ngay_bd_td]").val().split("/");
            newDate = new Date(actualDate[2], actualDate[1] - 1, actualDate[0]);
            minDatePick = new Date(newDate.getFullYear(), newDate.getMonth(), newDate.getDate());
            $("input[name=ngay_kt_td]").datepicker( "option", "minDate",minDatePick );
        });

        $("#rrhd1").change(function(){
            $("select[name=rrhd2]").html("");
            options = "<option ></option>";
            var index=$(this).val();

            $.getJSON('${createLink(controller:'kris',action:'getEvenList2')}?parent_id='+index,function(errorList2){

                if(errorList2!=-1)
                {
                    for(var i=0;i<errorList2.length;i++)
                    {
                        options += "<option value='" + errorList2[i].id  + "'>"+errorList2[i].name + "</option>";
                    }

                }
                $("select#rrhd2").html(options);
                $("select[name=rrhd2]").val();

            });
            $("select[name=rrhd2]").change()
        });
        $("select[name=rrhd2]").change(function(){

            if ($(this).val()){
                $.post('${createLink(controller:'kris',action:'getFirstNodesFromLevel2')}/rrhd2',
                        $("form[name=KRImanageFrom]").serialize(),function(data){
                            $("select[name=rrhd1]").html(data);
                        });

            } else{
                //$("select[name=LoiCap3]").html("");
            }

        });

        $("select[name=donvi1]").change(function(){
            $("select[name=donvi2]").html("");
            $("select[name=donvi3]").html("");

            if ($(this).val()){
                $.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/donvi1',
                        $("form[name=KRImanageFrom]").serialize(),function(data){
                            $("select[name=donvi2]").html(data);
                        });
            } else{
                $("select[name=donvi2]").html("");
            }
            $("select[name=donvi2]").change()
        });

        $("select[name=donvi2]").change(function(){

            if ($(this).val()){

                $("select[name=donvi1]").html("");
                $("select[name=donvi3]").html("");


                $.post('${createLink(controller:'unitDepartment',action:'getChildNodes')}/donvi2',
                        $("form[name=KRImanageFrom]").serialize(),function(data){
                            $("select[name=donvi3]").html(data);               	});

                $.post('${createLink(controller:'unitDepartment',action:'getFirstNodesFromLevel2')}/donvi2',
                        $("form[name=KRImanageFrom]").serialize(),function(data){
                            $("select[name=donvi1]").html(data); 	});
            }

        });
        $("select[name=donvi3]").change(function(){

            if ($(this).val()){

                $("select[name=donvi2]").html("");
                $("select[name=donvi1]").html("");

                $.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/donvi3',
                        $("form[name=KRImanageFrom]").serialize(),function(data){
                            $("select[name=donvi2]").html(data);
                        });


                $.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/donvi3',
                        $("form[name=KRImanageFrom]").serialize(),function(data){
                            $("select[name=donvi1]").html(data);
                        });

            }
        });
        $("select[name=loaiKRI]").change(function(){
            if($("select[name=loaiKRI]").val() == "${comboboxList.TH.value}"){
                $.post('${createLink(action:'getQLRR_donvi',controller:'kris')}',function (data) {
                    $("select[name=donvi1]").val(data.donvi1);
                    $("select[name=donvi2]").val(data.donvi2);
                    $("select[name=donvi3]").val(data.donvi3);
                });


/*                $("select[name=donvi1]").prop('disabled',true);
                $("select[name=donvi2]").prop('disabled',true);
                $("select[name=donvi3]").prop('disabled',true);*/
                $("select[name=donvi1]").removeClass("validate[required]");
            }else{
                $("select[name=donvi1]").prop('disabled',false);
                $("select[name=donvi2]").prop('disabled',false);
                $("select[name=donvi3]").prop('disabled',false);
                $("select[name=donvi1]").addClass("validate[required]");
            }

        });
    });
   $("button[name=deleteKRI]").click(function(){
       jquery_confirm("Xóa KRI","Anh/chị đồng ý xóa KRI này?",
               function(){
                   $("#delete").val("deleteKRI");
                   $("#KRImanageFrom").submit();
               });
       return false;

   });
   $("#deleteFile").click( function(){

       $("#fileUploadx").css("display", "none");
       $("#hfDeleteFile").val("deleteFile");

   });
    set_active_tab('kris_menu');//top
    $("#kris-add-management").closest('li').addClass('active');//leftMenu
    set_side_bar(true);

</script>

</body>



</html>


