<%@ page import="comboboxList" %>

<ol class="form form-clear error-form" style="margin-top:-15px;width: 900px;">
    <%def today = new Date();
    today.setMonth(today.month-1);
    %>
    <li>

        <label class="label-left" style="width:74px" for="fromDate">Từ ngày:</label>
        <label class="label-left"  style="float:none;width:74px" for="toDate">Đến ngày:</label>
        <label  class="error-label-left" style="width:145px !important" for="s_rrhd1">Thời hạn hoàn thành:</label>
        <label  class="error-label-left" style="width:140px !important" for="s_rrhd1">Trạng thái thời hạn:</label>
        <label  class="error-label-left" style="float:none;width:140px !important" for="s_rrhd2">Loại hành động:</label>
        
    </li>
    <li>
        <input style="width:71px" name="fromDate" id="fromDate" class=" datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/>
        <input name="toDate" id="toDate" style="width:71px" class="datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/>
        <input name="actionDueDate" id="actionDueDate" class="datetime" value="${params.actionDueDate}" style="width:134px">
        <g:select name="dueDateStatus" id="dueDateStatus" from="${['Trong hạn','Quá hạn']}"
                                           optionKey="value" value="${params.dueDateStatus}" noSelection="${['':'']}"
                                           style="width: 145px"/>
        <g:select name="actionType" id="actionType" from="${ActionType.executeQuery(' from ActionType t where t.status>=0 order by t.code+0')}" optionValue="${{it.code+'-'+it.name}}"
                                           optionKey="id" value="${params.actionType}" noSelection="${['':'']}"
                                           style="width: 145px"/>
                 
        
        
    </li>
    <li> <label class="label-left" style="width:160px">Đơn vị chịu trách nhiệm:</label></li>
    <li>

       
        <label  class="error-label-left" style="width:160px !important" for="responsible_donvi1">NH chuyên doanh/ khối:</label>
        <label  class="error-label-left" style="float:none;width:140px !important" for="responsible_donvi2">CN Trung tâm/ Phòng:</label>
        <label  class="error-label-left" style="float:none;width:148px !important" for="responsible_donvi3">PGD/PB/Tổ nhóm:</label>
        <label  class="error-label-left" style="float:none;width:140px !important" for="actionStatus">Trạng thái hành động:</label>
    </li>
    <li>        
        <g:select name="responsible_donvi1" id="responsible_donvi1"
                                           from="${donvi1}" value="${params.responsible_donvi1}"
                                           optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"
                                           style="width: 165px"/>
            <g:select name="responsible_donvi2" id="responsible_donvi2"  from="${donvi2}"
                  optionKey="id" optionValue="${{it.code+'-'+it.name }}" value="${params.responsible_donvi2}" noSelection="${['':'']}"  style="width: 145px"/>
            <g:select id="responsible_donvi3" name="responsible_donvi3" from="${donvi3}"
                  optionKey="id" optionValue="${{it.code+'-'+it.name }}" value="${params.responsible_donvi3}" noSelection="${['':'']}" style="width: 145px"/>
            <g:select style="width: 145px" from="${comboboxList.listIncidentStatus()}" optionKey="value" value="${params.actionStatus}" name="actionStatus" id="actionStatus" noSelection="${['':'']}"/>
    </li>
    <li><label class="label-left" style="width:160px">Đơn vị giám sát hành động:</label></li>
     <li>

        
        <label  class="error-label-left" style="width:160px !important" for="supervisor_donvi1">NH chuyên doanh/ khối:</label>
        <label  class="error-label-left" style="float:none;width:140px !important" for="supervisor_donvi2">CN Trung tâm/ Phòng:</label>
        <label  class="error-label-left" style="float:none;width:180px !important" for="supervisor_donvi3">PGD/phòng ban/tổ nhóm:</label>
    </li>
    <li>
        
        <g:select name="supervisor_donvi1" id="supervisor_donvi1"
                                           from="${donvi1}" value="${params.supervisor_donvi1}"
                                           optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"
                                           style="width: 165px"/>
           <g:select name="supervisor_donvi2" id="supervisor_donvi2"  from="${donvi2}"
                  optionKey="id" optionValue="${{it.code+'-'+it.name }}" value="${params.supervisor_donvi2}" noSelection="${['':'']}"  style="width: 145px"/>
            <g:select id="supervisor_donvi3" name="supervisor_donvi3" from="${donvi3}"
                  optionKey="id" optionValue="${{it.code+'-'+it.name }}" value="${params.supervisor_donvi3}" noSelection="${['':'']}" style="width: 145px"/>
                   <g:submitButton class="searchButtons btn primary" style="margin-left:0px;margin-top:0px;width:145px;" name="search" value="Lọc dữ liệu" />
    </li>
</ol>