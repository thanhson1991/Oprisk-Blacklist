<%@  import page ="ContractService" %>
<%
    def ContractService = grailsApplication.classLoader.loadClass('ContractService').newInstance()
%>
<html>
  <head>
    <meta  name="layout" content="main"/>
    <title>Táº¡o há»£p Ä‘á»“ng</title>
  </head>
  <body>
    <g:render template="/contract/menu"/>
    <br clear="both">
    <div class="body">
      <g:if test="${message != null}">
        <div class ="message">
          <g:message code="message${message}" />
        </div>
      </g:if>
      <%def today = new Date()%>
      <g:form method="post" name="contractForm" controller="contract" action="viewContract">
        <g:hiddenField name="contractId" value="${contract?.id}"/>
        <g:hiddenField id="dateCount" name="dateCount" value="${1}"/>
        <fieldset class="form">
          <ol>
            <li>
              <label for="accType">Loáº¡i tÃ i khoáº£n: </label>
              <select class="radio-input" id="accType" name="accType">
                <option ${contract?.accType=='CA'?'selected':''} value="CA">CA</option>
                <option ${contract?.accType=='GL'?'selected':''} value="GL">GL</option>
              </select>
            </li>
            <li id ="accNo">
              <label for="accNumber">Sá»‘ tÃ i khoáº£n: </label>
              <input name ="accNumber" id="accNumber" class="validate[required] input msb-account" value="${contract?.accNumber}"/>
              <g:if test="${(contract?.status==0 || contract?.status==200 || !(contract)) && SecurityService.hasRole([SecurityService.ROLE_TELLER])}">
              <input type="button" value="Tra cá»©u tÃ i khoáº£n" name="lookUp"/>
              </g:if>
            </li>
            <li id="accNoGL">
              <label for="accNumberGL">Sá»‘ tÃ i khoáº£n: </label>
              <input name ="accNumberGL" id="accNumberGL" class="validate[required] input readonly" value="${Conf.findByType("GL").value}"/>

            </li>
            <li>
              <label >&nbsp;</label>
              <div id="accExample" class="help"><u>VÃ­ dá»¥:</u> 010-01-01-123456-7</div>
            </li>
            <li>
              <label for="reference">Sá»‘ há»£p Ä‘á»“ng: </label>
              <input name ="reference" id="reference" class="validate[required] input" value="${contract?.reference}"/>
            </li>
            <li>
              <label for="customerName">TÃªn khÃ¡ch hÃ ng: </label>
              <input name ="customerName" id="customerName" class="e-xxl validate[required] input" value="${contract?.customerName}" readonly="readonly"/>
            </li>
            <li>
              <label for="branch">Chi nhÃ¡nh: </label>
              <select id="branch" name="branch">
                      <g:each in="${Branch.findAllByCodeNotEqual('0')}">
                        <option ${it==contract?.branch?'selected':''} value="${it.id}">${it.code} ${it.name}</option>
                      </g:each>
                    </select>
            </li>
            <li id="curTypeGL">
              <label for="currencyTypeGL">Loáº¡i tiá»n: </label>
              <select class="radio-input" id="currencyTypeGL" name="currencyTypeGL">
                <option ${contract?.curType=='VND'?'selected':''} value="VND">VND</option>
                <option ${contract?.curType=='USD'?'selected':''} value="USD">USD</option>
              </select>
            </li>
            <li id="curTypeCA">
              <label for="currencyType">Loáº¡i tiá»n: </label>
              <input name ="currencyType" id="currencyType" class="readonly validate[required] input" value="${contract?.curType}" readonly="readonly"/>
            </li>
             <li>
              <label for="feeType">Loáº¡i phÃ­: </label>
              <input type="radio" name ="feeType" id="feeType1" class="validate[required] float-left radio-input" value="1" ${contract?.feeType=='1'?'checked="true"':''}/><span class="float-left margin-right-20">PhÃ­ cá»‘ Ä‘á»‹nh</span>
              <input type="radio" name ="feeType" id="feeType2" value="2" class="float-left radio-input" ${contract?.feeType=='2'?'checked="true"':''}/>PhÃ­ theo pháº§n trÄƒm
             
            </li>
            <li id ="feeVal">
              <label for="feeValue" id="feeName">PhÃ­ dá»‹ch vá»¥: </label>
              <input name ="feeValue" id="feeValue" class="validate[required] input price" value="${contract?.feeValue}"/> <span id ="feeValueType"></span>
            </li>
            <li id ="feeMax">
              <label for="maxFee">Max: </label>
              <input name ="maxFee" id="maxFee" class="validate[required] input price" value="${contract?.maxFee?contract?.maxFee:0}"/> <span id ="feeMaxType"></span>
            </li>
            <li id ="feeMin">
              <label for="minFee">Min: </label>
              <input name ="minFee" id="minFee" class="validate[required] input price" value="${contract?.minFee?contract?.minFee:0}"/> <span id ="feeMinType"></span>
            </li>

            <li>
              <label for="vatPercent">VAT: </label>
              <input name ="vatPercent" id="vatPercent" class="validate[required] input integer" value="${contract?.vatPercent?contract?.vatPercent:10}"/> %
            </li>
            <li>
              <label for="feeAccount">TÃ i khoáº£n phÃ­: </label>
              <input name ="feeAccount" id="feeAccount" class="validate[required] input integer readonly" value="${420201001 }"/>
            </li>
            <li>
              <label for="dateStart">NgÃ y hiá»‡u lá»±c: </label>
              <input class="date validate[required]" readOnly="readonly" name ="dateStart" id="dateStart" value="${contract?.dateStart?DateUtil.formatDate(contract.dateStart):''}" />
            </li>
            <li>
              <label for="dateEnd">NgÃ y káº¿t thÃºc: </label>
              <input class="date validate[required]" readOnly="readonly" name ="dateEnd" id="dateEnd" value="${contract?.dateEnd?DateUtil.formatDate(contract.dateEnd):''}" />
            </li>
             <li>
              <label for="schedule">Äáº·t lá»‹ch: </label>
              <input type="radio" name ="schedule" id="scheduleType1" class="validate[required] float-left radio-input" value="1" ${contract?.schedule?.scheduleType==1?'checked="true"':''}/><span class="float-left margin-right-20">Theo chu ká»³</span>
              <input type="radio" name ="schedule" id="scheduleType2" value="2" class="float-left radio-input" ${contract?.schedule?.scheduleType==2?'checked="true"':''}/>Chá»n ngÃ y

            </li>
             <li id="setInterval">
              <label for="intervalDate">Chu ká»³: </label>
              <input name ="intervalDate" id="intervalDate" class="input integer validate[required]" value="${contract?.schedule?.intervalDate}"/> ngÃ y
            </li>
            <div id="setDateDiv">
              <g:if test="${contract!=null}">
                <g:if test="${contract?.schedule?.scheduleDates?.size() == 0}">
                <li id="runDate_1" class="uncreatedDate">
                   <label for="executionDate_1">NgÃ y thá»±c hiá»‡n 1: </label>
                  <input class="date validate[required] groupDate" readOnly="readonly" name ="executionDate_1" id="executionDate_1" value="" />
                  <g:if test="${SecurityService.hasRole([SecurityService.ROLE_TELLER]) && (contract?.status==0 || contract?.status==200 || !(contract))}">
                        <a class="deleteDate deleteUncreatedDate  set-edit" tid="1" title="XÃ³a ngÃ y" href="#body"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.png')}" height="15" alt="" /></a>
                  </g:if>
                  
                </li>
                </g:if>
                <g:else>
                  <g:each in="${contract?.schedule?.scheduleDates}" var="d" status="t">
                    <li id="runDate_${t+1}" class="createdDate">
                   <label for="executionDate_${t+1}">NgÃ y thá»±c hiá»‡n ${t+1}: </label>
                      <input class="date validate[required] groupDate" readOnly="readonly" name ="executionDate_${t+1}" id="executionDate_${t+1}" value="${DateUtil.formatDate(d.runDate)}" />
                      <g:if test="${SecurityService.hasRole([SecurityService.ROLE_TELLER]) && (contract?.status==0 || contract?.status==200 || !(contract))}">
                        <a class="deleteDate set-edit" tid="" title="XÃ³a ngÃ y" href="${createLink(controller:'contract',action:'viewContract',params:[deleteDateId:d.id,deleteDate:'a',contractId:contract.id])}"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.png')}" height="15" alt="" /></a>
                      </g:if>
                    </li>
                    <input type ="hidden" value ="${d.id}" name="executionDateId_${t+1}">
                  </g:each>


                </g:else>
              </g:if>
              <g:else>
                 <li id="runDate_1" class="uncreatedDate">
                   <label for="executionDate_1">NgÃ y thá»±c hiá»‡n 1: </label>
                  <input class="date validate[required] groupDate" readOnly="readonly" name ="executionDate_1" id="executionDate_1" value="" />
                   <g:if test="${SecurityService.hasRole([SecurityService.ROLE_TELLER]) && (contract?.status==0 || contract?.status==200 || !(contract))}">
                        <a class="deleteDate deleteUncreatedDate  set-edit" tid="1" title="XÃ³a ngÃ y" href="#body"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.png')}" height="15" alt="" /></a>
                  </g:if>
                </li>
              </g:else>
                <g:if test="${(contract?.status==0 || contract?.status==200 || !(contract)) && SecurityService.hasRole([SecurityService.ROLE_TELLER])}">
                  <li>
                    <label >&nbsp;</label>
                    <input type="button" value="ThÃªm ngÃ y thá»±c hiá»‡n" name="addRunDate"/>

                  </li>
                </g:if>
            
              
            </div>

          </ol>          
          <g:if test="${(((contract?.status==0 || contract?.status==200) && (contract?ContractService.checkProcessingContract(contract) == 0:true)) || !(contract)) && SecurityService.hasRole([SecurityService.ROLE_TELLER])}">
           <button class="float-left blue awesome" id ="save" name="save">LÆ°u há»£p Ä‘á»“ng</button>
           <g:hiddenField name="save"/>
           <g:if test="${contract?.dateStart <= today && contract?.dateEnd >= (today-1)}">
           <button class="float-left blue awesome" id ="proceed" name="proceed">Gá»­i há»£p Ä‘á»“ng Ä‘áº¿n KSV Ä‘á»ƒ phÃª duyá»‡t</button>
           </g:if>
           <g:hiddenField name="proceed"/>
           <button class="float-left red awesome" id ="delete" name="delete">Há»§y bá» há»£p Ä‘á»“ng</button>
           <g:hiddenField name="delete"/>
           </g:if>
          <g:if test="${SecurityService.hasRole([SecurityService.ROLE_SUPERVISOR]) && contract?.status==100}">
            <button class="float-left blue awesome" id ="approve" name="approve">PhÃª duyá»‡t há»£p Ä‘á»“ng</button>
           <g:hiddenField name="approve"/>
           <button class="float-left red awesome" id ="deny" name="deny">Tá»« chá»‘i há»£p Ä‘á»“ng</button>
           <g:hiddenField name="deny"/>           
          </g:if>
        </fieldset>

      
      </g:form>
      <h3 align="center" class ="blue"><span id="processingSpan"> Äang phÃª duyá»‡t <img alt="loading..." src="${resource(dir:'images',file:'bar_spinner.gif')}"/>
        </span></h3>

      <g:if test="${Lot.findAllByContractAndStatusGreaterThan(contract,0)}">
       <g:each in="${Lot.findAllByContractAndStatusGreaterThan(contract,0)}" var="p" status="i">
         <% def transCount = 0
           def transAmount = 0
           def transFee = 0
           %>
        <fieldset class="form">
          <legend>Danh sÃ¡ch lÃ´ trong há»£p Ä‘á»“ng</legend>          
          <g:if test="${SecurityService.hasRole([SecurityService.ROLE_TELLER])&& (contract?.status==0 || contract?.status==200) && (p.status < 2) }">
            <a class="deleteLot set-edit float-right" title="XÃ³a lÃ´" href="${createLink(controller:'contract',action:'viewContract',params:[deleteLotId:p.id,deleteLot:'a',contractId:contract.id])}"> <img  border="0" src="${resource(dir:'images',file:'icon_delete.png')}" height="15" alt="" /></a>
          </g:if>
          NgÃ y táº¡o: <g:formatDate format="dd/MM/yyyy" date="${p.dateCreated}"/>
          <br>
          <br>

        <table class="">
           <thead>
	          <tr>
	            <th class ="center" width="20%">Sá»‘ TK</th>
                    <th class ="center" width="10%">TÃªn</th>
	            <th class ="center" width="15%">Sá»‘ tiá»n</th>
	            <th class ="center" width="10%">Ná»™i dung</th>
                    <th class ="center" width="10%">PhÃ­ dá»‹ch vá»¥</th>
                    <th class ="center" width="10%">PhÃ­ VAT</th>
                    <th class ="center" width="10%">Tráº¡ng thÃ¡i</th>

                   

	          </tr>
	   </thead>
              <tbody>

	        <g:each in="${p.transactions}" var="k" status="t">
                <%
                 k.each{
                     transCount ++
                     transAmount = transAmount + it.debitAmount.toLong()
                     transFee = transFee + it.serviceFee.toLong() + it.vatFee.toLong()
                   }
                 
                  %>
	        <tr>
                   
                  <g:if test ="${k.status >= 0 && k.status != 100}">
                    <g:form controller="contract" action="processTransaction" name="processForm_${k.id}" id="processForm_${k.id}">
                    <input name="transactionId" type="hidden" class="authTransaction" value="${k.id}"/>                    
                    </g:form>
                  </g:if>                
                  <td class ="center">${k.debitAccount}</td>
                  <td class ="center">${k.customerName}</td>
                  <td class ="center"><g:formatNumber number="${k.debitAmount}" format="#,###" /></td>
                  <td class ="center">${k.comments}</td>                 
                  <td class ="center"><g:formatNumber number="${k.serviceFee}" format="#,###" /></td>
                  <td class ="center"><g:formatNumber number="${k.vatFee}" format="#,###" /></td>
                  <td class ="center ${k.status==100||k.status==0?'':'negative'}"><span value="s_${k.id}"><g:message code="status${k.status}"/></span> </td>
                </tr>
                  </g:each>

	        

        </table>        
          
          <div>
          <span class="float-left e-xxl">Tá»•ng sá»‘ mÃ³n: ${transCount}</span>
          <span class="float-left e-xxl" >Tá»•ng tiá»n: <g:formatNumber number="${transAmount}" format="#,###" /> ${contract.curType}</span>
          <span class="float-left e-xxl" >Tá»•ng phÃ­: <g:formatNumber number="${transFee}" format="#,###" /> ${contract.curType}</span>
        </div>
        </fieldset>
         </g:each>
      </g:if>
      

      <g:if test="${(((contract?.status==0 || contract?.status==200) && (contract?ContractService.checkProcessingContract(contract) == 0:true)) || !(contract)) && SecurityService.hasRole([SecurityService.ROLE_TELLER])}">
          <g:form name="uploadForm" id="uploadForm" controller="contract" action="upload" method="post" enctype="multipart/form-data">
            <g:hiddenField name="contractId" value="${contract?.id}"/>
            <fieldset class="form">
              <legend>ThÃªm lÃ´ má»›i</legend>
              <ol>

                  <li>
                  <label for="file">Chá»n file</label>
                  <input type="file" name="file" id="file"/>
                  </li>
                  <li><label></label><a href="${resource(dir:'docs',file:'thuho.xls')}">Download file máº«u</a></li>
                  <input class="save" type="submit" value="Upload"/>

              </ol>
            </fieldset>
          </g:form>
      </g:if>

    </div>
      <script type="text/javascript">
     $("span[id=processingSpan]").hide();
     
    $(document).ready(function(){      
      var count =0;     
        $("#contractForm").validationEngine();
        $("#feeVal").hide();        
        $("#feeMax").hide();
        $("#feeMin").hide();
        $("#setInterval").hide();
        $("#setDateDiv").hide();
        showFee();
        checkAccType();
        checkSchedule();
        formatEndDate();
        formatStartDate();
        formatExecutionDate();
        if (${SecurityService.hasRole([SecurityService.ROLE_SUPERVISOR])}){
          $(".input").attr('readonly', 'readonly');
          $(".input").attr('readonly', 'readonly');
          $(".radio-input").attr('disabled', 'disabled');
        }

        $("input[name=feeType]").click(function() {           
          showFee();
        });

         $("input[name=schedule]").click(function() {
          checkSchedule();
        });


         $(".deleteLot").click(function(){
            var url = $(this).attr('href');
              jquery_confirm("XÃ¡c nháº­n","Báº¡n cÃ³ muá»‘n há»§y bá» lÃ´ nÃ y khÃ´ng?", function(){
              document.location = url;
          });
          return false;
          });

        $("button[name=save]").click(function(){          
//          var test = $("#dateStart").val();
//          var split = test.split("/");
//          alert (split[0]);
          if($("#contractForm").validationEngine({returnIsValid:true})){
          jquery_confirm("LÆ°u","Báº¡n Ä‘á»“ng Ã½ lÆ°u há»£p Ä‘á»“ng nÃ y?",
                      function(){
                            $("#contractForm input[name=save]").val('Processing');
                            $("#contractForm").submit();
                            jquery_open_load_spinner();
                });
          }
          return false;
      });
      $("button[name=proceed]").click(function(){
          if($("#contractForm").validationEngine({returnIsValid:true})){
          jquery_confirm("Gá»­i","Báº¡n gá»­i há»£p Ä‘á»“ng Ä‘áº¿n KSV Ä‘á»ƒ phÃª duyá»‡t?",
                      function(){
                            $("#contractForm input[name=proceed]").val('Processing');
                            $("#contractForm").submit();
                            jquery_open_load_spinner();
                });
          }
          return false;
      });
      $("button[name=delete]").click(function(){
          if($("#contractForm").validationEngine({returnIsValid:true})){
          jquery_confirm("XÃ³a","Báº¡n Ä‘á»“ng Ã½ xÃ³a bá» há»£p Ä‘á»“ng nÃ y?",
                      function(){
                            $("#contractForm input[name=delete]").val('Processing');
                            $("#contractForm").submit();
                            jquery_open_load_spinner();
                });
          }
          return false;
      });

      $("button[name=approve]").click(function(){
          if($("#contractForm").validationEngine({returnIsValid:true})){
          jquery_confirm("PhÃª duyá»‡t","Báº¡n Ä‘á»“ng Ã½ phÃª duyá»‡t há»£p Ä‘á»“ng nÃ y?",
                      function(){
                            $("#contractForm input[name=approve]").val('Processing');
                            $("#contractForm").submit();
                            jquery_open_load_spinner();
                });
          }
          return false;
      });

      $("button[name=deny]").click(function(){
          if($("#contractForm").validationEngine({returnIsValid:true})){
          jquery_confirm("Tá»« chá»‘i","Báº¡n Ä‘á»“ng Ã½ tá»« chá»‘i há»£p Ä‘á»“ng nÃ y vÃ  gá»­i láº¡i cho GDV?",
                      function(){
                            $("#contractForm input[name=deny]").val('Processing');
                            $("#contractForm").submit();
                            jquery_open_load_spinner();
                });
          }
          return false;
      });
      
        $("input[name=addRunDate]").click(function(){
         
          count = $(".groupDate").length;
          $("#dateCount").val(count+1);
          $('#runDate_1').clone(true).insertAfter('#runDate_'+count).attr('id','runDate_'+(count+1));
          $('#runDate_'+(count+1)).find('input.date').removeClass('hasDatepicker').datepicker();
          $('#runDate_'+(count+1)).find("label").html('NgÃ y thá»±c hiá»‡n '+(count+1)+':');
          $('#runDate_'+(count+1)).find("label").attr('for','executionDate_'+(count+1));
          $('#runDate_'+(count+1)).find("input").val("");         

          $('#runDate_'+(count+1)).find("a").attr('href','#body');
          $('#runDate_'+(count+1)).find("a").attr('tid',count+1);
          $('#runDate_'+(count+1)).find("a").addClass('deleteUncreatedDate');
          $('#runDate_'+(count+1)).find("input.groupDate").attr('id','executionDate_'+(count+1));
          $('#runDate_'+(count+1)).find("input.groupDate").attr('name','executionDate_'+(count+1));
          $("#executionDate_"+(count+1)).removeClass('hasDatepicker');
          $("#executionDate_"+(count+1)).datepicker({ dateFormat: 'dd/mm/yy' });
          formatExecutionDate();

        });

     $("#dateStart").change(function(){
          formatStartDate();
          formatExecutionDate();
          
        });
      $("#dateEnd").change(function(){
          formatEndDate();
          formatExecutionDate();

        });

     $(".deleteDate").click(function(){        
        var dateCount = $(".groupDate").length;
        var dateId = Number($(this).attr('tid'))+1;
        if (dateCount > 1){
          $('#runDate_'+ (dateId -1)).remove();
          var temp;
          for(var i=dateId;i<=dateCount;i++){
            if(i == 1)
              temp = i;
            else
              temp = i - 1;

            $('#runDate_'+i).find("label").html('NgÃ y thá»±c hiá»‡n '+temp+':');
            $('#runDate_'+i).find('input.date').removeClass('hasDatepicker').datepicker();
            $('#runDate_'+i).find("label").attr('for','executionDate_'+temp);
            $('#runDate_'+i).find("a").attr('tid',temp);
            $('#runDate_'+i).find("input.groupDate").attr('id','executionDate_'+temp);
            $('#runDate_'+i).find("input.groupDate").attr('name','executionDate_'+temp);
            $('#runDate_'+i).attr('id','runDate_'+temp);

            $("#executionDate_"+temp).removeClass('hasDatepicker');
            $("#executionDate_"+temp).datepicker({ dateFormat: 'dd/mm/yy' });
            formatExecutionDate();



          }
          $("#dateCount").val($(".groupDate").length);
        }

      });

        $("input[name=lookUp]").click(function(){          
          $.get('${createLink(controller:'contract',action:'checkAccount')}',$("#contractForm").serialize(),function(data){
                   if(!data.ACNAME){
                     $("#accExample").html(data);
                     $("#customerName").val('');
                     $("#currencyType").val('');
                   }

                   else {
                     $("#accExample").html('<u>VÃ­ dá»¥:</u> 010-01-01-123456-7');
                     $("#customerName").val(data.ACNAME);
                     $("#currencyType").val(data.DDCTYP);
                   }
               
         });
        });
        
        $("#accType").change(function(){
          checkAccType();        
        });

        function formatEndDate(){
          var dateEnd = $("#dateEnd").val();
          var splitDate = dateEnd.split("/");
          dateEnd = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2];
          dateEnd = new Date(dateEnd);
          $("#dateStart").datepicker("destroy");
          $("#dateStart").datepicker({      maxDate: dateEnd,
                                            minDate: 'D',
                                          dateFormat: 'dd/mm/yy' });
          
        }
        function formatStartDate(){
          var dateStart = $("#dateStart").val();
          var splitDate = dateStart.split("/");
          dateStart = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2];
          dateStart = new Date(dateStart);
          $("#dateEnd").datepicker("destroy");
          $("#dateEnd").datepicker({      minDate: dateStart,
                                          dateFormat: 'dd/mm/yy' });
          
        }

        function formatExecutionDate(){
          var dateStart = $("#dateStart").val();
          var splitDate = dateStart.split("/");
          dateStart = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2];
          dateStart = new Date(dateStart);
          var dateEnd = $("#dateEnd").val();
          splitDate = dateEnd.split("/");
          dateEnd = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2];
          dateEnd = new Date(dateEnd);
          $(".groupDate").datepicker("destroy");
          $(".groupDate").datepicker({    maxDate: dateEnd,
                                          minDate: dateStart,
                                          dateFormat: 'dd/mm/yy' });
        }
        
        
        function checkAccType(){
          if($("#accType").val()=='GL'){
            $("#accNoGL").show();
            $("#curTypeGL").show();
            $("#curTypeCA").hide();
            $("#accNumberGL").addClass('validate[required]');
            $("#currencyType").removeClass('validate[required]');
            $("#accNumber").removeClass('validate[required]');
            $("#accNo").hide();
            $("input[name=customerName]").attr('readonly',false);
            $("input[name=currencyType]").attr('readonly',false);
            $("input[name=lookUp]").hide();
          }else{
            $("#accNoGL").hide();
            $("#curTypeGL").hide();
            $("#curTypeCA").show();
            $("#accNo").show();
            $("#currencyType").addClass('validate[required]');
            $("#accNumberGL").removeClass('validate[required]');
            $("#accNumber").addClass('validate[required]');
            $("input[name=accNumber]").attr('disabled', false);
            $("input[name=customerName]").attr('readonly',true);
            $("input[name=currencyType]").attr('readonly',true);
            $("input[name=lookUp]").show();
          }

        }

        function checkSchedule(){
          if ($("#scheduleType1").is(':checked')){
            $("#setInterval").show();
            $("#setDateDiv").hide();
            $(".groupDate").removeClass('validate[required]');
            $("#intervalDate").addClass('validate[required]');
            $("#intervalDate").addClass('validate[custom[onlyNumber]]');
          }
          if ($("#scheduleType2").is(':checked')){
            $("#setInterval").hide();
            $("#setDateDiv").show();
            $(".groupDate").addClass('validate[required]');
            $("#intervalDate").removeClass('validate[required]');
            $("#intervalDate").removeClass('validate[custom[onlyNumber]]');
          }

        }

        function showFee(){
           if ($("#feeType1").is(':checked')){
            $("#feeVal").show();
            $("#feeMax").hide();
            $("#feeMin").hide();
            $("#feeName").html('PhÃ­ dá»‹ch vá»¥:');
            $("#feeValueType").html('${contract?.curType}');
            $("#maxFee").removeClass('validate[required]');
            $("#minFee").removeClass('validate[required]');
          }
          if ($("#feeType2").is(':checked')){
              $("#feeVal").show();
              $("#feeMax").show();
              $("#feeMin").show();
              $("#feeMaxType").html('${contract?.curType}');
              $("#feeMinType").html('${contract?.curType}');
              $("#feeName").html('Pháº§n trÄƒm phÃ­ dá»‹ch vá»¥:');
              $("#feeValueType").html('%');
              $("#maxFee").addClass('validate[required]');
              $("#minFee").addClass('validate[required]');
          }
        }


        if (${contract==null}){
         $("#uploadForm").hide();
         $("#proceed").hide();
         $("#delete").hide();
        }
        else{
         $("#uploadForm").show();
          $("#proceed").show();
           $("#delete").show();
        }





    });

    $(document).ajaxError(function(){
      alert('Lá»—i há»‡ thá»‘ng. Xin vui lÃ²ng liÃªn há»‡ IT Service Desk Ä‘á»ƒ Ä‘Æ°á»£c trá»£ giÃºp.');
    });
    
    if(${isApproved == true}){
      var processing = false;
          $("span[id=processingSpan]").show();
          var intervalId = setInterval("processRequest()",1000);
          var reqCount = $(".authTransaction").length;
          function processRequest(){
              var r = $(".authTransaction:first");
              
              if(!r.val()){
                  clearInterval(intervalId);
                  $("span[id=processingSpan]").replaceWith("ÄÃ£ thá»±c hiá»‡n xong" + " " + reqCount + " " + "giao dá»‹ch");
              }

              else if(r && !processing){
                  processing = true;
                  var transId = r.val();
                  $("span[value=s_"+transId+"]").html('<img alt="loading..." src="${resource(dir:'images',file:'bar_spinner.gif')}"/>');
                  $.post('${createLink(controller:'contract',action:'processTransaction',params:[scheduleLogId:scheduleLog?.id,accNumber:contract?.accNumber])}',$("#processForm_"+ transId).serialize(),function (data){
                      processing = false;
                      $("span[value=s_"+transId+"]").html(data);
                      $("span[value=s_"+transId+"]").addClass("blue");
                      r.removeClass("authTransaction");
                  });
              }
          }
      }

    </script>    
  </body>

</html>
