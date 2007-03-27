<?php

class UserNotFoundException extends Exception {

	public $email;

	function UserNotFoundException( $email ) {
		$this->email = $email;
	}

}

?>
