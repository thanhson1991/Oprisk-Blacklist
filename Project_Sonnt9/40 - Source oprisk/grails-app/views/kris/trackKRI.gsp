<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Theo dõi KRI</title>
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
                                 [href:createLink(controller:'kris',action:'kristrackDisplay'),title:'Theo dõi KRI',label:'Theo dõi KRI']]
                  ]}"/>

        <div class="clear"></div>
    </div>

    <div id="m-melanin-left-sidebar">
        <g:render template="krisSidebar"/>
    </div>
</div>
<div id="m-melanin-main-content">
    <div id="tempRender">
    <g:render template="../kris/trackKRITemp"/>
    </div>
    <div class="" id="panel">
        <fieldset>
        <g:form id="addTrackKris" name="addTrackKris" class="form float-right" controller="kris" action="addTrackKris">
            <g:hiddenField name="krisID" id="krisID"></g:hiddenField>
            <g:hiddenField name="trackKrisID" id="trackKrisID"></g:hiddenField>
            <ol class="form form-clear error-form" style="margin-top:-15px;">
                <li>
                    <label class="label-left"  for="kridateVal"  style="width:150px">Ngày giá trị KRI:</label>
                    <label class="error-label-left" style="width:150px !important"  for="kriVal">Giá trị KRI:</label>
                    <label class="error-label-left" for="inputDate" style="width:150px !important">Thời gian cập nhật:</label>
                    <label class="error-label-left" for="inputUser" style="width:150px !important">User nhập:</label>
                </li>
                <li>
                    <label class="label-left" style="width:150px"><input type="text" id="kridateVal" name="kridateVal" class="datetime validate[required]" readonly="readonly" style="width:130px"/></label>
                    <label class="error-label-left" style="width:150px !important"><input type="text" id="kriVal" name="kriVal" class="validate[required,custom[number2]]" style="width:130px !important"/></label>
                    <label class="error-label-left" style="width:150px !important"><input id="inputDate" name="inputDate" readonly="readonly" style="width:130px"/></label>
                    <label class="error-label-left" style="width:150px !important"><input id="inputUser" name="inputUser" readonly="readonly" class="validate[required]" style="width:130px"/></label>
                </li>
                <li>
                    <label class="label-left"  for="userNote"  style="width:606px">Ghi chú ( ghi rõ nguyên nhân, biện pháp khắc phục khi vượt ngưỡng):</label>
                </li>
                <li>
                    <g:textArea name="userNote"  cols="140" rows="2" id="userNote" style="width: 606px"/>
                </li>
            </ol>
            <button id="addKrisBt"  name="addKrisBt" class="btn primary" value="add" style="position: relative;float:left; margin-top:15px;display: none">Thêm giá trị</button>
            <button id="editKrisBt"  name="editKrisBt" class="btn primary" value="edit" style=" position: relative;float:left; margin-top:15px;display: none">Sửa giá trị</button>
        </g:form>
        </fieldset>
    </div>
</div>


<script class="jsbin" src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
<script type="text/javascript">
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
    $(document).ready(function(){
        set_active_tab('kris_menu');//top
        $("#kris-track-management").closest('li').addClass('active');//leftMenu
        set_side_bar(true);
        jQuery('form#addTrackKris').validationEngine();
    });
    $(document).on("click",".anchorClass",function(){
        elementClick = $(this).attr("href")
        destination = $(elementClick).offset().top;
        $("html:not(:animated),body:not(:animated)").animate({ scrollTop: destination}, 1100 );
        return false;
    });

    $(document).on("click",".set-edit",function(){
        $("#panel").slideDown("fast");
        $("#editKrisBt").show();
        $("#addKrisBt").hide();
        var id = $(this).attr("id");
        $("#krisID").val($("#maKRI").val());
        $("#trackKrisID").val(id);
        $("#kridateVal").attr("value",$("#kridateVal"+id).html());
        $("#kriVal").attr("value",$("#kriVal"+id).html());
        $("#inputDate").attr("value",$("#inputDate"+id).html());
        $("#inputUser").attr("value",$("#inputUser"+id).html());
        $("#userNote").attr("value",$("#userNote"+id).html());

    });
    $(document).on("click","#addKris",function(){
        $("#panel").slideDown("fast");
        $("#addKrisBt").show();
        $("#editKrisBt").hide();
        $("#krisID").val($("#maKRI").val());
        $("#trackKrisID").val("");
        $("#kridateVal").val($("#kridateValTemp").val());
        $("#kriVal").val("");
        $("#inputDate").val($("#inputDateTemp").val());
        $("#inputUser").val($("#inputUserTemp").val());
        $("#userNote").val("");
    });
    $(document).on("focusout","#maKRI",function() {
        jquery_open_load_spinner();
        var maKRI = $('input[name=maKRI]').val();
        $.ajax({
            url: "${createLink(action:'loadKRI',controller:'kris')}",
            type:"POST",
            data:{maKRI:maKRI},
            success:function(data) {
                $('#tempRender').html(data);
                jQuery('form#addTrackKris').validationEngine();
                $("#trackKRItable").dataTable(
                        {
                            "bSort": true,
                            "bLengthChange": false,
                            "bPaginate":true,
                            "bFilter": true,
                            "bInfo": true,
                            'sPaginationType': 'full_numbers',
                            "iDisplayLength": 20,
                            "bDestroy":true,
                            "sDom": 'lftipr<"break">T',
                            "bAutoWidth": false,
                        //    "aaSorting": [[1, "desc" ]],
                            "oLanguage": {
                                "oPaginate":
                                {
                                    "sNext": '&gt',
                                    "sLast": '&raquo',
                                    "sFirst": '&laquo',
                                    "sPrevious": '&lt'
                                },

                                "sInfo": "Hiển thị từ _START_ đến _END_. Tổng cộng: _TOTAL_ hàng",
                                "sZeroRecords": "Không có kết quả nào được tìm thấy",
                                "sInfoEmpty": "Hiển thị từ 0 đến 0. Tổng cộng: 0 hàng"
                            }
                        }
                );
            }
        });
        jquery_close_load_spinner();
    });

    $("#exportExcel").click(function(){
        $("#actionbutton").val("ExportExcel");
        $("#krisTrackForm").submit();
        $("#actionbutton").val("");
    });
    TableToolsInit.sTitle = "DanhSachKRI";
    TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
</script>

</body>
</html>
