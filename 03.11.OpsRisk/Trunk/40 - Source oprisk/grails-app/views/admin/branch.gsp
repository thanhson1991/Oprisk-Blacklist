

<html>
    <head>
        <meta name="layout" content="main" />
        <title>Quản trị người dùng</title>
    </head>
    <body>
        <g:render template="/admin/adminMenu"/>
        <fieldset class="float-left org-chart">
          <legend>Maritime Bank - <button id="edit">Edit</button>
            <button id="add_branch">Thêm Chi nhánh</button>
            <button id="add_employee">Thêm nhân viên</button>
          </legend>
          <div id="branch_tree"></div>
        </fieldset>

        <div class="float-left margin-10" style="width: 550px">
          <div id="info">
             <h3><a href="#">Thông tin chi nhánh</a></h3>
              <form id="branch_form">
                <ul class="form">
                  <li><label for="parent.id">Chi nhánh cha</label>
                    <g:select name="parent.id" from="${Branch.list()}"
                      optionKey="id" optionValue="name"/>
                  </li>
                  <li><label for="name">Tên chi nhánh</label>
                    <input id="name" class="e-xxxl" name="name"/>
                  </li>
					<li><label for="code">Mã CN (cung cấp CIC)</label>
	                    <input id="code" class="e-xl" name="code"/>
	                  </li>
                  <li class="float-right">
                    <button name="save_button">Lưu</button>
                    <g:hiddenField name="id" />
                  </li>
                </ul>
                </form>


              <h3><a href="#">Thông tin nhân viên</a></h3>
              <div>
                <form id="employee_form">
                <ul class="form">
                  <li><label for="branch.id">Chi Nhánh</label>
                    <g:select name="branch.id" from="${Branch.list()}"
                      optionKey="id" optionValue="name"/>
                  </li>
                  <li><label for="login">Login</label>
                    <input id="login" name="login"/>
                  </li>
                  <li><label for="pass">Password</label>
                    <input id="pass" name="pass" type="password"/>
                  </li>
                  <li><label for="name">Họ tên</label>
                    <input id="name" class="e-xxxl" name="name"/>
                  </li>
                  <li><label for="email">Email</label>
                    <input id="email" class="e-xxxl" name="email"/>
                  </li>
                  
                  <li><label for="role">Vai trò</label>
                    <g:select name="role" from="${Conf.findAllByType('ROLE')}"
                      optionKey="value" optionValue="label"/>
                  </li>
                  
                  <li><label for="activated">Trạng thái</label>
                    <g:checkBox name="activated"/>
                  </li>
                  <li class="float-right">
                    <button name="save_button">Lưu</button>
                    <g:hiddenField name="id" />
                  </li>
                </ul>
                </form>
              </div>
          </div>
        </div>

        <script type="text/javascript">
          $(document).ready(function(){
               $("#branch_tree").jstree({
                        "json_data" : {
                                "ajax" : { "url" : "${createLink(controller:'systemAdmin',action:'getOrgChart')}" }
                        },
                        "plugins" : [ "themes", "json_data", "ui", "cookies" ]
                });
                $("#edit").click(function(){
                    var obj = $.getJSON('${createLink(controller:'systemAdmin',action:'getBranchObject')}/'+getSelectedId(),
                    // Now displayin data in the accordion
                    function(data){
                      if(getSelectedId()[0]=='e'){
                        if($("#info").accordion("option","active") != 1)
                          $("#info").accordion("activate",1);
                        $("#employee_form input[name=login]").val(data.login);
                        $("#employee_form input[name=name]").val(data.name);
                        $("#employee_form input[name=pass]").val('');
                        $("#employee_form input[name=email]").val(data.email);
                        $("#employee_form select[name=role]").val(data.role);
                        $("#employee_form select[name=branch.id]").val(data.branch.id);
                        $("#employee_form input[name=activated]").attr("checked",data.activated);
                        $("#employee_form input[name=id]").val(data.id);

                      }else{
                        if($("#info").accordion("option","active") != 0 ||
                          $("#info").accordion("option","active") === false)
                          $("#info").accordion("activate",0);
                        $("#branch_form input[name=name]").val(data.name);
						$("#branch_form input[name=code]").val(data.code);
                        $("#branch_form select[name=parent.id]").val(data.parent.id);
                        $("#branch_form input[name=id]").val(data.id);
                      }
                    });
                });

                // Add branch
                $("#add_branch").click(function(){
                  if($("#info").accordion("option","active") != 0 ||
                      $("#info").accordion("option","active") === false)
                      $("#info").accordion("activate",0);
                  $("#branch_form input[name=name]").val('');
					$("#branch_form input[name=code]").val('');
                  $("#branch_form select[name=parent.id]").val(1);
                  $("#branch_form input[name=id]").val('');
                  if(getSelectedId()[0]=='b'){
                    $("#branch_form select[name=parent.id]").val(
                      getSelectedId().substring(1));
                  }
                });

                // saving employee
                $("#branch_form button[name=save_button]").click(function(){
                    // post the value with AJAX
                    $.post('${createLink(controller:'systemAdmin',action:'saveBranch')}',
                    $("#branch_form").serialize(),function(data){
                        if(data == '1'){
                          alert('Cập nhật thành công');
                          $("#branch_tree").jstree("refresh",-1);
                        }else{
                          alert(getErrors(data));
                        }
                    });
                    return false;
                });



                // Add employee
                $("#add_employee").click(function(){
                    if($("#info").accordion("option","active") != 1)
                      $("#info").accordion("activate",1);
                    $("#employee_form input[name=login]").val('');
                    $("#employee_form input[name=name]").val('');
                    $("#employee_form input[name=pass]").val('');
                    $("#employee_form input[name=email]").val('');
                    $("#employee_form select[name=role]").val('');
                    $("#employee_form select[name=branch.id]").val('');
                    $("#employee_form input[name=activated]").attr("checked",false);
                    $("#employee_form input[name=id]").val('');
                    if(getSelectedId()[0]=='b'){
                      $("#employee_form select[name=branch.id]").val(
                        getSelectedId().substring(1));
                    }


                });

                // saving employee
                $("#employee_form button[name=save_button]").click(function(){
                    // post the value with AJAX
                    $.post('${createLink(controller:'systemAdmin',action:'saveEmployee')}',
                    $("#employee_form").serialize(),function(data){
                        if(data == '1'){
                          alert('Cập nhật thành công');
                          $("#branch_tree").jstree("refresh",-1);
                        }else{
                          alert(getErrors(data));
                        }
                    });
                    return false;
                });



                function getSelectedId(){
                  return $("#branch_tree .jstree-clicked").parent().attr('id');
                }

                $("#info").accordion({
                  autoHeight: false,
                  collapsible: true,
                  active: false
                });
                $("button[name=save_button]").button({icons: {primary: 'ui-icon-disk'}});
                $("#edit").button({icons: {primary: 'ui-icon-pencil'},text: false});
                $("#add_branch").button({icons: {secondary: 'ui-icon-home',primary: 'ui-icon-plus'},text: false});
                $("#add_employee").button({icons: {secondary: 'ui-icon-person',primary: 'ui-icon-plus'},text: false});

          });
        </script>
    </body>
</html>