<%@ page import="Survey" %>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Quản trị hệ thống</title>
    </head>
    <body>
        <g:render template="/admin/adminMenu"/>
        <g:form name="questionTable" action="index" method="post">
            <fieldset class="form">
                <legend>Thông số hệ thống<legend>
                    <span class="button"><button name="save" class="save" value="save">Lưu</button></span>
                <br/>
                <table >
                    <thead>
                        <tr>
                            <th>Loại</th>
                            <th>Tên/Nhãn</th>
                            <th>Gía trị</th>
                            <th>Thứ tự</th>
                            <th> </th>
                        <tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="5"><button name="add" class="add" value="add">Thêm mới</button><br/><br/></td>
                            
                        </tr>
                        <g:each var="c" in="${confs}">
                            <tr>
                                <td>${c.type}</td>
                                <td><g:textField name="label" class="e-xl validate[required]" value="${c?.label}" /></td>
                                <td><g:textField name="value" class="e-xl validate[required]" value="${c?.value}" /></td>
                                <td><g:textField name="ord" class="e-s validate[required]" value="${c?.ord}" /></td>
                                <td align="center" >
                                      <a href="index?delete=${c.id}" name="delete" id="${c?.id}">Xóa</a>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </fieldset>
       </g:form>

       <div id="addNewConf" title="Tạo tham số">
            <div class="form">
                <g:form name="addNewConfForm" method="post" >
                  <ol>
                      <li><label for="typeAdd">Loại</label>
                          <input type="text" name="typeAdd" id="typeAdd" class="e-xl validate[required]" value=""/></li>
                      <li><label for="labelAdd">Tên/Nhãn</label>
                          <input type="text" name="labelAdd" id="labelAdd" class="e-xl" value=""/></li>
                      <li><label for="valueAdd">Gía trị</label>
                          <input type="text" name="valueAdd" id="valueAdd" class="e-xl validate[required]" value=""/></li>
                      <li><label for="ordAdd">Thứ tự</label>
                          <input type="text" name="ordAdd" id="ordAdd" class="e-xl validate[required]" value=""/></li>
                  </ol>
                </g:form>
              <div>
          </div>

     
<script type="text/javascript">
    $(document).ready(function(){

        $("button[name=add]").click(function(){
            $("#addNewConf").dialog("open")
            return false;
        });

        $("a[name=delete]").click(function(){
            return confirm('Bạn có chắc chắn muốn xóa?');
        });
        
        $("#addNewConf").dialog({
          width: 450,
          height:230,
          autoOpen: false,
          modal: true,
          buttons:{
            "Đóng":function(){
              $(this).dialog('close');
            },
            "Cập nhật":function(){
                    if($("#addNewConfForm").validationEngine({returnIsValid:true})){
                        $.post('${createLink(controller:'configuration',action:'index')}/0?'+"add=data",
                        $("#addNewConfForm").serialize(),function(data){
                            var result = parseInt(data);
                                if(result == 1){
                                    $("#addNewConf").dialog('close');
                                      jquery_alert('Thông báo','Cập nhật thành công');
                                      document.location='${createLink(controller:'configuration',action:'index')}';

                                }else{
                                      jquery_alert('Lỗi','Cập nhật không thành công: ' + data);
                                }
                        });
                    }
             }
          }
        });

        $("#continueConfirmDialog").dialog({
              width: 450,
              height:150,
              autoOpen: false,
              modal: true,
              buttons:{
                "Đóng":function(){
                  $(this).dialog('close');
                },
                "Đồng ý":function(){
                        if($("#questionTable").validationEngine({returnIsValid:true})){
                            $.post('${createLink(controller:'configuration',action:'index')}/0?'+"delete=data",
                            $("#questionTable").serialize(),function(data){
                                var result = parseInt(data);
                                    if(result == 1){
                                        $("#continueConfirmDialog").dialog('close');
                                          jquery_alert('Thông báo','Xóa thành công');
                                          document.location='${createLink(controller:'configuration',action:'index')}';

                                    }else{
                                          jquery_alert('Lỗi','Xóa không thành công: ' + data);
                                    }
                            });
                        }
                 }
              }
        });


      });
</script>
      
    </body>
</html>