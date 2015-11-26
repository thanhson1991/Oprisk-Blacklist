<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Cơ cấu tổ chức</title>
	</head>
	<body>

		<div id="m-melanin-tab-header">
			<g:render plugin="melanin" template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-node',label:'Tạo đơn vị 11']]
					]}"/>
			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'admin'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'admin',action:'viewUnitDepartment'),title:'Danh sách loại đơn vị',label:'Danh sách đơn vị']]
					]}"/>

			<div class="clear"></div>
		</div>
		<g:render template="../admin/sidebar"/>
		
      
			<div id="m-melanin-main-content">
			 <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
	      </g:if>
			<div id="m-atrack-tree-section" style="float:left;max-width:350px;width:350px">
				<fieldset>
					<legend>Sơ đồ tổ chức MSB</legend>
					<div id="m-atrack-tree" class="m-melanin-hierarchy-tree"></div>
				</fieldset>
			</div>
			<div id="m-atrack-form-section" style="float:left;margin-left:20px;display:none">
				<fieldset style="width:400px">
					<legend>Thông tin chi tiết</legend>
					<form id="m-oprisk-tree-node-form"  name="m-oprisk-tree-node-form" controller="unitDepartment" action="addNode">
						<ul class="form form-clear form-stacked">
							<li>
								<label for="name"><font color="red">*</font> Tên đơn vị:</label>
								<g:textField name="name" class="validate[required] e-xxl"/>
							</li>
							
							<li>
								<label for="code"><font color="red">*</font> Mã đơn vị:</label>
								<g:textField name="code" class="validate[required] e-xxl"/>
							</li>
							
							
							<li>
								<label for="parent">Trực thuộc:</label>
								${htmlResControl} 
								
<%--								<select class="e-xxl" name="parent">--%>
<%--									<option></option>--%>
<%--									<g:each in="${nodes}" var="node">--%>
<%--										<option value="${node.id}"><g:if test="${node.ord==2}">|---</g:if>${node.name}</option>--%>
<%--									</g:each>--%>
<%--								</select>--%>
							 
							</li>
							 
							<li class="buttons">
							 
								<g:hiddenField name="nodeId"/>
								 
								<g:hiddenField name="currentAction" value="horizontal"/>
								<br><br>
								<button type="submit" class="awesome primary">Lưu</button>
								<button type="button" class="awesome red" name="m-melanin-form-button-delete">Xóa</button>
								<button type="button" class="awesome" name="m-melanin-form-button-cancel">Bỏ qua</button>
								<g:hiddenField name="AddMaLoi"/>
								<g:hiddenField name="AddChildrenId"/>
								<g:hiddenField name="AddTrucThuoc"/>
							</li>
						</ul>
					</form>
				</fieldset>
			</div>
		</div>



		<script type="text/javascript">
			$(function(){
				
				
				set_side_bar(true);
                $("#admin-unit-department").closest('li').addClass('active');
				$("#admin-unit-department").closest('li').addClass('active');
				
				$("#m-oprisk-tree-node-form").validationEngine();
				$("button[name=m-melanin-form-button-delete]").hide();

				$("#m-atrack-tree").jstree({
					"json_data" : {
						"ajax" : { "url" : "${createLink(controller:'unitDepartment',action:'getTree')}/horizontal" }
	                },
	                "themes" : {
						"theme":"msb"
					},
	                "plugins" : [ "themes", "json_data", "ui", "cookies" ]
        		});

        		$("#m-atrack-tree a").live("click",function(){
            		
        			$("#m-atrack-tree").jstree("toggle_node","#"+$(this).parent("li").attr("id"));
        			$("form[name=m-oprisk-tree-node-form] input#name").val($(this).html().replace(/<ins.*?ins>/g,"").replace(/<INS.*?INS>/g,""));
        			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val($(this).parent("li").parent("ul").parent("li").attr("id").substring(19));
        			$("form[name=m-oprisk-tree-node-form] input#nodeId").val($(this).parent("li").attr("id").substring(19));
        			$("form[name=m-oprisk-tree-node-form] input#code").val($(this).parent("li").attr("tid"));
        			
        			$("#AddChildrenId").val($("form[name=m-oprisk-tree-node-form] input#nodeId").val());      			
				    $.post('${createLink(controller:'unitDepartment',action:'findParent')}/AddChildrenId',
							$("form[name=m-oprisk-tree-node-form]").serialize(),function(data){								
								$("#AddTrucThuoc").val(data);
								
		               	});
        			$.post('${createLink(controller:'unitDepartment',action:'findCodeParent')}/AddChildrenId',
							$("form[name=m-oprisk-tree-node-form]").serialize(),function(data){								
								$("#AddMaLoi").val(data);
								
		               	});
					
        			
        			$("button[name=m-melanin-form-button-delete]").show();
        			if ($("#m-atrack-form-section").css("display")!="none"){
        				$("#m-atrack-form-section").hide('slide',{direction:'right'});
            		}
        			$("#m-atrack-form-section").show('slide');
            	});

        		$("button[name=m-melanin-form-button-delete]").click(function(){
					jquery_confirm("Xóa đơn vị","Bạn chắc chắn muốn xóa đơn vị này?<br/><br/><b>Lưu ý:</b> Tất cả các đơn vị con của đơn vị này cũng sẽ bị xóa!",
							function(){
								jquery_open_load_spinner();
								document.location = "${createLink(controller:'unitDepartment',action:'deleteNode')}/" + $('form[name=m-oprisk-tree-node-form] input#nodeId').val() + "?currentAction=" + $('form[name=m-oprisk-tree-node-form] input#currentAction').val();
							});
				});

        		$("button[name=m-melanin-form-button-cancel]").click(function(){
					$('form[name=m-oprisk-tree-node-form] input#nodeId').val("");
					$("form[name=m-oprisk-tree-node-form] input#name").val("");
        			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val("");
        			$("button[name=m-melanin-form-button-delete]").hide();
        			$("#m-atrack-form-section").hide('slide',{direction:'right'});
				});

        		$("button[name=m-melanin-action-bar-button-create-node]").click(function(){



        			var maloi=$("#AddMaLoi").val()
        			var tructhuoc=$("#AddTrucThuoc").val();
        			
        			if(maloi!=null){        
        				   		
        				$("form[name=m-oprisk-tree-node-form] input#code").val(maloi);
            		}
            		if(tructhuoc!=null){
                		
            			$("form[name=m-oprisk-tree-node-form] select[name=parent]").val(tructhuoc);
                	}

            		

            		
            		var nodeID = $("#nodeId").val(); 

					$('form[name=m-oprisk-tree-node-form] input#nodeId').val("");
					$("form[name=m-oprisk-tree-node-form] input#name").val(""); 
        		    
					/*$("form[name=m-oprisk-tree-node-form] select[name=parent]").val(nodeID);*/
        			
        			$("button[name=m-melanin-form-button-delete]").hide();
        			if ($("#m-atrack-form-section").css("display")!="none"){
        				$("#m-atrack-form-section").hide('slide',{direction:'right'});
            		}
        			$("#m-atrack-form-section").show('slide');
				});
			});
		
			var sidebarSwitch = false;
			function toggle_sidebar(flag){
				set_side_bar(flag);
			}		    
		</script>			
	</body>
</html>