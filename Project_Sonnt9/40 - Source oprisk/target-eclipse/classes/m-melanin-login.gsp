<%@page import="msb.platto.commons.*" %>
<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		
		<div id="m-melanin-main-content">
			<div id="m-melanin-welcome-box" class="pull-left e-6l" style="margin-top: 15px; margin-left: 20px;">
				<g:if test="${Conf.findByLabel('welcome-text')?.value}">
					${Conf.findByLabel('welcome-text').value}
				
				</g:if>
				<g:else>
					<fieldset>
						<legend>Giới thiệu</legend>
					
						<h5>Chức năng phần mềm:</h5>
						<ul>
							<li>Tìm kiếm thông tin khách hàng đã tham gia chương trình dự thưởng</li>
							<li>Tạo mã dự thưởng mới cho khách hàng tham gia gửi CASA/FD</li>
							<li>In phiếu dự thưởng cho khách hàng</li>
							<li>Xuất báo cáo</li>
							
						</ul>
						<h5>Đối tượng sử dụng phần mềm này:</h5>
						<ul>
							<li>GDV tại các TTKHCN</li>
							<li>Cán bộ tại Hội sở được phân quyền</li>
							
						</ul>
						<h5>Đầu mối liên hệ:</h5>
						<ul>
							<li><strong>Nghiệp vụ:</strong> Nguyễn Sơn Tùng – Trung tâm PTSP: 043. 771 8989 – Máy lẻ: 6363:<br/>
								- Đề nghị cấp user vào chương trình dự thưởng<br/>
								- Hướng dẫn sử dụng</li>
							<li><strong>IT</strong>: ITService_Desk: 043.771 8989 – Máy lẻ: 8686</li>
							
						</ul>
						<h5>Các tài liệu liên quan:</h5>
						<ul>
							<li><a href="#">Thể lệ chương trình dự thưởng</a></li>
							<li><a href="#">Hướng dẫn sử dụng chương trình cấp mã dự thưởng</a></li>
							<li><a href="#">Đề  nghị cấp user đăng nhập chương trình dự thưởng</a></li>
						</ul>
						<br/>
						<div class="alert-message info">Để thay đổi các thông tin này, xin vui lòng chỉnh sửa trong table <strong>conf</strong>, 
							record có <strong>label='welcome-text'</strong></div>
					</fieldset>
				</g:else>
			</div>
			
			<g:render template="/templates/m-melanin-login"/>

		</div>
		
		<script type="text/javascript">
			$(function(){
				set_active_tab('login');
			});
	    </script>
	
	</body>
</html>