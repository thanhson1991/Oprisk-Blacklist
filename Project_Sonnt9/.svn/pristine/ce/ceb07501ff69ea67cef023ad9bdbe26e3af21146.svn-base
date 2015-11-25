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
        <g:render template="../capitalCal/capitalSidebar"/>
    </div>
</div>
<div id="m-melanin-main-content">

    <g:if test="${flash.message}">
        <div id="flash-message" class="message info">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div id="flash-error" class="alert-message error">${flash.error}</div>
    </g:if>

    <g:form name="biSForm" id="biSForm" class="form float-left" controller="bi" action="searchBI" >
        <g:render template="../capitalCal/biSearchReport"/>
        <g:hiddenField id="actionbutton" name="exportExcel"/>
    </g:form>
    <table  class="sortDatatablesExport">
        <thead>
        <tr>
            <th class="center" >STT</th>
            <th class="center" >Tên báo cáo</th>
            <th class="center">Thời điểm báo cáo</th>
            <th class="center">Chỉ số kinh doanh 4 quý đầu tiên</th>
            <th class="center">Chỉ số kinh doanh 4 quý tiếp theo</th>
            <th class="center">Chỉ số kinh doanh 4 quý gần nhất</th>

            <th class="center">Yêu cầu vốn cho Rủi ro Hoạt động</th>
            <th class="center">Chi tiết</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${listBI}" var="listBIs" status="i">

            <tr>
                <td class ="center">${i+1}</td>
                <td class ="" style="text-align: left">${listBIs.biName}</td>
                <td class ="center"><g:formatDate format="dd/MM/yyyy" date="${listBIs.biDate}"/></td>
                <td class ="" style="text-align: right">${formatNumber(number:listBIs.businessPointNN4,format: '###,###.###',locale:'us')}</td>
                <td class ="" style="text-align: right">${formatNumber(number:listBIs.businessPointN4,format: '###,###.###',locale:'us')}</td>
                <td class ="" style="text-align: right">${formatNumber(number:listBIs.businessPoint,format: '###,###.###',locale:'us')}</td>

                <td class ="" style="text-align: right">${formatNumber(number:listBIs.rrhdCapital,format: '###,###.###',locale:'us')}</td>
                <td class ="center"><a href="${createLink(controller:'bi',action:'detailBIDisplay',params:[id:listBIs.id])}" >Xem chi tiết</a></td>
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
        set_active_tab('capitalCal_menu');//top
        $("#bi-list").closest('li').addClass('active');//leftMenu
        set_side_bar(true);

        $("#alertType").val($("#alertTypeHidden").val());

    });
    $("#exportExcel").click(function(){
        $("#actionbutton").val("ExportExcel");
        $("#biSForm").submit();
        $("#actionbutton").val("");
    });
    TableToolsInit.sTitle = "DanhsachtinhtoanvontheoBI";
    TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";




</script>

</body>
</html>
