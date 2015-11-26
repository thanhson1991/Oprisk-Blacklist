<div id="m-melanin-left-sidebar">
      <ul class="m-melanin-vertical-navigation">
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="quiz-management" href="${createLink(controller:'quizAdmin',action:'index')}" class="m-melanin-vertical-navigation-link">Tạo mẫu kiểm tra</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="quiz-reportList" href="${createLink(controller:'opRisk',action:'quizReportList')}" class="m-melanin-vertical-navigation-link">Danh sách kiểm tra</a>
              </li>
               <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="quiz-report" href="${createLink(controller:'opRisk',action:'quizReport')}" class="m-melanin-vertical-navigation-link">Tổng hợp kết quả</a>
              </li>  
      </ul>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		set_active_tab('management');
	});
</script>