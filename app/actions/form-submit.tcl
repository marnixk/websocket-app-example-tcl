namespace eval Action::formsubmit {

	variable validate {
		nickname: required, min 3, max 16
		name: required, min 3
		email: email
		password: required, min 8
		confirmpassword: required, equals "password" "The passwords do not match"
		gender: required, options {male female}
		birthday: required, date
		accept: required, options { true }
		groupies: required, number
	}


	proc on-message {chan message} { 
		app'load-page $chan "nickname"
	}

}