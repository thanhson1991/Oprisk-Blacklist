<div id="m-melanin-left-sidebar">
      <ul class="m-melanin-vertical-navigation">
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="baro-incidentReport" href="${createLink(controller:'opRisk',action:'incidentReport')}" class="m-melanin-vertical-navigation-link">Danh sách tổn thất</a>
              </li>             
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="report-incidents" href="${createLink(controller:'report',action:'incidentReport')}" class="m-melanin-vertical-navigation-link">Thống kê sự kiện tổn thất theo đơn vị</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="report-events" href="${createLink(controller:'report',action:'eventReport')}" class="m-melanin-vertical-navigation-link">Thống kê sự kiện tổn thất theo sự kiện</a>
              </li>
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="report-causes" href="${createLink(controller:'report',action:'causeReport')}" class="m-melanin-vertical-navigation-link">Thống kê sự kiện tổn thất theo nguyên nhân</a>
              </li>
      </ul>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		set_active_tab('report');
	});
</script>