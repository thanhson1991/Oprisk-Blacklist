<%@page import="msb.platto.fingerprint.*" %>

<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Control Panel | Role Management</title>
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-role',label:'Create new role',class:'primary']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:createLink(uri:'/'),title:'home',label:'Home'],
						[href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint'],
						[href:createLink(controller:'fingerprint',action:'role'),title:'Role Management',label:'Role Management']]
					]}"/>
			<div class="clear"></div>
		</div>
		<g:render template="/m-melanin-fingerprint/m-melanin-fingerprint-sidebar"/>
		
		<div id="m-melanin-main-content">
		
			<div id="m-melanin-form-section">
					<g:form name="m-melanin-form-role-details" controller="fingerprint" action="addRole">
						<fieldset >
							<legend id="m-melanin-form-role-details-legend">Create new role</legend>
							<ol class="form form-clear">
								<li><label for="authority">Authority:</label>
									<g:textField name="authority" type="text" class="validate[required]"
										placeholder="Enter role authority."/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter Role Authority">&nbsp;</span>
								</li>
								<li>
									<label for="users" style="vertical-align:top;margin-top:7px">User assigned:</label>
									<%-- Dual Listbox impplementation --%>
									<div class="m-melanin-dual-listbox-wrapper">
										<div>
											Filter: <input type="text" id="box2Filter" class="m-melanin-dual-listbox-filter" />
											<button type="button" id="box2Clear" class="btn small m-melanin-dual-listbox-button"><span class=" ss_sprite ss_cross">&nbsp;</span></button><br />
											<select id="box2View" name="users" multiple="multiple" style="width:200px;" size="10">
											</select><br/>
											<span id="box2Counter" class="countLabel"></span>
											<select id="box2Storage"></select>
										</div>
										<div class="m-melanin-dual-listbox-center-command">
											<button id="to2" type="button" class="btn small"><span class=" ss_sprite ss_resultset_previous">&nbsp;</span></button>
											<button id="allTo2" type="button" class="btn small"><span class=" ss_sprite ss_resultset_first">&nbsp;</span></button>
											<button id="allTo1" type="button" class="btn small"><span class=" ss_sprite ss_resultset_last">&nbsp;</span></button>
											<button id="to1" type="button" class="btn small"><span class=" ss_sprite ss_resultset_next">&nbsp;</span></button>
										</div>
										<div>
											Filter: <input type="text" id="box1Filter" class="m-melanin-dual-listbox-filter" />
											<button type="button" id="box1Clear" class="btn small m-melanin-dual-listbox-button"><span class=" ss_sprite ss_cross">&nbsp;</span></button><br />
											<select id="box1View" name="sourceUsers" multiple="multiple" style="width:200px;" size="10">
												<g:each in="${User.list()}" var="user">
													<option value="${user.id}">${user.fullname} (${user.username})</option>
												</g:each>
											</select><br/>
											<span id="box1Counter" class="countLabel"></span>
											<select id="box1Storage"></select>
										</div>
									</div>
								</li>
								<li class="buttons">
									<g:hiddenField name="roleId" id="m-melanin-form-id"/>
									<button  class="btn primary" >Validate &amp; Save</button>
									<button  class="btn danger" name="m-melanin-form-button-delete">Delete role</button>
									<button class="btn"  name="m-melanin-form-button-cancel">Cancel</button>
								</li>
							</ol>
							
						</fieldset>
					</g:form>
				</div>
			
			<div id="m-melanin-fingerprint-role-table-section">
				<table id="m-melanin-fingerprint-role-table">
					<thead>
						<tr>
							<th>Role ID</th>
							<th>Authority</th>
							<th>User assigned</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${Role.list()}" var="role">
							<tr>
								<td>${role.id}</td>
								<td><a href="#" rel="${role.id}" class="m-melanin-authority-link">${role.authority}</a></td>
								<td>${UserRole.findAllByRole(role).size()}</td>
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
				$("#m-melanin-vertical-navigation-role").closest('li').addClass('active');
				$.configureBoxes();
				$("#m-melanin-form-role-details").validationEngine();
				
				$("button[name=m-melanin-action-bar-button-create-role]").click(function(){
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=roleId]").val("");
					$("#allTo1").click();
					$("input[name=authority]").val("");
					$("#m-melanin-form-role-details-legend").html("Create new role");
					$("button[name=m-melanin-form-button-delete]").hide();
				});

				$("button[name=m-melanin-form-button-cancel]").click(function(e){
					$("#m-melanin-form-section").hide('blind');
					e.preventDefault();
				});

				$(".m-melanin-authority-link").click(function(e){
					e.preventDefault();
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("#allTo1").click();
					$("input[name=authority]").val($(this).html());
					var arr_users = [];
					$.get('${createLink(controller:'fingerprint',action:'findUsersByRole')}/' + $(this).attr('rel'),
				               function(data){
				                     for (var i = 0; i < data.length; i++){
				                    	 $("select[name=sourceUsers] option[value=" + data[i].id + "]").attr("selected","true");
					                 }
					                 $("#to2").click();
				               });
					$("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));
					$("#m-melanin-form-id").val($(this).attr("rel"));
					$("#m-melanin-form-role-details-legend").html("Edit role: " + $(this).attr("rel"));
					$("button[name=m-melanin-form-button-delete]").show();
					$("button[name=m-melanin-form-button-delete]").attr("rel",$(this).attr("rel"));
				});

				$("button[name=m-melanin-form-button-delete]").click(function(e){
					e.preventDefault();
					var rid = $(this).attr("rel");
					jquery_confirm("Delete role","Are you sure you want to delete this role?",
							function(){
								jquery_open_load_spinner();
								document.location = "${createLink(controller:'fingerprint',action:'deleteRole')}/" + rid;
							});
				});
				$("#m-melanin-fingerprint-role-table").dataTable();
			});
		</script>

	</body>
</html>