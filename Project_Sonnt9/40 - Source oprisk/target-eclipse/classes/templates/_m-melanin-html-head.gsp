<!-- BLUE PRINT CSS -->
<link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.min.css')}" type="text/css" media="screen, projection" />  
<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />  

<link rel="stylesheet" href="${resource(dir:'css',file:'m-melanin.css')}" />
<link rel="stylesheet" href="${resource(dir:'../../css',file:'msb-main.css')}" />

<g:javascript library="jquery" plugin="jquery"/>
<jqui:resources themeCss="${resource(dir:'jquery-ui/themes/'+theme,file:'jquery-ui-1.8.15.custom.css')}" />

<!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
    
<g:javascript src="jquery.tools.min.js"/>
<g:javascript src="jquery.ui.pane.js"/>
<g:javascript src="jquery.dataTables.min.js"/>
<g:javascript src="jquery.msb.validationEngine.js"/>
<g:javascript src="jquery.validationEngine-vi.js"/>
<g:javascript src="jquery.cookie.js"/>
<g:javascript src="jquery.easing.js"/>
<g:javascript src="jquery.spotlight.js"/>
<g:javascript src="jquery.jstree.js"/>
<g:javascript src="jquery.dualListBox-1.3.min.js"/>
<g:javascript src="jquery.maskedinput.min.js"/>
<g:javascript src="date.js"/>
<g:javascript src="hashtable.js"/>
<g:javascript src="jquery.numberformatter.min.js"/>
<g:javascript src="jquery.hotkeys.js"/>
<g:javascript src="jquery.ad.gallery.js"/>
<g:javascript src="swfobject.js"/>
<g:javascript src="jquery.uploadify.v2.1.4.min.js"/>
<g:javascript src="jquery.notes.js"/>
<g:javascript src="jquery.scroll.min.js"/>
<g:javascript src="jquery.mousewheel.js"/>
<g:javascript src="prettify/jquery.prettify.js"/>

<g:javascript src="m-melanin.js"/>
<g:if test="${grailsApplication.config.msb.platto.melanin.javascriptFiles}">
<g:each in="${grailsApplication.config.msb.platto.melanin.javascriptFiles}" var="js">
<g:javascript src="../../../js/${js}"/>
</g:each>
</g:if>
