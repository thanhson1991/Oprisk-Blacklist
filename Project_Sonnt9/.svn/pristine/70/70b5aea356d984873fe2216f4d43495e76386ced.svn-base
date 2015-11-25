<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Cơ cấu tổ chức</title>
	</head>
	<body>

		<div id="m-melanin-tab-header">
			<g:render plugin="melanin" template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-node',label:'Tạo đợn vị']]
					]}"/>
			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'admin'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'admin',action:'viewUnitDepartment'),title:'Danh sách loại đơn vị',label:'Danh sách đơn vị']]
					]}"/>

			<div class="clear"></div>
		</div>
		<g:render template="sidebar"/>
		<div id="m-melanin-main-content">
                        <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
			<div id="m-oprisk-tree-section" style="float:left;max-width:300px;width:300px">
				<fieldset>
					<legend>Danh sách các đơn vị</legend>
					<div id="m-oprisk-tree" class="m-melanin-hierarchy-tree"></div>
				</fieldset>
			</div>
			<div id="m-oprisk-form-section" style="float:left;margin-left:20px;display:none">
				<fieldset style="width:300px">
					<legend>Thông tin chi tiết</legend>                                      
					<form method="post" id="m-oprisk-tree-node-form" name="m-oprisk-tree-node-form" controller="admin" action="addUnitDepartment">
						<ul class="form form-clear form-stacked">
							<li>
								<label class="e-xxl" for="name"><font color="red">*</font> Tên đơn vị:</label>
								<g:textField name="name" class="validate[required] e-xxl"/>
							</li>
                            <li>
								<label for="code"><font color="red">*</font> Mã:</label>
								<g:textField name="code" class="validate[required,custom[number]] e-xxl"/>
							</li>

							<li >
								<g:hiddenField name="nodeId"/>                                                                
								<button type="submit" class="btn primary">Lưu</button>
								<button type="button" class="btn red" name="m-melanin-form-button-delete">Xóa</button>
								<button type="button" class="btn" name="m-melanin-form-button-cancel">Bỏ qua</button>
							</li>
						</ul>
					</form>
				</fieldset>
			</div>
			<div class="clear"></div>
		</div>

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
                                $("#admin-unit-department").closest('li').addClass('active');
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');
				$("#m-oprisk-tree-node-form").validationEngine();
				$("button[name=m-melanin-form-button-delete]").hide();

				$("#m-oprisk-tree").jstree({
					"json_data" : {
						"ajax" : { "url" : "${createLink(controller:'admin',action:'getUnitDepartmentTree')}","cache": false }
	                },
	                "themes" : {
						"theme":"msb"
					},
	                "plugins" : [ "themes", "json_data", "ui", "cookies" ]
        		});

        		$("#m-oprisk-tree a").live("click",function(){
            	
//                          $.get('${createLink(action:'getUnitDepartment',controller:'admin')}/'+
//						$(this).closest('li').attr('id'),function(data){
        			$("#m-oprisk-tree").jstree("toggle_node","#"+$(this).parent("li").attr("id"));
        			$("form[name=m-oprisk-tree-node-form] input#name").val($(this).html().replace(/<ins.*?ins>/g,"").replace(/<INS.*?INS>/g,""));
                                $("form[name=m-oprisk-tree-node-form] input#code").val($(this).parent("li").attr("code"));
        			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val($(this).parent("li").parent("ul").parent("li").attr("id").substring(19));
        			$("form[name=m-oprisk-tree-node-form] input#nodeId").val($(this).parent("li").attr("id").substring(19));
        			$("button[name=m-melanin-form-button-delete]").show();
        			if ($("#m-oprisk-form-section").css("display")!="none"){
        				$("#m-oprisk-form-section").hide('slide',{direction:'right'});
                                }
        			$("#m-oprisk-form-section").show('slide');
                        //  });
                        });

        		$("button[name=m-melanin-form-button-delete]").click(function(){
					jquery_confirm("Xóa đơn vị","Anh/chị chắc chắn muốn xóa đơn vị này?<br/>",
							function(){
								jquery_open_load_spinner();
								document.location = "${createLink(controller:'admin',action:'deleteUnitDepartment')}/" + $('form[name=m-oprisk-tree-node-form] input#nodeId').val() + "?currentAction=" + $('form[name=m-oprisk-tree-node-form] input#currentAction').val();
							});
				});

        		$("button[name=m-melanin-form-button-cancel]").click(function(){
					$('form[name=m-oprisk-tree-node-form] input#nodeId').val("");
					$("form[name=m-oprisk-tree-node-form] input#name").val("");
                                        $("form[name=m-oprisk-tree-node-form] input#code").val("");
        			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val("");
        			$("button[name=m-melanin-form-button-delete]").hide();
        			$("#m-oprisk-form-section").hide('slide',{direction:'right'});
				});

        		$("button[name=m-melanin-action-bar-button-create-node]").click(function(){
                          
					$('form[name=m-oprisk-tree-node-form] input#nodeId').val("");
					$("form[name=m-oprisk-tree-node-form] input#name").val("");
                                        $("form[name=m-oprisk-tree-node-form] input#code").val("");
        			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val("");
        			$("button[name=m-melanin-form-button-delete]").hide();
        			if ($("#m-oprisk-form-section").css("display")!="none"){
        				$("#m-oprisk-form-section").hide('slide',{direction:'right'});
            		}
        			$("#m-oprisk-form-section").show('slide');
				});
				$("#admin-unit-department").closest('li').addClass('active');
				set_side_bar(true);
			});

			
		</script>

	</body>
</html>