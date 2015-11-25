<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />
    <ckeditor:resources />
    <title>Khả năng xảy ra</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'admin'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Hướng dẫn đánh giá khả năng xảy ra',label:'Hướng dẫn đánh giá khả năng xảy ra']]
					]}"/>

			<div class="clear"></div>
		</div>
        <g:render template="sidebar"/>
    <div id="m-melanin-main-content">
      <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
    <table  class="survey">
      <thead>
        <tr>
          <th>Mức độ</th>
          <th>Hướng dẫn đánh giá</th>
          <th>Điểm</th>
          <th>Sửa đổi</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${possibilities}" var ="i" status="k">
        <tr>
         <td class="level${i.id}" >${i.level} </td>
        <td class="description${i.id}" > ${i.description} </td>
        <td class="center score${i.id}">${i.score}</td>
        <td class="center"><a class="set-edit anchorLink" tid="${i.id}" href="#possibilityForm"> <span class="ss_sprite ss_application_edit"></span></a>

        <input type="hidden" id="possibilityNo${i.id}" name="possibilityNo"value="${i.id}"/>
        </tr>
      </g:each>
      </tbody>
    </table>
      <form method="post" controller="admin" action="viewPossibility" id="possibilityForm" name="possibilityForm" >
      <ul class="form">
        <li><label class="e-l label-left" for="level">Mức độ: </label><br>
          <input type="text" readonly="readonly" id="level" name="level"/>
        </li>
         <li><label class="e-l label-left" for="score">Điểm:</label><br>
          <input type="text" readonly="readonly" id="score" name="score"/>
        </li><br>
        <li><label class="e-l label-left" for="description">Hướng dẫn đánh giá:</label><br>
          <span class="float-left"><ckeditor:editor height="250"  width="600" name="description" id="description" toolbar="Basic"> </ckeditor:editor></span>

        </li>
        <br>
		<li class="">
	        <input type="submit" class="btn primary" id="save" name="save" value="Lưu"/>
	        <input type="hidden" id="possibilityId" name="possibilityId"/>
		</li>
      </ul>
    </form>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
        set_side_bar(true);
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');
        $("#possibilityForm").hide();
          $(".set-edit").click(function(){
            var possibilityId = $(this).attr('tid');
            $("#level").val($(".level"+possibilityId).html());
            CKEDITOR.instances['description'].setData($(".description"+possibilityId).html());
            $("#score").val($(".score"+possibilityId).html());
            $("#possibilityId").val(possibilityId);
            $("#possibilityForm").show();
          });

          JQUERY4U.UTIL.smoothAnchor('anchorLink');
			$("#admin-possibility").closest('li').addClass('active');
			set_side_bar(true);
      })
    </script>
  </body>
</html>
