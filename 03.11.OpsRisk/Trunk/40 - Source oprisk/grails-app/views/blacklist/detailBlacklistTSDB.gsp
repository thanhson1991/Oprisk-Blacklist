<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="comboboxList"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Nhập thông tin tài sản bảo đảm</title>
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
                                 [href:createLink(controller:'blackList',action:'detailQLTaiSan'),title:'Blacklist tài sản đảm bảo',label:'Blacklist tài sản đảm bảo']]
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
		<g:form method="post" name="detailBlacklistTSDB" id="detailBlacklistTSDB" controller="blackList" action="saveTsbdBlacklist"	enctype="multipart/form-data">
			<fieldset>
				<legend>Nhập thông tin TSBĐ blacklist</legend>
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
						value="${blacklistTsbd?.id}" />
					<table class="tableControlCenter" style="border:0px !important">
						 <tr style="border:0px ;">
		        			<td style ="border:0px"><label for="loaiTsBL" class=" lableTableCenter">Loại tài sản <font color="red">*</font> </label></td>		        			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><g:select style= "width: 640px;margin-right: 20px" type= "text" id = "loaiTsBL" name="loaiTsBL" class = "controlTableCenter validate[required]"
        												value="${blacklistTsbd?blacklistTsbd.loaiTsBL.id:'' }"
														from="${BlacklistTaiSan.executeQuery('from BlacklistTaiSan ts where ts.status>=0 order by ts.code+0') }"
														noSelection="${[loaiTsBL=='1'?'selected="true"':'']}" optionKey="id"
														optionValue="${{it.code+'-'+it.name}}"/></td>
        												</td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important">
						 <tr style="border:0px ;">
		        			<td style ="border:0px"><label data-toggle="tooltip" style="margin-top: 10px !important" for="thongtinTsBL" class=" lableTableCenter">Thông tin nhận diện tài sản <font color="red">*</font> </label></td>		        			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input title="- Đối với BĐS: seri sổ đỏ, số quyết định
- Đối với phương tiện vận tải: Số đăng ký xe, số khung, số máy
- Đối với Tiền gửi/GTCG: số seri thẻ tiết kiệm
- Đối với công cụ chuyển nhượng: số seri trên công cụ chuyển nhượng
- Đối với hàng hóa: tên hàng hóa
- Đối với bảo lãnh ngân hàng: bảo lãnh của Ngân hàng “(Tên Ngân hàng)”
   		"	
        						style= "width: 630px;margin-right: 20px" type= "text" id = "thongtinTsBL" name="thongtinTsBL" value="${blacklistTsbd?.thongtinTsBL}"  class = "controlTableCenter validate[required]"/>
        										
        										</td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important">
						 <tr style="border:0px ;">
		        			<td style ="border:0px"><label style="margin-top: 10px !important" for="sohuuTsBL" class=" lableTableCenter">Chủ sở hữu <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="cmtcshTsBL" class=" lableTableCenter">CMT/hộ chiếu Chủ SH (nếu là cá nhân) <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="masothueTsBL" class=" lableTableCenter">ĐKKD/mã số thuế chủ sỡ hữu (nếu là tổ chức) <%--<font color="red">*</font> --%></label></td>		        			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 210px" type= "text" id = "sohuuTsBL" name="sohuuTsBL" value="${blacklistTsbd?.sohuuTsBL}" class = "controlTableCenter "/></td>
        					<td style ="border:0px"><input style="margin-right: 20px" type= "text" id = "cmtcshTsBL" name="cmtcshTsBL" value="${blacklistTsbd?.cmtcshTsBL}" class = "controlTableCenter "/></td>
        					<td style ="border:0px"><input style="margin-right: 20px" type= "text" id = "masothueTsBL" name="masothueTsBL" value="${blacklistTsbd?.masothueTsBL}" class = "controlTableCenter "/></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important">
						 <tr style="border:0px ;">
		        			<td style ="border:0px"><label style="margin-top: 10px !important" for="canhanTsBL" class=" lableTableCenter">Người vay bằng TSBD bên thứ 3 <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="cmtlqTsBL" class=" lableTableCenter">CMT/HC/ĐKKD người vay <%--<font color="red">*</font> --%></label></td>	        					        			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 210px" type= "text" id = "canhanTsBL" name="canhanTsBL" value="${blacklistTsbd?.canhanTsBL}" class = "controlTableCenter "/></td>
        					<td style ="border:0px"><input style="margin-right: 20px" type= "text" id = "cmtlqTsBL" name="cmtlqTsBL" value="${blacklistTsbd?.cmtlqTsBL}" class = "controlTableCenter "/></td>       					       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important">
						 <tr style="border:0px ;">
		        			<td style ="border:0px"><label style="margin-top: 10px !important" for="diachiTsBL" class=" lableTableCenter">Địa chỉ <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label style="width: 200px !important;margin-top: 10px !important" for="ngaycapTsBL" class=" lableTableCenter">Ngày cấp/ngày phát hành TSBĐ <%--<font color="red">*</font> --%></label></td>		        					        			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 210px;margin-top: 5px" type= "text" id = "diachiTsBL" name="diachiTsBL" value="${blacklistTsbd?.diachiTsBL}" class = "controlTableCenter "/></td>
        					<td style ="border:0px"><input style="margin-right: 130px;margin-top: 5px" type= "text" id = "ngaycapTsBL" readonly="readonly" name="ngaycapTsBL" class = "controlTableCenter datetime  "
        														value="${blacklistTsbd?.ngaycapTsBL?formatDate(format: 'dd/MM/yyyy', date: blacklistTsbd?.ngaycapTsBL):null }"/></td>					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label style="width: 200px !important" for="motaTsBL" class=" lableTableCenter">Mô tả tài sản <%--<font color="red">*</font> --%></label></td>		        			  		
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 630px;" type= "text" id = "motaTsBL" name="motaTsBL" value="${blacklistTsbd?.motaTsBL}"  class = "controlTableCenter "/></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important">
						 <tr style="border:0px ;">
		        			<td style ="border:0px"><label style="margin-top: 10px !important" for="giatriTsBL" class=" lableTableCenter">Giá trị tài sản <%--<font color="red">*</font> --%></label></td>	
		        			<td style ="border:0px"><label style="margin-top: 10px !important" for="lichsuGdTsBL" class=" lableTableCenter">Lịch sử giao dịch của TSBĐ <%--<font color="red">*</font> --%></label></td>	        			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					
        					<td style ="border:0px"><input style="margin-right: 20px;width: 210px" type= "text" id = "lichsuGdTsBL" name="lichsuGdTsBL" value="${blacklistTsbd?.lichsuGdTsBL }" class = "controlTableCenter"/></td>
        					<td style ="border:0px"><input style= "width: 180px;margin-right: 130px" type= "text" id = "giatriTsBL" name="giatriTsBL" value="${blacklistTsbd?.giatriTsBL }"  class = "controlTableCenter"/></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label for="riskTsdbTsBL" class=" lableTableCenter">Lý do thuộc danh sách<font color="red">*</font> </label></td>		        			
		        			<td style ="border:0px"><label for="lydoCtTsBL" class=" lableTableCenter">Lý do chi tiết (Nếu có) <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="thoihanTsBL" class=" lableTableCenter">Thời hạn<%--<font color="red">*</font> --%></label></td>       			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><g:select style="margin-right: 20px;width: 220px;" type= "text" id = "riskTsdbTsBL" name="riskTsdbTsBL" class = "controlTableCenter validate[required]"
        												value="${blacklistTsbd?blacklistTsbd.riskTsdbTsBL.id:'' }"
														from="${BlacklistRiskTSBD.executeQuery('from BlacklistRiskTSBD ts where ts.status>=0 order by ts.code+0') }"
														noSelection="${[riskTsdbTsBL=='1'?'selected="true"':'']}" optionKey="id"
														optionValue="${{it.code+'-'+it.name}}"/></td>
        												</td>
        					<td style ="border:0px"><input style="margin-right: 20px;width: 180px" type= "text" id = "lydoCtTsBL" name="lydoCtTsBL" value="${blacklistTsbd?.lydoCtTsBL }" class = "controlTableCenter"/></td>
        						<td style ="border:0px"><input style="width: 175px;" type= "text" id = "thoihanTsBL" readonly="readonly" name="thoihanTsBL" class = "controlTableCenter datetime validate[required]"
        												value="${formatDate(format: 'dd/MM/yyyy', date: blacklistTsbd?.thoihanTsBL)?formatDate(format: 'dd/MM/yyyy', date: blacklistTsbd?.thoihanTsBL):DateUtil.formatDate(year3later) }"/></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label for="doituongTsBL" class=" lableTableCenter">Phân loại đối tượng<font color="red">*</font> </label></td>
		        			<td style ="border:0px"><label for="dulieuTsBL"   class=" lableTableCenter">Nguồn dữ liệu <%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="ghichuTsBL"   class=" lableTableCenter">Ghi chú <%--<font color="red">*</font> --%></label></td>       			    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><g:select style="margin-right: 20px;width: 220px;" type= "text" id = "doituongTsBL" name="doituongTsBL" class = "controlTableCenter validate[required]"
        												value="${blacklistTsbd?blacklistTsbd.doituongTsBL.id:'' }"
														from="${BlacklistObject.executeQuery('from BlacklistObject ts where ts.status>=0 order by ts.code+0') }"
														noSelection="${[doituongTsBL=='1'?'selected="true"':'']}" optionKey="id"
														optionValue="${{it.code+'-'+it.name}}"/></td>
        											</td>
        					<td style ="border:0px"><input style="margin-right: 20px;width: 180px;" type= "text" id = "dulieuTsBL" name="dulieuTsBL" value="${blacklistTsbd?.dulieuTsBL }" class = "controlTableCenter"/></td>
        					<td style ="border:0px"><input style="width: 175px" type= "text" id = "ghichuTsBL" name="ghichuTsBL" value="${blacklistTsbd?.ghichuTsBL }" class = "controlTableCenter"/></td>       					
    					</tr>
					</table>
					<table class="tableControlCenter" style="border:0px !important; margin-top: 6px !important">
						 <tr style="border:0px; padding-top: 20px">
		        			<td style ="border:0px"><label for="ngaynhapTsBL" class=" lableTableCenter">Ngày nhập<font color="red">*</font> </label></td>
		        			<td style ="border:0px"><label for="usernhapTsBL" class=" lableTableCenter">User nhập<%--<font color="red">*</font> --%></label></td>
		        			<td style ="border:0px"><label for="phongbanTsBl" class=" lableTableCenter">Phòng/Ban nhập <%--<font color="red">*</font> --%></label></td>    			
		    			</tr>
		    			 <tr style="border:0px ;">
        					<td style ="border:0px"><input style="margin-right: 20px;width: 210px;" type= "text" readonly="readonly" id = "ngaynhapTsBL" name="ngaynhapTsBL" class = "controlTableCenter datetime validate[required]"
        														value="${formatDate(format: 'dd/MM/yyyy', date: blacklistTsbd?.ngaynhapTsBL)?formatDate(format: 'dd/MM/yyyy', date: blacklistTsbd?.ngaynhapTsBL):DateUtil.formatDate(today) }"/></td>
        					<td style ="border:0px"><input style="margin-right: 20px" type= "text" id = "usernhapTsBL" readonly="readonly" name="usernhapTsBL" value="${blacklistTsbd?.usernhapTsBL?blacklistTsbd.usernhapTsBL:currentUser }" class = "controlTableCenter validate[required]"/></td>
        					<td style ="border:0px"><input type= "text" id = "phongbanTsBl" name="phongbanTsBl" readonly="readonly" class = "controlTableCenter validate[required]"
        											value="${UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(blacklistTsbd?.usernhapTsBL?blacklistTsbd.usernhapTsBL:currentUser).tenDonVi3).name}" /></td>
    					</tr>
					</table>
					
					<table id="hiddenTsbd" class="tableControlCenter" style="border: 0px !important; margin-top: 6px !important">
						<tr style="border: 0px; padding-top: 20px">
							<td style="border: 0px">
							<label for="nguoisua" style="float: none" class=" lableTableCenter">Người cập
									nhật<%--<font color="red">*</font></label>--%></td>
							<td style="border: 0px"><label for="ngaysua"
								style="float: none" class=" lableTableCenter">Ngày cập
									nhật<%--<font color="red">*</font></label>--%></td>
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input
								style="margin-right: 20px; width: 210px" type="text"
								id="nguoisua" name="nguoisua" value="${currentUser}"
								readonly="readonly" class="controlTableCenter " /></td>
							<td style="border: 0px"><input
								style="margin-right: 130px; width: 180px;" type="text"
								id="ngaysua" name="ngaysua"
								value="${formatDate(format: 'dd/MM/yyyy hh:mm:ss', date: blacklistTsbd?.ngaysua)?formatDate(format: 'dd/MM/yyyy hh:mm:ss', date: blacklistTsbd?.ngaysua):DateUtil.formatDate(today) }"
								class="controlTableCenter datetime validate[required]" /></td>
						</tr>
					</table>
					
					<li style="margin-top: 20px !important">

        				 <g:if test="${blacklistTsbd}">
					    <sec:ifAnyGranted roles="ROLE_CVQLRR,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4">
						        <button value="saveEdit" class="btn primary"  id ="saveEdit" name="saveEdit">Lưu</button>
						        <button type="button" class="btn primary"  id="deleteTsbdBl" name="deleteTsbdBl" value="deleteTsbdBl">Xóa</button>
						        <button value="addNewTsbdBL" class="btn primary"  id ="addNewTsbdBL" name="addNewTsbdBL">Lưu mới</button>						          
					        </sec:ifAnyGranted>
    				</g:if>
					
					  <g:else>
						<button value="addNewTsbdBL" class="btn primary" id="addNewTsbdBL"
							name="addNewTsbdBL">${blacklistTsbd?'Cập nhập':'Lưu mới'}
						</button>
						</g:else>
   					<g:hiddenField id="deleteError" name="deleteError" value=""/>
					</li>
				</ol>
			</fieldset>
			<g:hiddenField name="blacklistId" value="${blacklistTsbd?.id }"/>		
		</g:form>
	</div>
	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#detailBlacklistTSDB").validationEngine();
			set_active_tab('blacklist-management');//top
			$("#blacklist-taisan-management").closest('li').addClass('active');//leftMenu
			if($("#blackListId").val()==''){
				$("#hiddenTsbd").hide();	
				}
			set_side_bar(true); // ẩn hiển thanh menu trái
		});
		$('#deleteTsbdBl').live('click',function(e){
	        e.preventDefault();
	        jquery_confirm("Xóa","Anh/chị đồng ý xóa bỏ báo cáo này?",function(){
		 		$("#deleteError").val("deleteTsbdBl");
                  $("#detailBlacklistTSDB").submit();

      		});
	 		return false;
	    });
	</script>
</body>
</html>
