<%@page import="msb.platto.commons.*" %>

<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Control Panel</title>
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-conf',label:'Create new Conf']]
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
				<li class="active">
					<span class=" ss_sprite ss_wrench">&nbsp;</span>
					<a id="m-melanin-vertical-navigation-user" href="${createLink(controller:'controlPanel',action:'conf')}" class="m-melanin-vertical-navigation-link">Conf</a>
				</li>
			</ul>
		</div>
		<div id="m-melanin-main-content">
			<div id="m-melanin-form-section">
					<g:form name="m-melanin-form-conf-details" controller="controlPanel" action="addConf">
						<fieldset >
							<legend id="m-melanin-form-conf-details-legend">Create new Conf</legend>
							<ol class="form form-clear">
								<li><label for="url">DataType</label>
									<select name="dataType">
										<option></option>
										<g:each in="${ConfType}" var="type">
											<option value="${type}">${type}</option>
										</g:each>
									</select>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter URL expression to be configured">&nbsp;</span>
								</li>
								<li>
									<label for="label" style="vertical-align:top">Label:</label>
									<g:textField name="label" type="text" class="validate[required]"
										placeholder="Enter label"/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter security configuration for above URL">&nbsp;</span>
								</li>
								<li>
									<label for="value" style="vertical-align:top">Value:</label>
									<g:textField name="value" type="text" class="validate[required]"
										placeholder="Enter value"/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter security configuration for above URL">&nbsp;</span>
								</li>
								<li>
									<label for="ord" style="vertical-align:top">Order:</label>
									<g:textField name="ord" type="text" class="validate[required]"
										placeholder="Enter order"/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter security configuration for above URL">&nbsp;</span>
								</li>
								<li class="buttons">
									<g:hiddenField name="confId"/>
									<input type="submit" class=" primary" value="Validate &amp; Save"/>
									<input type="button" class=" red" name="m-melanin-form-button-delete" value="Delete conf"/>
									<input type="button" class="" value="Cancel" name="m-melanin-form-button-cancel"/>
								</li>
							</ol>
							
						</fieldset>
					</g:form>
				</div>
			
			<div id="m-melanin-fingerprint-conf-table-section">
				<table id="m-melanin-fingerprint-conf-table">
					<thead>
						<tr>
							<th>ConfID</th>
							<th>Data Type</th>
							<th>Label</th>
							<th>Value</th>
							<th>Order</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${Conf.list()}" var="conf">
							<tr>
								<td>${conf.id}</td>
								<td id="m-melanin-control-panel-td-datatype-${conf.id}">${conf.dataType}</td>
								<td><a href="#" rel="${conf.id}" class="m-melanin-url-link">${conf.label}</a></td>
								<td id="m-melanin-control-panel-td-value-${conf.id}">${conf.value}</td>
								<td id="m-melanin-control-panel-td-ord-${conf.id}">${conf.ord}</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>

		</div>

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				set_active_tab('control-panel');
				$("#m-melanin-fingerprint-conf-table").dataTable();
				$("input[name=m-melanin-form-button-delete]").hide();

				$("input[name=m-melanin-action-bar-button-create-conf]").click(function(){
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=confId]").val("");
					$("select[name=dataType]").val("");
					$("input[name=label]").val("");
					$("input[name=value]").val("");
					$("input[name=ord]").val("");
					$("input[name=m-melanin-form-button-delete]").hide();
				});

				$("input[name=m-melanin-form-button-cancel]").click(function(){
					$("input[name=confId]").val("");
					$("#m-melanin-form-section").hide('blind');
					$("input[name=m-melanin-form-button-delete]").hide();
				});

				$(".m-melanin-url-link").click(function(){
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=confId]").val($(this).attr("rel"));
					$("select[name=dataType]").val($("#m-melanin-control-panel-td-datatype-"+$(this).attr("rel")).html());
					$("input[name=label]").val($(this).html());
					$("input[name=value]").val($("#m-melanin-control-panel-td-value-"+$(this).attr("rel")).html());
					$("input[name=ord]").val($("#m-melanin-control-panel-td-ord-"+$(this).attr("rel")).html());
					$("input[name=m-melanin-form-button-delete]").show();
				});

				$("input[name=m-melanin-form-button-delete]").click(function(){
					jquery_confirm("Delete conf","Are you sure you want to delete this conf record?",
							function(){
								jquery_open_load_spinner();
								document.location = "${createLink(controller:'controlPanel',action:'deleteConf')}/" + $("input[name=confId]").val();
							});
				});
			});
		
			var sidebarSwitch = false;
			function toggle_sidebar(flag){
				set_side_bar(flag);
			}
		</script>

	</body>
</html>