%{--<%pac %>--}%

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="sun.util.resources.CalendarData_ro; comboboxList" %>
<html>
<head>
    <style type="text/css">
    .tablewrapper {
        position: relative;
    }
    .table {
        display: table;
    }

    .row {
        display: table-row;
    }

    .cell {
        display: table-cell;
        text-align: left;
/*        border: 1px solid red;*/
        padding: 0.5em;
       /* white-space: nowrap;*/
        width: 200px;
    }
    .cell.empty
    {
        border: none;
    }

    .formatNumber{
            text-align: right;
    }
    </style>
    <meta name="layout" content="m-melanin-layout" />
    <title>Tính toán vốn theo BI</title>
%{--    <g:javascript src="autoNumeric.js" />--}%
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
                                 [href:createLink(controller:'bi',action:'biDisplay'),title:'Tính toán vốn BI',label:'Tính toán vốn BO']]
                  ]}"/>
    </div>
    <div class="clear"></div>
</div>
<div id="m-melanin-left-sidebar">
    <g:render template="../capitalCal/capitalSidebar"/>
</div>
<div id="m-melanin-main-content">
    <g:if test="${flash.message}">
        <div id="flash-message" class="message info">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div id="flash-error" class="alert-message error">${flash.error}</div>
    </g:if>
    <%def today = new Date();
    %>
    <g:form method="post" name="biAđForm" controller="bi" action="saveCalBI" enctype="multipart/form-data">
        <g:hiddenField name="biId" id="biId" value="${biId}"/>
        <g:hiddenField id = "delete" name = "delete"/>
        <g:hiddenField id = "addBIParam" name = "addBIParam"/>
        <g:hiddenField id = "saveBIParam" name = "saveBIParam"/>
    %{--<g:textField name="id" id="id" value="${param?.id}"/>--}%
        <div class="tablewrapper">
        <div class="table">
            <div class="row">
                <div class="cell">
                    <b>Tên báo cáo</b>
                </div>
                <div class="cell">
                    <b>Thời điểm báo cáo</b>
                </div>
                <div class="cell"></div>
                <div class="cell"></div>
                <div class="cell"></div>
            </div>
            <div class="row">
                <div class="cell">
                    <input type="text" id="biName" name="biName" value="${param?.biName?param.biName:'Báo cáo riêng lẻ MSB'}" class="validate[required]" style="width:150px !important"/>

                </div>
                <div class="cell">
                    <input type="text" id="biDate" name="biDate" value="${formatDate(format: 'dd/MM/yyyy', date: param?.biDate)?formatDate(format: 'dd/MM/yyyy', date: param?.biDate):DateUtil.formatDate(today)}" class="datetime validate[required]" readonly="readonly" style="width:150px !important"/>
                </div>
                <div class="cell">
                </div>
                <div class="cell">
                </div>
                <div class="cell">
                </div>
            </div>
            <div class="row"></div>
            <div class="row">
                <div class="cell">
                </div>
                <div class="cell">
                </div>
                <div class="cell">
                    <b>4 quý đầu tiên (VND)</b>
                </div>
                <div class="cell">
                    <b>4 quý tiếp theo (VND)</b>
                </div>
                <div class="cell">
                    <b>4 quý gần nhất (VND)</b>
                </div>
            </div>
            <div class="row">
                <div class="cell">
                    <b>Thành phần về lãi</b>
                </div>
                <div class="cell">
                    Thu nhập lãi
                </div>
                <div class="cell">
                    <input type="text" id="profitIncomeNN4" name="profitIncomeNN4" value="${param?.profitIncomeNN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

                <div class="cell">
                    <input type="text" id="profitIncomeN4" name="profitIncomeN4" value="${param?.profitIncomeN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
                <div class="cell">
                    <input type="text" id="profitIncome" name="profitIncome" value="${param?.profitIncome}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
            </div>
            <div class="row">
                <div class="cell empty"></div>
                <div class="cell">
                    Chi phí lãi
                </div>
                <div class="cell">
                    <input type="text" id="profitCostNN4" name="profitCostNN4" value="${param?.profitCostNN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
                <div class="cell">
                    <input type="text" id="profitCostN4" name="profitCostN4" value="${param?.profitCostN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

                <div class="cell">
                    <input type="text" id="profitCost" name="profitCost" value="${param?.profitCost}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
            </div>
            <div class="row">
                <div class="cell">
                    <b>Thành phần về dịch vụ</b>
                </div>
                <div class="cell">
                    Thu nhập từ hoạt động dịch vụ
                </div>
                <div class="cell">
                    <input type="text" id="serviceIncomeNN4" name="serviceIncomeNN4" value="${param?.serviceIncomeNN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
                <div class="cell">
                    <input type="text" id="serviceIncomeN4" name="serviceIncomeN4" value="${param?.serviceIncomeN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

                <div class="cell">
                    <input type="text" id="serviceIncome" name="serviceIncome" value="${param?.serviceIncome}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
            </div>
            <div class="row">
                <div class="cell">
                </div>
                <div class="cell">
                    Chi phí hoạt động dịch vụ
                </div>
                <div class="cell">
                    <input type="text" id="serviceCostNN4" name="serviceCostNN4" value="${param?.serviceCostNN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
                <div class="cell">
                    <input type="text" id="serviceCostN4" name="serviceCostN4" value="${param?.serviceCostN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

                <div class="cell">
                    <input type="text" id="serviceCost" name="serviceCost" value="${param?.serviceCost}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

            </div>
            <div class="row">
                <div class="cell">
                </div>
                <div class="cell">
                    Thu nhập từ hoạt động khác
                </div>
                <div class="cell">
                    <input type="text" id="anotherIncomeNN4" name="anotherIncomeNN4" value="${param?.anotherIncomeNN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

                <div class="cell">
                    <input type="text" id="anotherIncomeN4" name="anotherIncomeN4" value="${param?.anotherIncomeN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
                <div class="cell">
                    <input type="text" id="anotherIncome" name="anotherIncome" value="${param?.anotherIncome}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

            </div>
            <div class="row">
                <div class="cell">
                </div>
                <div class="cell">
                    Chi phí hoạt động khác
                </div>
                <div class="cell">
                    <input type="text" id="anotherCostNN4" name="anotherCostNN4" value="${param?.anotherCostNN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

                <div class="cell">
                    <input type="text" id="anotherCostN4" name="anotherCostN4" value="${param?.anotherCostN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
                <div class="cell">
                    <input type="text" id="anotherCost" name="anotherCost" value="${param?.anotherCost}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

            </div>
            <div class="row">
                <div class="cell">
                    <b>Thành phần về tài chính</b>
                </div>
                <div class="cell">
                    Lãi/lỗ thuần từ hoạt động mua bán chứng khoán kinh doanh
                </div>
                <div class="cell">
                    <input type="text" id="profitBusinessStockNN4" name="profitBusinessStockNN4" value="${param?.profitBusinessStockNN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

                <div class="cell">
                    <input type="text" id="profitBusinessStockN4" name="profitBusinessStockN4" value="${param?.profitBusinessStockN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
                <div class="cell">
                    <input type="text" id="profitBusinessStock" name="profitBusinessStock" value="${param?.profitBusinessStock}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
            </div>
            <div class="row">
                <div class="cell">
                </div>
                <div class="cell">
                    Lãi/lỗ thuần từ hoạt động mua bán chứng khoán đầu tư
                </div>
                <div class="cell">
                    <input type="text" id="profitBusinessInvestNN4" name="profitBusinessInvestNN4" value="${param?.profitBusinessInvestNN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>

                <div class="cell">
                    <input type="text" id="profitBusinessInvestN4" name="profitBusinessInvestN4" value="${param?.profitBusinessInvestN4}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
                <div class="cell">
                    <input type="text" id="profitBusinessInvest" name="profitBusinessInvest" value="${param?.profitBusinessInvest}" class="validate[required] formatNumber" style="width:200px !important"/>
                </div>
            </div>
            <div class="row">
                <div class="cell">
                    <b>Chỉ số kinh doanh</b>
                </div>
                <div class="cell empty"></div>
                <div class="cell">
                    <input type="text" id="businessPointNN4" name="businessPointNN4" value="${formatNumber(number:param?.businessPointNN4,format: '###,###.###',locale:'us')}" class="" readonly="readonly" style="width:200px !important;text-align: right"/>
                </div>

                <div class="cell">
                    <input type="text" id="businessPointN4" name="businessPointN4" value="${formatNumber(number:param?.businessPointN4,format: '###,###.###',locale:'us')}" class="" readonly="readonly" style="width:200px !important;text-align: right"/>
                </div>
                <div class="cell">
                    <input type="text" id="businessPoint" name="businessPoint" value="${formatNumber(number:param?.businessPoint,format: '###,###.###',locale:'us')}" class="" readonly="readonly" style="width:200px !important;text-align: right"/>
                </div>
            </div>
            <div class="row"><br><br><br></div>

        </div>
        </div>

        <div class="tablewrapper">
            <div class="table">
                <div class="row">
                    <div class="cell">
                        <b>Yêu cầu vốn cho RRHĐ</b>
                    </div>
                    <div class="cell"></div>
                    <div class="cell">
                        <input type="text" id="rrhdCapital" name="rrhdCapital" value="${formatNumber(number:param?.rrhdCapital,format: '###,###.###',locale:"us")}" class="" readonly="readonly" style="width:646px !important;text-align: right"/>
                    </div>
                </div>
                <div class="row">
                    <div class="cell">
                        <g:if test="${biId}">
                        <button value="exportExcelDetails" class="btn primary"  id ="exportExcelDetails" name="exportExcelDetails">Xuất ra Excel</button>
                        </g:if>
                    </div>
                    <div class="cell">
                    </div>
                    <div class="cell">
                        <ol class="form form-clear "style="text-align: right;padding-right: 0.1em">
                            <li>
                                <button value="calBI" class="btn primary"  id ="calBI" name="calBI">Tính toán</button>
                                <g:if test="${biId}">
                                    <button type="button" class="btn primary"  id ="saveBI" name="saveBI">Lưu thông tin</button>
                                    <button type="button" class="btn primary"  id ="deleteCalBI" name="deleteCalBI">Xóa</button>
                                </g:if>
                                <g:else>
                                    <button type="button" class="btn primary"  id ="addBI" name="addBI">Lưu thông tin</button>
                                </g:else>
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>


        <br>



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



    $("document").ready( function(){
        $("#biAđForm").validationEngine();
        $(".formatNumber").priceFormat({prefix:'',limit:15,centsLimit:0,centsSeparator: '',clearOnEmpty: false,allowNegative:true});

    });
/*    $("button[name=deleteCal]").click(function(){
        jquery_confirm("Xóa tính toán vốn","Anh/chị đồng ý xóa tính toán vốn này?",
                function(){
                    $("#delete").val("deleteKRI");
                    $("#calpitalAddForm").submit();
                });
        return false;

    });*/
    $("button[name=addBI]").click(function(){
        var inputDate = $("input[name=biDate]").val();
        var ajaxchecker = $.post('${createLink(action:'checkinputDate',controller:'bi')}', {
            inputDate: inputDate
        }, function (data) {

            if (data == 0) {
                jquery_confirm("Trùng thời điểm báo cáo","Anh/chị đồng ý tiếp tục lưu tính toán vốn này?",
                        function(){
                            $("#addBIParam").val("addBIParam");
                            $("#biAđForm").submit();
                        });
                return false;
            }else{
                $("#addBIParam").val("addBIParam");
                $("#biAđForm").submit();
            }
        });
    });

    $("button[name=saveBI]").click(function(){
        var inputDate = $("input[name=biDate]").val();
        var biIDvar = $("input[name=biId]").val();
        var ajaxchecker = $.post('${createLink(action:'checkinputDate2',controller:'bi')}', {
            inputDate: inputDate,
            biIDvar: biIDvar
        }, function (data) {

            if (data == 0) {
                jquery_confirm("Trùng thời điểm báo cáo","Anh/chị đồng ý tiếp tục lưu tính toán vốn này?",
                        function(){
                            $("#saveBIParam").val("saveBIParam");
                            $("#biAđForm").submit();
                        });
                return false;
            }else{
                $("#saveBIParam").val("saveBIParam");
                $("#biAđForm").submit();
            }
        });
    });

    $("button[name=deleteCalBI]").click(function(){
        jquery_confirm("Xóa tính toán vốn theo BI","Anh/chị đồng ý xóa tính toán vốn này?",
                function(){
                    $("#delete").val("deleteCalBI");
                    $("#biAđForm").submit();
                });
        return false;

    });
    set_active_tab('capitalCal_menu');//top
    $("#bi-management").closest('li').addClass('active');//leftMenu
    set_side_bar(true);

</script>

</body>



</html>


