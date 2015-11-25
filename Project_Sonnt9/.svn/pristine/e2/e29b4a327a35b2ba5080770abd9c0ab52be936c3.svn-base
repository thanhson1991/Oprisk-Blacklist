<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="comboboxList" %>
<html>
<head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Danh sách KRIs</title>
    <style type="text/css">
    option.white {background-color: white;color:black;}
    option.green {background-color: green;color:green;}
    option.orange {background-color: orange; color: orange;}
    option.red {background-color: red; color: red;}
    option.black {background-color: black;color:black;}

    </style>
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
                                 [href:createLink(controller:'kris',action:'krisDisplay'),title:'Danh sách KRIs',label:'Danh sách KRIs']]
                  ]}"/>

        <div class="clear"></div>
    </div>

    <div id="m-melanin-left-sidebar">
        <g:render template="krisSidebar"/>
    </div>
</div>
<div id="m-melanin-main-content">

    <g:if test="${flash.message}">
        <div id="flash-message" class="message info">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div id="flash-error" class="alert-message error">${flash.error}</div>
    </g:if>

    <g:form name="krisSForm" id="krisSForm" class="form float-left" action="searchKRI" >
        <g:render template="../kris/krisSearchReport"/>
        <g:hiddenField name="search" value="maxresults30"/>
        <g:hiddenField id="actionbutton" name="exportExcel"/>
    </g:form>
    <g:form name="addkris" class="form float-right" controller="kris" action="krisManagePage">
        <button  name="addKris" class=" btn primary" style=" position: relative;float:right; margin-top:15px">Thêm mới KRI</button>
    </g:form>
    <table id="kRItable" name="kRItable">
        <thead>
        <tr>
            <th class = "center">Mã KRI</th>
            <th class ="center" >Mã/Tên rủi ro</th>
            <th class ="center" >Tiêu đề KRI</th>
            <th class ="center" >Tấn suất theo dõi</th>
            <th class ="center" >Loại KRI</th>
            <th class ="center" >NHCD/Khối</th>
            <th class ="center" >CN/TT/Phòng</th>
            <th class ="center" >PGD/Phòng ban/Tổ nhóm</th>
            <th class ="center" >Trạng thái</th>
            <th class ="center" >Nhập số liệu</th>
            <th class ="center" >Xem chi tiết</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${listKRI}" var="listKRIs" status="i">
            <tr>
                <td class ="center">${listKRIs.maKRI}</td>
                <td class ="" style="text-align: left">${listKRIs.maRR}</td>
                <td class ="" style="text-align: left">${listKRIs.ttKRI}</td>
                <td class ="" style="text-align: left">${listKRIs.tstd}</td>
                <td class ="" style="text-align: left">${listKRIs.loaiKRI}</td>
                <td class ="" style="text-align: left">${listKRIs.donvi_1?.name}</td>
                <td class ="" style="text-align: left">${listKRIs.donvi_2?.name}</td>
                <td class ="" style="text-align: left">${listKRIs.donvi_3?.name}</td>
                <td class ="center">${listKRIs.trang_thai}</td>
                <td class ="center">
                    <sec:ifAnyGranted roles="ROLE_CVQLRR">
                        <a href="${createLink(controller:'kris',action:'pageAddTrackKRI',params:[maKRI:listKRIs.maKRI])}" >Nhập</a>
                    </sec:ifAnyGranted>
                    <sec:ifNotGranted roles="ROLE_CVQLRR">
                        <g:if test="${listKRIs.usernhap == nowUser || listKRIs.user_tn == nowUser || listKRIs.user_pd == nowUser}">
                            <a href="${createLink(controller:'kris',action:'pageAddTrackKRI',params:[maKRI:listKRIs.maKRI])}" >Nhập</a>
                        </g:if>
                    </sec:ifNotGranted>
                </td>
                <td class ="center"><a href="${createLink(controller:'kris',action:'viewKRIDetail',params:[id:listKRIs.id])}" >Xem chi tiết</a></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <button class="btn primary" id="exportExcel" name="exportExcel"> Xuất ra excel </button>
    <br>
    <br>





</div>

<script class="jsbin" src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        set_active_tab('kris_menu');//top
        $("#kris-management").closest('li').addClass('active');//leftMenu
        set_side_bar(true);
        $("#kRItable").dataTable({
            "bSort": false,
            "bLengthChange": false,
            "bPaginate":true,
            "bFilter": true,
            "bInfo": true,
            'sPaginationType': 'full_numbers',
            "iDisplayLength": 20,
            "bDestroy":true,
            "sDom": 'lftipr<"break">T',
            "bAutoWidth": false,
        //    "aaSorting": false,
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
        });
        $("#alertType").val($("#alertTypeHidden").val());
        var quantity = 0;
        var options = '';
        $("#s_rrhd1").change(function(){
            $("select[name=s_rrhd2]").html("");
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
                $("select#s_rrhd2").html(options);
                $("select[name=s_rrhd2]").val();

            });
            $("select[name=s_rrhd2]").change()
        });
        $("select[name=s_rrhd2]").change(function(){

            if ($(this).val()){
                $.post('${createLink(controller:'kris',action:'getFirstNodesFromLevel2')}/s_rrhd2',
                        $("form[name=krisSForm]").serialize(),function(data){
                            $("select[name=s_rrhd1]").html(data);
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
                        $("form[name=krisSForm]").serialize(),function(data){
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
                        $("form[name=krisSForm]").serialize(),function(data){
                            $("select[name=donvi3]").html(data);               	});

                $.post('${createLink(controller:'unitDepartment',action:'getFirstNodesFromLevel2')}/donvi2',
                        $("form[name=krisSForm]").serialize(),function(data){
                            $("select[name=donvi1]").html(data); 	});
            }

        });
        $("select[name=donvi3]").change(function(){

            if ($(this).val()){

                $("select[name=donvi2]").html("");
                $("select[name=donvi1]").html("");

                $.post('${createLink(controller:'unitDepartment',action:'getParentNodes')}/donvi3',
                        $("form[name=krisSForm]").serialize(),function(data){
                            $("select[name=donvi2]").html(data);
                        });


                $.post('${createLink(controller:'unitDepartment',action:'getFirstNodes')}/donvi3',
                        $("form[name=krisSForm]").serialize(),function(data){
                            $("select[name=donvi1]").html(data);
                        });

            }
        });
        $("select[name=s_loaiKRI]").change(function(){
            if($("select[name=s_loaiKRI]").val() == "${comboboxList.TH.value}"){
                $("select[name=donvi1]").val("");
                $("select[name=donvi2]").val("");
                $("select[name=donvi3]").val("");
                $("select[name=donvi1]").prop('disabled',true);
                $("select[name=donvi2]").prop('disabled',true);
                $("select[name=donvi3]").prop('disabled',true);
            }else{
                $("select[name=donvi1]").prop('disabled',false);
                $("select[name=donvi2]").prop('disabled',false);
                $("select[name=donvi3]").prop('disabled',false);
            }

        });

    });
    $("#exportExcel").click(function(){
        $("#actionbutton").val("ExportExcel");
        $("#krisSForm").submit();
        $("#actionbutton").val("");
    });
    TableToolsInit.sTitle = "DanhSachKRI";
    TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";




</script>

</body>
</html>
