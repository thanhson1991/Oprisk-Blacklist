<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Control Panel</title>
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-test-button-1',label:'Action 1'],
						[name:'m-test-button-2',label:'Action 1'],
						[name:'m-test-button-3',label:'Toggle sidebar',class:'yellow']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:'#',title:'home',label:'Home'],
						[href:'#',title:'Melanin',label:'Melanin'],
						[href:'#',title:'Control Panel',label:'Control Panel']]
					]}"/>
			<div class="clear"></div>
		</div>
		<div id="m-melanin-left-sidebar">
			<ul class="m-melanin-vertical-navigation">
				<li>
					<span class=" ss_sprite ss_wrench">&nbsp;</span>
					<a id="m-melanin-vertical-navigation-user" href="${createLink(controller:'controlPanel',action:'conf')}" class="m-melanin-vertical-navigation-link">Conf</a>
				</li>
			</ul>
		</div>
		<div id="m-melanin-main-content">
			<h3>Lorem ipsum dolor sit amet</h3>
			<p>
				Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
				Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
				Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
				Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
			</p>
			<h3>//TODO: brief guide for admin here</h3>
			<p/>
			<div class="clear"></div>

		</div>

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				set_active_tab('control-panel');
			});
		
			var sidebarSwitch = false;
			function toggle_sidebar(flag){
				set_side_bar(flag);
			}		    
		</script>

	</body>
</html>