   <ol class="form form-clear">
         <li>
            <%def today = new Date();
            today.setMonth(today.month-12);
            %>
            <label class="label-left" for="fromDate">Từ ngày:</label>
            <label class="label-left" style="float:none" for="toDate">Đến ngày:</label>
            <label for="departments" style="float:none" class="label-left">Loại nghiệp vụ:</label>
          </li>
          <li>
            <label class="label-left"><input name="fromDate" id="fromDate" class="e-m datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/></label>
            <label class="label-left"><input name="toDate" id="toDate" class="e-m datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/></label>
            <label class="label-left"><g:select class="se-xl" name="department" id="department" from="${departments}" optionKey="id" optionValue="name" value="${departmentId}" noSelection="${['':'Tất cả']}"/></label>
            <g:submitButton class="searchButtons btn primary" name="search" value="Xem" />
          </li>

   </ol>