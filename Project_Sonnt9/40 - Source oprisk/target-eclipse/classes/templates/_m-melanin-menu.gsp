<div id="m-melanin-navigation" class="${navigationType?:'navigationMSB'}">
	<ul>
		<g:each in="${tabs}" var="tab">
			<sec:ifAnyGranted roles="${tab.roles}">
				<li>
					<a href="${tab.controller?createLink(controller:tab.controller,action:tab.action):tab.url}" title="${tab.title?:''}"
						class="${tab.active?'active':''}" id="m-melanin-menu-${tab.name}">
						<span>${tab.label}</span>
					</a>
				</li>
			</sec:ifAnyGranted>
	    </g:each>
	</ul>
</div>