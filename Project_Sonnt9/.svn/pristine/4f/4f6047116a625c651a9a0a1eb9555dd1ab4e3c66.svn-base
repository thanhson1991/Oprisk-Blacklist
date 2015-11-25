<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="comboboxList"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Lỗi</title>
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
						[href:createLink(controller:'riskAction',action:'detail'),title:'Hành động giám sát rủi ro',label:'Hành động giám sát rủi ro']]
					]}" />
		</div>
		<div class="clear"></div>
	</div>
	<div id="m-melanin-left-sidebar">
		<g:render template="riskActionSidebar" />

	</div>
	<div id="m-melanin-main-content">
		<g:form method="post" name="riskActionForm" controller="riskAction"
			action="save" enctype="multipart/form-data">

			<fieldset class="info">
				<legend>Nhập thông tin hành động </legend>

				<ol class="form form-clear olCenter" id="incidentField">
					<g:if test="${flash.message}">
						<div id="flash-message" class="message info">
							${flash.message}
						</div>
					</g:if>
					<table class="tableControlCenter" style="border: 0px !important">
						<tr style="border: 0px;">
							<td style="border: 0px"><label for="actionId"
								class=" lableTableCenter">Mã hành động<font color="red">*</font>
							</label></td>
							<td style="border: 0px"><label for="actionType"
								class=" lableTableCenter">Loại hành động<font
									color="red">*</font>
							</label></td>
							<td style="border: 0px"><label for="riskName"
								class=" lableTableCenter">Tên rủi ro<font color="red">*</font>
							</label></td>
						</tr>
						<tr style="border: 0px;">
							<td style="border: 0px"><input name="actionId"
								readonly="readonly"
								value="${riskAction?riskAction.id:RiskAction.findAll().size() +1 }"
								id="actionId" class="validate[required] controlTableCenter" /></td>
							<sec:ifAnyGranted roles="ROLE_CVQLRR">
								<td style="border: 0px"><g:select name="actionType"
										id="actionType"
										value="${riskAction?riskAction.actionType.id:'' }"
										from="${ActionType.executeQuery(' from ActionType t where t.status>=0 order by t.code+0')}"
										noSelection="${['':'']}" optionKey="id"
										optionValue="${{it.code+'-'+it.name}}"
										class=" validate[required]  controlComboboxTableCenter" /></td>
							</sec:ifAnyGranted>
							<sec:ifNotGranted roles="ROLE_CVQLRR">
								<td style="border: 0px"><g:select
										disabled="${riskAction?'true':'' }" name="actionType"
										id="actionType"
										value="${riskAction?riskAction.actionType.id:'' }"
										from="${ActionType.executeQuery(' from ActionType t where t.status>=0 order by t.code+0')}"
										noSelection="${['':'']}" optionKey="id"
										optionValue="${{it.code+'-'+it.name}}"
										class=" validate[required]  controlComboboxTableCenter" /></td>
								<g:hiddenField id="actionType_hidden" name="actionType_hidden"
									value="${riskAction?riskAction.actionType.id:''}" />

							</sec:ifNotGranted>


							<td style="border: 0px"><input name="riskName"
								value="${riskAction?riskAction.riskName:'' }" id="riskName"
								class="validate[required] controlTableCenter" /></td>
						</tr>
					</table>
					<li><label for="description" class="lableCenter">Mô tả
							hành động <font color="red">*</font>
					</label> <br> <textArea type="text" name="description"
							id="description"
							class="validate[required] text-input largeControlCenter">
							${riskAction?riskAction.description:'' }
						</textArea></li>
					<li>
						<table class="tableControlCenter" style="border: 0px !important">
							<tr style="border: 0px">
								<td style="border: 0px"><label for="actionDueDate"
									class="lableTableCenter ">Mức độ rủi ro <font
										color="red">*</font></label></td>
								<td style="border: 0px"><label for="actionStatus"
									class="lableTableCenter">Trạng thái hành động <font
										color="red">*</font></label></td>
								<td style="border: 0px"><label for="actionStatus"
									class="lableTableCenter">Thời hạn hành động <font
										color="red">*</font></label></td>

							</tr>
							<tr style="border: 0px">

								<td style="border: 0px"><g:select
										class="controlComboboxTableCenter validate[required]"
										id="actionStatus" name="riskLevel"
										from="${['Trung bình','Cao','Thấp']}" optionKey="value"
										value="${ riskAction?riskAction.riskLevel:''}" /></td>
								<td><g:select
										class="controlComboboxTableCenter validate[required]"
										id="actionStatus" name="actionStatus"
										from="${comboboxList.listIncidentStatus()}" optionKey="value"
										value="${ riskAction?riskAction.actionStatus:''}" /></td>
								<td style="border: 0px"><input readonly="readonly"
									type="text" id="actionDueDate" name="actionDueDate"
									class="validate[required] datetime controlTableCenter"
									value="${riskAction?DateUtil.formatDate(riskAction.actionDueDate):''}" /></td>

							</tr>
						</table>
					</li>


					<li><label class="incident_label ">Người chịu trách
							nhiệm hành động</label> <input type="button" class="btn" value="Thêm"
						name="addRunDate" tid="responsible_" /></li>

					<g:if test="${riskAction?.responsibleUsers}">
						<g:each in="${riskAction?.responsibleUsers}" var="d" status="t">
							<li id="responsible_runDate_${t+1}">
								<table class="tableControlCenter">
									<tr>
										<td><label for="responsible_OutLook_${t+1}"
											class="nguoiso">UserOutlook ${t+1}</label></td>
										<td><label for="responsible_HoVaTen_${t+1}"
											class="hovaten">Họ và tên ${t+1}</label></td>
										<td><label for="responsible_ChucDanh_${t+1}"
											class="chucdanh">Chức danh ${t+1}</label></td>
										<td rowspan="4"><a
											class="deleteDate deleteUncreatedDate  set-edit"
											tname="responsible_" tid="${t+1}" title="Xoa ngay"
											href="#body"> <img border="0"
												src="${resource(dir:'images',file:'icon_delete.PNG')}"
												height="15" alt="" /></a></td>
									</tr>
									<tr>
										<td><input style="width: 177px !important" class="errorManagement responsible_errorManagement" tname="responsible_" tid="${t+1}" name ="responsible_OutLook_${t+1}" id="responsible_OutLook_${t+1}" value="${d.userEmail }" /> </td>
		    			<td> <input class="errorHoVaTen responsible_errorHoVaTen"  name ="responsible_HoVaTen_${t+1}" id="responsible_HoVaTen_${t+1}" readonly="readonly" value="${ d.fullName}" width="10px" /></td>
		    			<td> <input class="errorChucDanh responsible_errorChucDanh"  name ="responsible_ChucDanh_${t+1}" id="responsible_ChucDanh_${t+1}" value="${d.title}" readonly="readonly" width="10px" /></td>
		    			
		    		</tr>
		    		
		    		<tr>    			
		    			<td> <label for="responsible_BdsUser_${t+1} " class="BdsUser">User hệ thống ${t+1} </label></td>
		    			<td> <label for="responsible_IdNhanSu_${t+1} " class="IdNhanSu">ID nhân sự ${t+1}</label></td>
		    			
		    		</tr>
		    		
		    		<tr>    			
		    			<td><input class="errorBDSUser responsible_errorBDSUser"  name ="responsible_BdsUser_${t+1}" id="responsible_BdsUser_${t+1}" value="${d.bDSUser }" width="10px" readonly="readonly"  />         </td>
		    			<td><input class="errorNhanSu responsible_errorNhanSu"  name ="responsible_IdNhanSu_${t+1}" id="responsible_IdNhanSu_${t+1}" value="${d.codeSalary }" width="100px" readonly="readonly"  />   </td>    			
		    		</tr>
		    		
		    		<tr>
		    			<td> <label for="responsible_NHCD" class="NHCD">NH Chuyên doanh/Khối ${t+1}</label></td>
		    			<td> <label for="responsible_TenDonVi" class="TenDonVi">CN/Trung tâm/Phòng ${t+1}</label></td>    		
		    			<td> <label for="responsible_PGD" class="PGD">PGD/Phòng ban/Tổ Nhóm ${t+1}</label></td>
		    			
		    		</tr>
		    		
		    		<tr>
		    			<td><input class="errorNHCD responsible_errorNHCD"  name ="responsible_NHCD_${t+1}" id="responsible_NHCD_${t+1}" value="${UnitDepart.get(d.tenDonVi1)?.name}" width="100px" style="!important" readonly="readonly" /></td>
		    			<td><input class="errorTenDonVi responsible_errorTenDonVi"  name ="responsible_TenDonVi_${t+1}" id="responsible_TenDonVi_${t+1}" value="${UnitDepart.get(d.tenDonVi2)?.name}" width="100px" readonly="readonly"  />         </td>
		    			<td><input class="errorPGD responsible_errorPGD"  name ="responsible_PGD_${t+1}" id="responsible_PGD_${t+1}" value="${UnitDepart.get(d.tenDonVi3)?.name}" width="100px" readonly="readonly"  />         </td>
		    			<td>
		    			<g:hiddenField class="errorNHCDId responsible_errorNHCDId" id="responsible_NHCD_Id_${t+1}" name="responsible_NHCD_Id_${t+1}" value="${d.tenDonVi1}" />
		    			<g:hiddenField class="errorTenDonViId responsible_errorTenDonViId"  id="responsible_TenDonVi_Id_${t+1}" name="responsible_TenDonVi_Id_${t+1}" value="${d.tenDonVi2}"/>
		    			<g:hiddenField class="errorPGDId responsible_errorPGDId"  id="responsible_PGD_Id_${t+1}" name="responsible_PGD_Id_${t+1}" value="${d.tenDonVi3}" />
    					</td>   
		    			<td></td>			
		    		</tr>
		    		
		    		
		    		
		    	</table>
		                                    
		   </li>
       
       </g:each>
    </g:if>
    <g:else>
    
    <li id="responsible_runDate_1" >
    
    	<table class="tableControlCenter">
    		<tr>
    			<td> <label for="responsible_OutLook_1" class="nguoiso">UserOutlook 1</label> </td>
    			<td> <label for="responsible_HoVaTen_1" class="hovaten">Họ và tên 1</label></td>
    			<td> <label for="responsible_ChucDanh_1" class="chucdanh">Chức danh 1</label></td>
    			<td rowspan="4">
    				  <a class="deleteDate deleteUncreatedDate  set-edit" tname="responsible_" tid="1" title="Xoa ngay" href="#body"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.PNG')}" height="15" alt="" /></a>
    			</td>
    		</tr>
    		<tr>
    			<td><input style="width:177px !important" class="errorManagement responsible_errorManagement" tname="responsible_" tid="1" name ="responsible_OutLook_1" id="responsible_OutLook_1" value="" /> </td>
    			<td> <input class="errorHoVaTen responsible_errorHoVaTen"  name ="responsible_HoVaTen_1" id="responsible_HoVaTen_1" readonly="readonly" value="" width="100px" /></td>
    			<td> <input class="errorChucDanh responsible_errorChucDanh"  name ="responsible_ChucDanh_1" id="responsible_ChucDanh_1" value="" readonly="readonly" width="100px" /></td>
    			
    		</tr>
    		
    		<tr>    			
    			<td> <label for="responsible_BdsUser_1 " class="BdsUser">User hệ thống 1 </label></td>
    			<td> <label for="responsible_IdNhanSu_1 " class="IdNhanSu">ID nhân sự 1</label></td>
    			
    		</tr>
    		
    		<tr>    			
    			<td><input class="errorBDSUser responsible_errorBDSUser"  name ="responsible_BdsUser_1" id="responsible_BdsUser_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td><input class="errorNhanSu responsible_errorNhanSu"  name ="responsible_IdNhanSu_1" id="responsible_IdNhanSu_1" value="" width="100px" readonly="readonly"  />   </td>    			
    		</tr>
    		
    		<tr>
    			<td> <label for="responsible_NHCD" class="NHCD">NH Chuyên doanh/Khối 1</label></td>
    			<td> <label for="responsible_TenDonVi" class="TenDonVi">CN/Trung tâm/Phòng 1</label></td>    		
    			<td> <label for="responsible_PGD" class="PGD">PGD/Phòng ban/Tổ Nhóm 1</label></td>
    			
    		</tr>
    		
    		<tr>
    			<td><input class="errorNHCD responsible_errorNHCD"  name ="responsible_NHCD_1" id="responsible_NHCD_1" value="" width="100px" style="!important" readonly="readonly" /></td>
    			<td><input class="errorTenDonVi responsible_errorTenDonVi"  name ="responsible_TenDonVi_1" id="responsible_TenDonVi_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td><input class="errorPGD responsible_errorPGD"  name ="responsible_PGD_1" id="responsible_PGD_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td>
    			<g:hiddenField class="errorNHCDId responsible_errorNHCDId" id="responsible_NHCD_Id_1" name="responsible_NHCD_Id_1" />
    			<g:hiddenField class="errorTenDonViId responsible_errorTenDonViId"  id="responsible_TenDonVi_Id_1" name="responsible_TenDonVi_Id_1" />
    			<g:hiddenField class="errorPGDId responsible_errorPGDId"  id="responsible_PGD_Id_1" name="responsible_PGD_Id_1" />
    			</td>       
    			<td></td>			
    		</tr>
    		
    		
    		
    	</table>
                                    
   </li>
   </g:else>
  
	<li>
    	<label  class="incident_label ">Người giám sát hành động</label> <input type="button" class="btn" value="Thêm" name="addRunDate" tid="supervisor_"/>
    </li>
    
    <g:if test="${riskAction?.supervisors}">
       <g:each in="${riskAction?.supervisors}" var="d" status="t">
       		<li id="supervisor_runDate_${t+1}" >    
		    	<table class="tableControlCenter">
		    		<tr>
		    			<td> <label for="supervisor_OutLook_${t+1}" class="nguoiso">UserOutlook ${t+1}</label> </td>
		    			<td> <label for="supervisor_HoVaTen_${t+1}" class="hovaten">Họ và tên ${t+1}</label></td>
		    			<td> <label for="supervisor_ChucDanh_${t+1}" class="chucdanh">Chức danh ${t+1}</label></td>
		    			<td rowspan="4">
		    				  <a class="deleteDate deleteUncreatedDate  set-edit" tname="supervisor_" tid="${t+1}" title="Xoa ngay" href="#body"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.PNG')}" height="15" alt="" /></a>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td><input style="width:177px !important" class="errorManagement supervisor_errorManagement" tname="supervisor_" tid="${t+1}" name ="supervisor_OutLook_${t+1}" id="supervisor_OutLook_${t+1}" value="${d.userEmail }" /> </td>
		    			<td> <input class="errorHoVaTen supervisor_errorHoVaTen"  name ="supervisor_HoVaTen_${t+1}" id="supervisor_HoVaTen_${t+1}" readonly="readonly" value="${ d.fullName}" width="10px" /></td>
		    			<td> <input class="errorChucDanh supervisor_errorChucDanh"  name ="supervisor_ChucDanh_${t+1}" id="supervisor_ChucDanh_${t+1}" value="${d.title}" readonly="readonly" width="10px" /></td>
		    			
		    		</tr>
		    		
		    		<tr>    			
		    			<td> <label for="supervisor_BdsUser_${t+1} " class="BdsUser">User hệ thống ${t+1} </label></td>
		    			<td> <label for="supervisor_IdNhanSu_${t+1} " class="IdNhanSu">ID nhân sự ${t+1}</label></td>
		    			
		    		</tr>
		    		
		    		<tr>    			
		    			<td><input class="errorBDSUser supervisor_errorBDSUser"  name ="supervisor_BdsUser_${t+1}" id="supervisor_BdsUser_${t+1}" value="${d.bDSUser }" width="10px" readonly="readonly"  />         </td>
		    			<td><input class="errorNhanSu supervisor_errorNhanSu"  name ="supervisor_IdNhanSu_${t+1}" id="supervisor_IdNhanSu_${t+1}" value="${d.codeSalary }" width="100px" readonly="readonly"  />   </td>    			
		    		</tr>
		    		
		    		<tr>
		    			<td> <label for="supervisor_NHCD" class="NHCD">NH Chuyên doanh/Khối ${t+1}</label></td>
		    			<td> <label for="supervisor_TenDonVi" class="TenDonVi">CN/Trung tâm/Phòng ${t+1}</label></td>    		
		    			<td> <label for="supervisor_PGD" class="PGD">PGD/Phòng ban/Tổ Nhóm ${t+1}</label></td>
		    			
		    		</tr>
		    		
		    		<tr>
		    			<td><input class="errorNHCD supervisor_errorNHCD"  name ="supervisor_NHCD_${t+1}" id="supervisor_NHCD_${t+1}" value="${UnitDepart.get(d.tenDonVi1)?.name}" width="100px" style="!important" readonly="readonly" /></td>
		    			<td><input class="errorTenDonVi supervisor_errorTenDonVi"  name ="supervisor_TenDonVi_${t+1}" id="supervisor_TenDonVi_${t+1}" value="${UnitDepart.get(d.tenDonVi2)?.name}" width="100px" readonly="readonly"  />         </td>
		    			<td><input class="errorPGD supervisor_errorPGD"  name ="supervisor_PGD_${t+1}" id="supervisor_PGD_${t+1}" value="${UnitDepart.get(d.tenDonVi3)?.name}" width="100px" readonly="readonly"  />         </td>
		    			<td>
		    			<g:hiddenField class="errorNHCDId supervisor_errorNHCDId" id="supervisor_NHCD_Id_${t+1}" name="supervisor_NHCD_Id_${t+1}" value="${d.tenDonVi1}" />
		    			<g:hiddenField class="errorTenDonViId supervisor_errorTenDonViId"  id="supervisor_TenDonVi_Id_${t+1}" name="supervisor_TenDonVi_Id_${t+1}" value="${d.tenDonVi2}"/>
		    			<g:hiddenField class="errorPGDId supervisor_errorPGDId"  id="supervisor_PGD_Id_${t+1}" name="supervisor_PGD_Id_${t+1}" value="${d.tenDonVi3}" />
		    			</td>    
		    			<td></td>			
		    		</tr>
		    		
		    		
		    		
		    	</table>
		                                    
		   </li>
       
       </g:each>
    </g:if>
    <g:else>
    
    <li id="supervisor_runDate_1" >
    
    	<table class="tableControlCenter">
    		<tr>
    			<td> <label for="supervisor_OutLook_1" class="nguoiso">UserOutlook 1</label> </td>
    			<td> <label for="supervisor_HoVaTen_1" class="hovaten">Họ và tên 1</label></td>
    			<td> <label for="supervisor_ChucDanh_1" class="chucdanh">Chức danh 1</label></td>
    			<td rowspan="4">
    				  <a class="deleteDate deleteUncreatedDate  set-edit" tname="supervisor_" tid="1" title="Xoa ngay" href="#body"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.PNG')}" height="15" alt="" /></a>
    			</td>
    		</tr>
    		<tr>
    			<td><input style="width:177px !important" class="errorManagement supervisor_errorManagement" tname="supervisor_" tid="1" name ="supervisor_OutLook_1" id="supervisor_OutLook_1" value="" /> </td>
    			<td> <input class="errorHoVaTen supervisor_errorHoVaTen"  name ="supervisor_HoVaTen_1" id="supervisor_HoVaTen_1" readonly="readonly" value="" width="100px" /></td>
    			<td> <input class="errorChucDanh supervisor_errorChucDanh"  name ="supervisor_ChucDanh_1" id="supervisor_ChucDanh_1" value="" readonly="readonly" width="100px" /></td>
    			
    		</tr>
    		
    		<tr>    			
    			<td> <label for="supervisor_BdsUser_1 " class="BdsUser">User hệ thống 1 </label></td>
    			<td> <label for="supervisor_IdNhanSu_1 " class="IdNhanSu">ID nhân sự 1</label></td>
    			
    		</tr>
    		
    		<tr>    			
    			<td><input class="errorBDSUser supervisor_errorBDSUser"  name ="supervisor_BdsUser_1" id="supervisor_BdsUser_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td><input class="errorNhanSu supervisor_errorNhanSu"  name ="supervisor_IdNhanSu_1" id="supervisor_IdNhanSu_1" value="" width="100px" readonly="readonly"  />   </td>    			
    		</tr>
    		
    		<tr>
    			<td> <label for="supervisor_NHCD" class="NHCD">NH Chuyên doanh/Khối 1</label></td>
    			<td> <label for="supervisor_TenDonVi" class="TenDonVi">CN/Trung tâm/Phòng 1</label></td>    		
    			<td> <label for="supervisor_PGD" class="PGD">PGD/Phòng ban/Tổ Nhóm 1</label></td>
    			
    		</tr>
    		
    		<tr>
    			<td><input class="errorNHCD supervisor_errorNHCD"  name ="supervisor_NHCD_1" id="supervisor_NHCD_1" value="" width="100px" style="!important" readonly="readonly" /></td>
    			<td><input class="errorTenDonVi supervisor_errorTenDonVi"  name ="supervisor_TenDonVi_1" id="supervisor_TenDonVi_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td><input class="errorPGD supervisor_errorPGD"  name ="supervisor_PGD_1" id="supervisor_PGD_1" value="" width="100px" readonly="readonly"  />         </td>
    			<td>
    			<g:hiddenField class="errorNHCDId supervisor_errorNHCDId" id="supervisor_NHCD_Id_1" name="supervisor_NHCD_Id_1" />
    			<g:hiddenField class="errorTenDonViId supervisor_errorTenDonViId"  id="supervisor_TenDonVi_Id_1" name="supervisor_TenDonVi_Id_1" />
    			<g:hiddenField class="errorPGDId supervisor_errorPGDId"  id="supervisor_PGD_Id_1" name="supervisor_PGD_Id_1" />
    			</td>    
    			<td></td>			
    		</tr>
    		
    		
    		
    	</table>
                                    
   </li>
  
   </g:else>
   
   
    <li>
   	      <label for="uploadFile" class="lableCenter ">Hồ sơ đính kèm:</label>
   	      <br>
   	       <div id="fileUploadx" >
 
            <g:if test="${riskAction?.fileName!=null}">
               
                    <label style="width:50px "  class="">Tên file:</label>
                    	 <g:link style="margin-left:0px !important"  id="lblFilename" url="${resource(dir:'riskActionFiles',file:riskAction?.fileName)}">${riskAction?.fileName }</g:link>

                    <input type="hidden" width="100px" name="fileName" value="${riskAction?.fileName }" />                
                    <button type="button" class="btn primary" id="deleteFile" name="deleteFile" value="deleteFile">Xóa file</button>
                    
                    <br>
     		</g:if>
     	</div>
    	<br>
   	      <input type="file" id="uploadFile" name="uploadFile" size="79px"></input>
   </li>
   <g:if test ="${!riskAction }">
     <li>
      <label for="YKienCacDonViKhac" class="incident_label">Ý kiến của anh/chị:</label>
    </li>    
    <li>
      <g:textArea name="YKienCacDonViKhac"   class="largeControlCenter" rows="1"  id="YKienCacDonViKhac"/>
   </li>
   </g:if>
   
    
   <li>
   <%--<sec:ifAnyGranted roles="ROLE_CVQLRR"> --%>
   	<button value="Cập nhật" type="button" class="btn primary"  id ="submit_riskAction" name="saveRiskAction">Lưu</button>
   	<g:if test ="${riskAction }">
   	<button value="Lưu mới" type="button" class="btn primary"  id ="new_riskAction" name="newRiskAction">Lưu mới</button>
   	<button value="Xóa" type="button" class="btn primary"  id ="delete_riskAction" name="deleteRiskAction">Xóa</button>
   	</g:if>
   	 <%--</sec:ifAnyGranted>--%>
   	<%--<sec:ifNotGranted roles="ROLE_CVQLRR">
   		<g:if test ="${!riskAction }">
   		<button value="Cập nhật" type="button" class="btn primary"  id ="submit_riskAction" name="saveRiskAction">Lưu</button>
   		</g:if>
   	</sec:ifNotGranted>
   --%></li>
   
   <g:hiddenField id = "clone" name = "clone"/>
	<g:hiddenField id = "delete" name = "delete"/>
	<g:hiddenField id = "save" name = "save"/>
	<g:hiddenField id="hfDeleteFile" name="hfDeleteFile" value="notDeletefile"/>
	<g:hiddenField id = "riskActionId" name = "riskActionId" value="${riskAction?riskAction.id:'' }"/>
	<% def supervisorCount = riskAction?riskAction.supervisors.size():1 
	   def responsibleCount = riskAction?riskAction.responsibleUsers.size():1
	%>
    <g:hiddenField id="supervisor_dateCount" name="supervisor_dateCount" value="${supervisorCount==0?1:supervisorCount}"/>
    <g:hiddenField id="responsible_dateCount" name="responsible_dateCount" value="${responsibleCount==0?1:responsibleCount}"/>
  </g:form>
   
  	<g:if test ="${riskAction }">
  		<g:form method="post" id="commentList" controller="riskAction" action="addComment">
  		<g:hiddenField id="commentAction" name="commentAction" value="${riskAction.id}"/>
              <fieldset style="width:540px">
                <ol class="form-clear">
                  <g:if test="${riskAction.actionComments.size()>0}">
                  <li><b>Các ý kiến đã gửi:</b></li>
                  <li>
                     <table class="commentTable" >
                        <thead class="hidden">
                          <td></td>
                        </thead>
                        <tbody>
                        <g:each in="${riskAction.actionComments}" var="i">
                          <tr>
                            <td>
                              ${i.content}<br/>
                              <span class="red">Người viết: ${i.createdBy.username}</span>
                              <span>${formatDate(date:i.dateCreated)}</span>
                            </td>

                          </tr>
                        </g:each>
                        </tbody>

                      </table>

                  </li>
                  </g:if>
                  <li>
			      <label for="YKienCacDonViKhac" class="incident_label"><font color="red"></font>Ý kiến của anh/chị:</label>
			    </li>
			    <li>
			      <g:textArea name="YKienCacDonViKhac" style="width:520px"  cols="140" rows="2"class="incident-field " id="YKienCacDonViKhac"/>
			      
			      <br>
			      <br>
			      <button class="btn "  id="saveComment" name="saveComment" value="sendComment">Gửi ý kiến</button>
			   </li>
			   
			   
			   <li>
			   	
			   </li>
			    
			  </ol>
			</fieldset>
			</g:form>
    </g:if>
                  
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
                      <sec:ifNotGranted roles="ROLE_GDTT_LEVEL2 ">
                      	<th>Chức năng</th>
                      </sec:ifNotGranted>
                    </tr>
                  </thead>
                  <tbody>
                     <g:each in="${riskAction?.actionComments}" var="i" status="k">
                       <tr>
                         <td class="center">${k+1}</td>
                         <td>${i.content}</td>
                         <td class="center">${i.createdBy.username}</td>
                         <td class="center"><span tid="${i.id}" class="ss_sprite ss_cancel set-delete delete_comment" title="Xóa"></td>                         
                       </tr>
                     </g:each>
                  </tbody>

                </table>
	<br><br>
</sec:ifAnyGranted>	
	</div>
	
 	
	<script type="text/javascript">
	$(".onlyNumber").blur(function(){
		 
		 $(this).parseNumber({format:"#,###.###", locale:"us"});
   		 $(this).formatNumber({format:"#,###.###", locale:"us"});		
	  
	  });
	  $(".onlyNumber2").blur(function(){
		 
		 $(this).parseNumber({format:"#######", locale:"us"});
   		 $(this).formatNumber({format:"#######", locale:"us"});		
	  
	  });
	$("input[name*=OutLook_1]").focusout(function() {
		var groupString = $(this).attr('tname');		
		var count = Number($(this).attr('tid'));		
		var un=$("#"+groupString+"OutLook_"+count).val();		
		if(un!="")
		{
		
		$.getJSON('${createLink(controller:'opError',action:'getDisplayName')}?username='+un,function(fullNameOutlook){
			
			if(fullNameOutlook==","){
				$("#"+groupString+"OutLook_"+count).val("");				
				alert("Chua ton tai user '"+un+"' .Anh/chi can vao menu 'Quan ly nguoi dung' o menu bao cao loi de khai bao thong tin ve user nay.")
			}
			$("#"+groupString+"HoVaTen_"+count).val(fullNameOutlook[0]);
			$("#"+groupString+"ChucDanh_"+ count).val(fullNameOutlook[1]);
			$("#"+groupString+"BdsUser_"+ count).val(fullNameOutlook[2]);
			$("#"+groupString+"IdNhanSu_"+ count).val(fullNameOutlook[3]);
			
			$("#"+groupString+"NHCD_"+ count).val(fullNameOutlook[4]);
			$("#"+groupString+"TenDonVi_"+ count).val(fullNameOutlook[5]);
			$("#"+groupString+"PGD_"+ count).val(fullNameOutlook[6]);				
			
			$("#"+groupString+"NHCD_Id_"+ count).val(fullNameOutlook[7]);
			$("#"+groupString+"TenDonVi_Id_"+ count).val(fullNameOutlook[8]);
			$("#"+groupString+"PGD_Id_"+ count).val(fullNameOutlook[9]);
			
			});
		}
		else
			{
				$("#"+groupString+"HoVaTen_"+count).val("");
				$("#"+groupString+"ChucDanh_"+ count).val("");
				$("#"+groupString+"ChucDanh_"+ count).val("");
				$("#"+groupString+"IdNhanSu_"+ count).val("");
				$("#"+groupString+"NHCD_"+ count).val("");
				$("#"+groupString+"TenDonVi_"+ count).val("");
				$("#"+groupString+"PGD_"+ count).val("");
				$("#"+groupString+"NHCD_Id_"+ count).val("");
				$("#"+groupString+"TenDonVi_Id_"+ count).val("");
				$("#"+groupString+"PGD_Id_"+ count).val("");
			
			}

	});
	
	   $("#riskActionForm").validationEngine();
       $("button[name=saveRiskAction]").click(function(){
       	   $("#save").val("true");	
    	   $("#riskActionForm").submit();

        });
        
        $("button[name=newRiskAction]").click(function(){
       	   $("#clone").val("true");	
    	   $("#riskActionForm").submit();

        });
        
        $("button[name=deleteRiskAction]").click(function(){
        	jquery_confirm("Xóa hành động","Anh/chị đồng ý xóa hành động này?",
                    function(){
      	 			$("#delete").val("true");	
       	   			$("#riskActionForm").submit();
              });
        	return false;
       	   
        });
        
        $("#deleteFile").click( function(){
		
			$("#fileUploadx").css("display", "none");   
			$("#hfDeleteFile").val("deleteFile");  
			
		});
		
		 $(".delete_comment").click(function(){
	              var deleteId = $(this).attr('tid');
	              jquery_confirm("Xóa ý kiến","Anh/chị đồng ý xóa ý kiến này?",
	                            function(){
	                                  document.location = "${createLink(controller:'riskAction',action:'deleteComment',params:[deleteComment:'1'])}&deleteId="+deleteId;

	                      });

	                return false;

	            });
        
	$("input[name=addRunDate]").click(function(){
        var groupString = $(this).attr('tid');
        count = $("."+groupString+"errorManagement").length;        
        $("#"+groupString+"dateCount").val(count+1);
        $('#'+groupString+'runDate_1').clone(true).insertAfter('#'+groupString+'runDate_'+count).attr('id',groupString+'runDate_'+(count+1));        
        //BdsUser_1        
        $('#'+groupString+'runDate_'+(count+1)).find("label.nguoiso").html('UserOutlook '+(count+1)+'');        
        $('#'+groupString+'runDate_'+(count+1)).find("label.BdsUser").html('User hệ thống '+(count+1)+'');
        $('#'+groupString+'runDate_'+(count+1)).find("label.hovaten").html('Họ và tên '+(count+1)+'');
        $('#'+groupString+'runDate_'+(count+1)).find("label.chucdanh").html('Chức danh '+(count+1)+'');
        $('#'+groupString+'runDate_'+(count+1)).find("label.IdNhanSu").html('ID nhân sự '+(count+1)+'');
        $('#'+groupString+'runDate_'+(count+1)).find("label.NHCD").html(' NH Chuyên doanh/Khối '+(count+1)+'');
        $('#'+groupString+'runDate_'+(count+1)).find("label.TenDonVi").html('CN/Trung tâm/Phòng  '+(count+1)+'');
        $('#'+groupString+'runDate_'+(count+1)).find("label.PGD").html('PGD/Phòng ban/Tổ Nhóm '+(count+1)+'');
        
        
        $('#'+groupString+'runDate_'+(count+1)).find("label.nguoiso").attr('for',groupString+'OutLook_'+(count+1));        
        $('#'+groupString+'runDate_'+(count+1)).find("label.BdsUser").attr('for',groupString+'BdsUser_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("label.hovaten").attr('for',groupString+'hovaten_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("label.chucdanh").attr('for',groupString+'chucdanh_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("label.IdNhanSu").attr('for',groupString+'IdNhanSu_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("label.NHCD").attr('for',groupString+'NHCD_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("label.TenDonVi").attr('for',groupString+'TenDonVi_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("label.PGD").attr('for',groupString+'PGD_'+(count+1));
                
               
        $('#'+groupString+'runDate_'+(count+1)).find("input").val("");       
        $('#'+groupString+'runDate_'+(count+1)).find("a").attr('href','#body');
        $('#'+groupString+'runDate_'+(count+1)).find("a").attr('tid',count+1);
        $('#'+groupString+'runDate_'+(count+1)).find("a").addClass('deleteUncreatedDate');
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorManagement").attr('id',groupString+'OutLook_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorManagement").attr('name',groupString+'OutLook_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorManagement").attr('tid',count+1); 
        
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorHoVaTen").attr('id',groupString+'HoVaTen_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorHoVaTen").attr('name',groupString+'HoVaTen_'+(count+1));
        
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorChucDanh").attr('id',groupString+'ChucDanh_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorChucDanh").attr('name',groupString+'ChucDanh_'+(count+1));

        $('#'+groupString+'runDate_'+(count+1)).find("input.errorBDSUser").attr('id',groupString+'BdsUser_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorBDSUser").attr('name',groupString+'BdsUser_'+(count+1));

        $('#'+groupString+'runDate_'+(count+1)).find("input.errorNhanSu").attr('id',groupString+'IdNhanSu_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorNhanSu").attr('name',groupString+'IdNhanSu_'+(count+1));
        
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorNHCD").attr('id',groupString+'NHCD_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorNHCD").attr('name',groupString+'NHCD_'+(count+1));
        
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorTenDonVi").attr('id',groupString+'TenDonVi_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorTenDonVi").attr('name',groupString+'TenDonVi_'+(count+1));
        
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorPGD").attr('id',groupString+'PGD_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorPGD").attr('name',groupString+'PGD_'+(count+1));
        
        
		$('#'+groupString+'runDate_'+(count+1)).find("input.errorNHCDId").attr('id',groupString+'NHCD_Id_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorNHCDId").attr('name',groupString+'NHCD_Id_'+(count+1));
        	
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorTenDonViId").attr('id',groupString+'TenDonVi_Id_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorTenDonViId").attr('name',groupString+'TenDonVi_Id_'+(count+1));

        $('#'+groupString+'runDate_'+(count+1)).find("input.errorPGDId").attr('id',groupString+'PGD_Id_'+(count+1));
        $('#'+groupString+'runDate_'+(count+1)).find("input.errorPGDId").attr('name',groupString+'PGD_Id_'+(count+1));
        
        //formatExecutionDate();

      });


	  $(".deleteDate").click(function(){        
		  	var groupString = $(this).attr('tname');
	        var dateCount = $("."+groupString+"errorManagement").length;	        
	        var dateId = Number($(this).attr('tid'))+1;
	        if (dateCount > 1){
	          $('#'+groupString+'runDate_'+ (dateId -1)).remove();
	          var temp;
	          for(var i=dateId;i<=dateCount;i++){
	            if(i == 1)
	              temp = i;
	            else
	              temp = i - 1;

	            $('#'+groupString+'runDate_'+i).find("label.nguoiso").html('Người số '+temp+':');
	            $('#'+groupString+'runDate_'+i).find("label.mucdoloi").html('Mức độ lỗi '+temp+':');  
	            $('#'+groupString+'runDate_'+i).find("label.BdsUser").html('User hệ thống '+temp+':');
	            $('#'+groupString+'runDate_'+i).find("label.hovaten").html('Họ và tên '+temp+':');
   	            $('#'+groupString+'runDate_'+i).find("label.chucdanh").html('Chức danh '+temp+':');  
   	            $('#'+groupString+'runDate_'+i).find("label.IdNhanSu").html('ID nhân sự '+temp+':');
   	            $('#'+groupString+'runDate_'+i).find("label.NHCD").html('NHCD/Khối hỗ trợ '+temp+':');
   	            $('#'+groupString+'runDate_'+i).find("label.TenDonVi").html('Tên đơn vị '+temp+':');
   	            $('#'+groupString+'runDate_'+i).find("label.PGD").html('PGD/Phòng ban/Tổ Nhóm '+temp+':');
	                
	            
	            $('#'+groupString+'runDate_'+i).find("label").attr('for','executionDate_'+temp);
	            
	            $('#'+groupString+'runDate_'+i).find("a").attr('tid',temp);
	            
	            $('#'+groupString+'runDate_'+i).find("input.errorManagement").attr('id',groupString+'OutLook_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorManagement").attr('name',groupString+'OutLook_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorManagement").attr('for',groupString+'OutLook_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorManagement").attr('tid',temp);

	            $('#'+groupString+'runDate_'+i).find("input.errorMucDoLoi").attr('id',groupString+'Mucdoloi_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorMucDoLoi").attr('name',groupString+'Mucdoloi_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorMucDoLoi").attr('for',groupString+'Mucdoloi_'+temp);

	            $('#'+groupString+'runDate_'+i).find("input.errorHoVaTen").attr('id',groupString+'HoVaTen_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorHoVaTen").attr('name',groupString+'HoVaTen_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorHoVaTen").attr('for',groupString+'HoVaTen_'+temp);


	            $('#'+groupString+'runDate_'+i).find("input.errorChucDanh").attr('id',groupString+'ChucDanh_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorChucDanh").attr('name',groupString+'ChucDanh_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorChucDanh").attr('for',groupString+'ChucDanh_'+temp);

	            $('#'+groupString+'runDate_'+i).find("input.errorBDSUser").attr('id',groupString+'BdsUser_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorBDSUser").attr('name',groupString+'BdsUser_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorBDSUser").attr('for',groupString+'BdsUser_'+temp);
	            
	            $('#'+groupString+'runDate_'+i).find("input.errorNHCD").attr('id',groupString+'NHCD_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorNHCD").attr('name',groupString+'NHCD_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorNHCD").attr('for',groupString+'NHCD_'+temp);
	            
	            
	            $('#'+groupString+'runDate_'+i).find("input.errorTenDonVi").attr('id',groupString+'TenDonVi_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorTenDonVi").attr('name',groupString+'TenDonVi_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorTenDonVi").attr('for',groupString+'TenDonVi_'+temp);


   
	            $('#'+groupString+'runDate_'+i).find("input.errorPGD").attr('id',groupString+'PGD_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorPGD").attr('name',groupString+'PGD_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorPGD").attr('for',groupString+'PGD_'+temp);
	            	            
	            
	             $('#'+groupString+'runDate_'+i).find("input.errorNHCD").attr('id',groupString+'NHCD_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorNHCD").attr('name',groupString+'NHCD_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorNHCD").attr('for',groupString+'NHCD_'+temp);
	            
	            
	            $('#'+groupString+'runDate_'+i).find("input.errorTenDonVi").attr('id',groupString+'TenDonVi_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorTenDonVi").attr('name',groupString+'TenDonVi_'+temp);
	            $('#'+groupString+'runDate_'+i).find("input.errorTenDonVi").attr('for',groupString+'TenDonVi_'+temp);
	            
	          
	            	            
	            $('#'+groupString+'runDate_'+i).attr('id',groupString+'runDate_'+temp);

	            
	           //formatExecutionDate();



	          }
	          $("#"+groupString+"dateCount").val($("."+groupString+"errorManagement").length);
	          
	        }

	      });
      

	
	 
	      	
	        set_active_tab('riskAction');
	        $("#riskAction-add-management").closest('li').addClass('active');
	        set_side_bar(true);
	 
	       TableToolsInit.sTitle = "Bao cao lỗi";
	        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
	
</script>

  </body>
  
  
  
</html>


