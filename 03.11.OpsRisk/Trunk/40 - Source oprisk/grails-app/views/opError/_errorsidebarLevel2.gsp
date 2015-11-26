<div id="m-melanin-left-sidebar">
      <ul class="m-melanin-vertical-navigation">
              <li>
              		<sec:ifAllGranted roles="ROLE_GDTT_LEVEL3">
              			<span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="error-management" href="${createLink(controller:'opError',action:'getErrorDisplayLevel3')}" class="m-melanin-vertical-navigation-link">Danh sách lỗi đã nhập</a>
              		</sec:ifAllGranted>
              		<sec:ifAllGranted roles="ROLE_GDTT_LEVEL4">
              			<span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="error-management" href="${createLink(controller:'opError',action:'getErrorDisplayLevel4')}" class="m-melanin-vertical-navigation-link">Danh sách lỗi đã nhập</a>
              		</sec:ifAllGranted>              		
              		<sec:ifNotGranted roles="ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4">
                      	<span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      	<a id="error-management" href="${createLink(controller:'opError',action:'getErrorDisplayLevel2')}" class="m-melanin-vertical-navigation-link">Danh sách lỗi đã nhập</a>
                     </sec:ifNotGranted>

              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="error-management-Full" href="${createLink(controller:'opError',action:'getErrorDisplayLevelAllLevel2')}" class="m-melanin-vertical-navigation-link">Danh sách lỗi đầy đủ</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="error-reportUserCreate" href="${createLink(controller:'opError',action:'reportErrorUserCreate1')}" class="m-melanin-vertical-navigation-link">Báo cáo người gây lỗi</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="error-management" href="${createLink(controller:'opError',action:'reportErrorLevel')}" class="m-melanin-vertical-navigation-link">Báo cáo loại lỗi</a>
              </li>
              <sec:ifNotGranted roles="ROLE_GDTT_LEVEL4">
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="error-management-UserManagement" href="${createLink(controller:'masterUserCreate',action:'displayAll')}" class="m-melanin-vertical-navigation-link">Quản lý người dùng</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="error-management-Assign" href="${createLink(controller:'opError',action:'getErrorDisplayLevelAssign')}" class="m-melanin-vertical-navigation-link">Danh sách lỗi bị nhập</a>
              </li>
              </sec:ifNotGranted>              
            
      </ul>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		set_active_tab('getErrorDisplayLevel2');
	});
</script>