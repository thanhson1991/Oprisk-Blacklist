<%@page import ="org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
   
    <style type="text/css" media="screen">
      fieldset{
        margin-left:0px !important;
        margin-right:0px !important;
      }
    </style>    
    <title>Kiểm tra kiến thức rủi ro hoạt động</title>
  </head>

  <body>
   <br>
    <br>
   <div id="m-melanin-main-content" style="width:960px;margin:auto">
   
  <div>
      <fieldset class="info">
        <legend>Hướng dẫn</legend>
        
        <p><i>- Anh/chị hãy tick vào đáp án đúng nhất với mỗi câu hỏi.</i></p>       
        <p>Thời gian làm bài là <b>${surveyType.minutes } phút</b></p>        
      </fieldset>
    </div>
 
  <center><button class="btn primary" id="proceed" name="proceed" onclick="window.location='${createLink(action:"createQuiz")}'"/>Bắt đầu làm bài kiểm tra</button></center>



<script type="text/javascript">
  
    $(document).ready(function(){ 
      set_active_tab('quiz');      
   

    
});
   
</script>

</div>
</body>

</html>
