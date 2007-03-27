<?php

class UserDoesntExistException {

	public $email;

	function UserDoesntExistException( $email ) {
		$this->email = $email;
	}

}

?>