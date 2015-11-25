<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<div id="m-melanin-tab-header-inner">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-open-dialog',label:'Open dialog',class:'info'],
						[name:'m-open-input-dialog',label:'Open input dialog',class:'info'],
						[name:'m-test-button-3',label:'Toggle sidebar',class:'primary m-melanin-toggle-side-bar']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:'#',title:'home',label:'Home'],
						[href:'#',title:'Melanin',label:'Melanin'],
						[href:'#',title:'Documentation page',label:'Documentation']]
					]}"/>
			</div>
			<div class="clear"></div>
		</div>
		<div id="m-melanin-left-sidebar">
			<ul class="m-melanin-vertical-navigation">
				<li><span class=" ss_sprite ss_email">&nbsp;</span><a>Test Inbox</a><div class="right"><span class=" ss_sprite ss_arrow_refresh">&nbsp;</span></div></li>
				<li class="active"><span class=" ss_sprite ss_email_go">&nbsp;</span><a>Documentation</a> </li>
				<li><span class=" ss_sprite ss_bin">&nbsp;</span><a>Trash</a> <div class="right"><span class=" ss_sprite ss_tab_delete">&nbsp;</span></div></li>
			</ul>
		</div>
		<div id="m-melanin-main-content">
			
			<div class="m-melanin-widget m-melanin-small-panel" id="m-melanin-small-panel-1">
				<h3>1. Website anatomy</h3>
				<div>
					<ul>
						<li><a href="#" id="m-melanin-spotlight-logo">Logo</a></li>
						<li><a href="#" id="m-melanin-spotlight-control-panel">Control panel</a></li>
						<li><a href="#" id="m-melanin-spotlight-navigation">Navigation tab</a></li>
						<li><a href="#" id="m-melanin-spotlight-tab-header">Tab header</a></li>
						<li><a href="#" id="m-melanin-spotlight-breadcrum">Breadcrum</a></li>
						<li><a href="#" id="m-melanin-spotlight-left-sidebar">Left sidebar</a></li>
						<li><a href="#" id="m-melanin-spotlight-widget-panel">Widget panel</a></li>

					</ul>
				</div>
			</div>
			<div class="m-melanin-widget m-melanin-medium-panel" id="m-melanin-medium-panel-1">
				<h3>2. How to </h3>
				<div>
					<ul>
						<li><a href="#2.1">Install PLATTO plugin</a></li>
						<li><a href="#2.2">Configure database connection - MySQL</a></li>
						<li><a href="#2.3">Configure security - MSB Active Directory</a></li>
						<li><a href="#2.4">Configure global settings</a></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-1">
				<h3><a name="2.1">2.1 Install PLATTO (Melanin Wrapper) plugin</a></h3>
				<div>
					<ol>
						<li>Create a new Grails project - called FacebookClone.
							<p class="blockquote">c:\my_projects> grails create-app FacebookClone</p>	
						</li>
						<li>Check out Melanin plugin from MSB SVN
							<p class="blockquote">c:\my_projects\FacebookClone> svn checkout  http://svn.msb.com.vn/svn/itproject/2011/03.%20Risk%20Workflow/03.14.Platto/Trunk/002-MELANIN/trunk/40-Source-MELANIN/grails-melanin-<strong>0.2</strong>.zip</p>		
							<p class="notice">Notice: File version may differ from time to time</p>
						</li>
						<li>Install Melanin plugin
							<p class="blockquote">c:\my_projects\FacebookClone> grails install-plugin grails-melanin-0.2.zip</p>	
							<p class="error">Notice: <strong><u>Answer 'Y' to all the question when prompted.</u></strong><p>
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-1">
				<h3><a name="2.2">2.2 Configure database connection - MySQL</a></h3>
				<div>
					<ol>
						<li>The default configuration when you install Melanin plugin is used for MySQL, you don't need to change any driver configuration.</li>
						<li>Open grails-app/conf/DataSource.groovy. Change the database connection URL according to your database name.
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-1">
				<h3><a name="2.3">2.3 Configure security - MSB Active Directory</a></h3>
				<div>
					<ol>
						<li>When install Melanin plugin, your application is configured to use <a href="http://grails-plugins.github.com/grails-spring-security-core/docs/manual/">Spring Security plugin</a> for Grails and authenticates against Maritime Bank Active Directory. For more information on how to use Spring Security, please visit <a href="http://grails-plugins.github.com/grails-spring-security-core/docs/manual/">http://grails-plugins.github.com/grails-spring-security-core/docs/manual</a>
						<li>Open grails-app/conf/Config.groovy. Make sure this file contains the following Active Directory configuration:
							<p class="blockquote">
<br>								grails.plugins.springsecurity.ldap.context.managerDn = 'cn=ADInquiry,OU=MSB Service,DC=msb,DC=com,DC=vn'
								
<br>								grails.plugins.springsecurity.ldap.context.managerPassword = 'ADInquiry'
<br>								grails.plugins.springsecurity.ldap.context.server = 'ldap://10.1.16.1:3268'
<br>								grails.plugins.springsecurity.ldap.authorities.groupSearchBase = 'cn=ADInquiry,OU=MSB Service,DC=msb,DC=com,DC=vn'
<br>								grails.plugins.springsecurity.ldap.search.base = 'DC=msb,DC=com,DC=vn'

<br>								grails.plugins.springsecurity.ldap.search.filter="sAMAccountName={0}" // for Active Directory you need this
<br>								grails.plugins.springsecurity.ldap.search.searchSubtree = true
<br>								grails.plugins.springsecurity.ldap.auth.hideUserNotFoundExceptions = false
<br>								grails.plugins.springsecurity.ldap.authorities.retrieveDatabaseRoles = true

<br>								grails.plugins.springsecurity.userLookup.userDomainClassName = 'msb.platto.fingerprint.User'
<br>								grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'msb.platto.fingerprint.UserRole'
<br>								grails.plugins.springsecurity.authority.className = 'msb.platto.fingerprint.Role'
<br>								grails.plugins.springsecurity.requestMap.className = 'msb.platto.fingerprint.RequestMap'
<br>								grails.plugins.springsecurity.securityConfigType = 'Requestmap'
							</p>
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-1">
				<h3><a name="2.4">2.4 Configure global settings before you code...</a></h3>
				<div>
					<ol>
						<li>Configure your grails-app/conf/Config.groovy to your needs
							<div class="blockquote">
							// Application settings<br/>
							msb.platto.melanin.searchController='lucket' // the search handler for the global search<br/>
							msb.platto.melanin.searchAction='search' // the search handler for the global search<br/>
							msb.platto.melanin.appDescription='Quản lý phiếu dự thưởng' // this will appear next to your logo<br/>
							msb.platto.melanin.appTimeOut=1000<br/>
							msb.platto.melanin.helpDocument='http://intranet/' // link to intranet documentation for your app<br/>
							msb.platto.fingerprint.defaultUrlMappings = [ROLE_ADMIN:'/fingerprint'] // default page for each roles<br/>
							//--@melanin--
							</div>
						</li>
						<li>Open grails-app/conf/DataSource.groovy. Change the database connection URL according to your database name.
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>

		</div>

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				set_active_tab('documentation');
				$("button[name=m-open-dialog]").click(function(){
					jquery_confirm('Example Dialog',"There are 3 types of dialog: alert, confirm and input dialogs, just like javascript.<br/>"+
							"Look up the API in the API tab."
							);
				});
				$("button[name=m-open-input-dialog]").click(function(){
					jquery_input('Example Input Dialog',"Please enter anything:<br/>",function(data){
						jquery_alert('Example input','You have entered: ' + data);	
					});
				});
				
				$("#m-melanin-spotlight-logo").click(function(){
					$("#m-melanin-logo").spotlight(); return false;
				});
				$("#m-melanin-spotlight-navigation").click(function(){
					$("#m-melanin-navigation").spotlight(); return false;
				});
				$("#m-melanin-spotlight-control-panel").click(function(){
					$("#m-melanin-control-panel").spotlight(); return false;
				});
				$("#m-melanin-spotlight-tab-header").click(function(){
					$("#m-melanin-tab-header").spotlight(); return false;
				});				
				$("#m-melanin-spotlight-breadcrum").click(function(){
					$("#m-melanin-breadcrum").spotlight(); return false;
				});				
				
				$("#m-melanin-spotlight-left-sidebar").click(function(){
					$("#m-melanin-left-sidebar").spotlight(); return false;
				});				
				$("#m-melanin-spotlight-widget-panel").click(function(){
					$(".m-melanin-widget").spotlight(); return false;
				});				
				$("input[name=m-test-button-3]").click(function(){
					toggle_sidebar(sidebarSwitch);
					sidebarSwitch=!sidebarSwitch;
				});
				$(".m-melanin-small-panel").panel({
					width:200,
					cookies:true
				});
				$(".m-melanin-medium-panel").panel({
					width:400,
					cookie:true
				});
				$(".m-melanin-large-panel").panel({
					width:620,
					cookie:true
				});
			});
			    
		</script>

	</body>
</html>