<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />
    <ckeditor:resources />
    <title>Biện pháp giảm rủi ro</title>
	<g:javascript src="timeglider.js"/>
	<style type="text/css" media="screen">
		#timeglider-placement{
			height: 400px;
		}
	</style>
  </head>
  <body>
   	<div id="m-melanin-tab-header">
      <g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
                model="${[items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
                        [href:createLink(controller:'admin',action:'viewDepartment'),title:'Quản lý rủi ro tại chi nhánh',label:'Quản lý rủi ro tại chi nhánh']]
                        ]}"/>

      <div class="clear"></div>
    </div>
    <div id="m-melanin-main-content">
<!--<h2>Lịch sử các sự kiện rủi ro xảy ra tại trung tâm của bạn </h2>
<div id='timeglider-placement'></div>

<div class="clearfix"></div>-->
<h3> Danh sách các biện pháp giảm rủi ro chưa hoàn thành</h3>
<table  class="">
      <thead>
        <tr>
          <th>Rủi ro</th>
          <th>Mức rủi ro</th>
          <th>Đề xuất các biện pháp giảm rủi ro</th>
          <th>Người chịu trách nhiệm</th>
          <th>Thời hạn</th>
          <th>Tình trạng</th>
      
      </tr>
      </thead>
      <tbody>
      <g:each in="${actions}" var ="i" status="k">
         <g:hiddenField name="actionId" value="${i.id}"/>
        <tr>
         <td class="">${i.riskInstance.risk.name} </td>
        <td class="center"> ${i.riskInstance.score} </td>
        <td class="">${i.description}</td>
        <td class="">${i.executor}</td>
        <td class=""><g:formatDate format="dd/MM/yyyy" date="${i.deadline}"/></td>
         <td class="status${i.id}"><select  id="status" name="status">
            <option ${i.status==10?'selected="selected"':''} value="10">Đang thực hiện</option>
            <option ${i.status==20?'selected="selected"':''} value="20">Bị chậm</option>
            <option ${i.status==100?'selected="selected"':''} value="100">Hoàn thành</option>
          </select></td>
        </tr>
      </g:each>
      </tbody>
    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
		   $(document).ready(function () { 
//		      var tg1 = $("#timeglider-placement").timeline({
//		         "data_source":"${createLink(action:'getPastRisksJson')}",
//				//"data_source":"${resource(dir:'js',file:'timeglider.json')}",
//		         "min_zoom":20,
//		         "max_zoom":40,
//				'show_footer':false,
//				icon_folder:'${resource(dir:'css/icons/')}'
//		     });
//		   });
		
              
		set_active_tab('risk-management');
              
      })
    </script>
  </body>
</html>
