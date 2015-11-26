<%@ page import="comboboxList" %>

<ol class="form form-clear error-form" style="margin-top:-15px">
    <%def today = new Date().getAt(Calendar.YEAR);

    %>
    <li>

        <label class="label-left" style="width:105px" for="capital_year">Năm :</label>

    </li>
    <li>
        <label class="label-left" style="width:105px"><input style="margin-right:105px;width:85px" name="capital_year" id="capital_year" class=" datetime" value="${params?.capital_year?params.capital_year:today}" readonly="readonly"/></label>
        <label class="error-label-left" style="width:220px"><g:submitButton class="searchButtons btn primary" style="margin-left:0px;margin-top:0px" name="search" value="Lọc dữ liệu" /></label>
    </li>




</ol>