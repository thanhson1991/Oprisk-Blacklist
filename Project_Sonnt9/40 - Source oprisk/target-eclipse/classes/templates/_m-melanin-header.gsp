<%@page import="msb.platto.commons.*" %>

<div id="m-melanin-header">
	<img id="m-melanin-logo" class="pull-left" src="${logoURL}"
		alt="add a logo.png into web-app/images folder" height="40" width="60"/>
	<div id="m-melanin-app-descriptions">${appDescriptions}</div>
	<div class="pull-right">
		<div id="m-melanin-control-panel">
			<sec:ifLoggedIn>
				Xin chào, <sec:loggedInUserInfo field="username"/> (<span id="m-melanin-time-out"></span>, 
				<a href="#" id="m-melanin-refresh-timeout">refresh session</a>)
				| <a href="#" class="m-melanin-change-password-trigger">Đổi password</a>
				| <a href="#" id="m-melanin-logout">Thoát</a>
				| 
			</sec:ifLoggedIn>
			<a href="${Conf.findByLabel('help-file-url')?Conf.findByLabel('help-file-url').value:'#'}">Hướng dẫn</a>
			<g:if env="development">
			| <g:link controller="melanin" action="documentation">Developer's docs</g:link>
			</g:if>
		</div>
		<sec:ifLoggedIn>
		<g:if test="${grailsApplication.config.msb.platto.melanin.searchController}">
			<div id="m-melanin-global-search">
				<form method="post" action="${searchAction?:createLink(controller:grailsApplication.config.msb.platto.melanin.searchController,
								action:grailsApplication.config.msb.platto.melanin.searchAction)}">
					<input class="pull-right" type='text' name="globalSearch" placeholder="Search..."/>
				</form>
			</div>
		</g:if>
		
		<g:else>
			<g:if env="development"><div id="m-melanin-global-search">
				<a class="right" href="#" onclick="javascript:alert('Long Tran says: to enable this global search box, pass showSearchBox param to the m-melanin-header template in your main.gsp.');return false;">
					Global search is disabled.</a></div>
			</g:if>
		</g:else>
		<div id="m-melanin-change-password-dialog" title="Đổi password" class="hide">
			<g:form name="m-melanin-change-password-form" action="changePassword" controller="melanin" >
			<ol class="form form-clear">
				<li><label for="m-melanin-old-password">Nhập password cũ:</label>
					<g:passwordField id="m-melanin-old-password" name="oldPassword" class="validate[required]"/>
					<span class="ss_sprite ss_help m-melanin-tooltip" title="Nhập password truy cập được cấp vào phần mềm này.">&nbsp;</span>
				</li>
				<li><label for="m-melanin-new-password">Nhập password mới:</label>
					<g:passwordField id="m-melanin-new-password" name="newPassword" class="validate[required]"/>
					<span class="ss_sprite ss_help m-melanin-tooltip" title="Nhập password mới">&nbsp;</span>
				</li>
				<li><label for="m-melanin-retype-password">Nhập lại password:</label>
					<g:passwordField id="m-melanin-retype-password" name="retypePassword" class="validate[required,equals[m-melanin-new-password]]"/>
					<span class="ss_sprite ss_help m-melanin-tooltip" title="Nhập lại mật mã mới.">&nbsp;</span>
				</li>
				<li class="buttons e-xl"><a href="#" class="btn primary" id="m-melanin-change-password-confirm-button">Xác nhận</a>
					<a href="#" class="btn" id="m-melanin-change-password-cancel-button">Đóng</a>
				</li>
			</ol>
			</g:form>
		</div>
		</sec:ifLoggedIn>
	</div>
	
	<sec:ifLoggedIn>
	<script type="text/javascript" charset="utf-8">

		var TIME_OUT = ${grailsApplication.config.msb.platto.melanin.appTimeOut};
		var mMelaninTimeOut = TIME_OUT;
		var timeOutInterval = setInterval('changeTimeOut()',1000);
		function changeTimeOut(){
			if(mMelaninTimeOut == 0){
				//document.location="${createLink(controller:'logout')}";
				jquery_alert('Thông báo','Bạn đã bị log out khỏi phần mềm. Xin vui lòng <strong><u>lưu lại các dữ liệu đang xử lý vào file word bên ngoài</u></strong> và login lại.');
				clearInterval(timeOutInterval);
				return;
			}
			$("#m-melanin-time-out").html(mMelaninTimeOut--);
			if(mMelaninTimeOut == 60){
				jquery_confirm('Thông báo','Bạn sẽ tự động bị log out ra khỏi hệ thống trong vòng 60 giây nữa, bạn có muốn thêm thời gian không?',
				function(){
					refreshTimeOut();
				});
			}
		}
		function refreshTimeOut(){
			$.get("${createLink(controller:'melanin',action:'refresh')}",function(data){
				if(data){
					mMelaninTimeOut = TIME_OUT;
				}
			});
		}
		$(function(){
			$("#m-melanin-change-password-dialog").dialog({modal:true,'autoOpen':false,width: 400, height: 200 });
			$(".m-melanin-change-password-trigger").click(function(){
				$("#m-melanin-change-password-dialog").dialog('open');
				return false;
			});
			$("#m-melanin-change-password-cancel-button").click(function(){
				$("#m-melanin-change-password-dialog").dialog('close');
				return false;
			});
			$("#m-melanin-change-password-confirm-button").click(function(){
				
				if($("#m-melanin-change-password-form").validationEngine('validate')){
					$.post('${createLink(controller:'melanin',action:'changePassword')}',$("#m-melanin-change-password-form").serialize(),
					function(result){
						if(result == 1){
							$("#m-melanin-change-password-dialog").dialog('close');
							jquery_alert('Thông báo','Password đã được đổi thành công.');
						}else{
							jquery_alert('Thông báo','Password cũ không chính xác, xin vui lòng nhập lại.');
						}
					});
				}
				return false;
			});
			$("#m-melanin-change-password-form").validationEngine();
			$("#m-melanin-refresh-timeout").click(function(){ refreshTimeOut();return false;});
			$("#m-melanin-logout").click(function(){
				//jquery_confirm('Xác nhận','Bạn có muốn logout khỏi chương trình này?',function(){
					document.location="${createLink(controller:'melanin',action:'logout')}";
				//});
				//return false;
			});
		});
	</script>
	</sec:ifLoggedIn>
</div>