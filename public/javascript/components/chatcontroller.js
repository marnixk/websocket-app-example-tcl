angular.module("app").controller("ChatController", function($scope) {


	_.extend($scope, {

		memberList : {},
		message : "",
		messageList : [],

		/**
		 * Sends a chat message over the websocket
		 */
		sendChat : function() {
			sendMessage("message", { message : $scope.message });
			$scope.message = "";
		},

		/**
		 * New content is available, make sure the list is updated and we 
		 * scroll the textarea down.
		 */
		update : function() {
			$scope.$digest();

			var chatlist = $('.chat-list');
			chatlist.scrollTop(chatlist.prop('scrollHeight'));
		}
	});


	// setup remote watch on 'members' variable
	observe("members", $scope, "memberlist");

	/**
	 * If a message is received, store it and trigger apply
	 */
	registerAction("received-message", function(data) {
		$scope.messageList.push({
			type : "message",
			from : data.name,
			content  :data.message
		});

		$scope.update();
	})

	/**
	 * If someone joins the channel, handle it here.
	 */
	registerAction("joined", function(data) {
		$scope.messageList.push({
			type : "success",
			content : data.name + " joined the chat!"
		});

		$scope.update();
	});


	registerAction("left", function(data) {
		$scope.messageList.push({
			type : "warning",
			content : data.name + " sadly left the chat."
		});
		$scope.update();
	});

});