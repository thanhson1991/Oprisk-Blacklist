<%@page import="msb.platto.fingerprint.*" %>

<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Control Panel | User Management</title>
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-user',class:'primary',label:'Create new user']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:createLink(uri:'/'),title:'home',label:'Home'],
						[href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint'],
						[href:createLink(controller:'fingerprint',action:'user'),title:'User Management',label:'User Management']]
					]}"/>
			<div class="clear"></div>
		</div>
		<g:render template="/m-melanin-fingerprint/m-melanin-fingerprint-sidebar"/>
		<div id="m-melanin-main-content">
			<g:if test="${flash.error}">
				<div class="error">${flash.error}</div>
			</g:if>
			<div id="m-melanin-form-section">
					<g:form name="m-melanin-form-user-details" controller="fingerprint" action="addUser">
						<fieldset >
							<legend id="m-melanin-form-user-details-legend">Create new user</legend>
							<ol class="form form-clear">
								<li><label for="username">Username:</label>
									<g:textField name="username" type="text" class="validate[required]"
										placeholder="Enter outlook username."/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter user's outlook username">&nbsp;</span>
								</li>
								<li><label for="password">Password:</label>
									<g:passwordField name="password"
										placeholder="Enter password."/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter alternative password. When authenticating with LDAP failed, this alternative password will be used">&nbsp;</span>
								</li>
								<li><label for="fullname">Full name:</label>
									<g:textField name="fullname" type="text" 
										class="validate[required] e-xxl"
										placeholder="Enter full name."/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter user's full name">&nbsp;</span>
								</li>
								<li><label for="prop1"><g:message code="msb.platto.fingerprint.user.prop1" default="Property 1"/>:</label>
									<input type="text" id="prop1" name="prop1" type="text" class="${message(code:"msb.platto.fingerprint.user.prop1CssClass",default:"e-xxl")}"
										placeholder="Enter property 1"/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter user's ${message(code:"msb.platto.fingerprint.user.prop1",default:"Property 1")}">&nbsp;</span>
								</li>
								<li><label for="prop2"><g:message code="msb.platto.fingerprint.user.prop2" default="Property 2"/>:</label>
									<input type="text" id="prop2" name="prop2" type="text" class="${message(code:"msb.platto.fingerprint.user.prop2CssClass",default:"e-xxl")}"
										placeholder="Enter property 2"/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter user's ${message(code:"msb.platto.fingerprint.user.prop2",default:"Property 2")}">&nbsp;</span>
								</li>
								<li><label for="prop3"><g:message code="msb.platto.fingerprint.user.prop3" default="Property 3"/>:</label>
									<input type="text" id="prop3" name="prop3" type="text" class="${message(code:"msb.platto.fingerprint.user.prop3CssClass",default:"e-xxl")}"
										placeholder="Enter property 3"/>
									<span class="ss_sprite ss_help m-melanin-tooltip" title="Enter user's ${message(code:"msb.platto.fingerprint.user.prop3",default:"Property 3")}">&nbsp;</span>
								</li>
								<li>
									<label style="vertical-align:top">Roles:</label>
									<div style="display:inline-block">
										<g:each in="${Role.list()}" var="role">
											<g:checkBox name="roles" value="${role.authority}" checked="false"/><label>${role.authority}</label><br/>
										</g:each>
									</div>
								</li>
								<li><label for="enabled">Account enabled:</label>
									<g:checkBox name="enabled"/>
								</li>
								<li class="buttons">
									<g:hiddenField name="userId"/>
									<button class=" btn primary" name="m-melanin-form-button-save">Validate &amp; Save</button>
									<button class=" btn danger" name="m-melanin-form-button-delete" >Delete user</button>
									<button class="btn"  name="m-melanin-form-button-cancel">Cancel</button>
								</li>
							</ol>
							
						</fieldset>
					</g:form>
				</div>
			
			<div id="m-melanin-fingerprint-user-table-section">
				<table id="m-melanin-fingerprint-user-table">
					<thead>
						<tr>
							<th>UserID</th>
							<th>Username</th>
							<th>Full name</th>
							<th>Role</th>
							<th>Account enabled</th>
							<th><g:message code="msb.platto.fingerprint.user.prop1" default="Property 1"/></th>
							<th><g:message code="msb.platto.fingerprint.user.prop2" default="Property 2"/></th>
							<th><g:message code="msb.platto.fingerprint.user.prop3" default="Property 3"/></th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${User.list()}" var="user">
							<tr>
								<td>${user.id}</td>
								<td><a href="#" rel="${user.id}" class="m-melanin-username-link">${user.username}</a></td>
								<td id="m-melanin-fingerprint-td-fullname-${user.id}">${user.fullname}</td>
								<td id="m-melanin-fingerprint-td-roles-${user.id}">${UserRole.findAllByUser(user).role.authority}</td>
								<td id="m-melanin-fingerprint-td-enabled-${user.id}"><g:if test="${user.enabled}"><span class="ss_sprite ss_tick"> &nbsp; </span></g:if></td>
								<td id="m-melanin-fingerprint-td-prop1-${user.id}">${user.prop1}</td>
								<td id="m-melanin-fingerprint-td-prop2-${user.id}">${user.prop2}</td>
								<td id="m-melanin-fingerprint-td-prop3-${user.id}">${user.prop3}</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		</div>

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				add_tab('#','Security','security');				
				set_active_tab('security');
				$("#m-melanin-form-user-details").validationEngine();
				$("#m-melanin-vertical-navigation-user").closest('li').addClass('active');
				
				$("button[name=m-melanin-action-bar-button-create-user]").click(function(){
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=userId]").val("");
					$("input[name=enabled]").removeAttr("checked");
					$("input[name=roles]").removeAttr("checked");
					$("input[name=username]").val("");
					$("input[name=password]").val("");
					$("input[name=fullname]").val("");
					$("input[name=prop1]").val("");
					$("input[name=prop2]").val("");
					$("input[name=prop3]").val("");
					$("#m-melanin-form-user-details-legend").html("Create new user");
					$("button[name=m-melanin-form-button-delete]").hide();
				});

				$("button[name=m-melanin-form-button-cancel]").click(function(e){
					$("#m-melanin-form-section").hide('blind');
					e.preventDefault();
				});

				$(".m-melanin-username-link").click(function(e){
					e.preventDefault();
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=enabled]").removeAttr("checked");
					$("input[name=roles]").removeAttr("checked");
					$("input[name=username]").val($(this).html());
					$("input[name=password]").val("");
					$("input[name=fullname]").val($("#m-melanin-fingerprint-td-fullname-"+$(this).attr("rel")).html());
					$("input[name=prop1]").val($("#m-melanin-fingerprint-td-prop1-"+$(this).attr("rel")).html());
					$("input[name=prop2]").val($("#m-melanin-fingerprint-td-prop2-"+$(this).attr("rel")).html());
					$("input[name=prop3]").val($("#m-melanin-fingerprint-td-prop3-"+$(this).attr("rel")).html());
					var str_roles = $("#m-melanin-fingerprint-td-roles-"+$(this).attr("rel")).html();
					str_roles = str_roles.substring(1,str_roles.length-1);
					var arr_roles = str_roles.split(", ");
					for (var i = 0; i < arr_roles.length; i++){
						$("#m-melanin-form-section input[value=" + arr_roles[i] + "]").attr("checked","checked");
					}
					if ($("#m-melanin-fingerprint-td-enabled-"+$(this).attr("rel")).html()){
						$("input[name=enabled]").attr("checked","checked");
					}
					$("input[name=userId]").val($(this).attr("rel"));
					$("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));
					$("#m-melanin-form-user-details-legend").html("Edit user: " + $(this).attr("rel"));
					$("button[name=m-melanin-form-button-delete]").show();
					$("button[name=m-melanin-form-button-delete]").attr("rel",$(this).attr("rel"));
				});

				$("button[name=m-melanin-form-button-delete]").click(function(e){
					e.preventDefault();
					var uid = $(this).attr("rel");
					jquery_confirm("Delete user","Are you sure you want to delete this user?",
							function(){
								jquery_open_load_spinner();
								document.location = "${createLink(controller:'fingerprint',action:'deleteUser')}/" + uid;
							});
					
				});
				$("#m-melanin-fingerprint-user-table").dataTable();
			});
		</script>

	</body>
</html>