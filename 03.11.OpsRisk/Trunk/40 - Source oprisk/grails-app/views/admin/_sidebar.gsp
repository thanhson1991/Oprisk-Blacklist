<div id="m-melanin-left-sidebar">
      <ul class="m-melanin-vertical-navigation">
      <sec:ifAnyGranted roles="ROLE_CVQLRR">
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="user-management" href="${createLink(controller:'admin',action:'userManagement')}" class="m-melanin-vertical-navigation-link">Quản lý người dùng</a>
              </li>
              
              <%--<li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="user-error-management" href="${createLink(controller:'masterUserCreate',action:'displayAll')}" class="m-melanin-vertical-navigation-link">Quản lý người gây lỗi</a>
              </li>
              
              
              --%><li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-department" href="${createLink(controller:'admin',action:'viewDepartment')}" class="m-melanin-vertical-navigation-link">Quản lý nghiệp vụ</a>
              </li>
              
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-unit-department" href="${createLink(controller:'unitDepartment',action:'horizontal')}" class="m-melanin-vertical-navigation-link">Quản lý đơn vị</a>
              </li>
              
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-risk" href="${createLink(controller:'admin',action:'viewRisk')}" class="m-melanin-vertical-navigation-link">Quản lý danh sách rủi ro</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-cause" href="${createLink(controller:'admin',action:'viewCause')}" class="m-melanin-vertical-navigation-link">Quản lý loại nguyên nhân</a>
              </li>
              
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-error" href="${createLink(controller:'errorAdmin',action:'horizontal')}" class="m-melanin-vertical-navigation-link">Quản lý loại lỗi</a>
              </li>
              
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-event" href="${createLink(controller:'admin',action:'viewEvent')}" class="m-melanin-vertical-navigation-link">Quản lý loại sự kiện</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-impact" href="${createLink(controller:'admin',action:'viewImpact')}" class="m-melanin-vertical-navigation-link">Hướng dẫn đánh giá ảnh hưởng của rủi ro</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-possibility" href="${createLink(controller:'admin',action:'viewPossibility')}" class="m-melanin-vertical-navigation-link">Hướng dẫn đánh giá khả năng xảy ra rủi ro</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-controlEffect" href="${createLink(controller:'admin',action:'viewControlEffect')}" class="m-melanin-vertical-navigation-link">Hướng dẫn đánh giá hiệu quả kiểm soát rủi ro</a>
              </li>
              
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-errorCheck" href="${createLink(controller:'admin',action:'errorCheckList')}" class="m-melanin-vertical-navigation-link">Hình thức phát hiện</a>
              </li>
			  <li>
			  	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			  	<a id="admin-errorCategory" href="${createLink(controller:'admin',action:'errorCategory')}" class="m-melanin-vertical-navigation-link">Quản lý nghiệp vụ</a>
			  </li>
			  <li>
			  	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			  	<a id="admin-businessField" href="${createLink(controller:'admin',action:'listBusinessField')}" class="m-melanin-vertical-navigation-link">Quản lý lĩnh vực kinh doanh</a>
			  </li>
			  <li>
			  	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			  	<a id="admin-actionType" href="${createLink(controller:'admin',action:'listActionType')}" class="m-melanin-vertical-navigation-link">Quản lý loại hành động</a>
			  </li>
			  <li>
			  	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			  	<a id="admin-errorStatus" href="${createLink(controller:'admin',action:'errorStatus') }" class="m-melanin-vertical-navigation-link">Quản lý trạng thái</a>
			  </li>
			  
			    <li>
			  	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			  	<a id="admin-blacklistCategory" href="${createLink(controller:'admin',action:'viewBlacklist')}" class="m-melanin-vertical-navigation-link">Quản lý rủi ro Blacklist</a>
			  </li>
			  
			    <li>
			  	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			  	<a id="admin-blacklistTSBD" href="${createLink(controller:'admin',action:'viewRiskTsdbBlacklist')}" class="m-melanin-vertical-navigation-link">Quản lý rủi ro tài sản đảm bảo Blacklist</a>
			  </li>
			  
			   <li>
			  	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			  	<a id="admin-blacklistObject" href="${createLink(controller:'admin',action:'viewObjectBlacklist')}" class="m-melanin-vertical-navigation-link">Phân loại đối tượng Blacklist</a>
			  </li>
			  
			  <li>
			  	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			  	<a id="admin-blacklistTaiSanDB" href="${createLink(controller:'admin',action:'viewTaiSandbBlacklist')}" class="m-melanin-vertical-navigation-link">Loại tài sản đảm bảo Blacklist</a>
			  </li>
                            
          </sec:ifAnyGranted>
           <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL3">
            			<span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="admin-error" href="${createLink(controller:'admin',action:'viewError')}" class="m-melanin-vertical-navigation-link">Quản lý loại lỗi</a>
           </sec:ifAnyGranted>
           
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      
						 <a id="error-sendEmail" href="${createLink(controller:'admin',action:'viewSelectSendEmail')}" class="m-melanin-vertical-navigation-link">Có/Không gửi Email </a>
<%--						 <g:checkBox name="checkmail"   checked="${checkmail }"/> --%>
						 
              </li>         
      </ul>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		set_active_tab('management');
	});
</script>