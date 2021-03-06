
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Nhập thông tin cá nhân</title>
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
                                 [href:createLink(controller:'blackList',action:'detailCaNhan'),title:'Blacklist cá nhân',label:'Blacklist cá nhân']]
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
		<g:form method="post" name="detailCaNhanBlacklist"
			id="detailCaNhanBlacklist" controller="blackList"
			action="saveCnBlacklist" enctype="multipart/form-data">
			<fieldset>
				<legend>Nhập thông tin blacklist</legend>
				<ol class="form form-clear olCenter" id="incidentField">
					<g:if test="${flash.message}">
						<li>
							<div class="${flash.messageType}">
								${flash.message}
							</div>
						</li>
					</g:if>
					<g:if test="${flash.error}">
						<li>
        			 		<div id="flash-error" class="alert-message error">${flash.error}</div>
        			 	</li>
    				</g:if>
					<g:hiddenField name="blackListId" id="blackListId"
						value="${blackListCn?.id}" />
					<table class="tableControlCenter" style="border: 0px !important">
						<tr style="border: 0px;">
							<td style="border: 0px"><label for="tenCnBL"
								class=" lableTableCenter">Họ và tên<font color="red">*</font></label>
							</td>
							<td style="border: 0px"><label for="ngaysinhCnBL"
								class=" lableTableCenter">Ngày sinh <%--<font color="red">*</font> --%></label></td>
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input
								style="width: 420px; margin-right: 20px" type="text"
								id="tenCnBL" name="tenCnBL" value="${blackListCn?.tenCnBL}"
								class="controlTableCenter validate[required]" /></td>
							<td style="border: 0px"><input type="text" id="ngaysinhCnBL"
								name="ngaysinhCnBL"
								value="${blackListCn?.ngaysinhCnBL?formatDate(format: 'dd/MM/yyyy', date:blackListCn?.ngaysinhCnBL):null}"
								class="controlTableCenter datetime " /></td>
						</tr>
					</table>
					<table class="tableControlCenter"
						style="border: 0px !important; margin-top: 6px !important">
						<tr style="border: 0px; padding-top: 20px">
							<td style="border: 0px"><label for="cmndCnBL"
								class=" lableTableCenter">CMND/Hộ chiếu<font color="red">*</font>
							</label></td>
							<td style="border: 0px"><label for="ngaycapCnBL"
								class=" lableTableCenter">Ngày cấp
							</label></td>
							<td style="border: 0px"><label for="noicapCnBl"
								class=" lableTableCenter">Nơi cấp </font>
							</label></td>
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input
								style="margin-right: 20px; width: 210px;" type="text"
								id="cmndCnBL" name="cmndCnBL" value="${blackListCn?.cmndCnBL }"
								class="controlTableCenter validate[required]" /></td>
							<td style="border: 0px"><input style="margin-right: 20px"
								type="text" id="ngaycapCnBL" name="ngaycapCnBL"

								value="${blackListCn?.ngaycapCnBL?formatDate(format: 'dd/MM/yyyy', date: blackListCn?.ngaycapCnBL):''}"

								

								class="controlTableCenter datetime " /></td>
							<td style="border: 0px"><input type="text" id="noicapCnBl"
								name="noicapCnBl" value="${blackListCn?.noicapCnBl }"
								class="controlTableCenter " /></td>
						</tr>
					</table>
					<table class="tableControlCenter"
						style="border: 0px !important; margin-top: 6px !important">
						<tr style="border: 0px; padding-top: 20px">
							<td style="border: 0px"><label for="cmnd2CnBL"
								class=" lableTableCenter">CMND/Hộ chiếu 2 (Nếu có) <%--<font color="red">*</font> --%></label></td>
							<td style="border: 0px"><label for="ngaycap2CnBL"
								class=" lableTableCenter">Ngày cấp <%--<font color="red">*</font> --%></label></td>
							<td style="border: 0px"><label for="noicap2CnBl"
								class=" lableTableCenter">Nơi cấp <%--<font color="red">*</font> --%></label></td>
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input
								style="margin-right: 20px; width: 210px;" type="text"
								id="cmnd2CnBL" name="cmnd2CnBL"
								value="${blackListCn?.cmnd2CnBL }" class="controlTableCenter " /></td>
							<td style="border: 0px"><input style="margin-right: 20px"
								type="text" id="ngaycap2CnBL" name="ngaycap2CnBL"
								value="${blackListCn?.ngaycap2CnBL?formatDate(format: 'dd/MM/yyyy', date: blackListCn?.ngaycap2CnBL):''}"
								class="controlTableCenter datetime " /></td>
							<td style="border: 0px"><input type="text" id="noicap2CnBl"
								name="noicap2CnBl" value="${blackListCn?.noicap2CnBl }"
								class="controlTableCenter " /></td>
						</tr>
					</table>
					<table class="tableControlCenter"
						style="border: 0px !important; margin-top: 6px !important">
						<tr style="border: 0px; padding-top: 20px">
							<td style="border: 0px"><label for="diachiCnBL"
								class=" lableTableCenter">Địa chỉ<%--<font color="red">*</font> --%></label></td>
							<td style="border: 0px"><label for="sdtCnBl"
								class=" lableTableCenter">Số điện thoại <%--<font color="red">*</font> --%></label></td>
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input
								style="margin-right: 20px; width: 420px;" type="text"
								id="diachiCnBL" name="diachiCnBL"
								value="${blackListCn?.diachiCnBL }"
								class="controlTableCenter" /></td>
							<td style="border: 0px"><input style="margin-right: 20px"
								type="text" id="sdtCnBl" name="sdtCnBl"
								value="${blackListCn?.sdtCnBl }" class="controlTableCenter " /></td>
						</tr>
					</table>
					<div>
						<table class="tableControlCenter"
							style="border: 0px !important; margin-top: 6px !important">
							<tr style="border: 0px; padding-top: 20px">
								<td style="border: 0px"><label for="danhsachCnBL"
									class=" lableTableCenter">Lý do thuộc danh sách<font
										color="red">*</font>
								</label></td>
								<td style="border: 0px"><label for="lydochitietCnBL"
									class=" lableTableCenter">Lý do chi tiết (Nếu có) <%--<font color="red">*</font> --%></label>
								</td>
								<td style="border: 0px"><label for="dulieuCnBl"
									class=" lableTableCenter">Nguồn dữ liệu <%--<font color="red">*</font> --%></label>
								</td>

							</tr>
							<tr style="border: 0px;">
								<td style="border: 0px"><g:select
										style="margin-right: 20px;width: 220px;" type="text"
										id="danhsachCnBL" name="danhsachCnBL"
										value="${blackListCn?blackListCn.danhsachCnBL.id:'' }"
										from="${BlacklistCategory.executeQuery('from BlacklistCategory cn where cn.status>=0 order by cn.code+0') }"
										noSelection="${[danhsachCnBL=='1'?'selected="true"':'']}"
										optionKey="id" optionValue="${{it.code+'-'+it.name}}"
										class="controlTableCenter validate[required]" /></td>
								<td style="border: 0px"><input style="margin-right: 20px;"
									type="text" id="lydochitietCnBL" name="lydochitietCnBL"
									value="${blackListCn?.lydochitietCnBL }"
									class="controlTableCenter " /></td>
								<td style="border: 0px"><input style="width: 180px"
									type="text" id="dulieuCnBl" name="dulieuCnBl"
									value="${blackListCn?.dulieuCnBl }" class="controlTableCenter " /></td>
							</tr>
						</table>
					</div>
					<table class="tableControlCenter"
						style="border: 0px !important; margin-top: 6px !important">
						<tr style="border: 0px; padding-top: 20px">
							<td style="border: 0px"><label for="doituongCnBL"
								class=" lableTableCenter">Phân loại đối tượng<font
									color="red">*</font>
							</label></td>
							<td style="border: 0px"><label for="thoihanCnBL"
								class=" lableTableCenter">Thời hạn <font color="red">*</font></label></td>
							<td style="border: 0px"><label for="ghichuCnBL"
								class=" lableTableCenter">Ghi chú <%--<font color="red">*</font> --%></label></td>
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><g:select
									style="margin-right: 20px;width: 220px;" type="text"
									id="doituongCnBL" name="doituongCnBL" id="doituongCnBL"
									name="doituongCnBL"
									value="${blackListCn?blackListCn.doituongCnBL.id:'' }"
									from="${BlacklistObject.executeQuery('from BlacklistObject cn where cn.status>=0 order by cn.code+0') }"
									noSelection="${[doituongCnBL=='1'?'selected="true"':'']}"
									optionKey="id" optionValue="${{it.code+'-'+it.name}}"
									class="controlTableCenter" /></td>
							<td style="border: 0px"><input style="margin-right: 20px;"
								type="text" id="thoihanCnBL" name="thoihanCnBL"
								value="${formatDate(format: 'dd/MM/yyyy', date: blackListCn?.thoihanCnBL)?formatDate(format: 'dd/MM/yyyy', date: blackListCn?.thoihanCnBL):DateUtil.formatDate(year3later) }"
								class="controlTableCenter datetime " /></td>
							<td style="border: 0px"><input style="width: 180px"
								type="text" id="ghichuCnBL" name="ghichuCnBL"
								value="${blackListCn?.ghichuCnBL }" class="controlTableCenter " /></td>
						</tr>
					</table>
					<table class="tableControlCenter"
						style="border: 0px !important; margin-top: 6px !important">
						<tr style="border: 0px; padding-top: 20px">
							<td style="border: 0px"><label for="tochucCnBL"
								class=" lableTableCenter">Tên đơn vị công tác<%--<font color="red">*</font>
							--%></label></td>
							<td style="border: 0px"><label for="masothueCnBL"
								class=" lableTableCenter">Địa chỉ đơn vị công tác
									<%--<font color="red">*</font> --%>
							</label></td>
							
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input
								style="margin-right: 20px; width: 210px;" type="text"
								id="tochucCnBL" name="tochucCnBL"
								value="${blackListCn?.tochucCnBL }" class="controlTableCenter " /></td>
							<td style="border: 0px"><input style="margin-right: 20px"
								type="text" id="masothueCnBL" name="masothueCnBL"
								value="${blackListCn?.masothueCnBL }"
								class="controlTableCenter " /></td>							
						</tr>
					</table>
					<table class="tableControlCenter"
						style="border: 0px !important; margin-top: 6px !important">
						<tr style="border: 0px; padding-top: 20px">
							<td style="border: 0px"><label for="ngaynhapCnBL"
								class=" lableTableCenter">Ngày nhập<font color="red">*</font></label>
							</td>
							<td style="border: 0px"><label for="usernhapCnBL"
								class=" lableTableCenter">User nhập<font color="red">*</font>
							</label></td>
							<td style="border: 0px"><label for="phongbanCnBl"
								class=" lableTableCenter">Phòng/Ban nhập <font
									color="red">*</font></label></td>
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input
								style="margin-right: 20px; width: 210px;" type="text"
								id="ngaynhapCnBL" name="ngaynhapCnBL"
								value="${formatDate(format: 'dd/MM/yyyy', date: blackListCn?.ngaynhapCnBL)?formatDate(format: 'dd/MM/yyyy', date: blackListCn?.ngaynhapCnBL):DateUtil.formatDate(today) }"
								class="controlTableCenter datetime validate[required]" /></td>
							<td style="border: 0px"><input style="margin-right: 20px"
								type="text" id="usernhapCnBL" name="usernhapCnBL"
								value="${blackListCn?.usernhapCnBL?blackListCn.usernhapCnBL:currentUser}"
								readonly="readonly"
								class="controlTableCenter validate[required]" /></td>
							<td style="border: 0px"><input type="text" id="phongbanCnBl"
								readonly="readonly" name="phongbanCnBl"
								value="${UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(blackListCn?.usernhapCnBL?blackListCn.usernhapCnBL:currentUser).tenDonVi3).name}"
								class="controlTableCenter validate[required]" /></td>
						</tr>
					</table>
					<table id="hiddenCn"class="tableControlCenter" style="border: 0px !important; margin-top: 6px !important">
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
								value="${formatDate(format: 'dd/MM/yyyy hh:mm:ss', date: blackListCn?.ngaysua)?formatDate(format: 'dd/MM/yyyy hh:mm:ss', date: blackListCn?.ngaysua):DateUtil.formatDate(today) }"
								class="controlTableCenter datetime validate[required]" /></td>
						</tr>
					</table>
					<li style="margin-top: 20px !important">
						<g:if test="${blackListCn}">
							<sec:ifAnyGranted
								roles="ROLE_CVQLRR,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4">
								<button value="saveEdit" class="btn primary" id="saveEdit"
									name="saveEdit">Lưu</button>
								<button class="btn primary" id="deleteCnBl" name="deleteCnBl"
									value="deleteCnBl">Xóa</button>
								
								<button value="addNewCnBL" class="btn primary" id="addNewCnBL"
									name="addNewCnBL">Lưu mới</button>								
							</sec:ifAnyGranted>
						</g:if> 
						<g:else>
							<button value="addNewCnBL" class="btn primary" id="addNewCnBL"
								name="addNewCnBL">
								${blackListCn?'Cập nhập':'Lưu mới'}
							</button>
						</g:else>
						 <g:hiddenField id="deleteError" name="deleteError" value="" /></li>
				</ol>
			</fieldset>
			<g:hiddenField name="savebl" id="savebl" />
			<g:hiddenField name="blacklistId" value="${blackListCn?.id }" />
		</g:form>
	</div>
	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js">
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#detailCaNhanBlacklist").validationEngine();
		set_active_tab('blacklist-management');//top
		$("#blacklist-canhan-management").closest('li').addClass('active');//leftMenu
		set_side_bar(true); // ẩn hiển thanh menu trái	
		if($("#blackListId").val()==''){
			$("#hiddenCn").hide();	
			}
		});

	$("#deleteCnBl").click( function(){
		 jquery_confirm("Xóa","Anh/chị đồng ý xóa bỏ báo cáo này?",
               function(){
			 		$("#deleteError").val("deleteCnBl");
			 		  // $("#actionButton").val("errorDelete");
                     $("#detailCaNhanBlacklist").submit();
         });
		 return false;
	});
	</script>
		
</body>
</html>