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
        <g:render template="capitalSidebar"/>
    </div>
</div>
<div id="m-melanin-main-content">

    <g:if test="${flash.message}">
        <div id="flash-message" class="message info">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div id="flash-error" class="alert-message error">${flash.error}</div>
    </g:if>

    <g:form name="capitalSForm" id="capitalSForm" class="form float-left" controller="capitalCal" action="searchCapital" >
        <g:render template="../capitalCal/capitalSearchReport"/>
        <g:hiddenField id="actionbutton" name="exportExcel"/>
    </g:form>
    <table  class="sortDatatablesExport">
        <thead>
        <tr>
            <th class="center" rowspan="2">STT</th>
            <th class="center" rowspan="2">Năm</th>
            <th colspan="3" class="center">Vốn yêu cầu theo các phương pháp</th>
            <th class="center" rowspan="2">Chi tiết</th>
        </tr>
        <tr>
            <th class="center">BIA</th>
            <th class="center">SA</th>
            <th class="center">ASA</th>
        </tr>
        </thead>



        <tbody>

        <g:each in="${listCap}" var="listCaps" status="i">

            <tr>
                <td class ="center">${i+1}</td>
                <td class ="center"><g:formatDate format="dd/MM/yyyy" date="${listCaps.bia_year}"/></td>
                <td class ="" style="text-align: right">${formatNumber(number: listCaps.bia_calResult,format: '###,###.###',locale:'us')}</td>
                <td class ="" style="text-align: right">${formatNumber(number: listCaps.sa_calResult,format: '###,###.###',locale:'us')}</td>
                <td class ="" style="text-align: right">${formatNumber(number: listCaps.asa_calResult,format: '###,###.###',locale:'us')}</td>
                <td class ="center"><a href="${createLink(controller:'capitalCal',action:'viewCapDetails',params:[id:listCaps.id])}" >Xem chi tiết</a></td>

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
    $("input.datetime").datepicker({
        dateFormat: 'yy',
        changeMonth: true,
        changeYear: true
    });
    $(document).ready(function(){
        set_active_tab('capitalCal_menu');//top
        $("#capital-list").closest('li').addClass('active');//leftMenu
        set_side_bar(true);

        $("#alertType").val($("#alertTypeHidden").val());
    });
    $("#exportExcel").click(function(){
        $("#actionbutton").val("ExportExcel");
        $("#capitalSForm").submit();
        $("#actionbutton").val("");
    });
    TableToolsInit.sTitle = "Danhsachtinhtoanvon";
    TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";




</script>

</body>
</html>
