<%@ page import="comboboxList" %>

<ol class="form form-clear error-form" style="margin-top:-15px;">
    <%def today = new Date();
    today.setMonth(today.month-1);
    %>
    <li>
		<table class="tableControlCenter" style="border:0px !important;margin-top: 20px !important">
				<tr style="border:0px ;">
					<td style ="border:0px"><label for="donvi1" class=" lableTableCenter">NHCD/Khối nhập <%--<font color="red">*</font> --%></label></td>
		        	<td style ="border:0px"><label for="donvi2" class=" lableTableCenter">Đơn vị nhập <%--<font color="red">*</font> --%></label></td>
		        	<td style ="border:0px"><label for="usernhapDsBL" class=" lableTableCenter">User nhập <%--<font color="red">*</font> --%></label></td>

    			

		        	<td style ="border:0px"><label for="loaiDsBL" class=" lableTableCenter">Loại blacklist  </label></td>    			

		    	</tr>
		    	<tr style="border:0px ;">
        			<td style ="border:0px">	
        			<sec:ifAllGranted roles="ROLE_GDTT_LEVEL3">
	   						<g:select style="width:190px;margin-right: 20px"  name="donvi1" from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0  order by e.code+0')}"
	   						disabled="true"
							value="${params.donvi1}" 
							optionKey="id" optionValue="${{it.code +' - '+it.name }}" noSelection="${['':'']}" />							   
							</sec:ifAllGranted>
        					
        					
        					</td>
        			<td style ="border:0px">
        					<g:select name="donvi2" id="donvi2" style="width: 190px;margin-right: 20px"
                                           from="${UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')}" 
                                           value="${params.donvi2}"
                                           optionKey="id" optionValue="${{it.code+'-'+it.name }}" noSelection="${['':'']}"
                                          />
        			</td>
        			<td style ="border:0px">
        				<input  type="text" style="width: 180px;margin-right: 20px" id="usernhapDsBL" value="${usernhapDsBL}" name="usernhapDsBL" >
        			</td>
        		<td td style ="border:0px">	
        			<select name="loaiDsBL" style="width:190px" class = "controlTableCenter validate[required]">
					<option value="1" ${loaiDsBL=='1'?'selected="true"':'' }>1- Cá nhân</option>
					<option value="2" ${loaiDsBL=='2'?'selected="true"':'' }>2- Pháp nhân</option>
					<option value="3" ${loaiDsBL=='3'?'selected="true"':'' }>3- TSBĐ</option>				  
				</select>
				</td>
    			</tr>
		</table>
    </li>
    <li>
        <table class="tableControlCenter" style="border:0px !important">
				<tr style="border:0px; padding-top: 20px">

		 

		        	<td style ="border:0px"><label for="fromDate" class=" lableTableCenter">Từ ngày nhâp/cập nhật </label></td>
		        	<td style ="border:0px"><label for="toDate" class=" lableTableCenter">Đến ngày nhập/cập nhật </label></td>
		        	<td style ="border:0px"><label for="phanloaiDsBl" class=" lableTableCenter">Phân loại đối tượng  </label></td>    			

		    	</tr>
		    	<tr style="border:0px ;">
        			<td style ="border:0px"><input style="margin-right: 20px;" type= "text" id = "fromDate" name="fromDate" readonly="readonly" class = "controlTableCenter datetime validate[required]"
        												value="${params.fromDate?params.fromDate:DateUtil.formatDate(today) }"/></td>
        			<td style ="border:0px"><input style="margin-right: 20px"  type= "text"  id = "toDate" name="toDate" readonly="readonly" class = "controlTableCenter datetime validate[required]"
        												value="${params.toDate?params.toDate:DateUtil.formatDate(new Date()) }"/></td>
        			<td style ="border:0px"><g:select style="width:190px;margin-right: 23px;" name="phanloaiDsBl" id="phanloaiDsBl" 
																	from="${BlacklistObject.executeQuery('from BlacklistObject ts where ts.status>=0 order by ts.code+0') }" 
																	optionKey="id" 
																	optionValue="${{it.code+'-'+it.name}}"
																	value="${phanloaiDsBl}" 
																	}"/></td>
        			
        			
        			<td style ="border:0px">
        			<sec:ifAnyGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
					   	<label class="error-label-left">
					   	<g:submitButton class="searchButtons btn primary" style="margin-left:10px;margin-top:-5px;width:190px" name="search" value="Tra cứu Blacklist" /></label>
					   	</sec:ifAnyGranted>
        			</td>
    			</tr>
		</table>
    </li>
</ol>
<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			set_side_bar(true); // ẩn hiển thanh menu trái

		});
		</script>