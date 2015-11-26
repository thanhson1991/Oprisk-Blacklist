<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <ckeditor:resources />
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
      ${currentInstance.risk.name}
      <form method="post" name="evaluationForm" id="evaluationForm" action="evaluateForm">
        Đánh giá ảnh hưởng
        <table>
          <thead>
            <tr>
              <th>Hướng dẫn</th>              
              <th>Chọn</th>
            </tr>

          </thead>
           <tbody>             
            <g:each in="${impacts}" var ="i" status="k">
              <tr>
              <td class="description${i.id}" > ${i.description} </td>
              <td><input type="radio" name="getImpact" value="${i.id}" ${currentInstance.impact==i?'checked':'' } /></td>
              </tr>
            </g:each>

            </tbody>
        </table>
        Khả năng xảy ra
         <table>
          <thead>
            <tr>
              <th>Hướng dẫn</th>
              <th>Chọn</th>
            </tr>

          </thead>
           <tbody>
            <g:each in="${possibilities}" var ="i" status="k">
              <tr>
              <td class="description${i.id}" > ${i.description} </td>
              <td><input type="radio" name="getPossibility" value="${i.id}" ${currentInstance.possibility==i?'checked':'' } /></td>
              </tr>
            </g:each>

            </tbody>
        </table>
        Đánh giá hiệu quả kiểm soát
         <table>
          <thead>
            <tr>
              <th>Hướng dẫn</th>
              <th>Chọn</th>
            </tr>

          </thead>
           <tbody>
            <g:each in="${controlEffects}" var ="i" status="k">
              <tr>
              <td class="description${i.id}" > ${i.description} </td>
              <td><input type="radio" name="getControlEffect" value="${i.id}" ${currentInstance.controlEffect==i?'checked':'' } /></td>
              </tr>
            </g:each>

            </tbody>
        </table>

        Kiểm soát :
        ${currentInstance.risk.control}
                <br>
        <span class="float-left"><ckeditor:editor height="250"  width="400" name="control" id="control"  toolbar="Basic"> ${currentInstance.control}</ckeditor:editor></span>


        <br clear="both">
        <input type="hidden" name="processId" value="${process?.id}"/>
        <input type="hidden" name="instanceId" value="${currentInstance?.id}"/>
        <input type="submit" name="saveInstance" id="saveInstance" value="Tiếp tục"/>

      </form>
    </div>



    <script type="text/javascript">

    </script>

  </body>
</html>