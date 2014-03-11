(function($, undefined) {

	window.app = angular.module("app", []);

	$("body").bind("load-complete", function() {
		console.log($("#app > div:first")[0]);
		angular.bootstrap($("#app > div:first")[0], ['app']);
	});

})(jQuery);

