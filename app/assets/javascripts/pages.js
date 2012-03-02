jQuery(document).ready(function(){

	$(".run").click(function(){
        $("#box").animate({opacity: "0.1", left: "+=400"}, 2200)
        .animate({opacity: "0.4", top: "+=160", height: "20", width: "20"}, "slow")
        .animate({opacity: "1", left: "0", height: "100", width: "100"}, "slow")
        .animate({top: "0"}, "fast")
        .slideUp()
        .slideDown("slow")
        return true;
	});
});