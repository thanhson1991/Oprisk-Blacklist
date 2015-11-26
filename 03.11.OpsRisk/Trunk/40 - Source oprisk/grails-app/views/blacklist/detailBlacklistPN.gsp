<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="comboboxList"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Nhập thông tin pháp nhân</title>
</head>
<body>
	<div id="m-melanin-tab-header">
		<div id="m-melanin-tab-header-inner">
			<div id="m-melanin-tab-actions">
				<button class="btn small primary m-melanin-toggle-side-bar"
					name="m-test-button-3" value="Toggle sidebar">Toggle
					sidebar</button>


			</div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
                          items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
                                 [href:createLink(controller:'blackList',action:'detailPhapNhan'),title:'Blacklist pháp nhân',label:'Blacklist pháp nhân']]
                  ]}" />

			<div class="clear"></div>
		</div>
		<%-- Để gọi đến dialog --%>
		<div id="m-melanin-left-sidebar">
			<g:render template="/blacklist/blacklistSidebar" />
		</div>
	</div>
	<div id="m-melanin-main-content">
		<%def today = new Date();
	    def year3later = new Date();
	        year3later.setYear(year3later.year+10);
	    %>
			<g:form method="post" name="detailBlacklistPN" id="detailBlacklistPN" controller="blackList" action="savePnBlacklist" enctype="multipart/form-data">
			<fieldset>
				<legend>Nhập thông tin pháp nhân blacklist</legend>
				<ol class="form form-clear olCenter" id="incidentField">
					<g:if test="${flash.message}">
						<li>
							<div class="${flash.messageType}">
								${flash.message}
							</div>
						</li>
					</g:if>
					<g:if test="${flash.error}">
       				 <div id="flash-error" class="alert-message error">${flash.error}</div>
   			 		</g:if>
					<g:hiddenField name="blackListId" id="blackListId"
						value="${blackListPn?.id}" />
					<table class="tableControlCenter" style="border:0px !important">
						 <tr style="border:0px ;">
		        			<td style ="border:0px"><label for="tenPnBL" class=" lableTableCenter">Tên doanh nghiệp <font color="red">*</font> </label></td>		        			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style= "width: 630px;margin-right: 20px" type= "text" id = "tenPnBL" name="tenPnBL" value="${blackListPn?.tenPnBL }"  class = "controlTableCenter validate[required]"/></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label style="width: 200px !important" for="giayphepPnBL" class=" lableTableCenter">Số ĐKKD/ Giấy phép đầu từ<font color="red">*</font> </label></td>
		        			<td style ="border:0px"><label for="ngaycapPnBL" class=" lableTableCenter">Ngày cấp<font color="red">*</font></label></td>
		        			<td style ="border:0px"><label for="noicapPnBL" class=" lableTableCenter">Nơi cấp <font color="red">*</font></label></td>    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 210px;" type= "text" id = "giayphepPnBL" name="giayphepPnBL" value="${blackListPn?.giayphepPnBL }"  class = "controlTableCenter validate[required]"/></td>
        					<td style ="border:0px"><input style="margin-right: 20px" type= "text" id = "ngaycapPnBL" name="ngaycapPnBL" class = "controlTableCenter datetime validate[required]" readonly="readonly"
        					value="${blackListPn?.ngaycapPnBL?formatDate(format: 'dd/MM/yyyy', date: blackListPn?.ngaycapPnBL):''}"
        					/></td>
        					<td style ="border:0px"><input type= "text" id = "noicapPnBL" name="noicapPnBL" value="${blackListPn?.noicapPnBL }" class = "controlTableCenter"/></td>
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label style="width: 200px !important" for="diachiPnBL" class=" lableTableCenter">Địa chỉ doanh nghiệp (Nếu có) <%--<font color="red">*</font> --%></label></td>		        			  		
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 630px;" type= "text" id = "diachiPnBL" name="diachiPnBL" value="${blackListPn?.diachiPnBL }"  class = "controlTableCenter "/></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label style="width: 200px !important" for="masothuePnBL" class=" lableTableCenter">Mã số thuế/Mã số DN (Nếu có) <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="phapluatPnBL" class=" lableTableCenter">Người đại diện pháp luật <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label style="width: 200px !important" for="cmndPnBL" class=" lableTableCenter">CMND/Hộ chiếu người đại diện <%--<font color="red">*</font> --%></label></td>		        			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 210px;" type= "text" id = "masothuePnBL" name="masothuePnBL" value="${blackListPn?.masothuePnBL }"  class = "controlTableCenter "/></td>
        					<td style ="border:0px"><input style="margin-right: 20px" type= "text" id = "phapluatPnBL" name="phapluatPnBL" value="${blackListPn?.phapluatPnBL }" class = "controlTableCenter "/></td>
        					<td style ="border:0px"><input type= "text" id = "cmndPnBL" name="cmndPnBL" value="${blackListPn?.cmndPnBL }" class = "controlTableCenter "/></td>      					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label for="danhsachPnBL" class=" lableTableCenter">Lý do thuộc danh sách<font color="red">*</font> </label></td>
		        			<td style ="border:0px"><label for="lydoPnBL" class=" lableTableCenter">Lý do chi tiết (Nếu có) <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="ghichuPnBL" class=" lableTableCenter">Ghi chú <%--<font color="red">*</font> --%></label></td>       			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><g:select style="margin-right: 20px;width: 220px;" type= "text" id = "danhsachPnBL" name="danhsachPnBL" class = "controlTableCenter validate[required]"
        												value="${blackListPn?blackListPn.danhsachPnBL.id:'' }"
														from="${BlacklistCategory.executeQuery('from BlacklistCategory cn where cn.status>=0 order by cn.code+0') }"
														noSelection="${[danhsachPnBL=='1'?'selected="true"':'']}" optionKey="id"
														optionValue="${{it.code+'-'+it.name}}"/></td>
        					<td style ="border:0px"><input style="margin-right: 20px;width: 180px;" type= "text" id = "lydoPnBL" name="lydoPnBL" value="${blackListPn?.lydoPnBL }"  class = "controlTableCenter "/></td>
        					<td style ="border:0px"><input style="width: 180px" type= "text" id = "ghichuPnBL" name="ghichuPnBL" value="${blackListPn?.ghichuPnBL}" class = "controlTableCenter "/></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label for="doituongPnBL" class=" lableTableCenter">Phân loại đối tượng<font color="red">*</font> </label></td>
		        			<td style="border: 0px"><label for="thoihanPnBL"  class=" lableTableCenter">Thời hạn <font color="red">*</font></label></td>
							<td style="border: 0px"><label for="dulieuPnBL"	class=" lableTableCenter">Nguồn dữ liệu <%--<font color="red">*</font> --%></label></td>       			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><g:select style="margin-right: 20px;width: 220px;" type= "text" id = "doituongPnBL" name="doituongPnBL" class = "controlTableCenter validate[required]"
        												value="${blackListPn?blackListPn.doituongPnBL.id:'' }"
														from="${BlacklistObject.executeQuery('from BlacklistObject cn where cn.status>=0 order by cn.code+0') }"
														noSelection="${[doituongPnBL=='1'?'selected="true"':'']}" optionKey="id"
														optionValue="${{it.code+'-'+it.name}}"/></td>
        												</td>
        					<td style="border: 0px"><input style="margin-right: 20px;" type="text" id="thoihanPnBL" name="thoihanPnBL"
															value="${formatDate(format: 'dd/MM/yyyy', date: blackListPn?.thoihanPnBL)?formatDate(format: 'dd/MM/yyyy', date: blackListPn?.thoihanPnBL):DateUtil.formatDate(year3later) }"
															class="controlTableCenter datetime " /></td>
							<td style="border: 0px"><input style="width: 180px"	type="text" id="dulieuPnBL" name="dulieuPnBL" value="${blackListPn?.dulieuPnBL}" class="controlTableCenter " /></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border: 0px !important; margin-top: 6px !important">
						<tr style="border: 0px; padding-top: 20px">
							
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input	style="margin-right: 20px; width: 210px;" type="text" id="tochucPnBL" name="tochucPnBL" value="${blackListPn?.tochucPnBL }" class="controlTableCenter " /></td>
							<td style="border: 0px"><input style="margin-right: 20px" type="text" id="hochieuPnBL" name="hochieuPnBL" value="${blackListPn?.hochieuPnBL }" class="controlTableCenter " /></td>
							<td style="border: 0px"><input type="text" id="lydoLqPnBL" name="lydoLqPnBL" value="${blackListPn?.lydoLqPnBL}" class="controlTableCenter " />
							</td>
						</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label for="ngaynhapPnBL" class=" lableTableCenter">Ngày nhập<font color="red">*</font> </label></td>
		        			<td style ="border:0px"><label for="usernhapPnBL" class=" lableTableCenter">User nhập<font color="red">*</font> </label></td>
		        			<td style ="border:0px"><label for="phongbanPnBL" class=" lableTableCenter">Phòng/Ban nhập<font color="red">*</font></label></td>    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 210px;" type= "text" id = "ngaynhapPnBL" name="ngaynhapPnBL" class = "controlTableCenter datetime validate[required]" readonly="readonly"
        											value="${formatDate(format: 'dd/MM/yyyy', date: blackListPn?.ngaynhapPnBL)?formatDate(format: 'dd/MM/yyyy', date: blackListPn?.ngaynhapPnBL):DateUtil.formatDate(today) }"/></td>
        					<td style ="border:0px"><input style="margin-right: 20px" type= "text" id = "usernhapPnBL" name="usernhapPnBL" readonly="readonly" class = "controlTableCenter validate[required]"
        													value="${blackListPn?.usernhapPnBL?blackListPn.usernhapPnBL:currentUser}"/></td>
        					<td style ="border:0px"><input type= "text" id = "phongbanPnBL" name="phongbanPnBL" class = "controlTableCenter validate[required]" readonly="readonly"
        												   value="${UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(blackListPn?.usernhapPnBL?blackListPn.usernhapPnBL:currentUser).tenDonVi3).name}" /></td>
    					</tr>
					</table>
					
					<table id="hiddenPN" class="tableControlCenter" data-toggle="tab" style="border: 0px !important; margin-top: 6px !important;">
						<tr style="border: 0px; padding-top: 20px">
							<td style="border: 0px">
								<label for="nguoisua" style="float:none" class=" lableTableCenter">Người cập nhật<%--<font color="red">*</font></label>--%>
							</td>
							<td style="border: 0px">
								<label for="ngaysua" style="float:none"  class=" lableTableCenter">Ngày cập nhật<%--<font color="red">*</font></label>--%>
							</td>
							</tr>
						<tr style="border: 0px;">
							<td style="border: 0px">
							<input style="margin-right: 20px;width: 210px" type="text" id="nguoisua" name="nguoisua" value="${currentUser}" readonly="readonly" class="controlTableCenter " />
							</td>
							<td style="border: 0px">
							<input style="margin-right: 130px; width: 180px;" type="text" id="ngaysua" name="ngaysua"
								value="${formatDate(format: 'dd/MM/yyyy hh:mm:ss', date: blackListPn?.ngaysua)?formatDate(format: 'dd/MM/yyyy hh:mm:ss', date: blackListPn?.ngaysua):DateUtil.formatDate(today) }"
								class="controlTableCenter datetime validate[required]" />
							</td>
						</tr>							
					</table>
					<li style="margin-top: 20px !important">
					 <g:if test="${blackListPn}">
					    <sec:ifAnyGranted roles="ROLE_CVQLRR,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4">
						        <button value="saveEdit" class="btn primary"  id ="saveEdit" name="saveEdit">Lưu</button>
						        <button class="btn primary"  id="deletePnBl" name="deletePnBl" value="deletePnBl">Xóa</button>
						        <button value="addNewPnBL" class="btn primary"  id ="addNewPnBL" name="addNewPnBL">Lưu mới</button><%--						        
						        <button type="button" value="cancelEdit" class="btn primary"  id ="cancelEdit" name="cancelEdit">Hủy</button>
					        --%></sec:ifAnyGranted>
    				</g:if>
					  <g:else>
						<button value="addNewPnBL" class="btn primary" id="addNewPnBL"
							name="addNewPnBL">${blackListPn?'Cập nhập':'Lưu mới'}
						</button>
						</g:else>
   					<g:hiddenField id="deleteError" name="deleteError" value=""/>
					</li>
				</ol>
				
			</fieldset>		
			<g:hiddenField name="savebl" id="savebl" /><%--
			<g:hiddenField name="detail" id="detail" value="${detail }"/>
			--%><g:hiddenField name="blacklistId" value="${blackListPn?.id }"/>			
					<%--
					<li style="margin-top: 20px !important">

        					<button value="addNewPnBL" class="btn primary"  id ="addNewPnBL" name="addNewPnBL">Lưu mới</button>
        					<button type="button" value="cancelEdit" class="btn primary"  id ="cancelEdit" name="cancelEdit">Hủy</button>

					</li>
				</ol>
			</fieldset>
		--%></g:form>
	</div>
	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#detailBlacklistPN").validationEngine();
			set_active_tab('blacklist-management');//top
			$("#blacklist-phapnhan-management").closest('li').addClass('active');//leftMenu
			if($("#blackListId").val()==''){
				$("#hiddenPN").hide();	
				}
			set_side_bar(true); // ẩn hiển thanh menu trái	
		});
		$("#deletePnBl").click( function(){
			 jquery_confirm("Xóa","Anh/chị đồng ý xóa bỏ báo cáo này?",
	                function(){
				 		$("#deleteError").val("deletePnBl");
				 		  // $("#actionButton").val("errorDelete");
	                      $("#detailBlacklistPN").submit();

	          });
			 return false;
		});
	</script>
</body>
</html>
