<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Báo cáo chi tiết gửi lên từ chi nhánh</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Báo cáo tự đánh giá tình hình rủi ro hoạt động',label:'Báo cáo tự đánh giá tình hình rủi ro hoạt động']]
					]}"/>

			<div class="clear"></div>
		</div>

    <div id="m-melanin-main-content">
       <g:if test="${messageCode != null}">
        <div class ="message">
          <g:message code="message${messageCode}" />
        </div>
      </g:if>
     <fieldset class="info">
       <g:form method="post" name="detailForm" controller="admin" action="processDetail">
          <g:hiddenField name="id" value="${process.id}"/>
          <g:hiddenField name="deny"/>
          <g:hiddenField name="delete"/>
      <ol class="form">
        <li><label class="e-xxxxl label-left" for="empName">Tên giám đốc TT (Ví dụ: Nguyễn Văn A):</label><br>
          <input class="e-xxxxl validate[required]" id="empName" name ="empName" type="text" value="${user.fullname}"/>
        </li><br>
        <li><label class="e-xxxxl label-left" for="branch">Tên Đơn vị (Ví dụ: TT KHCN Láng Hạ):</label><br>
          <input class="e-xxxxl validate[required]" id="branch" name ="branch" type="text" value="${process.branchName}"/>
        </li> <br>
        <li class="">
          <button class="btn primary" id="save" name="save" value="save">Lưu thông tin</button>
          <button class="btn" id="deny" name="deny" value="deny">Gửi trả báo cáo lại cho đơn vị</button>
          <button class="btn" id="delete" name="delete" value="delete">Xoá bỏ báo cáo</button>
          <button class="btn" type="button" onclick="javascript:document.location='${createLink(controller:'admin',action:'evaluationManagement')}'">Quay lại</button>
        </li>

      </ol>
         </g:form>
    </fieldset>
      <h3>Báo cáo tự đánh giá tình hình rủi ro hoạt động</h3>
    <table class="datatablesExport">
	        <thead>
	          <tr>
                    <th >Mã kết quả</th>
	            <th >Mã đánh giá</th>
	            <th >Rủi ro level 1</th>
                    <th >Rủi ro level 2</th>
                    <th >Rủi ro level 3</th>
                    <th >Ảnh hưởng</th>
                    <th >Tần suất</th>
                    <th >Hiệu quả kiểm soát</th>
                    <th >Mô tả kiểm soát tại đơn vị</th>
                    <th >Mức độ rủi ro</th>
                    <th >Biện pháp giảm rủi ro</th>
                    <th >Người chịu trách nhiệm</th>
                    <th >Thời hạn</th>
                    <th >User nhập</th>
                    <th >Trạng thái</th>
                    <th >Ngày báo cáo</th>
	          </tr>
	        </thead>
	        <tbody>
                <g:each in="${instances}" var="p" status="i">
	        <tr>

                  <td class="center">${p.id}</td>
                  <td class="center">${p.selfEvaluationProcess.id}</td>
	          <td >${p.risk?.parent?.parent?.name}</td>
                  <td >${p.risk?.parent?.name}</td>
                  <td >${p.risk?.name}</td>
                  <td class ="center">${p.impact?.score}</td>
                  <td class ="center">${p.possibility?.score}</td>
                  <td class ="center">${p.controlEffect?.score}</td>
                  <td class ="center">${p.control}</td>
                  <td class ="center">${p.score}</td>
                  <td >${p.riskAction?.description}</td>
                  <td >${p.riskAction?.executor}</td>
                  <td ><g:formatDate format="dd-MM-yyyy" date="${p.riskAction?.deadline}"/></td>
                  <td >${user.username}</td>
                  <td ><g:message code="action${p.riskAction?.status}"/></td>
                  <td ><g:formatDate format="dd-MM-yyyy" date="${p.dateCreated}"/></td>


	        </tr>
                 </g:each>
	      </tbody>
	    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
          $("button[name=deny]").click(function(){
          jquery_confirm("Từ chối","Anh/chị đồng ý gửi lại báo cáo này về đơn vị để sửa đổi?",
                      function(){
                             $("#detailForm input[name=deny]").val('Processing');
                            $("#detailForm").submit();

                });

          return false;
      });

        $("button[name=delete]").click(function(){
          jquery_confirm("Xóa","Anh/chị đồng xóa bỏ báo cáo này?",
                      function(){
                            $("#detailForm input[name=delete]").val('Processing');
                            $("#detailForm").submit();

                });
          return false;
      });

       // set_side_bar(true);
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');

        var sidebarSwitch = false;
        function toggle_sidebar(flag){
                set_side_bar(flag);
        }

      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
