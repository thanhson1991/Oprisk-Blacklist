<ol class="form form-clear error-form" style="margin-top:-15px">
    <%def today = new Date();
    today.setMonth(today.month-1);
    %>
    <li>
        <label class="label-left" style="width:70px" for="fromDate">Từ ngày:</label>
        <label class="label-left"  style="float:none;width:70px;" for="toDate">Đến ngày:</label>
    </li>
    <li>
        <label class="label-left" style="width:70px !important"><input style="margin-right:105px;width:60px" name="fromDate" id="fromDate" class=" datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/></label>
        <label class="label-left" style="width:70px !important"><input name="toDate" id="toDate" style="width:60px" class="datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/></label>
        <label class="error-label-left" style="width:220px"><g:submitButton class="searchButtons btn primary" style="margin-left:0px;margin-top:0px" name="search" value="Lọc dữ liệu" /></label>
    </li>




</ol>