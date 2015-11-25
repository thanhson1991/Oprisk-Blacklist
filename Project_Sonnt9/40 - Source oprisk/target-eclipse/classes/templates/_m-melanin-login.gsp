<div id="m-melanin-login-widget" style="margin-top: 15px; margin-left: 20px;" class="left"> 
		<g:form controller='j_spring_security_check' method='POST' name='m-melanin-login-form' class='e-6l'  autocomplete='off' >
		<fieldset >
			<legend>Đăng nhập</legend>
			<ol class="form form-clear">
				<g:if test="${params.login_error}">
					<li><div class="alert-message error">Thông tin bạn nhập không chính xác.</div></li>
				</g:if>
				<g:if env="development">
					<li><div class="alert-message info">Login info: admin/admin, developer/developer</div></li>
				</g:if>
				<li>
					<label for="username">Mã truy cập:</label>
					<g:textField placeholder="Vd: longtd, khanhnq..." type="text" name="j_username"
					class="validate[required]"
					/>
					<span class="ss_sprite ss_help m-melanin-tooltip" title="Xin nhập mã truy cập được cấp vào phần mềm này.">&nbsp;</span>
					</li>
				<li><label for="password">Mật khẩu:</label>
					<g:passwordField placeholder="Nhập password" name="j_password" type="password"
					class="validate[required]"
					/>
					<span class="ss_sprite ss_help m-melanin-tooltip" title="Xin nhập password được cấp. Nếu bạn gặp vấn đề xin liên hệ IT Service Desk.">&nbsp;</span>
					</li>
				<li class="buttons">
					&nbsp;<input name="m-melanin-login-button" type="submit" class="btn primary " value="Đăng nhập"/>
					<a href="#" id="m-melain-login-help">Trợ giúp?</a>
				</li>
			</ol>
		</fieldset>
	</g:form>
</div>
<script type="text/javascript" charset="utf-8">
	$(function(){
		$("form[id=m-melanin-login-form]").validationEngine();
		$("#m-melain-login-help").click(function(){
			jquery_alert('Trợ giúp', 'Xin vui lòng đọc hướng dẫn sử dụng tại ' +
			"<a href='${grailsApplication.config.msb.platto.melanin.helpDocument}'>địa chỉ này</a> hoặc liên hệ IT Service Desk để được hổ trợ thêm.");
			return false;	
		})
	});
</script>