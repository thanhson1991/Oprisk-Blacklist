<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
  
    <title>Quản lý lỗi</title>
    <meta name="layout" content="m-melanin-layout" />

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
						[href:createLink(controller:'opError',action:'reportList'),title:'Danh sách lỗi',label:'Danh sách lỗi']]
					]}"/>

			%{--<div class="clear"></div>--}%
		</div>
		
            <div id="m-melanin-left-sidebar">
               	<g:render template="errorsidebar"/>
			</div>
		</div>
     <div id="m-melanin-main-content">
     <%--<g:form name="reportForm" class="form float-left" action="getErrorDisplay" >
     
     
     --%>
     <g:if test="${ErrorDonVi=='ErrorDonVi'}">
     <g:form name="reportForm" class="form float-left" action="displayErrorQLRR" >
     <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
      </g:if>
        
      	<g:render template="../opError/errorSReportRutgon"/>
      </g:form>
      </g:if>
      <g:else>
      <g:form id="reportForm" name="reportForm" class="form float-left" action="getErrorDisplay" >
	     <g:if test="${flash.message}">
					<div id="flash-message" class="message info">${flash.message}</div>
	      </g:if>

	      	<g:render template="../opError/errorSReportRutgon"/>
	      	<g:hiddenField name="search" value="maxresults30"/>
	 	 	
   				<g:hiddenField id="actionButton" name="exportExcel" value="${exportExcel}"/>
   		 
      </g:form>
      </g:else>
      	<g:form name="opError" class="form float-right" action="errorManagementList">	
  				<button  name="addComment" class=" btn primary" style=" position: relative;float:right; margin-top:15px">Nhập thông tin</button>
   		</g:form>		
	      <table  class="sortDatatablesExport">
	        <thead>
	          <tr>
	          <th class="center">Mã</th>
	            <!--  <th class ="center" width="130px" >NHCD/Khối</th> -->
<%--	            <th class ="center" width="150px">Tên đơn vị</th> 
                     --%>
                <th class = "center">Tên Đơn Vị</th>
	            <th class ="center" >Nhóm lỗi mức 3</th>
	            <th class ="center" >Mô tả lỗi</th>	            
	            <th class ="center" >User lỗi</th>
	            <th class ="center" >Cấp độ lỗi</th>
	            <th class ="center" width="90px">Trạng thái</th>
	            <th class ="center" width="80px">Ngày xảy ra</th>	            
	            <th class ="center" width="80px">Thời hạn khắc phục</th>
	            <th class ="center" width="80px">Ngày giờ nhập</th>	           
	            <th class ="center" >Xem</th>
	            
	          </tr>
	        </thead>



	        %{--<tbody>

	        <g:each in="${errorManagement}" var="e" status="i">

	        <tr>
	       <td class ="center">${e.id}  </td><%--
	          
	          <td class ="">${e.unitDepart.name}</td>	            
              --%>
              <td class = "">${e?UnitDepart.get(e.tenDonVi3)?.name:null }</td>
              <td class ="" style="width:120px">${e?ErrorList.get(e.loiCap3)?.name:null}</td>
              <td class="" style="width:150px"><span style="text-align:left">${e?.motaChiTiet}</span> </td>
              <td class ="" >
              	
              	<g:each in="${e.errorUserCreate}" var="u" >
              		${u?.userEmail} </br>
              	</g:each>
              </td>
              <td class ="" >
              	<g:each in="${e.errorUserCreate}" var="u" >
              		${u?.levelError}</br>
              	</g:each>
              </td>
              <td class ="">${ErrorStatus.get(e.trangThai).nameStatus}</td>
              <td class =""><g:formatDate format="yyyy-MM-dd" date="${e?.ngayXayRa}" /></td>    
              <td class =""><g:formatDate format="yyyy-MM-dd" date="${e?.thoiHanKhacPhuc}" /></td>
              <td class =""><g:formatDate format="yyyy-MM-dd HH:mm" date="${e?.thoiGianNhapVaoHeThong}" /></td>              
    <%--          <td class ="center">
                  	${ErrorManagement.get(e.id).errorsComments.size()}
              </td>
              <td class ="center"> <g:formatDate format="yyyy-MM-dd" date="${e?.errorsComments?e?.errorsComments.dateCreated.last():null}"/>  </td>
              --%>
                  	<sec:ifAnyGranted roles="ROLE_CVQLRR">
			      		<td class ="center"><a href="${createLink(controller:'opError',action:'getErrorDetail',params:[id:e.id])}" >Xem</a></td>
					</sec:ifAnyGranted>
					
					<sec:ifNotGranted roles="ROLE_CVQLRR">
						<td class ="center"><a href="${createLink(controller:'opError',action:'viewErrorDetail',params:[id:e.id])}" >Xem</a></td>
					</sec:ifNotGranted>
                  
	        </tr>
	        </g:each>

	      </tbody>--}%
           %{--<tfoot>--}%
            %{--<tr>--}%
                %{--<td colspan="11" style="border: 0px;text-align: right">--}%
                    %{--<g:paginate params="${filterParams}" next="Forward" prev="Back" controller="opError" action="getErrorDisplay" total="${errorCount}" />--}%
                %{--</td>--}%
            %{--</tr>--}%
           %{--</tfoot>--}%

	    </table>
	    	<button class="btn primary" id = "exportExcel" name="exportExcel" >Xuất ra excel</button>
			<br>
			<br>
      </div>
<%-- <script class="jsbin" src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>--%>
    <script type="text/javascript" >


       $(document).ready(function(){

    	 
        set_active_tab('error-management');
        $("#error-management").closest('li').addClass('active');
           set_side_bar(true);
           var tbParams = "?tempID=1";
           if($("input[name=NguoiGayLoi]").val()){
               tbParams += "&NguoiGayLoi="+$("input[name=NguoiGayLoi]").val();
           }

           if($("input[name=IdNhanSu]").val()){
               tbParams += "&IdNhanSu="+$("input[name=IdNhanSu]").val();
           }
           if($("input[name=fromDate]").val()){
               tbParams += "&fromDate="+$("input[name=fromDate]").val();
           }
           if($("input[name=toDate]").val()){
               tbParams += "&toDate="+$("input[name=toDate]").val();
           }
           if($("select[name=LoaiNghiepVu]").val()){
               tbParams += "&LoaiNghiepVu="+$("select[name=LoaiNghiepVu]").val();
           }
           if($("select[name=HTPH]").val()){
               tbParams += "&HTPH="+$("select[name=HTPH]").val();
           }
           if($("select[name=NHCD]").val()){
               tbParams += "&NHCD="+$("select[name=NHCD]").val();
           }
           if($("select[name=CN]").val()){
               tbParams += "&CN="+$("select[name=CN]").val();
           }
           if($("select[name=PGD]").val()){
               tbParams += "&PGD="+$("select[name=PGD]").val();
           }
           if($("select[name=PGDLoi]").val()){
               tbParams += "&PGDLoi="+$("select[name=PGDLoi]").val();
           }
           if($("select[name=NHCDLoi]").val()){
               tbParams += "&NHCDLoi="+$("select[name=NHCDLoi]").val();
           }
           if($("select[name=CNLoi]").val()){
               tbParams += "&CNLoi="+$("select[name=CNLoi]").val();
           }
           if($("select[name=LoiCap1]").val()){
               tbParams += "&LoiCap1="+$("select[name=LoiCap1]").val();
           }
           if($("select[name=LoiCap2]").val()){
               tbParams += "&LoiCap2="+$("select[name=LoiCap2]").val();
           }
           if($("select[name=LoiCap3]").val()){
               tbParams += "&LoiCap3="+$("select[name=LoiCap3]").val();
           }
           if($("select[name=TrangThai]").val()){
               tbParams += "&TrangThai="+$("select[name=TrangThai]").val();
           }
           if($("input[name=NguoiNhap]").val()){
               tbParams += "&NguoiNhap="+$("input[name=NguoiNhap]").val();
           }
           if($("select[name=KieuNgay]").val()){
               tbParams += "&KieuNgay="+$("select[name=KieuNgay]").val();
           }

           var oTable = $("table.sortDatatablesExport").dataTable({
               "bSort": true,
               "aoColumns": [{"bSortable": true},{"bSortable": false},{"bSortable": false},{"bSortable": false},
                   {"bSortable": false},{"bSortable": false},{"bSortable": false},{"bSortable": true},
                   {"bSortable": true},{"bSortable": true},{"bSortable": false}],
               "bLengthChange": false,
               "bProcessing": true,
               "bServerSide": true,
               "sAjaxSource":  "${request.contextPath + '/opError/getErrorDisplayAjaxDataTb/'}"+tbParams,
               "bPaginate":true,
               "bFilter": true,
               "bInfo": true,
               'sPaginationType': 'full_numbers',
               "iDisplayLength": 10,
               "bDestroy":true,
               "sDom": 'lftipr<"break">T',
               "bAutoWidth": false,
               "aaSorting": [[0, "desc" ]],
               "oLanguage": {
                   "oPaginate":
                    {
                    "sNext": '&gt',
                    "sLast": '&raquo',
                    "sFirst": '&laquo',
                    "sPrevious": '&lt'
                    },
                   "sInfo": "Hiển thị từ _START_ đến _END_. Tổng cộng: _TOTAL_ hàng",
                   "sZeroRecords": "Không có kết quả nào được tìm thấy",
                   "sInfoEmpty": "Hiển thị từ 0 đến 0. Tổng cộng: 0 hàng",
                   "sProcessing": "Hệ thống đang xử lý xin vui lòng đợi trong giây lát..."
               }
           });
           var searchWait = 0;
           var searchWaitInterval;
           $('.dataTables_filter input').unbind('keypress keyup').bind('keypress keyup', function(e){
               var item = $(this);
               searchWait = 0;
               if(!searchWaitInterval) searchWaitInterval = setInterval(function(){
                   if(searchWait>=3){
                       if(oTable.fnSettings().fnRecordsDisplay() >= 2000)
                       {
                           jquery_alert("Số bản ghi quá nhiều" ,"Vui lòng hãy lọc thông tin trước khi quick search ( < 2000 )");
                           clearInterval(searchWaitInterval);
                           searchWaitInterval = '';
                           oTable.fnFilter("");
                           searchWait = 0;
                       }else{
                           clearInterval(searchWaitInterval);
                           searchWaitInterval = '';
                           oTable.fnFilter($(item).val());
                           searchWait = 0;
                       }

                   }
                   searchWait++;
               },500);
            });
           $("#exportExcel").click( function(){
               if($(".dataTables_filter input").val()){
                   window.location.href = "${createLink(action:'getErrorDisplayAjaxDataTb',controller:'opError')}"+"/"+tbParams+"&exportExcel=ExportEcel"+
                           "&sSearch="+$(".dataTables_filter input").val();
               }else{
                   window.location.href = "${createLink(action:'getErrorDisplayAjaxDataTb',controller:'opError')}"+"/"+tbParams+"&exportExcel=ExportEcel";
               }

           });
       });

       TableToolsInit.sTitle = "DanhSachLoiRutGon";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
 
    </script>
 
  </body>
</html>
