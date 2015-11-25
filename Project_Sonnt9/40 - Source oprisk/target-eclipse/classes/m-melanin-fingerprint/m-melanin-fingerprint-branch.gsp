<%@page import="msb.platto.fingerprint.*" %>

<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Control Panel | Branch Management</title>
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-branch',label:'Create new branch',class:'primary']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:createLink(uri:'/'),title:'home',label:'Home'],
						[href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint'],
						[href:createLink(controller:'fingerprint',action:'role'),title:'Role Management',label:'Branch Management']]
					]}"/>
			<div class="clear"></div>
		</div>
		<g:render template="/m-melanin-fingerprint/m-melanin-fingerprint-sidebar"/>
		<div id="m-melanin-main-content">
			<fieldset class="left e-xxxl"><legend>Cơ cấu tổ chức</legend>
				<g:if test="${flash.message}">
					<div id="flash-message" class="alert-message info">${flash.message}</div>
				</g:if>
				<div class="m-melanin-hierarchy-tree" id="m-melanin-fingerprint-branch-tree" >
				
				</div>
			</fieldset>
			<div id="branch-info-section" class="left e-7l hide">
				<form id="branch-form">
					<fieldset><legend>Thông tin chi nhánh</legend>
	                <ul class="form form-clear">
					
	                  <li><label for="parent.id">Chi nhánh cha</label>
	                    <g:select name="parent.id" from="${Branch.list()}"
							noSelection="${['':'----- Chọn chi nhánh -----']}"
	                      optionKey="id" optionValue="name"/>
	                  </li>
	                  <li><label>ID</label>
	                  	<input id="id" name="id" class="e-s" readonly="true"/>
	                  </li>
	                  <li><label for="name">Tên chi nhánh</label>
	                    <input id="name" class="e-xxxl validate[required]" name="name"/>
	                  </li>
						<li><label for="code">Mã chi nhánh</label>
		                    <input id="code" class="e-xl" name="code"/>
		                </li>
	                  <li><label>&nbsp;</label>
	                    <button name="save-button" class="btn primary">Lưu</button>
                    
	                  </li>
                  
	                </ul>
	                </fieldset>
	              </form>
	              <fieldset id="user-list-section"><legend>Danh sách user trong chi nhánh</legend>
	              	<span id="users-list"></span>
	              	<p></p>
	              	<div>
	              		Thêm vào danh sách: 
	              		<g:textField name="add-user-field" class="e-xxl" placeholder="Tìm theo tên, username."/>
	              		<button name="add-user-button" class="btn " disabled="disabled">Thêm</button>
	              	</div>
	              </fieldset>
				</div>
			<div class="clear"></div>

		</div>

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				add_tab('#','Security','security');				
				set_active_tab('security');
				$("#m-melanin-vertical-navigation-branch").closest('li').addClass('active');
				$("#branch-form").validationEngine();
				
				$("#m-melanin-fingerprint-branch-tree a").live("dblclick",function(){
					$.get('${createLink(action:'getBranch',controller:'fingerprint')}/'+
						$(this).closest('li').attr('id'),function(data){
						$("#branch-form #id").val(data.branch.id);
						$("#branch-form #code").val(data.branch.code);
						$("#branch-form #name").val(data.branch.name);
						$("#branch-form #parent\\.id").val(data.branch.parent.id).attr('selected',true);
						$("#users-list").html('');
						$(data.users).each(function(i,e){
							$("#users-list").append('<span>'+e.fullname+' ('+e.username+', <a href="#" class="remove-user" rel="'+e.id+'">remove</a>), </span>');
						});
						$("button[name=add-user-button]").attr('disabled',true).removeClass('primary');
						$("#branch-info-section").show('slide');
					});
            	});
				
				$("button[name=save-button]").click(function(e){
					e.preventDefault();
					if($("#branch-form").validationEngine('validate')){
						$.post("${createLink(controller:'fingerprint',action:'saveBranch')}", $("#branch-form").serialize(),function(data){
							document.location="${createLink(controller:'fingerprint',action:'branch')}";
						});
					}
				});
				
				$("#m-melanin-fingerprint-branch-tree").jstree({
					"json_data" : {
						"ajax" : { "url" : "${createLink(controller:'fingerprint',action:'getBranchTree')}" }
	                },
	                "themes" : {
						"theme":"branch"
					},
	                "plugins" : [ "themes", "json_data", "ui", "cookies" ]
        		});

				
				$(".remove-user").live('click',function(e){
                	e.preventDefault();
                	var myA = $(this);
                	$.get('${createLink(controller:'fingerprint',action:'removeUserFromBranch')}', 
                        	{id:$(myA).attr('rel'),branch:$('#branch-form #id').val()},function(data){
                    	$(myA).closest('span').hide('highlight');
                    });
                });
				
				$("button[name=add-user-button]").click(function(e){
					e.preventDefault();
					$.get('${createLink(controller:'fingerprint',action:'addUserToBranch')}', 
                        	{id:$(this).attr('title'),branch:$('#branch-form #id').val()},function(data){
                            	if(data!=-1){
			                        $("#users-list").append('<span>'+data.fullname+' ('+data.username+
			                        ', <a href="#" class="remove-user" rel="'+data.id+'">remove</a>), </span>');
			                        $(this).attr('disabled',true);
			                        $("#add-user-field" ).val('');
                            	}
                        		
                    });
				});
				$("#add-user-field").change(function(){
					$("button[name=add-user-button]").attr('disabled',true).removeClass('primary');
				});
				$("#add-user-field").autocomplete({
					source: "${createLink(controller:'fingerprint',action:'searchUser')}",
					minLength: 2,
					select: function( event, ui ) {
						$("#add-user-field" ).val( ui.item.fullname );
						$("button[name=add-user-button]").attr('disabled',false).addClass('primary');
						$("button[name=add-user-button]").attr('title',ui.item.id);
						return false;
					},
					focus: function( event, ui ) {
						$( "#add-user-field" ).val( ui.item.fullname );
						return false;
					}
				}).data( "autocomplete" )._renderItem = function( ul, item ) {
					return $( "<li></li>" )
					.data( "item.autocomplete", item )
					.append( "<a>" + item.fullname + " (" + item.username + ")</a>" )
					.appendTo( ul );
					
				};
				$("button[name=m-melanin-action-bar-button-create-branch]").click(function(e){
					e.preventDefault();
					$("#branch-form input").val('');
					$("#user-list-section").hide();
					$("#branch-info-section").show('slide');
				});
				setTimeout('$("#flash-message").hide("blind")',2000);
			});
		</script>

	</body>
</html>