(function($, undefined) {

	window.app = angular.module("app", []);

	$("body").bind("load-complete", function() {
		angular.bootstrap($("#app > div:first")[0], ['app']);
	});

})(jQuery);

