angular.module("app").controller("ChatController", function($scope) {

	$scope.message = "";
	$scope.messageList = [];

	$scope.sendChat = function() {
		sendMessage("message", {
			message : $scope.message
		});
		$scope.message = "";
	}


	/**
	 * If a message is received, store it and trigger apply
	 */
	registerAction("received-message", function(data) {
		$scope.messageList.push({
			type : "message",
			from : data.name,
			content  :data.message
		});

		update();
	})

	/**
	 * If someone joins the channel, handle it here.
	 */
	registerAction("joined", function(data) {
		$scope.messageList.push({
			type : "success",
			content : data.name + " joined the chat!"
		});

		update();
	});


	registerAction("left", function(data) {
		$scope.messageList.push({
			type : "warning",
			content : data.name + " sadly left the chat."
		});
		update();
	});


	function update() {
		$scope.$digest();
		var chatlist = $('.chat-list');
		chatlist.scrollTop(chatlist.prop('scrollHeight'));
	}

});