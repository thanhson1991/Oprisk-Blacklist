<%@page import="msb.platto.fingerprint.*" %>

<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Control Panel | Requestmap Management</title>
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-requestmap',label:'Create new requestmap',class:'primary']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:createLink(uri:'/'),title:'home',label:'Home'],
						[href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint'],
						[href:createLink(controller:'fingerprint',action:'requestmap'),title:'Requestmap Management',label:'Requestmap Management']]
					]}"/>
			<div class="clear"></div>
		</div>
		<g:render template="/m-melanin-fingerprint/m-melanin-fingerprint-sidebar"/>
		<div id="m-melanin-main-content">
		
			<div id="m-melanin-form-section">
					<g:form name="m-melanin-form-requestmap-details" controller="fingerprint" action="addRequestmap">
						<fieldset >
							<legend id="m-melanin-form-requestmap-details-legend">Create new requestmap</legend>
							<ol class="form form-clear">
								<li><label for="url">URL:</label>
									<g:textField name="url" type="text" class="validate[required]"
										placeholder="Enter requestmap URL."/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter URL expression to be configured">&nbsp;</span>
								</li>
								<li>
									<label for="configAttribute" style="vertical-align:top">Config Attribute:</label>
									<g:textField name="configAttribute" type="text" class="validate[required]"
										placeholder="Enter config attribute."/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter security configuration for above URL">&nbsp;</span>
								</li>
								<li class="buttons">
									<g:hiddenField name="requestmapId"/>
									<button type="submit" class="btn primary">Validate &amp; Save</button>
									<button type="button" class="btn danger" name="m-melanin-form-button-delete" >Delete Request Map</button>
									<button type="button" class="" name="m-melanin-form-button-cancel">Cancel</button>
								</li>
							</ol>
							
						</fieldset>
					</g:form>
				</div>
			
			<div id="m-melanin-fingerprint-requestmap-table-section">
				<table id="m-melanin-fingerprint-requestmap-table">
					<thead>
						<tr>
							<th>Requestmap ID</th>
							<th>URL</th>
							<th>Config Attribute</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${RequestMap.list()}" var="requestmap">
							<tr>
								<td>${requestmap.id}</td>
								<td><a href="#" rel="${requestmap.id}" class="m-melanin-url-link">${requestmap.url}</a></td>
								<td id="m-melanin-fingerprint-td-configAttribute-${requestmap.id}">${requestmap.configAttribute}</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
			
<%--			<p/>--%>
<%--			<div class="clear"></div>--%>

		</div>

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				add_tab('#','Security','security');				
				set_active_tab('security');
				$("#m-melanin-form-requestmap-details").validationEngine();
				$("#m-melanin-vertical-navigation-requestmap").closest('li').addClass('active');
				

				$("button[name=m-melanin-action-bar-button-create-requestmap]").click(function(){
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=requestmapId]").val("");
					$("input[name=url]").val("");
					$("input[name=configAttribute]").val("");
					$("#m-melanin-form-requestmap-details-legend").html("Create new requestmap");
					$("button[name=m-melanin-form-button-delete]").hide();
				});

				$("button[name=m-melanin-form-button-cancel]").click(function(e){
					e.preventDefault();
					$("#m-melanin-form-section").hide('blind');
				});

				$(".m-melanin-url-link").click(function(e){
					e.preventDefault();
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=url]").val($(this).html());
					$("input[name=configAttribute]").val($("#m-melanin-fingerprint-td-configAttribute-"+$(this).attr("rel")).html());
					$("input[name=requestmapId]").val($(this).attr("rel"));
					$("#m-melanin-form-requestmap-details-legend").html("Edit requestmap: " + $(this).attr("rel"));
					$("button[name=m-melanin-form-button-delete]").show();
					$("button[name=m-melanin-form-button-delete]").attr("rel",$(this).attr("rel"));
				});

				$("button[name=m-melanin-form-button-delete]").click(function(e){
					e.preventDefault();
					var rmid = $(this).attr("rel");
					jquery_confirm("Delete requestmap","Are you sure you want to delete this requestmap?",
							function(){
								jquery_open_load_spinner();
								document.location = "${createLink(controller:'fingerprint',action:'deleteRequestmap')}/" + rmid;
							});
				});
				$("#m-melanin-fingerprint-requestmap-table").dataTable();
			});
		</script>

	</body>
</html>