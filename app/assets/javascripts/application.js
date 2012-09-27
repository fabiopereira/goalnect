// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require bootstrap-wysihtml5-all


(function($) {
$.fn.serializeFormJSON = function() {

   var o = {};
   var a = this.serializeArray();
   $.each(a, function() {
       if (o[this.name]) {
           if (!o[this.name].push) {
               o[this.name] = [o[this.name]];
           }
           o[this.name].push(this.value || '');
       } else {
           o[this.name] = this.value || '';
       }
   });
   return o;
};
})(jQuery);

setVideoFrame = function () {
    $('#fade').css('display','block');
    $('#lightBoxContent').append('<iframe id="video_frame" src="http://player.vimeo.com/video/29110208?title=0&amp;byline=0&amp;portrait=0" width="640" height="385" frameborder="0"></iframe>');
    $('#lightbox').css('display','block');
    
}

setImageFlow = function (){
    $('#fade').css('display','block');
    $('#lightBoxContent').append('<img src="/assets/goalnect.home.flow.png" id="goalnectFlow" width="800" height="600" ></img>');
    $('#lightbox').css('display','block');
    
}

$('.submittable').click(function() {
  $(this).parents('form:first').submit();
});

(function($){
	
	$.extend({
			 
		smoothAnchors : function(speed, easing, redirect){
				
			speed = speed || "fast";
			easing = easing || null;
			redirect = (redirect === true || redirect == null) ? true : false;
			
			$("a").each(function(i){
							
				var url = $(this).attr("href");
				
				if(url){
					if(url.indexOf("#") != -1 && url.indexOf("#") == 0){
		
						var aParts = url.split("#",2);
						var anchor = $("a[name='"+aParts[1]+"']");
						
						if(anchor){
																					
							$(this).click(function(){
												   
								if($(document).height()-anchor.offset().top >= $(window).height()
								 || anchor.offset().top > $(window).height()
								 || $(document).width()-anchor.offset().left >= $(window).width()
								 || anchor.offset().left > $(window).width()){
												   
									$('html, body').animate({
										scrollTop: anchor.offset().top - 90,
										scrollLeft: anchor.offset().left
									}, speed, easing, function(){
										if(redirect){ 
											window.location = url 
										}
									});
								
								}
								
								return false;
																
							});
						}
					
					}
					
				}
				
			});
			
		}
	
	});
	
})(jQuery);

;(function(d){var k=d.scrollTo=function(a,i,e){d(window).scrollTo(a,i,e)};k.defaults={axis:'xy',duration:parseFloat(d.fn.jquery)>=1.3?0:1};k.window=function(a){return d(window)._scrollable()};d.fn._scrollable=function(){return this.map(function(){var a=this,i=!a.nodeName||d.inArray(a.nodeName.toLowerCase(),['iframe','#document','html','body'])!=-1;if(!i)return a;var e=(a.contentWindow||a).document||a.ownerDocument||a;return d.browser.safari||e.compatMode=='BackCompat'?e.body:e.documentElement})};d.fn.scrollTo=function(n,j,b){if(typeof j=='object'){b=j;j=0}if(typeof b=='function')b={onAfter:b};if(n=='max')n=9e9;b=d.extend({},k.defaults,b);j=j||b.speed||b.duration;b.queue=b.queue&&b.axis.length>1;if(b.queue)j/=2;b.offset=p(b.offset);b.over=p(b.over);return this._scrollable().each(function(){var q=this,r=d(q),f=n,s,g={},u=r.is('html,body');switch(typeof f){case'number':case'string':if(/^([+-]=)?\d+(\.\d+)?(px|%)?$/.test(f)){f=p(f);break}f=d(f,this);case'object':if(f.is||f.style)s=(f=d(f)).offset()}d.each(b.axis.split(''),function(a,i){var e=i=='x'?'Left':'Top',h=e.toLowerCase(),c='scroll'+e,l=q[c],m=k.max(q,i);if(s){g[c]=s[h]+(u?0:l-r.offset()[h]);if(b.margin){g[c]-=parseInt(f.css('margin'+e))||0;g[c]-=parseInt(f.css('border'+e+'Width'))||0}g[c]+=b.offset[h]||0;if(b.over[h])g[c]+=f[i=='x'?'width':'height']()*b.over[h]}else{var o=f[h];g[c]=o.slice&&o.slice(-1)=='%'?parseFloat(o)/100*m:o}if(/^\d+$/.test(g[c]))g[c]=g[c]<=0?0:Math.min(g[c],m);if(!a&&b.queue){if(l!=g[c])t(b.onAfterFirst);delete g[c]}});t(b.onAfter);function t(a){r.animate(g,j,b.easing,a&&function(){a.call(this,n,b)})}}).end()};k.max=function(a,i){var e=i=='x'?'Width':'Height',h='scroll'+e;if(!d(a).is('html,body'))return a[h]-d(a)[e.toLowerCase()]();var c='client'+e,l=a.ownerDocument.documentElement,m=a.ownerDocument.body;return Math.max(l[h],m[h])-Math.min(l[c],m[c])};function p(a){return typeof a=='object'?a:{top:a,left:a}}})(jQuery);


