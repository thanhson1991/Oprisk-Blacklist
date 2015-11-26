<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Quản lý tự đánh giá rủi ro hoạt động</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">
      <div id="m-melanin-tab-header-inner">
           <div id="m-melanin-tab-actions">
             <button class="btn small primary m-melanin-toggle-side-bar" name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>
           </div>


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Quản lý tự đánh giá rủi ro hoạt động',label:'Quản lý tự đánh giá rủi ro hoạt động']]
					]}"/>
                    </div>
			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="mntsidebar"/>
		</div>
    <div id="m-melanin-main-content">
    
       <g:form name="riskForm" class="form" action="riskManagement">
        <ol class="form form-clear">
        
          <li><label for="departments" class="">Loại nghiệp vụ:</label>
                <g:select name="departmentId" id="department" from="${departments}" optionKey="id" optionValue="name" value="${departmentId}"/>
          
           <label style="float:none" for="departments" class="">Mã:</label>
             <input readonly="readonly" value="${department.code}"/>
          </li>
          <li class="buttons"><g:submitButton class="btn primary" name="search" value="Xem" /></li>
        </ol>
      </g:form>

    <table class="">
        <thead>
	          <tr>
                    <th >STT</th>
	            <th >Rủi ro level 1</th>
                    <th >Rủi ro level 2</th>
                    <th >Hiện tượng rủi ro hoạt động</th>
                    <th >Xóa</th>
	          </tr>
	        </thead>
	        <tbody>
                <g:each in="${risklv3}" var="p" status="i">
	        <tr>                  
                  <td class="center">${i + 1}</td>
	          <td >${p.parent.parent.name}</td>
                  <td >${p.parent.name}</td>
                  <td >${p.name}</td>
                  <td class ="center"><span class="ss_sprite set-edit ss_cancel delete-risk" tid="${p.id}"></span></td>
	        </tr>
                 </g:each>
	      </tbody>
	    </table>
      <input type="button" class="primary btn" name="add" id="add" value="Thêm rủi ro"/>
      <div class="addRisk">
      <g:form name="addForm" id ="addForm" class="form" action="addRiskManagement">
        <ol class="form form-clear">

          <li><label for="risklv1" class="">Rủi ro lv1:</label>
                <g:select name="risklv1" id="risklv1" from="${risklv1}" optionKey="id" optionValue="name" value="" noSelection="${['':'--Vui lòng chọn--']}"/>
          
          <label style="float:none" for="risklv2" class="">Rủi ro lv2:</label>
                <g:select name="risklv2" id="risklv2"/>
          </li>
          <li><label for="risklv3" class="">Rủi ro lv3:</label>
                <g:select class="validate[required]" name="risklv3" id="risklv3"/>
          </li>
          
          <li class="buttons"><g:submitButton name="add" class="btn primary" value="Thêm" /></li>
        </ol>
      </g:form>
      </div>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
         $("#admin-risk-management").closest('li').addClass('active');
        $("#addForm").validationEngine();
        $(".addRisk").hide();
        $("#add").click(function(){
           $(".addRisk").show('slow');
        });
        $(".delete-risk").click(function(){
        var deleteId = $(this).attr('tid');        
        jquery_confirm("Xóa rủi ro","Anh/chị đồng ý xóa bỏ rủi ro này?",
                      function(){                        
                            document.location = "${createLink(controller:'admin',action:'deleteRiskManagement',params:[departmentId:departmentId])}&id="+deleteId;

                });

          return false;

      });

        $("#risklv1").change(function(){          
          	if ($(this).val()){
                                $.post('${createLink(controller:'admin',action:'getChildRiskManagement')}/1',
                                        $("form[name=addForm]").serialize(),function(data){
                                                $("select[name=risklv2]").html(data);
                                                $("select[name=risklv3]").html("");
                                                $("select[name=risklv3]").change();
                });
                        } else{
                           
                                $("select[name=risklv2]").html("");
                                $("select[name=risklv2]").change();
                        }
               
        });
         $("#risklv2").change(function(){
          	if ($(this).val()){
                                $.post('${createLink(controller:'admin',action:'getChildRiskManagement')}/2',
                                        $("form[name=addForm]").serialize(),function(data){
                                                $("select[name=risklv3]").html(data);
                });
                        } else{

                                $("select[name=risklv3]").html("");
                                $("select[name=risklv3]").change();
                        }

        });

        set_side_bar(true);
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');

      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
