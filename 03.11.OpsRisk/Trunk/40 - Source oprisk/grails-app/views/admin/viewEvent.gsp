<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Cơ cấu tổ chức</title>
	</head>
	<body>

		<div id="m-melanin-tab-header">
			<g:render plugin="melanin" template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-node',label:'Tạo sự kiện']]
					]}"/>
			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'admin'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'admin',action:'viewEvent'),title:'Danh sách sự kiện rủi ro hoạt động',label:'Danh sách sự kiện rủi ro hoạt động']]
					]}"/>

			<div class="clear"></div>
		</div>
        <g:render template="sidebar"/>
		<div id="m-melanin-main-content">
                    <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
			<div id="m-oprisk-tree-section" style="float:left;max-width:440px;width:440px">
				<fieldset>
					<legend>Danh sách các sự kiện</legend>
					<div id="m-oprisk-tree" class="m-melanin-hierarchy-tree"></div>
				</fieldset>
			</div>
			<div id="m-oprisk-form-section" style="float:left;margin-left:150px;display:none">
				<fieldset style="width:350px">
					<legend>Thông tin chi tiết</legend>
					<form id="m-oprisk-tree-node-form" name="m-oprisk-tree-node-form" controller="admin" action="addEvent">
						<ul class="form form-clear form-stacked">
							<li>
								<label for="name"><font color="red">*</font> Tên sự kiện:</label>
								<g:textField name="name" class="validate[required] e-xxxl"/>
							</li>
							<li>
								<label for="parent">Trực thuộc:</label>
								<select class="se-xxxl" name="parent">
									<option></option>
									<g:each in="${nodes}" var="node">
										<option value="${node.id}">${node.name}</option>
									</g:each>
								</select>
							</li>
							<li >
								<g:hiddenField name="nodeId"/>
								<button type="submit" class="btn primary">Lưu</button>
								<button type="button" class="btn" name="m-melanin-form-button-delete">Xóa</button>
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
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');
				$("#m-oprisk-tree-node-form").validationEngine();
				$("button[name=m-melanin-form-button-delete]").hide();

				$("#m-oprisk-tree").jstree({
					"json_data" : {
						"ajax" : { "url" : "${createLink(controller:'admin',action:'getEventTree')}","cache": false }
	                },
	                "themes" : {
						"theme":"msb"
					},
	                "plugins" : [ "themes", "json_data", "ui", "cookies" ]
        		});

        		$("#m-oprisk-tree a").live("click",function(){
        			$("#m-oprisk-tree").jstree("toggle_node","#"+$(this).parent("li").attr("id"));
        			$("form[name=m-oprisk-tree-node-form] input#name").val($(this).html().replace(/<ins.*?ins>/g,"").replace(/<INS.*?INS>/g,""));
        			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val($(this).parent("li").parent("ul").parent("li").attr("id").substring(19));
        			$("form[name=m-oprisk-tree-node-form] input#nodeId").val($(this).parent("li").attr("id").substring(19));
        			$("button[name=m-melanin-form-button-delete]").show();
        			if ($("#m-oprisk-form-section").css("display")!="none"){
        				$("#m-oprisk-form-section").hide('slide',{direction:'right'});
            		}
        			$("#m-oprisk-form-section").show('slide');
            	});

        		$("button[name=m-melanin-form-button-delete]").click(function(){
					jquery_confirm("Xóa sự kiện","Anh/chị chắc chắn muốn xóa sự kiện này?",
							function(){
								jquery_open_load_spinner();
								document.location = "${createLink(controller:'admin',action:'deleteEvent')}/" + $('form[name=m-oprisk-tree-node-form] input#nodeId').val() + "?currentAction=" + $('form[name=m-oprisk-tree-node-form] input#currentAction').val();
							});
				});

        		$("button[name=m-melanin-form-button-cancel]").click(function(){
					$('form[name=m-oprisk-tree-node-form] input#nodeId').val("");
					$("form[name=m-oprisk-tree-node-form] input#name").val("");
        			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val("");
        			$("button[name=m-melanin-form-button-delete]").hide();
        			$("#m-oprisk-form-section").hide('slide',{direction:'right'});
				});

        		$("button[name=m-melanin-action-bar-button-create-node]").click(function(){

					$('form[name=m-oprisk-tree-node-form] input#nodeId').val("");
					$("form[name=m-oprisk-tree-node-form] input#name").val("");
//        			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val("");
        			$("button[name=m-melanin-form-button-delete]").hide();
        			if ($("#m-oprisk-form-section").css("display")!="none"){
        				$("#m-oprisk-form-section").hide('slide',{direction:'right'});
            		}
        			$("#m-oprisk-form-section").show('slide');
				});
				$("#admin-event").closest('li').addClass('active');
				set_side_bar(true);
			});

		</script>

	</body>
</html>