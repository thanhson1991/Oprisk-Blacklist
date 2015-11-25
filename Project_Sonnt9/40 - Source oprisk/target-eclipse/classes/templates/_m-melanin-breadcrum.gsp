<ul id="m-melanin-breadcrum" class="breadcrumb">
	<li><a href="${items[0].href?:'#'}" title='${items[0].title?:''}'>Home</a>
		<span class="divider">/</span>
	</li>
	<g:each in="${items}" var="item" status="i">
		<g:if test="${i>0 && i<items.size() - 1}">
			<li><a href="${item.href}" title="${item.title?:''}">${item.label}</a>
			<span class="divider">/</span>
			</li>
		</g:if>
		<g:if test="${i==items.size() - 1}">
			<li>${item.label}</li>
		</g:if>
    </g:each>
</ul>