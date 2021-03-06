<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý bản tin</title>
  </head>
  <body>
     <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opRisk',action:'listNews'),title:'Quản lý bản tin',label:'Danh sách báo cáo gửi từ chi nhánh']]
					]}"/>

			<div class="clear"></div>
		</div>
                
     <div id="m-melanin-main-content">
     <g:form name="newsForm" class="form" action="listNews">
         <g:render template="searchReport"/>
      </g:form>
      <button class="btn" type="button" onclick="javascript:document.location='${createLink(controller:'opRisk',action:'detailNews')}'">Thêm mới</button>
	      <table class="datatables">
	        <thead>
	          <tr>
	            <th class ="center" >STT</th>
	            <th class ="center" >Tiêu đề</th>
	            <th class ="center" >Loại nghiệp vụ</th>
                    <th class ="center" >Người tạo/sửa</th>
                    <th class ="center" >Ngày tạo</th>
                    <th class ="center" >Thao tác</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${news}" var="n" status="i">

	        <tr>
	          <td class="center">${i+1}</td>
                  <td >${n.headline}</td>
                  <td >${n.department.name}</td>
                  <td class="center">${n.createdBy.username}</td>
                  <td class ="center"><g:formatDate format="dd-MM-yyyy" date="${n.dateCreated}"/></td>
                  <td class ="center"><a href="${createLink(controller:'opRisk',action:'detailNews',params:[newsId:n.id])}" >Xem chi tiết</a></td>

	        </tr>
	        </g:each>
	      </tbody>
	    </table>
      <div class="clear"></div>

      </div>


    <script type="text/javascript">
       $(document).ready(function(){
     
       set_active_tab('news-management');
        
       });
       TableToolsInit.sTitle = "Quan ly ban tin";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>

  </body>
</html>
