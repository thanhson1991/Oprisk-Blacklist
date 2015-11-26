<%@ page import="comboboxList" %>

<ol class="form form-clear error-form" style="margin-top:-15px;">
    <%def today = new Date();
    today.setMonth(today.month-1);
    %>
    <li>

        <label class="label-left" style="width:70px" for="fromDate">Từ ngày:</label>
        <label class="label-left"  style="float:none;width:70px;" for="toDate">Đến ngày:</label>
        <label  class="error-label-left" style="width:150px !important" for="s_rrhd1">Sự kiện RRHĐ cấp 1:</label>
        <label  class="error-label-left" style="width:150px !important" for="s_rrhd2">Sự kiện RRHĐ cấp 2:</label>
        <label  class="error-label-left" style="width:150px !important" for="alertType">Loại cảnh báo:</label>
    </li>
    <li>
        <label class="label-left" style="width:70px !important"><input style="margin-right:105px;width:60px" name="fromDate" id="fromDate" class=" datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/></label>
        <label class="label-left" style="width:70px !important"><input name="toDate" id="toDate" style="width:60px" class="datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/></label>
        <label class="error-label-left" style="width:150px !important"><g:select name="s_rrhd1" id="s_rrhd1" from="${Event.executeQuery('from Event e where e.ord=0')}"
                                           optionKey="id" optionValue="name" value="${params.s_rrhd1}"
                                           noSelection="${['':'']}" style="width: 150px"/></label>
            <label class="error-label-left" style="width:150px !important"><g:select name="s_rrhd2" id="s_rrhd2" from="${Event.executeQuery('from Event e where e.ord=1')}"
                                           optionKey="id"
                                           optionValue="name" value="${params.s_rrhd2}"
                                           noSelection="${['':'']}" style="width: 150px"/></label>
        %{--<label class="error-label-left" style="width:150px !important"><select style="width: 150px" name="alertType" id="alertType">
            <option class="" value= "">Tất cả</option>
            <option class="white" value= "0">Chưa đạt ngưỡng</option>
            <option class="green" value= "1">Ngưỡng 1</option>
            <option class="orange" value= "2">Ngưỡng 2</option>
            <option class="red" value= "3">Ngưỡng 3</option>
            <option class="black" value= "4">Ngưỡng giới hạn</option>
        </select></label>--}%
        <label class="error-label-left" style="width:150px !important"><select style="width: 150px" name="alertType" id="alertType">
            <option class="" value= "">Tất cả</option>
            <option class="green" value= "0">Chưa đạt ngưỡng</option>
            <option class="orange" value= "1">Cam</option>
            <option class="red" value= "2">Đỏ</option>
            <option class="black" value= "3">Đen</option>
        </select></label>
        <g:hiddenField name="alertTypeHidden" id="alertTypeHidden" value="${params.alertType}"/>
    </li>
    <li>

        <label class="label-left" style="width:150px" for="fromDate">Loại KRI:</label>
        <label  class="error-label-left" style="width:150px !important" for="donvi1">NH chuyên doanh/ khối:</label>
        <label  class="error-label-left" style="float:none;width:150px !important" for="donvi2">CN Trung tâm/ Phòng:</label>
        <label  class="error-label-left" style="float:none;width:150px !important" for="donvi3">PGD/PB/Tổ nhóm:</label>
    </li>
    <li>
        <label class="label-left" style="width:150px !important"><g:select id="s_loaiKRI" name="s_loaiKRI" value="${params.s_loaiKRI}" style="width: 150px;" from="${comboboxList.listKRIType()}" optionKey="value" noSelection="${['':'Tất cả']}" /></label>
        <label class="error-label-left" style="width:150px !important">
       	<g:select name="donvi1" id="donvi1" style="width: 150px"
                                           from="${donvi1}" value="${params.donvi1}"
                                           optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"
                                          />
         </label>
            <label class="error-label-left" style="width:150px !important"><g:select name="donvi2" id="donvi2"  from="${donvi2}"
                  optionKey="id" optionValue="${{it.code+'-'+it.name }}" value="${params.donvi2}" noSelection="${['':'']}"  style="width: 150px"/></label>
            <label class="error-label-left" style="width:150px !important"><g:select id="donvi3" name="donvi3" from="${donvi3}"
                  optionKey="id" optionValue="${{it.code+'-'+it.name }}" value="${params.donvi3}" noSelection="${['':'']}" style="width: 150px"/></label>
    </li>

    <li>



        <label class="error-label-left"  for="tstd"  style="width:150px !important">Tần suất:</label>
        <label class="error-label-left" style="width:150px !important"  for="nguonsl">Nguồn số liệu:</label>
        <label class="error-label-left" for="trang_thai" style="width:150px !important">Trạng thái:</label>


    </li>
    <li>


        <label class="error-label-left" style="width:150px !important"><input type="text" id="tstd" name="tstd" value="${params.tstd}" style="width:140px"/></label>
        <label class="error-label-left" style="width:150px !important"><input type="text" id="nguonsl" name="nguonsl" value="${params.nguonsl}" style="width:140px !important"/></label>
        <label class="error-label-left" style="width:150px !important"><g:select id="trang_thai" name="trang_thai" from="${comboboxList.listStatus()}" optionKey="value" value="${params.trang_thai}" noSelection="${['':'']}" style="width:150px"></g:select></label>

        <label class="error-label-left" style="width:150px !important"><g:submitButton class="searchButtons btn primary" style="width:150px;margin-left:0px;margin-top:0px" name="search" value="Lọc dữ liệu" /></label>







    </li>



</ol>