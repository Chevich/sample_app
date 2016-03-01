jQuery(document).ready(function(){

	$(".run").click(function(){
        $("#box").animate({opacity: "0.1", left: "+=400"}, 2200)
        .animate({opacity: "0.4", top: "+=160", height: "20", width: "20"}, "slow")
        .animate({opacity: "1", left: "0", height: "100", width: "100"}, "slow")
        .animate({top: "0"}, "fast")
        .slideUp()
        .slideDown("slow");
        return false;
	});

    $(".menu a").hover(function() {
    		$(this).next("em").stop(true,true).animate({opacity: "show", top: "-65"}, "slow");
    	}, function() {
    		$(this).next("em").stop(true,true).animate({opacity: "hide", top: "-85"}, "fast");
    	});

    $(".accordion h3:first").addClass("active");
    $(".accordion p:not(:first)").hide();

    $(".accordion h3").click(function(){
        $(this).next("p").slideToggle("fast")
            .siblings("p:visible").slideUp("slow");
        $(this).toggleClass("active");
        $(this).siblings("h3").removeClass("active");
    });

    $("h3.alert_tag").mousemove(function(){
      $("#box").animate({opacity: "0.1", left: "+=400"}, 2200);
    });
});