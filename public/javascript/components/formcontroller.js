/**
 * form submit controller example that helps us make sure the form stuff works
 */
angular.module("app").controller("FormSubmitController", function($scope) {

	_.extend($scope, {

		form : {
			nickname : "mxck",
			name : "Marnix",
			email: "marnixkok@gmail.com",
			password: "asdf",
			confirmpassword: "asdf",
			birthday : "1984-12-30",
			gender: "unknown"
		},

		submitValues : function() {

			sendMessage("formsubmit", $scope.form, function(data) {
				if (data.state == "error") {
					$scope.distributeErrors(data.errors);
				} else {
					console.log("Done!");
					loadPage("nickname");
				}
			});
		},

		/**
		 * Put the errors at the correct form fields.
		 */
		distributeErrors : function(errors) {
			$("body .form-group .error-feedback").remove();

			_.each(errors, function(err, key) {
				var group = $("body [name='" + err.name + "']").closest(".form-group");

				var inline = $("<span />");
				inline
					.toggleClass("error-feedback", true)
					.text(err.message);

				group.append(inline);
			});
		}

	});

});