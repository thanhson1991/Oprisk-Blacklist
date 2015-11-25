<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title> </title>
  </head>
  <body>
     <div id="m-melanin-tab-header">
     	<div id="m-melanin-tab-header-inner">
	 		<div id="m-melanin-tab-actions">
             <button class="btn small primary m-melanin-toggle-side-bar" name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>
            
       	
             
           </div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
			model="${[
						items:[[href:createLink(controller:'opError',action:'reportList'),title:'home',label:'Home'],
						[href:createLink(controller:'opError',action:'reportList'),title:'Quản lý người gây lỗi',label:'Quản lý người gây lỗi']]
					]}"/>

			<div class="clear"></div>
		</div>
		
            <div id="m-melanin-left-sidebar">
             <g:render template="/admin/sidebar"/>
            </div>
		</div>
     <div id="m-melanin-main-content">
      
      <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
                        
      	<g:form name="SendEmail" class="form" action="checkSendEmail" style="margin-bottom:-15px">
      		<ol  >
      			<li>
		  		  	<table class="tableControlCenter" style="border:0px !important">  		  		 
		  		  		<tr style="border:0px">
							<td style="border:0px">Cho phép gửi email</td>
							<td style="border:0px"><g:radio   name="check" value="1" checked="${iEnable }" /></td>
						</tr>
						<tr style="border:0px">	
					  		<td style="border:0px"> Không cho phép gửi email</td>
					  		<td style="border:0px"><g:radio   name="check" value="2" checked="${iDisable }"/></td>
					  	</tr> 
					 	<tr style="border:0px">
					 		<td style="border:0px" ><button type="submit"  name="CheckMail" class="btn primary">Cập nhật</button></td>
					 	</tr>
					</table>
				</li>
			</ol>					
		</g:form>
<%--		<g:form id="frAddNewRestrictEmail" name="frAddNewRestrictEmail"  action="addRestricEmail">--%>
<%--		<table  class="sortDatatablesExport" id="example">--%>
<%--	        <thead>--%>
<%--	          <tr>--%>
<%--	          <th class="center">Mã</th>	            --%>
<%--	            <th class ="center" width="">Outlook</th>--%>
<%--	            <th class ="center" width="">Thao tác</th>                         --%>
<%--	           	            --%>
<%--	        --%>
<%--	          </tr>--%>
<%--	        </thead>--%>
<%--	        <tbody>--%>
<%----%>
<%--	        <g:each in="${restrictEmail}" var="e" status="i">--%>
<%----%>
<%--	      	<tr>	          	--%>
<%--				<td >${e.id}</td>--%>
<%--                <td >${e.userEmail}</td>--%>
<%--                <td >--%>
<%--                	<a class="linkDetail" currValue="${e.id}">Xem chi tiết</a>--%>
<%--                 </td>--%>
<%--                  --%>
<%--	        </tr>--%>
<%--	        </g:each>       --%>
<%--	        --%>
<%--	      </tbody>	     --%>
<%--	       <tfoot>--%>
<%--	             <tr>--%>
<%--               --%>
<%--                	<td ></td>--%>
<%--                	<td > <input name="AddNewEmail" id="AddNewEmail"> </td>--%>
<%--                	<td>                	--%>
<%--                	<button id="btnAddNewRestricEmail"  type="button" class="btn primary" value="AddEmail">Thêm mới</button>--%>
<%--                	<g:hiddenField id="deleteError" name="deleteError" value="1"/>                	--%>
<%--                	</td>                --%>
<%--                </tr>--%>
<%--              --%>
<%--              --%>
<%--           </tfoot>--%>
<%--          --%>
<%--	    </table>--%>
<%--	    </g:form> --%>
<%--	    --%>
<%--	    <div id="dialog11" title="Chi Tiết" >--%>
<%--			<g:form method="post" name="frUpdateRestricEmail" controller="admin" action="updateRestricEmail">--%>
<%--  --%>
<%--			  	 	  <label for="editOutLook" class="lableCenter ">Outlook: </label>--%>
<%--			   	      --%>
<%--			   	       <input type="text" value=""  name ="editOutLook" id="editOutLook" >--%>
<%--			   	       <br/><br/>--%>
<%--			   	       <button class="btn primary" type="submit" id="Edit">Sửa</button>--%>
<%--			   	       <button class="btn primary" type="submit" id="Delete">Xóa</button>--%>
<%--			           <g:hiddenField id="outLookId" name="outLookId" value="1"/>               --%>
<%--			           <g:hiddenField id="currAction" name="currAction" value="Edit"/>--%>
<%--			--%>
<%--			</g:form>--%>
<%--		</div> --%>

		
      </div>
      
 
 
    <script type="text/javascript">
       $(document).ready(function(){
   	  
        set_active_tab('management');
       $("#error-sendEmail").closest('li').addClass('active');
        set_side_bar(true);
    	$("#frAddNewRestrictEmail").validationEngine();
        $("#btnAddNewRestricEmail").click(function(){
        		 jquery_confirm("Thêm mới","Anh/chị muốn thêm mới ?",
                     function(){      			 		
      			 	 	$("#frAddNewRestrictEmail").submit();
               });
         return false;
         });  

         $("#Delete").click(function(){
        	 $("#currAction").val("Delete");             
         });
           

        $(".linkDetail").click(function(){
           
        	$("#outLookId").val($(this).attr('currValue'));
        	$.post('${createLink(controller:'admin',action:'getOutlookById')}/outLookId',
					$("form[name=frUpdateRestricEmail]").serialize(),function(data){								
						$("#editOutLook").val(data);
						//alert(data)
						
               	});
           	
        	$("#dialog11").dialog();

        	
        	//$("editOutLook").val("")
        });
        
       });
       

        
    </script>
 
  </body>
</html>
