<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title><g:layoutTitle default="${grailsApplication.config.msb.platto.melanin.appDescription}" /></title>
		<g:render template="/templates/m-melanin-html-head" model="[theme:'ui-lightness']"/>
		<g:layoutHead />
    </head>
    <body>
		<div id="m-melanin-page-wrap" class="m-melanin">
			<div id="m-melanin-inside">
				<g:if test="${'Melanin - the Platto wrapper' == grailsApplication.config.msb.platto.melanin.appDescription}">
					<g:render template="/templates/m-melanin-header"
						model="${[	logoURL:resource(dir:'images',file:'logo.png'),
									appDescriptions:grailsApplication.config.msb.platto.melanin.appDescription]}"/>
				</g:if>
				<g:else>
					<g:render template="/templates/m-melanin-header"
						model="${[	logoURL:resource(dir:'../../images',file:'logo.png'),
								appDescriptions:grailsApplication.config.msb.platto.melanin.appDescription]}"/>
				</g:else>
				<g:render template="/templates/m-melanin-menu" 
					model="${[tabs:msb.platto.melanin.MenuItem.list()]}"/>
				
				<g:layoutBody />
				
				
				<div class="clear"></div>
			
				<div id="m-melanin-footer">
					<div>&copy; Maritime Bank 2011</div>
				</div>
		
			</div>
		
			<div style="clear: both;"></div>
	
		</div>
		
		<div id="load_spinner" title="Processing..." class="center margin-10">
		    <center>
		        Please wait while your request is being processed...<br/>
		        <img alt="spinner" src="${resource(dir:'images',file:'loading.gif')}"/></center>
		</div>
	</body>
</html>