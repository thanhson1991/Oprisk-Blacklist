%{--<%pac %>--}%

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="sun.util.resources.CalendarData_ro; comboboxList" %>
<html>
<head>
    <style type="text/css">
    .formatNumber{
        text-align: right;
    }
    </style>
    <meta name="layout" content="m-melanin-layout" />
    <title>Tính toán vốn</title>
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
                                 [href:createLink(controller:'capitalCal',action:'capitalDisplay'),title:'Tính toán vốn',label:'Tính toán vốn']]
                  ]}"/>
    </div>
    <div class="clear"></div>
</div>
<div id="m-melanin-left-sidebar">
    <g:render template="capitalSidebar"/>
</div>
<div id="m-melanin-main-content">
    <g:if test="${flash.message}">
        <div id="flash-message" class="message info">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div id="flash-error" class="alert-message error">${flash.error}</div>
    </g:if>
    <%def today = new Date() //.getAt(Calendar.YEAR);
    Calendar thisyear = Calendar.getInstance();
    thisyear.add(Calendar.YEAR, -1);
    def lastyear = thisyear.getTime();
    thisyear.add(Calendar.YEAR, -1);
    def last2year = thisyear.getTime()
    thisyear.add(Calendar.YEAR, -1);
    def last3year = thisyear.getTime()
/*    def last2year = new Date()
    def last3year = new Date()*/
    today = DateUtil.formatDate(today)
    lastyear = DateUtil.formatDate(lastyear)
    last2year = DateUtil.formatDate(last2year)
    last3year = DateUtil.formatDate(last3year)
    %>
<g:form method="post" name="calpitalAddForm" id="calpitalAddForm" controller="capitalCal" action="saveCapital" enctype="multipart/form-data">
        <g:hiddenField name="calId" id="calId" value="${param?.id}"/>
        <g:hiddenField id = "delete" name = "delete"/>
        %{--<g:textField name="id" id="id" value="${param?.id}"/>--}%
        <table style="border:0px; !important">
            <tr style="border:0px ;">
                <td style ="border:0px">
                    <fieldset style="width: 280px">
                    <legend>Tính toán vốn theo BIA</legend>
                    <ol class="form form-clear olCenter">

                        <li>
                            <label class="label-left"  for="biaCode"  style="width:110px">Mã BIA:</label>
                            <label class="error-label-left" style="width:110px !important"  for="bia_year">Ngày/Tháng/Năm:</label>
                        </li>
                        <li>
                            <label class="label-left" style="width:110px"><input type="text" id="biaCode" name="biaCode" value="${param?.biaCode}" class="validate[required]" style="width:100px"/></label>
                            <label class="error-label-left" style="width:110px !important"><input type="text" id="bia_year" name="bia_year" value="${param?.bia_year?formatDate(format:'dd/MM/yyyy', date: param.bia_year):today}" class="datetime validate[required]" readonly="readonly" style="width:100px !important"/></label>
                        </li>
                        <li>
                            <label class="label-left" for="bia_year1"  style="width:60px">Năm 1:</label>
                            <label class="error-label-left" style="width:150px !important"><input type="text" id="bia_year1" name="bia_year1" value="${param?.bia_year1?formatDate(format:'dd/MM/yyyy', date: param.bia_year1):lastyear}" class="datetime validate[required]" readonly="readonly" style="width:150px !important"/></label>
                        </li>
                        <li>
                            <label class="label-left"  for="bia_profit1"  style="width:220px">Lợi nhuận gộp năm 1:</label>
                        </li>
                        <li>
                            <label class="label-left" style="width:220px"><input type="text" id="bia_profit1" name="bia_profit1" value="${param?.bia_profit1}" class="validate[required] formatNumber" style="width:215px"/></label>
                        </li>
                        <li>
                            <label class="label-left"  for="bia_year2"  style="width:60px">Năm 2:</label>
                            <label class="error-label-left" style="width:150px !important"><input type="text" id="bia_year2" name="bia_year2"  value="${param?.bia_year2?formatDate(format:'dd/MM/yyyy', date: param.bia_year2):last2year}" class="datetime validate[required]" readonly="readonly" style="width:150px !important"/></label>
                        </li>
                        <li>
                            <label class="label-left"  for="bia_profit2"  style="width:220px">Lợi nhuận gộp năm 2:</label>
                        </li>
                        <li>
                            <label class="label-left" style="width:220px"><input type="text" id="bia_profit2" name="bia_profit2"  value="${param?.bia_profit2}" class="validate[required] formatNumber" style="width:215px"/></label>
                        </li>
                        <li>
                            <label class="label-left"  for="bia_year3"  style="width:60px">Năm 3:</label>
                            <label class="error-label-left" style="width:150px !important"><input type="text" id="bia_year3" name="bia_year3" value="${param?.bia_year3?formatDate(format:'dd/MM/yyyy', date: param.bia_year3):last3year}" class="datetime validate[required]" readonly="readonly" style="width:150px !important"/></label>
                        </li>
                        <li>
                            <label class="label-left"  for="bia_profit3"  style="width:220px">Lợi nhuận gộp năm 3:</label>
                        </li>
                        <li>
                            <label class="label-left" style="width:220px"><input type="text" id="bia_profit3" name="bia_profit3" value="${param?.bia_profit3}" class="validate[required] formatNumber" style="width:215px"/></label>
                        </li>
                        <li>
                            <label class="label-left"  for="bia_alpha"  style="width:220px">Hệ số Alpha:</label>
                        </li>
                        <li>
                            <label class="label-left" style="width:220px"><input type="text" id="bia_alpha" name="bia_alpha" value="${param?.bia_alpha?param.bia_alpha:0.15}" class="validate[required,custom[number2],max[1]]" style="width:215px"/></label>
                        </li>
                        <li>
                            <label class="label-left"  for="bia_calResult"  style="width:220px">Kết quả tính toán vốn theo BIA:</label>
                        </li>
                        <li>
                            <label class="label-left" style="width:220px"><input type="text" id="bia_calResult" name="bia_calResult" value="${formatNumber(number: param?.bia_calResult,format: '###,###.###',locale:'us')}" readonly="readonly" style="width:215px;text-align: right" value="${param?.bia_calResult}"/></label>
                        </li>
                        <li style="text-align: right">
                            <br><br>
                            <label for="saCode"  style="width:110px;text-align: right">Đơn vị : VNĐ</label>
                        </li>
                    </ol>
                    </fieldset>
                </td>
                <td style ="border:0px">
                    <fieldset style="width: 280px">
                        <legend>Tính toán vốn theo SA</legend>
                        <ol class="form form-clear olCenter">
                            <li>
                                <label class="label-left"  for="saCode"  style="width:110px">Mã SA:</label>
                                <label class="error-label-left" style="width:110px !important"  for="sa_year">Ngày/Tháng/Năm:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:110px"><input type="text" id="saCode" name="saCode" value="${param?.saCode}" class="validate[required]" style="width:100px"/></label>
                                <label class="error-label-left" style="width:110px !important"><input type="text" id="sa_year" name="sa_year" value="${param?.sa_year?formatDate(format:'dd/MM/yyyy', date: param.sa_year):today}" class="datetime validate[required]" readonly="readonly" style="width:100px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_businessProfit"  style="width:220px">Lợi nhuận lĩnh vực kinh doanh tài chính doanh nghiệp:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_businessProfit" name="sa_businessProfit" value="${param?.sa_businessProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta1"  style="width:90px">Hệ số Beta 1:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="sa_beta1" name="sa_beta1" value="${param?.sa_beta1?param.sa_beta1:0.18}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_financialProfit"  style="width:220px">Lợi nhuận lĩnh vực kinh doanh thị trường tài chính:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_financialProfit" name="sa_financialProfit" value="${param?.sa_financialProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta2"  style="width:90px">Hệ số Beta 2:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="sa_beta2" name="sa_beta2" value="${param?.sa_beta2?param.sa_beta2:0.18}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_retailProfit"  style="width:220px">Lợi nhuận lĩnh vực bán lẻ:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_retailProfit" name="sa_retailProfit" value="${param?.sa_retailProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta3"  style="width:90px">Hệ số Beta 3:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="sa_beta3" name="sa_beta3" value="${param?.sa_beta3?param.sa_beta3:0.12}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_bankProfit"  style="width:220px">Lợi nhuận lĩnh vực ngân hàng thương mại:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_bankProfit" name="sa_bankProfit" value="${param?.sa_bankProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta4"  style="width:90px">Hệ số Beta 4:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="sa_beta4" name="sa_beta4" value="${param?.sa_beta4?param.sa_beta4:0.15}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_paymentsProfit"  style="width:220px">Lợi nhuận lĩnh vực thanh toán:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_paymentsProfit" name="sa_paymentsProfit" value="${param?.sa_paymentsProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta5"  style="width:90px">Hệ số Beta 5:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="sa_beta5" name="sa_beta5" value="${param?.sa_beta5?param.sa_beta5:0.18}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_serviceProfit"  style="width:220px">Lợi nhuận lĩnh vực kinh doanh dịch vụ đại lý:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_serviceProfit" name="sa_serviceProfit" value="${param?.sa_serviceProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta6"  style="width:90px">Hệ số Beta 6:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="sa_beta6" name="sa_beta6" value="${param?.sa_beta6?param.sa_beta6:0.15}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_assetsProfit"  style="width:220px">Lợi nhuận lĩnh vực quản lý tài sản:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_assetsProfit" name="sa_assetsProfit" value="${param?.sa_assetsProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta7"  style="width:90px">Hệ số Beta 7:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="sa_beta7" name="sa_beta7" value="${param?.sa_beta7?param.sa_beta7:0.12}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_agencyProfit"  style="width:220px">Lợi nhuận lĩnh vực kinh doanh môi giới bán lẻ:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_agencyProfit" name="sa_agencyProfit" value="${param?.sa_agencyProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta8"  style="width:90px">Hệ số Beta 8:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="sa_beta8" name="sa_beta8" value="${param?.sa_beta8?param.sa_beta8:0.12}" class=" validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_calResult"  style="width:220px">Kết quả tính toán vốn theo SA:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="sa_calResult" name="sa_calResult" value="${formatNumber(number: param?.sa_calResult,format: '###,###.###',locale:'us')}" readonly="readonly" style="width:215px;text-align: right"/></label>
                            </li>
                            <li style="text-align: right">
                                <br><br>
                                <label for="saCode"  style="width:110px;text-align: right">Đơn vị : VNĐ</label>
                            </li>
                        </ol>
                    </fieldset>
                </td>
                <td style ="border:0px">
                    <fieldset style="width: 280px">
                        <legend>Tính toán vốn theo ASA</legend>
                        <ol class="form form-clear olCenter">
                            <li>
                                <label class="label-left"  for="asaCode"  style="width:110px">Mã ASA:</label>
                                <label class="error-label-left" style="width:110px !important"  for="asa_year">Ngày/Tháng/Năm:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:110px"><input type="text" id="asaCode" name="asaCode" value="${param?.asaCode}" class="validate[required]" style="width:100px"/></label>
                                <label class="error-label-left" style="width:110px !important"><input type="text" id="asa_year" name="asa_year" value="${param?.asa_year?formatDate(format:'dd/MM/yyyy', date: param.asa_year):today}" class="datetime validate[required]" readonly="readonly" style="width:100px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_businessProfit"  style="width:220px">Lợi nhuận lĩnh vực kinh doanh tài chính doanh nghiệp:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_businessProfit" name="asa_businessProfit" value="${param?.asa_businessProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_beta1"  style="width:90px">Hệ số Beta 1:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="asa_beta1" name="asa_beta1" value="${param?.asa_beta1?param.asa_beta1:0.18}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_financialProfit"  style="width:220px">Lợi nhuận lĩnh vực kinh doanh thị trường tài chính:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_financialProfit" name="asa_financialProfit" value="${param?.asa_financialProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_beta2"  style="width:90px">Hệ số Beta 2:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="asa_beta2" name="asa_beta2" value="${param?.asa_beta2?param.asa_beta2:0.18}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_loanPropfit"  style="width:220px">Dư nợ và các khoản ứng trước lĩnh vực bán lẻ:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_loanPropfit" name="asa_loanPropfit" value="${param?.asa_loanPropfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_loanBankProfit"  style="width:220px">Dư nợ và các khoản ứng trước lĩnh vực doanh nghiệp:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_loanBankProfit" name="asa_loanBankProfit" value="${param?.asa_loanBankProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_m"  style="width:90px">Hệ số M:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="asa_m" name="asa_m" value="${param?.asa_m?param.asa_m:0.035}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_paymentProfit"  style="width:220px">Lợi nhuận lĩnh vực thanh toán:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_paymentProfit" name="asa_paymentProfit" value="${param?.asa_paymentProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="sa_beta5"  style="width:90px">Hệ số Beta 5:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="asa_beta5" name="asa_beta5" value="${param?.asa_beta5?param.asa_beta5:0.18}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_serviceProfit"  style="width:220px">Lợi nhuận lĩnh vực kinh doanh dịch vụ đại lý:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_serviceProfit" name="asa_serviceProfit" value="${param?.asa_serviceProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_beta6"  style="width:90px">Hệ số Beta 6:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="asa_beta6" name="asa_beta6" value="${param?.asa_beta6?param.asa_beta6:0.15}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_assetsProfit"  style="width:220px">Lợi nhuận lĩnh vực quản lý tài sản:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_assetsProfit" name="asa_assetsProfit" value="${param?.asa_assetsProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_beta7"  style="width:90px">Hệ số Beta 7:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="asa_beta7" name="asa_beta7" value="${param?.asa_beta7?param.asa_beta7:0.12}" class="validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_retailProfit"  style="width:220px">Lợi nhuận lĩnh vực kinh doanh môi giới bán lẻ:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_retailProfit" name="asa_retailProfit" value="${param?.asa_retailProfit}" class="validate[required] formatNumber" style="width:215px"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_beta8"  style="width:90px">Hệ số Beta 8:</label>
                                <label class="error-label-left" style="width:120px !important"><input type="text" id="asa_beta8" name="asa_beta8" value="${param?.asa_beta8?param.asa_beta8:0.12}" class=" validate[required,custom[number2],max[1]]" style="width:120px !important"/></label>
                            </li>
                            <li>
                                <label class="label-left"  for="asa_calResult"  style="width:220px">Kết quả tính toán vốn theo ASA:</label>
                            </li>
                            <li>
                                <label class="label-left" style="width:220px"><input type="text" id="asa_calResult" name="asa_calResult"  value="${formatNumber(number: param?.asa_calResult,format: '###,###.###',locale:'us')}" readonly="readonly" style="width:215px;text-align: right"/></label>
                            </li>
                            <li style="text-align: right">
                                <br><br>
                                <label for="asaCode"  style="width:110px;text-align: right">Đơn vị : VNĐ</label>
                            </li>
                        </ol>
                    </fieldset>
                    <br>
                    <ol class="form form-clear "style="text-align: right;">
                        <li>
                            <button value="calCapitalB" class="btn primary"  id ="calCapitalB" name="calCapitalB">Tính toán</button>
                            <button value="addNewCal" class="btn primary"  id ="addNewCal" name="addNewCal">Lưu mới</button>
                            <g:if test="${param?.id}">
                            <button value="saveEditCal" class="btn primary"  id ="saveEditCal" name="saveEditCal">Cập nhật</button>
                            <button type="button" class="btn primary"  id ="deleteCal" name="deleteCal">Xóa</button>
                            </g:if>
                        </li>
                    </ol>
                </td>
            </tr>

        </table>



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

    $("input.datetime").datepicker({
        dateFormat: 'dd/mm/yy',
        changeMonth: true,
        changeYear: true
    });
    $("#calpitalAddForm").validationEngine();


    $("document").ready( function(){
        $(".formatNumber").priceFormat({prefix:'',limit:18,centsLimit:0,centsSeparator: '',clearOnEmpty: false,allowNegative:true});
    });
    $("button[name=deleteCal]").click(function(){
        jquery_confirm("Xóa tính toán vốn","Anh/chị đồng ý xóa tính toán vốn này?",
                function(){
                    $("#delete").val("deleteCal");
                    $("#calpitalAddForm").submit();
                });
        return false;

    });
    set_active_tab('capitalCal_menu');//top
    $("#capital-add-management").closest('li').addClass('active');//leftMenu
    set_side_bar(true);

</script>

</body>



</html>


