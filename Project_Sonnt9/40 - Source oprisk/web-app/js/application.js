function jquery_alert_default_error(){
	jquery_alert('Lỗi hệ thống','Xin vui lòng liên hệ IT Service Desk để được hổ trợ thêm.');
}

var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
	  onCreate: function() {
        if($('spinner') && Ajax.activeRequestCount>0)
          Effect.Appear('spinner',{duration:0.5,queue:'end'});
	  },
	  onComplete: function() {
        if($('spinner') && Ajax.activeRequestCount==0)
          Effect.Fade('spinner',{duration:0.5,queue:'end'});
	  }
	});
}

var JQUERY4U = {}
JQUERY4U.UTIL = {
    /*
    *   Utility function used to make anchor links animate smoothly instead of jumping.
    */
    smoothAnchor: function (anchorClass)
    {
        $('a.'+anchorClass).click(function () {
            elementClick = $(this).attr("href")
            destination = $(elementClick).offset().top;
            $("html:not(:animated),body:not(:animated)").animate({ scrollTop: destination}, 1100 );
            return false;
        })
    }
}
 