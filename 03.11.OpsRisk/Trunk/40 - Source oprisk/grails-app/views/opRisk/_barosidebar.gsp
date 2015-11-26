<div id="m-melanin-left-sidebar">
      <ul class="m-melanin-vertical-navigation">
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="survey-management" href="${createLink(controller:'surveyAdmin',action:'index')}" class="m-melanin-vertical-navigation-link">Tạo mẫu báo cáo</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="baro-reportList" href="${createLink(controller:'opRisk',action:'reportList')}" class="m-melanin-vertical-navigation-link">Danh sách báo cáo</a>
              </li>
               <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="baro-report" href="${createLink(controller:'opRisk',action:'report')}" class="m-melanin-vertical-navigation-link">Tổng hợp đánh giá</a>
              </li>  
      </ul>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		set_active_tab('baro-management');
	});
</script>