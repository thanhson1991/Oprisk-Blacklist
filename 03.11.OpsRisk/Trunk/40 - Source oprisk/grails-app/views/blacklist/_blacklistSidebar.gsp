<div id="m-melanin-left-sidebar">
	<ul class="m-melanin-vertical-navigation">
		<li><span class="ss_sprite ss_application_view_list">&nbsp;</span>
			<a id="blacklist-canhan-management"
			href="${createLink(controller:'blackList',action:'detailCaNhan')}"
			class="m-melanin-vertical-navigation-link">Blacklist cá nhân</a></li>
			
		<li><span class="ss_sprite ss_application_view_list">&nbsp;</span>
			<a id="blacklist-phapnhan-management"
			href="${createLink(controller:'blackList',action:'detailPhapNhan')}"
			class="m-melanin-vertical-navigation-link">Blacklist pháp nhân</a></li>
			
		<li><span class="ss_sprite ss_application_view_list">&nbsp;</span>
			<a id="blacklist-taisan-management"
			href="${createLink(controller:'blackList',action:'detailQLTaiSan')}"
			class="m-melanin-vertical-navigation-link">Blacklist tài sản đảm bảo</a></li>
			
		<li>
	 <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">	
		<span class="ss_sprite ss_application_view_list">&nbsp;</span>
			<a id="blacklist-quanly-management"
			href="${createLink(controller:'blackList',action:'detailQLDanhSach')}"
			class="m-melanin-vertical-navigation-link">Quản lý danh sách</a>
		</sec:ifAnyGranted>
		</li>
		
			<li><span class="ss_sprite ss_application_view_list">&nbsp;</span>
			<a id="blacklist-canhanrg-management"
			href="${createLink(controller:'blackList',action:'searchCnBL')}"
			class="m-melanin-vertical-navigation-link">Blacklist cá nhân rút gọn</a></li>	
			
				<li><span class="ss_sprite ss_application_view_list">&nbsp;</span>
			<a id="blacklist-phapnhanrg-management"
			href="${createLink(controller:'blackList',action:'detailPhapNhan')}"
			class="m-melanin-vertical-navigation-link">Blacklist pháp nhân rút gọn</a></li>
			
			<li><span class="ss_sprite ss_application_view_list">&nbsp;</span>
			<a id="blacklist-taisanrg-management"
			href="${createLink(controller:'blackList',action:'detailQLTaiSan')}"
			class="m-melanin-vertical-navigation-link">Blacklist tài sản đảm bảo rút gọn</a></li>
			
		
	</ul>
</div>
