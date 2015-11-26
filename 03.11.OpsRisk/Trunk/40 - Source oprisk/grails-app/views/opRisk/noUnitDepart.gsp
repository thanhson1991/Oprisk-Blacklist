<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Báo cáo lỗi</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<div class="clear"></div>
		</div>
                
    <div id="m-melanin-main-content">
            <div class ="message">
                <g:message code="noUnitDepart" />
            </div>
    </div>
    <script type="text/javascript">
           $(document).ready(function(){
             set_active_tab('baro');
           });
    </script>
  </body>
</html>
