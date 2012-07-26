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