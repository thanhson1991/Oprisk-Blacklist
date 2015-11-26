<g:hiddenField name="inputUserTemp" id="inputUserTemp" value="${sec.username()}"/>
<g:hiddenField name="inputDateTemp" id="inputDateTemp" value="${formatDate(format:'dd/MM/yyyy HH:mm:ss',date:new Date())}"/>
<g:hiddenField name="kridateValTemp" id="kridateValTemp" value="${DateUtil.formatDate(new Date())}"/>
<g:form name="krisTrackForm" id="krisTrackForm" class="form float-left" action="trackKRIexport" >
    <g:if test="${flash.message}">
        <div id="flash-message" class="message info">${flash.message}</div>
    </g:if>
<ol class="form form-clear error-form" style="margin-top:-5px;">
    <li>
        <label  class="label-left" style="width:150px !important" for="maKRI">Mã KRI:</label>
        <label  class="error-label-left" style="float:none;width:150px !important" for="ttKRI">Tiêu đề KRI:</label>
        <label  class="error-label-left" style="float:none;width:150px !important" for="loaiKRI">Loại KRI:</label>
    </li>
    <li>
        <label class="label-left" style="width:150px !important"><input type="text" id="maKRI" name="maKRI" value="${kriCode}" readonly="readonly" style="width:130px"/></label>
        <label class="error-label-left" style="width:150px !important"><input type="text" id="ttKRI" name="ttKRI" value="${detailsKRI?.ttKRI}" readonly="readonly" style="width:130px"/></label>
        <label class="error-label-left" style="width:150px !important"><input type="text" id="loaiKRI" name="loaiKRI" value="${detailsKRI?.loaiKRI}" readonly="readonly" style="width:130px"/></label>
    </li>
    <li>
        <label  class="label-left" style="width:150px !important" for="donvi_1">NH chuyên doanh/ khối:</label>
        <label  class="error-label-left" style="float:none;width:150px !important" for="donvi_2">CN Trung tâm/ Phòng:</label>
        <label  class="error-label-left" style="float:none;width:150px !important" for="donvi_3">PGD/PB/Tổ nhóm:</label>
    </li>
    <li>
        <label class="label-left" style="width:150px !important"><input type="text" id="donvi_1" name="donvi_1" value="${detailsKRI?.donvi_1?.name}" readonly="readonly" style="width:130px"/></label>
        <label class="error-label-left" style="width:150px !important"><input type="text" id="donvi_2" name="donvi_2" value="${detailsKRI?.donvi_2?.name}" readonly="readonly" style="width:130px"/></label>
        <label class="error-label-left" style="width:150px !important"><input type="text" id="donvi_3" name="donvi_3" value="${detailsKRI?.donvi_3?.name}" readonly="readonly" style="width:130px"/></label>
    </li>

    <li>
        <label class="label-left"  for="tstd"  style="width:150px !important">Tần suất:</label>
        <label class="error-label-left" style="width:150px !important"  for="dvdl">Đơn vi đo lường:</label>
        <label class="error-label-left" for="ctdl" style="width:150px !important">Công thức đo lường:</label>
    </li>
    <li>
        <label class="label-left" style="width:150px !important"><input type="text" id="tstd" name="tstd" value="${detailsKRI?.tstd}" readonly="readonly" style="width:130px"/></label>
        <label class="error-label-left" style="width:150px !important"><input type="text" id="dvdl" name="dvdl" value="${detailsKRI?.dvdl}" readonly="readonly" style="width:130px !important"/></label>
        <label class="error-label-left" style="width:150px !important"><input id="ctdl" name="ctdl" value="${detailsKRI?.ctdl}" readonly="readonly" style="width:130px"/></label>
    </li>
    <li>
        <label class="label-left"  for="nguong1"  style="width:150px !important">Ngưỡng 1:</label>
        <label class="error-label-left" style="width:150px !important"  for="nguong2">Ngưỡng 2:</label>
        <label class="error-label-left" for="nguong3" style="width:150px !important">Ngưỡng 3:</label>
        <label class="error-label-left" for="nguonggh" style="width:150px !important">Ngưỡng giới hạn:</label>
    </li>
    <li>
        <label class="label-left" style="width:150px !important"><input type="text" id="nguong1" name="nguong1" value="${detailsKRI?.nguong1} "readonly="readonly" style="width:130px"/></label>
        <label class="error-label-left" style="width:150px !important"><input type="text" id="nguong2" name="nguong2" value="${detailsKRI?.nguong2}" readonly="readonly" style="width:130px !important"/></label>
        <label class="error-label-left" style="width:150px !important"><input id="nguong3" name="nguong3" value="${detailsKRI?.nguong3}" readonly="readonly" style="width:130px"/></label>
        <label class="error-label-left" style="width:150px !important"><input id="nguonggh" name="nguonggh" value="${detailsKRI?.nguonggh}" readonly="readonly" style="width:130px"/></label>
    </li>
</ol>
    <g:hiddenField id="actionbutton" name="exportExcel"/>
</g:form>
%{--<sec:ifAnyGranted roles="ROLE_CVQLRR">--}%
<g:if test="${detailsKRI}">
    <ol class="form form-clear error-form" style="margin-top:-15px;">
        <li>
            <a class="anchorLink" href="#addTrackKris"><button  id="addKris" name="addKris" class="btn primary" style="position: relative;float:right; margin-top:15px">Thêm giá trị</button></a>
        </li>
    </ol>

</g:if>
%{--</sec:ifAnyGranted>--}%
<table id="trackKRItable" name="trackKRItable" class="sortDatatablesExport">
    <thead>
    <tr>
        <th class = "center">Mã KRI</th>
        <th class ="center" >Ngày giá trị KRI</th>
        <th class ="center" >Giá trị KRI</th>
        <th class ="center" >User nhập</th>
        <th class ="center" >Thời gian cập nhập</th>
        <th class ="center" >Cảnh báo</th>
        <th class ="center" >Ghi chú</th>
        <th class ="center" >Sửa</th>
        <th class ="center" >Xóa</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${trackKRIList}" var="listTrackKRIs" status="i">

        <tr>
            <td class ="center" id="krisID${listTrackKRIs.kriObj.maKRI}">${listTrackKRIs.kriObj.maKRI}</td>
            <td class ="center" id="kridateVal${listTrackKRIs.id}"><g:formatDate date="${listTrackKRIs.kridateVal}" format="dd/MM/yyyy"/></td>
            <td class ="center" id="kriVal${listTrackKRIs.id}">${listTrackKRIs.kriVal}</td>
            <td class ="center" id="inputUser${listTrackKRIs.id}">${listTrackKRIs.inputUser}</td>
            <td class ="center" id="inputDate${listTrackKRIs.id}"><g:formatDate date="${listTrackKRIs.inputDate}" format="dd/MM/yyyy HH:mm:ss"/></td>
            %{--<g:if test="${listTrackKRIs.kriVal}">
                <g:if test="${listTrackKRIs.kriVal.toDouble() < detailsKRI.nguong1.toDouble()}">
                <td class ="center" style="background-color: white" ><font color="white">Chưa tới ngưỡng</font></td>
                </g:if>
                <g:elseif test="${listTrackKRIs.kriVal.toDouble() >= detailsKRI.nguong1.toDouble() && listTrackKRIs.kriVal.toDouble() < detailsKRI.nguong2.toDouble()}">
                    <td class ="center" style="background-color: green" ><font color="green">Xanh lá</font></td>
                </g:elseif>
                <g:elseif test="${listTrackKRIs.kriVal.toDouble() >= detailsKRI.nguong2.toDouble() && listTrackKRIs.kriVal.toDouble() < detailsKRI.nguong3.toDouble()}">
                    <td class ="center" style="background-color: orange" ><font color="orange">Cam</font></td>
                </g:elseif>
                <g:elseif test="${listTrackKRIs.kriVal.toDouble() >= detailsKRI.nguong3.toDouble() && listTrackKRIs.kriVal.toDouble() < detailsKRI.nguonggh.toDouble()}">
                    <td class ="center" style="background-color: red" ><font color="red">Đỏ</font></td>
                </g:elseif>
                <g:else>
                    <td class ="center" style="background-color: black" ><font color="black">Đen</font></td>
                </g:else>
            </g:if>
            <g:else>
                <td class ="center" style="background-color: white" ><font color="white">Chưa tới ngưỡng</font></td>
            </g:else>--}%
            <g:if test="${listTrackKRIs.kriVal}">
                <g:if test="${listTrackKRIs.kriVal.toDouble() < detailsKRI.nguong1.toDouble()}">
                    <td class ="center" style="background-color: green" ><font color="green">Chưa tới ngưỡng</font></td>
                </g:if>
                <g:elseif test="${listTrackKRIs.kriVal.toDouble() >= detailsKRI.nguong1.toDouble() && listTrackKRIs.kriVal.toDouble() < detailsKRI.nguong2.toDouble()}">
                    <td class ="center" style="background-color: orange" ><font color="orange">Cam</font></td>
                </g:elseif>
                <g:elseif test="${listTrackKRIs.kriVal.toDouble() >= detailsKRI.nguong2.toDouble() && listTrackKRIs.kriVal.toDouble() < detailsKRI.nguong3.toDouble()}">
                    <td class ="center" style="background-color: red" ><font color="red">Đỏ</font></td>
                </g:elseif>
                <g:elseif test="${listTrackKRIs.kriVal.toDouble() >= detailsKRI.nguong3.toDouble() && listTrackKRIs.kriVal.toDouble() < detailsKRI.nguonggh.toDouble()}">
                    <td class ="center" style="background-color: black" ><font color="black">Đen</font></td>
                </g:elseif>
                <g:else>
                    <td class ="center" style="background-color: black" ><font color="black">Đen</font></td>
                </g:else>
            </g:if>
            <g:else>
                <td class ="center" style="background-color: green" ><font color="green">Chưa tới ngưỡng</font></td>
            </g:else>

            <td class ="center" id="userNote${listTrackKRIs.id}">${listTrackKRIs.userNote}</td>
            <td class ="center"><a class="anchorLink" tid="${listTrackKRIs.id}" href="#addTrackKris"><span  id ="${listTrackKRIs.id}" class="ss_sprite ss_page_edit  set-edit" title="Sửa"></span></a></td>
            <td class ="center"><a onclick="return confirm('Chắc chắn xóa?');" href="${createLink(controller:'kris',action:'deleteTrackKris',params:[id:listTrackKRIs.id,maKRI:detailsKRI.maKRI])}"><span class="ss_sprite ss_cancel set-delete delete_incident" title="Xóa"></span></td>
        </tr>
    </g:each>
    </tbody>
</table>

<button class="btn primary" id="exportExcel" name="exportExcel"> Xuất ra excel </button>
<br>
<br>

