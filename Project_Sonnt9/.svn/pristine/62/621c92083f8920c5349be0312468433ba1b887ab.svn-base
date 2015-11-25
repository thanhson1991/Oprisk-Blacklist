<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

 	<title>Phần mềm quản lý rủi ro hoạt động</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">
			<div class="clear"></div>
	</div>

    <div id="m-melanin-main-content">
          
      <div style="width:670px;margin:auto">
      <fieldset>
        <legend>Thông tin đơn vị</legend>
        <ol class="form form-clear form-wide">
          <li>
             - Tên đăng nhập: ${user.username}  <!--    <a href="${createLink(controller:'opRisk',action:'updateInformation')}">(Thay đổi thông tin đơn vị)</a> -->
          </li>
          <li>
             - Họ và tên: ${user.fullname}
          </li>
          <li>
            - Chức danh: ${masterUser.title}
          </li>
          <li>
            - Tên đơn vị: ${user.prop2}
          </li>
          <li> 
          	Đề nghị anh/chị vui lòng liên hệ phòng QLRRHĐ qua email: <a href="mailto:qlrr_oprisk@msb.com.vn">qlrr_oprisk@msb.com.vn</a> trong trường hợp có nhu cầu cập nhật thông tin cá nhân.	 
          </li>
        </ol>       
        
      </fieldset>

      <fieldset>
        <legend>Các chức năng chính</legend>
        <ol class="form form-clear form-wide">
          <li>
              - Anh/chị vui lòng lựa chọn các chức năng trên menu để:
          </li>
          <li>
          	  <sec:ifAnyGranted roles="ROLE_CVQLRR">
          	  	+ <a href="${createLink(controller:'opError',action:'getErrorDisplay', params:[maxresults:'30'])}">Báo cáo Lỗi</a>: báo cáo và giám sát tình trạng khắc phục lỗi tại các đơn vị.
          	  </sec:ifAnyGranted>
          	  <sec:ifAnyGranted roles="ROLE_GDTT">
          	  	+ <a href="${createLink(controller:'opError',action:'getErrorDisplayLevel1', params:[maxresults:'30'])}">Báo cáo Lỗi</a>: báo cáo và giám sát tình trạng khắc phục lỗi tại các đơn vị.
          	  </sec:ifAnyGranted>
          	  <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL2">
          	  	+ <a href="${createLink(controller:'opError',action:'getErrorDisplayLevel2', params:[maxresults:'30'])}">Báo cáo Lỗi</a>: báo cáo và giám sát tình trạng khắc phục lỗi tại các đơn vị.
          	  </sec:ifAnyGranted>
          	  <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL3">
          	  	+ <a href="${createLink(controller:'opError',action:'getErrorDisplayLevel3', params:[maxresults:'30'])}">Báo cáo Lỗi</a>: báo cáo và giám sát tình trạng khắc phục lỗi tại các đơn vị.
          	  </sec:ifAnyGranted>
          	  <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL4">
          	  	+ <a href="${createLink(controller:'opError',action:'getErrorDisplayLevel4', params:[maxresults:'30'])}">Báo cáo Lỗi</a>: báo cáo và giám sát tình trạng khắc phục lỗi tại các đơn vị.
          	  </sec:ifAnyGranted>
          </li>
          <li>
            + <a href="${createLink(controller:'opRisk',action:'create')}">Báo cáo rủi ro</a>: định kỳ báo cáo tình hình quản lý Rủi ro Hoạt động tại đơn vị cho Phòng QLRR Hoạt động.
          </li>
          <li>
            + <a href="${createLink(controller:'opRisk',action:'listIncident')}">Báo cáo tổn thất</a>: báo cáo cho Phòng QLRR Hoạt động những sự kiện tổn thất đã xảy ra tại đơn vị.
          </li>
          <li>
            + <a href="${createLink(controller:'selfEvaluation',action:'index')}">Tự đánh giá rủi ro</a>: nhận thức Rủi ro Hoạt động và phòng tránh Rủi ro Hoạt động trong công việc hàng ngày.
          </li>
          <li>
            + <a href="${createLink(controller:'selfEvaluation',action:'actionManagement')}">Biện pháp giảm rủi ro</a>: cập nhật tiến độ các hành động giảm rủi ro sau khi đã thực hiện đánh giá rủi ro.
          </li>
          <li>
            + <a href="${createLink(controller:'opRisk',action:'viewResponse')}">Khuyến nghị hành động</a>: đưa ra các khuyến nghị giúp phòng tránh và tăng cường quản lý rủi ro tại đơn vị.
          </li>
          <li>
            + <a href="${createLink(controller:'opRisk',action:'viewNews')}">Bản tin rủi ro</a>: đưa tin tức, sự kiện và các bài học nhằm đẩy mạnh truyền thông và nâng cao nhận thức.
          </li>
          <li>
            + <a href="${createLink(controller:'opRisk',action:'getReport')}">Báo cáo đã tạo</a>: xem lại các báo cáo mà anh/chị đã gửi cho Phòng QLRR Hoạt động trong các kỳ trước.
          </li>

<%--          <li>--%>
<%--            + <a href="${createLink(controller:'opError',action:'getErrorDisplay')}">Báo cáo lỗi</a>: xem lại các báo cáo mà anh/chị đã gửi cho Phòng QLRR Hoạt động trong các kỳ trước.--%>
<%--          </li>--%>


        </ol>
      </fieldset>
      </div>

    </div>
    <script type="text/javascript">
           $(document).ready(function(){

           });
    </script>
  </body>
</html>
