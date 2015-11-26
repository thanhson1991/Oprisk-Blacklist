<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Tự đánh giá rủi ro</title>
  </head>
  <body>

    <div id="m-melanin-tab-header">
      <g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
                model="${[items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
                        [href:createLink(controller:'admin',action:'viewDepartment'),title:'Tự đánh giá rủi ro',label:'Tự đánh giá rủi ro']]
                        ]}"/>

      <div class="clear"></div>
    </div>
    <!--		<div id="m-melanin-left-sidebar">
			<ul class="m-melanin-vertical-navigation">
				<li>
					<span class=" ss_sprite ss_arrow_branch">&nbsp;</span>
					<a id="m-melanin-vertical-navigation-vertical" href="${createLink(controller:'hierarchy',action:'vertical')}" class="m-melanin-vertical-navigation-link">Cơ cấu hàng dọc</a>
				</li>
				<li class="active">
					<span class=" ss_sprite ss_arrow_switch">&nbsp;</span>
					<a id="m-melanin-vertical-navigation-horizontal" href="${createLink(controller:'hierarchy',action:'horizontal')}" class="m-melanin-vertical-navigation-link">Cơ cấu hàng ngang</a>
				</li>
			</ul>
		</div>-->
    <div id="m-melanin-main-content">
      <form method="post" name="evaluationForm" id="evaluationForm" action="createEvaluationProcess">
        <table>
          <thead>
            <tr>
              <th>Phân loại</th>
              <th>STT</th>
              <th>Hiện tượng rủi ro hoạt động</th>
              <th>Chọn</th>
            </tr>

          </thead>
           <tbody>
             <%def flag= false%>
             <%def parentId=0%>
            <g:each in="${risks}" var ="i" status="k">

                <tr>
                <g:if test="${parentId != i.parent.parent.id}">
                  <%
                  def parent = Risk.get(i.parent.parent.id)
                  def count = Risk.countByStatusGreaterThanEqualsAndParentInList(0,parent.children)%>
                  <td rowspan="${count}">${i.parent.parent.name}</td>
                  <%parentId=i.parent.parent.id%>
                </g:if>


              <td class="description${i.id}" > ${k+1} </td>
              <td class="score${i.id}">${i.name}</td>
              <td><input type="checkbox" name="getRisk" value="${i.id}" ${(chosenRisks.risk.id.contains(i.id))?'checked':''}/></td>
              </tr>
            </g:each>

            </tbody>
        </table>
        <input type="hidden" name="processId" value="${process?.id}"/>
        <input type="submit" name="submitBtn" id="submitBtn" value="Tiếp tục"/>

      </form>
    </div>



    <script type="text/javascript">
			
    </script>

  </body>
</html>