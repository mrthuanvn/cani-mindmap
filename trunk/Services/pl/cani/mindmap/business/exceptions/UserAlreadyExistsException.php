<?php

class UserAlreadyExistsException {

	public $user;
	public $message;

	function UserAlreadyExistsException( $message, $user ) {
		$this->message = $message;
		$this->user = $user;
	}

}

?>
