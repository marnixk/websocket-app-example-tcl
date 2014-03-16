angular.module("app").controller("NickNameController", function($scope) {

	$scope.nickname = "";

	$scope.enterChat = function() {
		if (_.str.trim($scope.nickname) !== "") {
			sendMessage("set-nickname", {
				name: $scope.nickname
			}, function() {
				loadPage("chat");
			});
		}
		else {
			alert("Please fill out a proper nickname");
		}
	};


});