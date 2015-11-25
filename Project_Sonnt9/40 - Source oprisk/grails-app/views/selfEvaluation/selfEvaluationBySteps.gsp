<%@page  import ="RiskService" %>
<%@page  import ="grails.converters.JSON" %>
<%
    def RiskService = grailsApplication.classLoader.loadClass('RiskService').newInstance()
	def i = 0
%>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Tự đánh giá rủi ro</title>
<style type="text/css" media="screen">
	ul#controlEffect-dropdown ul{
		left: -300px;
	}
	ul#possibility-dropdown ul{
		left: -100px;
	}
	.fix-li-margin{
		margin-top:6px;
		height: 15px;
	}
	.close-mega-menu {
		float: right;
		margin-right: 50px;
		cursor: pointer;
	}
        .selfForm{
          width:700px;
        }

        [class*="span"]{
          margin-left: 0;
        }
       
	#risk-instance-form label{
		width: 300px;
	}
	#risk-instance-form .buttons{
		margin-left: 135px;
	}

        .form li label{
          float: none;
        }
        .risk-label{
          width:67px !important;
          float: left !important;
        }

</style>
  </head>
  <body>


    <div id="m-melanin-tab-header">
      <g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
                model="${[items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
                        [href:createLink(controller:'admin',action:'viewDepartment'),title:'Tự đánh giá rủi ro',label:'Tự đánh giá rủi ro']]
                        ]}"/>

      <div class="clear"></div>
    </div>
    <div id="m-melanin-left-sidebar">
	      <ul class="m-melanin-vertical-navigation " id="risk-menu-list">
	              <li id='self-help' style="border-bottom: 1px ridge #aaa">
	                  <span class="ss_sprite ss_help">&nbsp;</span>&nbsp;Hướng dẫn đánh giá
	              </li>
				<g:each in="${process.riskInstances}" var="risk" status="k">
	              <li class="risk-object m-melanin-tooltip1" rel="${k}" title=" ${risk.risk?.name}">
	                      <span class="ss_sprite ss_page_white_edit">&nbsp;</span><a
							id="view-risk-${k}" href="#"
							
							class=" m-melanin-vertical-navigation-link">${k+1}. ${FormatUtil.cutString(risk.risk?.name,17,'...')}</a>
						<span class="float-right validity ss_sprite">&nbsp;</span>
	              </li>
				</g:each>
                                 <g:if test="${process.status!=100}">
				<li>

					<span class="ss_sprite ss_add">&nbsp;</span>
					<a id="add-risk-instance" href="#" class="m-melanin-vertical-navigation-link">Thêm mới...</a>
				</li>
                                 </g:if>
	            <li style="border-top: 1px ridge #aaa">

					<span class="ss_sprite ss_application_view_columns ">&nbsp;</span>
					<a id="result_board" href="#">Bảng tổng hợp</a>
				</li>
	      </ul>
	</div>
    <div id="m-melanin-main-content">
      <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
         </g:if>
          <g:if test="${process.status==100}">
            <div class ="message">
              <g:message code="message21" />
            </div>
          </g:if>
		<div id="help-info">
			<h3>Hướng dẫn tự đánh giá rủi ro</h3>
			<div class="progress-train">
					<div class="step ">
						Bước 1: Xác định rủi ro </div>
						<div class="step active">
						Bước 2: Đánh giá rủi ro </div>
						<div class="step">
						Bước 3: Đề xuất biện pháp giảm rủi ro</div>
                </div>
			<p>- Anh/chị cần điền đẩy đủ thông tin cho <strong><u>ít nhất 01</u></strong> rủi ro tại trung tâm của anh/chị tương ứng với danh sách rủi ro ở menu bên trái</p>
			<p>- Các rủi ro có đánh dấu <span class="ss_sprite ss_cancel">&nbsp;</span> là các rủi ro <strong><u>chưa</u></strong> điền đầy đủ thông tin.
			<p>- Các rủi ro có đánh dấu <span class="ss_sprite ss_accept">&nbsp;</span> là các rủi ro <strong><u>đã</u></strong> điền đầy đủ thông tin.
                        <p>- Anh/chị có thể điền thông tin của <strong><u>nhiều hơn 01</u></strong> rủi ro bằng cách nhấn vào menu <span class="ss_sprite ss_add">&nbsp;</span> "Thêm mới..." ở menu bên trái</p>
                        <p>- Chức năng <span class="ss_sprite ss_application_view_columns ">&nbsp;</span> "Bảng tổng hợp" để xem lại thông tin tất cả các rủi ro anh/chị đã nhập.
			<p>&nbsp;</p>
                    

		</div>
      <form method ="POST" controller="selfEvaluation"  action ="saveEvaluateForm" name="risk-instance-form" id="risk-instance-form">
        <span id="help-note" ><h3>Hướng dẫn tự đánh giá rủi ro</h3>
			<div class="progress-train">
					<div class="step">
						Bước 1: Xác định rủi ro </div>
						<div class="step active">
						Bước 2: Đánh giá rủi ro </div>
						<div class="step">
						Bước 3: Đề xuất biện pháp giảm rủi ro</div>
                </div>
		<fieldset id="risk-instance-fieldset" class="span12" style="display:none">
                  
			<legend>Thông tin rủi ro số 1</legend>

<!--                        <center><h3>Bước 2: Đánh giá rủi ro</h2></center>-->
			<ol class="form selfForm">
				<li>
                    <g:hiddenField name="processId" value="${process.id}"/>
					<g:hiddenField name="id"/>
					<g:hiddenField name="risk.id"/>
					<g:hiddenField name="impact.id"/>
					<g:hiddenField name="possibility.id"/>
					<g:hiddenField name="controlEffect.id"/>
					<label class="e-m risk-label label-left"> Tên rủi ro <font color="red">*</font></label>
						<ul class="mega-menu" rel="risk">
							<li><a href="#" class="drop" id="risk.name">Chọn rủi ro...</a><!-- Begin 4 columns Item -->
							        <div class="dropdown_6columns"><!-- Begin 4 columns container -->
								        <h2>Xin chọn 1 trong 4 loại rủi ro sau <a class="close-mega-menu " rel="-1">Đóng</a></h2>
										<div id="risk-list">
											<g:each in="${risklv1}" var="r">
								            <div class="col_2">
								                <h3>${r.name}</h3>
								                <ul>
													<g:each in="${RiskService.getRisklv3(r,process.id.toInteger())}" var="t">
								                    	<li><a href="#" rel="${t.id}">${t.name}</a></li>
								                    </g:each>
								                </ul>
								            </div>
											</g:each>
										</div>
							        </div>
							</li>
						</ul>

				</li>
                                <li>
                                  <label class="label-left"> Mô tả rủi ro thực tế tại đơn vị <font color="red">*</font></label>
                                      <textarea cols="300" rows="2" class="e-g risk_input" name="description" id ="description"></textarea>
                                </li>                                                          
				<li>
					<label class="label-left">Đánh giá ảnh hưởng <font color="red">*</font></label>
						<ul class="mega-menu" rel="impact">
							<li><a href="#"  class="drop" id="impact.description">Chọn ảnh thưởng...</a><!-- Begin 4 columns Item -->
							        <div id="impact-list" class="dropdown_4columns ">
								        <h2>Xin chọn 1 trong các ảnh hưởng sau<a class="close-mega-menu " rel="-1">Đóng</a></h2>
										<div class="col_4">
							                <ul>
												<g:each in="${impacts}" var="impact">
							                    	<li><a href="#" rel="${impact.id}">${impact.description}</a></li>
							                    </g:each>
							                </ul>
							            </div>
		          			        </div>
								</li>
						</ul>

				</li>
				<li>
					<label class="label-left">Đánh giá khả năng xảy ra <font color="red">*</font> </label>
						<ul class="mega-menu" rel="possibility">
							<li><a href="#" class="drop" id="possibility.description">Chọn khả năng xảy ra...</a><!-- Begin 4 columns Item -->
							        <div id="possibility-list" class="dropdown_4columns ">
								        <h2>Xin chọn 1 trong các khả năng xảy ra sau<a class="close-mega-menu " rel="-1">Đóng</a></h2>
										<div class="col_4">
							                <ul>
												<g:each in="${possibilities}" var="possibility">
							                    	<li><a href="#" rel="${possibility.id}">${possibility.description}</a></li>
							                    </g:each>
							                </ul>
							            </div>
		          			        </div>
								</li>
						</ul>

				</li>
                                <li>
                                  <label class="label-left">Các kiểm soát đối với rủi ro này</label>                                  
                                      <textarea readonly="readonly" cols="150" rows="4" class="e-g" name="riskControl" id ="riskControl"></textarea>
                                </li>  
                                <li>
                                  <label class="label-left">Các kiểm soát khác đã thực hiện tại đơn vị</label>                                  
                                      <textarea cols="150" rows="4" class="e-g risk_input" name="control" id ="control"></textarea>                                 
                                </li>
				<li>
					<label class="label-left">Đánh giá hiệu quả kiểm soát <font color="red">*</font></label>
						<ul class="mega-menu" rel="controlEffect">
							<li><a href="#" class="drop" id="controlEffect.description">Chọn hiệu quả kiểm soát...</a><!-- Begin 4 columns Item -->
							        <div id="controlEffect-list" class="dropdown_4columns ">
								        <h2>Xin chọn 1 trong các hiệu quả kiểm soát sau <a class="close-mega-menu " rel='-1'>Đóng</a></h2>
										<div class="col_4">
							                <ul>
												<g:each in="${controlEffects}" var="controlEffect">
							                    	<li><a href="#" rel="${controlEffect.id}">${controlEffect.description}</a></li>
							                    </g:each>
							                </ul>
							            </div>
		          			        </div>
								</li>
						</ul>

				</li>

<!--                                <center><h3>Bước 3: Biện pháp giảm rủi ro</h2></center>
                                <li>
                                  <label class="label-left" for="actionDescription">Đề xuất biện pháp:</label>
                                  <ul class="mega-menu normal " rel="actionDescription">
                                    <li>
                                      <textarea cols="150" rows="4" class="e-5l risk_input" name="actionDescription" id ="actionDescription"></textarea>

                                    </li>
                                  </ul>
                                </li>
                                <li>
                                  <label class="label-left" for="actionExecutor">Người thực hiện:</label>
                                  <ul class="mega-menu normal" rel="actionExecutor">
                                    <li>
                                      <input class="e-5l risk_input" name="actionExecutor" id ="actionExecutor"/>

                                    </li>
                                  </ul>
                                </li>
                                <li>
                                  <label class="label-left" for="actionDeadline">Thời hạn:</label>
                                  <ul class="mega-menu normal" rel="actionDeadline">
                                    <li>
                                           <input class="datetime risk_datetime" name="actionDeadline" id ="actionDeadline"/>

                                    </li>
                                  </ul>
                                </li>-->

				<li class="buttons">
                                  <g:if test="${process.status < 100}">
					<input name="m-melanin-save-button" type="button" class="btn primary " value="Lưu và nhập rủi ro tiếp theo &raquo;">
                                        <input name="m-melanin-continue-button" type="button" class="btn primary hide" value="Lưu và sang bước tiếp theo &raquo;">
                                        <input name="m-melanin-delete-button" type="button" class="btn " value="Xóa rủi ro">
                                   </g:if>
				</li>
			</ol>
		</fieldset>

      </form>
		<div class="clearfix"></div>
   </div>

    <script type="text/javascript">

        var current_risk = -1;
	function check_risk_object_valid(index){                
		if(index > -1){
			var risk_object = get_risk_object_data(index);                        
			if(	risk_object.impact == null || risk_object.risk == null || risk_object.controlEffect == null ||
				risk_object.possibility == null || risk_object.description == null || $.trim(risk_object.description) == ''){
				$($(".risk-object")[index]).find('.validity').addClass('ss_cancel');
				$($(".risk-object")[index]).find('.validity').removeClass('ss_accept');
			}else{
				$($(".risk-object")[index]).find('.validity').addClass('ss_accept');
				$($(".risk-object")[index]).find('.validity').removeClass('ss_cancel');
			}
		}
	}
	function submit_risk_instance(index){
		
		if(index >= 0){
			check_risk_object_valid(index);
			if($("#risk-instance-form #risk\\.id").val() != ''){
				$.post('${createLink(action:"saveRiskInstance")}',$("#risk-instance-form").serialize(),function(data){
					refreshTimeOut();
					if(data == -1){
						jquery_alert_default_error();
					}else{
						set_risk_object_data(index,data);
					}
				});
			}
		}
	}

        function delete_current_risk_instance(){		
		
			$.post('${createLink(action:"deleteRiskInstance")}',$("#risk-instance-form").serialize(),function(data){
				if(data == -1){
					jquery_alert_default_error();

				}else{
                    document.location = "${createLink(controller:"selfEvaluation", action:"viewEvaluationProcess",params:[id:process.id])}";
                                  
				}
			});
	}

        function check_last_risk_instance(){
              if (parseInt(current_risk)+1 == $(".risk-object").size()){
                  $("input[name=m-melanin-save-button]").hide();
                  $("input[name=m-melanin-continue-button]").show();
                }else{
                   $("input[name=m-melanin-save-button]").show();
                  $("input[name=m-melanin-continue-button]").hide();
                }
        }
	function update_risk_form(ri){


		$("#risk-instance-form #id").val(ri.id);

                $("#risk-instance-form #description").val(ri.description);
                $("#risk-instance-form #control").val(ri.control);                
                
//                var action_id = ri.riskAction.id;
//                $.post("${createLink(action:'getAction')}/"+action_id,function(data){
//                    $("#risk-instance-form #actionDescription").val(data.description);
//                    $("#risk-instance-form #actionExecutor").val(data.executor);
//                    $("#risk-instance-form #actionDeadline").val(data.deadline);
//
//                });

		$("#risk-instance-form #risk\\.id").val(get_id(ri.risk));
		$("#risk-instance-form #risk\\.name").html(get_text($("#risk-list a[rel="+get_id(ri.risk)+"]").html(),'Chọn rủi ro...'));

		$("#risk-instance-form #impact\\.id").val(get_id(ri.impact));
		$("#risk-instance-form #impact\\.description").html(get_text($("#impact-list a[rel="+get_id(ri.impact)+"]").html(),'Chọn ảnh hưởng...'));

		$("#risk-instance-form #possibility\\.id").val(get_id(ri.possibility));
		$("#risk-instance-form #possibility\\.description").html(get_text($("#possibility-list a[rel="+get_id(ri.possibility)+"]").html(),'Chọn khả năng xảy ra...'));

		$("#risk-instance-form #controlEffect\\.id").val(get_id(ri.controlEffect));
		$("#risk-instance-form #controlEffect\\.description").html(get_text($("#controlEffect-list a[rel="+get_id(ri.controlEffect)+"]").html(),'Chọn hiệu quả kiểm soát...'));

                var risk_id = get_id(ri.risk);
                $.post("${createLink(action:'getControl')}/"+risk_id,function(data){
                    $("#riskControl").html(data);
                });
	}
	function update_risk_object_with_selected_data(){
		var risk_object = get_risk_object_data(current_risk);                
                risk_object.description=$("#risk-instance-form #description").val();
                risk_object.control=$("#risk-instance-form #control").val();                
		$(".mega-menu").each(function(i,e){
			if($(e).find('.selected').length>0){
				if(risk_object[$(e).attr('rel')] == undefined){
					risk_object[$(e).attr('rel')] = new Object();
				}
				risk_object[$(e).attr('rel')].id=$(e).find('.selected a').first().attr('rel');
				$("#risk-instance-form #"+$(e).attr('rel')+"\\.id").val($(e).find('.selected a').first().attr('rel'));

			}
		});
		// HIEPNH Chú ý chỗ này
		$("#risk-instance-form #description").val(risk_object.description);
                $("#risk-instance-form #control").val(risk_object.control);                
	};
	function get_id(data){
		if(data != undefined) return data.id;
		return '';
	}
	function get_text(data,d ){
		if(data != undefined && data != '') return data;
		if(d) return d;
		return '';
	}
	function get_risk_object_data(index){
		return $($("#risk-menu-list li.risk-object")[index]).data('risk-object');
	}
	function set_risk_object_data(index,o){
		$($("#risk-menu-list li.risk-object")[index]).data('risk-object',o);
	}
	function set_selected_risk_object(index){        
		submit_risk_instance(current_risk);
		// change to the new index
		current_risk = index;
		$($("#risk-menu-list li")).removeClass('active');
		$($("#risk-menu-list li.risk-object")[index]).addClass('active');
		$(".mega-menu .selected").removeClass('selected');

		$("#risk-instance-fieldset legend").html('Thông tin rủi ro số ' + (parseInt(current_risk) + 1));
		$("#help-info").slideUp();
		$("#risk-instance-fieldset").slideDown();
                $("#help-note").show()
	}

        function validate_and_process(){
                    set_selected_risk_object(current_risk);
                    update_risk_object_with_selected_data();
                    check_risk_object_valid(current_risk);
                    //Self-helf has 1 ss_cancel
                    if($(".ss_cancel").size()>1){
                      jquery_alert('Lỗi','Anh/chị chưa hoàn thành việc đánh giá rủi ro. Xin vui lòng đánh giá tất cả các rủi ro để tiếp tục')

                    }else{
                      jquery_confirm("Tiếp tục","Anh/chị đã hoàn thành việc đánh giá rủi ro và muốn sang bước tiếp theo?",
                      function(){
                            document.location = "${createLink(controller:"selfEvaluation", action:"createAction",params:[processId:process.id])}";
                      });
                       
                    }

        }
	$(function(){
                $("#help-note").hide();
                if(${process.status == 100}){                  
                  $(".risk_input").attr('readonly','readonly');
                  $(".risk_datetime").attr('disabled','disabled');

                }
                
                


		<g:each in="${process.riskInstances}" var="riskInstance" status="j">                        
                      set_risk_object_data(${j},${riskInstance.encodeAsJSON()});
                      check_risk_object_valid(${j});			
		</g:each>              
		$("#add-risk-instance").click(function(){
			submit_risk_instance(current_risk);
			$.post("${createLink(action:'addRiskInstance',params:[id:process.id])}",function(data){
				if(data != -1){
					var l = $(".risk-object").length;
					$(".risk-object").last().after(
						'<li class="risk-object" rel="'+l+'">'+
			                      '<span class="ss_sprite ss_page_white_edit">&nbsp;</span>'+
			                      '<a id="view-risk-'+l+'" href="#" class=" m-melanin-vertical-navigation-link">'+(l+1)+'. ...</a>' +
                                              '<span class="float-right validity ss_sprite ss_cancel">&nbsp;</span>'+
			            '</li>'

						);
					set_risk_object_data(l,data);
					set_selected_risk_object(l);                                        
                                        update_risk_form($($("#risk-menu-list li.risk-object")[current_risk]).closest('li').first().data('risk-object'));
                                        check_last_risk_instance();
				}else{
					jquery_alert_default_error();
				}
			});

		});
                $("input[name=m-melanin-save-button]").live('click',function(event){                  
                     var targetOffset = $('#risk-instance-form').offset().top;
                      $('html,body').animate({scrollTop: targetOffset}, 500);
                     //set_selected_risk_object(current_risk);
                     //update_risk_form($($("#risk-menu-list li.risk-object")[current_risk]).closest('li').first().data('risk-object'));
                     update_risk_object_with_selected_data();

                  var risk_object = get_risk_object_data(current_risk);
                  if(risk_object.risk == null){
                      jquery_alert('Lỗi','Anh/chị chưa lựa chọn mục <b>Tên rủi ro</b>. Xin vui lòng hoàn tất để tiếp tục.');

                  }else if(risk_object.impact == null){
                      jquery_alert('Lỗi','Anh/chị chưa lựa chọn mục <b>Đánh giá ảnh hưởng</b>. Xin vui lòng hoàn tất để tiếp tục.');
                    
                  }else if(risk_object.controlEffect == null){
                     jquery_alert('Lỗi','Anh/chị chưa lựa chọn mục <b>Đánh giá hiệu quả kiểm soát</b>. Xin vui lòng hoàn tất để tiếp tục.');
                    
                  }else if(risk_object.possibility == null){
                     jquery_alert('Lỗi','Anh/chị chưa lựa chọn mục <b>Đánh giá khả năng xảy ra</b>. Xin vui lòng hoàn tất để tiếp tục.');
                    
                  }else if(risk_object.description == null || $.trim(risk_object.description) == ''){
                     jquery_alert('Lỗi','Anh/chị chưa lựa chọn mục <b>Mô tả rủi ro thực tế tại đơn vị</b>. Xin vui lòng hoàn tất để tiếp tục.');
                    
                  }
                  else{
                     check_risk_object_valid(current_risk);
                     set_selected_risk_object(parseInt(current_risk)+1);

                     update_risk_form($($("#risk-menu-list li.risk-object")[current_risk]).closest('li').first().data('risk-object'));
                     check_last_risk_instance();
                     return false;
                    }
                });
               
		$("#risk-menu-list li.risk-object").live('click',function(event){                        
			$("ul.mega-menu > li").removeClass('hover');
                        if(current_risk > -1){
                          update_risk_object_with_selected_data();
                        }
                        check_risk_object_valid(current_risk);
			set_selected_risk_object($(this).closest('li').attr('rel'));
			update_risk_form(get_risk_object_data(current_risk));                        
                        check_last_risk_instance();
			return false;
		});
                if(${process.status < 100}){

                  $("ul.mega-menu ul li a").click(function(){
                          var selected_risk = $(this).attr('rel');                          
                          var risk_object
                          var risk_objects  = $("#risk-menu-list li.risk-object").length;
                          for(var i=0;i< risk_objects;i++){
                            risk_object=get_risk_object_data(i);
                            if(current_risk != i && risk_object.risk !=null && risk_object.risk.id==selected_risk){
                              jquery_alert('Lỗi','Rủi ro anh/chị chọn đã tồn tại. Xin vui lòng chọn rủi ro khác');
                              return false;
                            }                            
                          }
                          $("ul.mega-menu > li").removeClass('hover');
                          $(this).closest('.mega-menu').find('li').removeClass('selected');
                          $(this).closest('li').addClass('selected');
                          $(this).closest('.mega-menu').find('.drop').first().html($(this).html());
                          update_risk_object_with_selected_data();
                          if($(this).closest('.mega-menu').find('.drop').first().attr('id')=='risk.name'){                            
                            var risk_name = $(this).closest('.mega-menu').find('.drop').first().html();                            
                            $("#view-risk-"+current_risk).html((parseInt(current_risk)+1) + '. ' +risk_name.substring(0,17) + '...');
                            var risk_id = get_id($($("#risk-menu-list li.risk-object")[current_risk]).closest('li').first().data('risk-object').risk);
                            $.post("${createLink(action:'getControl')}/"+risk_id,function(data){
                              $("#riskControl").html(data);
                            });
                          }
                          $('html,body').animate({scrollTop: $("#risk-instance-fieldset").offset().top});
                          return false;
                  });

                  $("ul.mega-menu > li").click(function(event){
                          $("ul.mega-menu > li").removeClass('hover');
                          $(this).addClass('hover')
                          return false;
                  });
                  $("ul.mega-menu .close-mega-menu").click(function(){

                          $("ul.mega-menu > li").removeClass('hover');
                          return false;
                  });
               }
                $("input[name=m-melanin-continue-button]").click(function(){
                  validate_and_process();
                });

                $("#result_board").click(function(){
                    if (current_risk==-1 || ${process.status==100}){
                      if($(".ss_cancel").size()>1){
                      jquery_alert('Lỗi','Anh/chị chưa hoàn thành việc đánh giá rủi ro. Xin vui lòng đánh giá tất cả các rủi ro để tiếp tục')

                      }else{
                         document.location = "${createLink(controller:"selfEvaluation", action:"createAction",params:[processId:process.id])}";
                      }

                    }else
                        validate_and_process();
                    // alert('aaa');
               

                })

                $("input[name=m-melanin-delete-button]").click(function(){
                  if($(".risk-object").length<=1){
                      jquery_alert('Lỗi','Anh/chị cần lựa chọn ít nhất 1 rủi ro');
                  }else
                      jquery_confirm("Xóa","Anh/chị đồng ý xóa rủi ro này?",
                      function(){
                            delete_current_risk_instance();
                      });
                      
                    
                });

		$("#self-help").click(function(){
			submit_risk_instance(current_risk);
			$(this).closest('ul').find('li').removeClass('active');
			$(this).closest('li').addClass('active');
			$("#help-info").slideDown();
			$("#risk-instance-fieldset").slideUp();
                        $("#help-note").hide();


		});

			set_active_tab('self-management');
			set_side_bar('true');
	});
    </script>

  </body>
</html>