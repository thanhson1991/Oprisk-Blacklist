<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <ckeditor:resources />
    <title>Quản lý bản tin</title>
  </head>
  <body>
     <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opRisk',action:'detailNews'),title:'Quản lý bản tin',label:'Quản lý bản tin']]
					]}"/>

			<div class="clear"></div>
		</div>

     <div id="m-melanin-main-content" style="width:760px;margin:auto">
       <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
          <g:form method="post" id="saveForm" name="saveForm" controller="opRisk" action="saveNews">
            <g:hiddenField name="newsId" value="${news?.id}"/>
            <fieldset>
              <legend>Quản lý bản tin</legend>
              <ol class="form form-top">
                <li>
                  <%def today = new Date();%>
                  <label class="e-xl label-left" for="department">Loại nghiệp vụ</label>
                  <br>
                  <g:select class="se-xl" name="department" id="department" from="${departments}" optionKey="id" optionValue="name" value="${news?.department?.id}"/>
                </li>
                <g:if test="${news}">
                <li>
                  <label for="createdBy" class="e-m label-left" style="float:none" for="toDate">Người tạo/sửa</label>
                  <br>
                  <input id="createdBy" name="createdBy" id="fromDate" class="e-m" value="${user.username}" readonly="readonly"/>
                </li>
                <li>
                  <label for="dateCreated" style="float:none" class="label-left">Ngày tạo</label>
                  <br>
                  <input  name="dateCreated" id="dateCreated" class="e-m datetime" value="${DateUtil.formatDate(news.dateCreated)}" readonly="readonly"/>
                </li>
                </g:if>
                <br>
                <li>
                  <label for="headline" class="label-left">Tiêu đề</label><br>
                  <input name="headline" id="headline" class="validate[required] e-g" value="${news?.headline}"/>
                </li>
                <li>
                  <label for="description" class="label-left">Miêu tả ngắn</label><br>
                  <ckeditor:editor height="200"  width="699" name="description" id="description" toolbar="Full"> ${news?.description}</ckeditor:editor>
                  
                </li>
                <li>
                  <label for="content" class="label-left">Miêu tả chi tiết</label><br>
                  <ckeditor:editor height="300"  width="699" name="content" id="content" toolbar="Full"> ${news?.content}</ckeditor:editor>
                  
                </li>
                <li class="buttons">
                  <button class="btn primary" type="submit" id="saveNews" name="saveNews" value="saveNews">Lưu bản tin</button>
                <g:if test="${news}">
                  <button class="btn" type="button" id="deleteNews" name="deleteNews" value="deleteNews">Xóa bản tin</button>
                  </g:if>
                  <button class="btn" type="button" onclick="javascript:document.location='${createLink(controller:'opRisk',action:'listNews')}'">Quay lại</button>
                </li>
              </ol>
            </fieldset>
            
            <sec:ifAnyGranted roles="ROLE_CVQLRR">
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
           </sec:ifAnyGranted>
          </g:form>
      </div>


    <script type="text/javascript">
       $(document).ready(function(){
          $("#saveForm").validationEngine();
          set_active_tab('news-management');

           $(".delete_comment").click(function(){
              var deleteId = $(this).attr('tid');
              jquery_confirm("Xóa ý kiến","Anh/chị đồng ý xóa ý kiến này?",
                            function(){
                                  document.location = "${createLink(controller:'opRisk',action:'deleteNewsComment',params:[newsId:news?.id])}&deleteId="+deleteId;

                      });

                return false;

            });

              $("#deleteNews").click(function(){
              jquery_confirm("Xóa bản tin","Anh/chị đồng ý xóa bản tin này?",
                            function(){
                                  document.location = "${createLink(controller:'opRisk',action:'deleteNews',params:[newsId:news?.id])}";
                      });
                return false;

            });
           

    
       });
       TableToolsInit.sTitle = "Quan ly ban tin";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>

  </body>
</html>
