

<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Danh sách rủi ro</title>
	</head>
	<body>

		<div id="m-melanin-tab-header">
                  	<g:if test="${nodes}">
					<g:render plugin="melanin" template="/templates/m-melanin-action-bar"
						model="${[
						buttons:[[name:'m-melanin-action-bar-button-create-node',label:'Tạo rủi ro']]
					]}"/>
                      </g:if>
                      <g:form controller="admin" action="viewRisk" class="float-right" style="margin-right: 20px" >
                        <g:select name="departmentId" from="${departments}"
                          optionKey="id" optionValue="name" onchange="this.form.submit()"
                          value="${d?.id}"/>
                         <g:submitButton style="width:auto;margin:3px -17px 0px 6px" name="show" class="btn small float-right" value="Xem" />
                      </g:form>
                        
			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'admin'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Cơ cấu tổ chức',label:'Cơ cấu tổ chức']]
					]}"/>

			<div class="clear"></div>
		</div>
        <g:render template="sidebar"/>
		<div id="m-melanin-main-content">
                  <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
	        <g:if test="${nodes}">
			<div id="m-oprisk-tree-section" style="float:left;">
				<fieldset style="max-width:350px;width:350px;overflow:hidden;">
					<legend>Danh sách rủi ro</legend>
					<div id="m-oprisk-tree" class="m-melanin-hierarchy-tree"></div>
				</fieldset>
			</div>
			<div id="m-oprisk-form-section" style="float:left;margin-left:150px;display:none">
				<fieldset style="width:390px">
					<legend>Thông tin chi tiết</legend>
					<form method="post" id="m-oprisk-tree-node-form" name="m-oprisk-tree-node-form" controller="admin" action="addRisk">
						<ul class="form form-clear form-stacked">
							<li>
								<label for="name"><font color="red">*</font> Tên rủi ro:</label>
								<g:textField name="name" class="validate[required] e-xxxxl"/>
							</li>
							<li>
								<label for="parentlv1">Rủi ro level 1:</label>
								<select id="parentlv1" class="se-xxxxl" name="parentlv1">
									<option></option>
									<g:each in="${nodes}" var="node">
                                                                          <g:if test="${node.ord==0}">
										<option value="${node.id}">${node.name}</option>
                                                                          </g:if>
									</g:each>
								</select>
							</li>
                                                        <li>
								<label for="parentlv2">Rủi ro level 2:</label>
								<select class="se-xxxxl" id="parentlv2" name="parentlv2">
									<option></option>
									<g:each in="${nodes}" var="node">
                                                                          <g:if test="${node.ord==1}">
										<option value="${node.id}">${node.name}</option>
                                                                          </g:if>
									</g:each>
								</select>
							</li>
                                                         <li id="riskControl">
								<label for="control">Kiểm soát:</label>
                                                                <g:textArea rows="10" name="control" id="control" class="e-xxxxl"/>
                                                                
							</li>
							<li>
                                                                <g:hiddenField name="nodeId"/>    
								<g:hiddenField name="departmentId" value="${d?.id}"/>
								<button type="submit" class="btn primary">Lưu</button>
								<button type="button" class="btn red" name="m-melanin-form-button-delete">Xóa</button>
								<button type="button" class="btn" name="m-melanin-form-button-cancel">Bỏ qua</button>
							</li>
						</ul>
					</form>
				</fieldset>
			</div>
        </g:if>
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
						"ajax" : { "url" : "${createLink(controller:'admin',action:'getRiskTree',params:[departmentId:d?.id])}","cache": false }
	                },
	                "themes" : {
						"theme":"msb"
					},
	                "plugins" : [ "themes", "json_data", "ui", "cookies" ]
        		});

        		$("#m-oprisk-tree a").live("click",function(){                                 
        			$("#m-oprisk-tree").jstree("toggle_node","#"+$(this).parent("li").attr("id"));                          
        			$("form[name=m-oprisk-tree-node-form] input#name").val($(this).html().replace(/<ins.*?ins>/g,"").replace(/<INS.*?INS>/g,""));

                                if($(this).parent("li").parent("ul").parent("li").attr("id").substring(19)!=''){                                  
                                  if($(this).parent("li").parent("ul").parent("li").parent("ul").parent("li").attr("id").substring(19)==''){                                     
                                    $("form[name=m-oprisk-tree-node-form] select[name=parentlv1]").val($(this).parent("li").parent("ul").parent("li").attr("id").substring(19));                                    
                                    $("form[name=m-oprisk-tree-node-form] select[name=parentlv2]").val("");
                                    $("#riskControl").hide();
                                  }else{
                                   // var test = $(this).parent("li").parent("ul").parent("li").attr("id").substring(19);
                                    $.post('${createLink(controller:'admin',action:'getChildRisks')}/'+ $(this).parent("li").parent("ul").parent("li").parent("ul").parent("li").attr("id").substring(19),function(data){                                         
                                         $("form[name=m-oprisk-tree-node-form] select[name=parentlv2]").html(data);                                        
                                         
                                          
                                    });
                                   //setInterval($("form[name=m-oprisk-tree-node-form] select[name=parentlv2]").val($(this).parent("li").parent("ul").parent("li").attr("id").substring(19)),500);
                                    $("form[name=m-oprisk-tree-node-form] select[name=parentlv1]").val($(this).parent("li").parent("ul").parent("li").parent("ul").parent("li").attr("id").substring(19));                                  
                                    $("form[name=m-oprisk-tree-node-form] select[name=parentlv2]").val($(this).parent("li").parent("ul").parent("li").attr("id").substring(19));
                                    $("form[name=m-oprisk-tree-node-form] textarea#control").val($(this).parent("li").attr("control"));
                                    $("#riskControl").show();
                                     
                                  }
                                }else{                                  
                                  $("form[name=m-oprisk-tree-node-form] select[name=parentlv1]").val("");
                                  $("form[name=m-oprisk-tree-node-form] select[name=parentlv2]").val("");
                                  $("#riskControl").hide();
                                }                                 
                                 
        			$("form[name=m-oprisk-tree-node-form] input#nodeId").val($(this).parent("li").attr("id").substring(19));
        			$("button[name=m-melanin-form-button-delete]").show();
        			if ($("#m-oprisk-form-section").css("display")!="none"){
        				$("#m-oprisk-form-section").hide('slide',{direction:'right'});
            		}
                               
        			$("#m-oprisk-form-section").show('slide');
                                  $.post('${createLink(controller:'admin',action:'getChildRisks')}',
                                                                    $("form[name=m-oprisk-tree-node-form]").serialize(),function(data){

                                                                            $("form[name=m-oprisk-tree-node-form] select[name=parentlv2]").html(data);
                                                                    });                                 
        			
                                   
            	});                
                                  $("#parentlv1").change(function(){
                                            if ($(this).val()){
                                                            $.post('${createLink(controller:'admin',action:'getChildRisks')}',
                                                                    $("form[name=m-oprisk-tree-node-form]").serialize(),function(data){
                                                                             $("select[name=parentlv2]").html("");
                                                                            $("select[name=parentlv2]").html(data);
                                            });
                                                    } else{

                                                            $("select[name=parentlv2]").html("");
                                                            $("select[name=parentlv2]").change();
                                                    }

                                    });


        		$("button[name=m-melanin-form-button-delete]").click(function(){
					jquery_confirm("Xóa đơn vị","Anh/chị chắc chắn muốn xóa rủi ro này?<br/><br/><b>Lưu ý:</b> Các rủi ro khác thuộc rủi ro này cũng sẽ bị xóa!",
							function(){
								jquery_open_load_spinner();
								document.location = "${createLink(controller:'admin',action:'deleteRisk')}/" + $('form[name=m-oprisk-tree-node-form] input#nodeId').val() + "?currentAction=" + $('form[name=m-oprisk-tree-node-form] input#currentAction').val();
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
                                $("#riskControl").show();
				$('form[name=m-oprisk-tree-node-form] input#nodeId').val("");
				$("form[name=m-oprisk-tree-node-form] input#name").val("");
                                $("form[name=m-oprisk-tree-node-form] textarea#control").val("");
//        			$("form[name=m-oprisk-tree-node-form] select[name=parentlv1]").val("");
//                                $("form[name=m-oprisk-tree-node-form] select[name=parentlv2]").val("");
        			$("button[name=m-melanin-form-button-delete]").hide();
        			if ($("#m-oprisk-form-section").css("display")!="none"){
        				$("#m-oprisk-form-section").hide('slide',{direction:'right'});
            		}
        			$("#m-oprisk-form-section").show('slide');
				});
				$("#admin-risk").closest('li').addClass('active');
				set_side_bar(true);
			});

		</script>

	</body>
</html>