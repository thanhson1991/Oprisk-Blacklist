<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <ckeditor:resources />
    <title>Quản lý khuyến nghị</title>
  </head>
  <body>
     <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opRisk',action:'detailResponse'),title:'Quản lý khuyến nghị',label:'Quản lý khuyến nghị']]
					]}"/>

			<div class="clear"></div>
		</div>

     <div id="m-melanin-main-content" style="width:760px;margin:auto">
       <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
          <g:form method="post" id="saveForm" name="saveForm" controller="opRisk" action="saveResponse">
            <g:hiddenField name="responseId" value="${riskResponse?.id}"/>
            <fieldset>
              <legend>Quản lý khuyến nghị</legend>
              <ol class="form form-top">
                <li>
                  <%def today = new Date();%>
                  <label class="e-xl label-left" for="department">Loại nghiệp vụ</label>
                  <br>
                  <g:select class="se-xl" name="department" id="department" from="${departments}" optionKey="id" optionValue="name" value="${riskResponse?.department?.id}"/>
                </li>
                <g:if test="${riskResponse}">
                <li>
                  <label for="createdBy" class="e-m label-left" style="float:none" for="toDate">Người tạo/sửa</label>
                  <br>
                  <input id="createdBy" name="createdBy" id="fromDate" class="e-m" value="${user.username}" readonly="readonly"/>
                </li>
                <li>
                  <label for="dateCreated" style="float:none" class="label-left">Ngày tạo</label>
                  <br>
                  <input name="dateCreated" id="dateCreated" class="e-m datetime" value="${DateUtil.formatDate(riskResponse.dateCreated)}" readonly="readonly"/>
                </li>
                </g:if>
                <br>
                <li>
                  <label for="headline" class="label-left">Tiêu đề</label><br>
                  <input name="headline" id="headline" class="validate[required] e-g" value="${riskResponse?.headline}"/>
                </li>
                <li>
                  <label for="description" class="label-left">Miêu tả ngắn</label><br>
                  <ckeditor:editor height="200"  width="699" name="description" id="description" toolbar="Full"> ${riskResponse?.description}</ckeditor:editor>

                </li>
                <li>
                  <label for="content" class="label-left">Miêu tả chi tiết</label><br>
                  <ckeditor:editor height="300"  width="699" name="content" id="content" toolbar="Full"> ${riskResponse?.content}</ckeditor:editor>

                </li>
                <li class="buttons">
                  <button class="btn primary" type="submit" id="saveResponse" name="saveResponse" value="saveResponse">Lưu khuyến nghị</button>
                <g:if test="${response}">
                  <button class="btn" type="button" id="deleteResponse" name="deleteResponse" value="deleteResponse">Xóa khuyến nghị</button>
                  </g:if>
                  <button class="btn" type="button" onclick="javascript:document.location='${createLink(controller:'opRisk',action:'listResponse')}'">Quay lại</button>
                </li>
              </ol>
            </fieldset>
            <h3>Nội dung comment</h3>
            <table class="datatables">
                  <thead>
                    <tr>
                      <th>STT</th>
                      <th>Comment</th>
                      <th>Người viết</th>
                      <th>Chức năng</th>
                    </tr>
                  </thead>
                  <tbody>
                     <g:each in="${comments}" var="i" status="k">
                       <tr>
                         <td class="center">${k+1}</td>
                         <td>${i.content}</td>
                         <td class="center">${i.createdBy.username}</td>
                         <td class="center"><span tid="${i.id}" class="ss_sprite ss_cancel set-delete delete_comment" title="Xóa"></td>
                       </tr>
                     </g:each>
                  </tbody>

                </table>
          </g:form>
      </div>


    <script type="text/javascript">
       $(document).ready(function(){
          $("#saveForm").validationEngine();
          set_active_tab('response-management');

           $(".delete_comment").click(function(){
              var deleteId = $(this).attr('tid');
              jquery_confirm("Xóa ý kiến","Anh/chị đồng ý xóa ý kiến này?",
                            function(){
                                  document.location = "${createLink(controller:'opRisk',action:'deleteResponseComment',params:[responseId:riskResponse?.id])}&deleteId="+deleteId;

                      });

                return false;

            });

              $("#deleteResponse").click(function(){
              jquery_confirm("Xóa khuyến nghị","Anh/chị đồng ý xóa khuyến nghị này?",
                            function(){
                                  document.location = "${createLink(controller:'opRisk',action:'deleteResponse',params:[responseId:riskResponse?.id])}";
                      });
                return false;

            });
           


       });
       TableToolsInit.sTitle = "Quan ly khuyen nghi";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>

  </body>
</html>
