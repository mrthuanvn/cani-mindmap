<?php

class WrongPasswordException {

	public $password;

	function WrongPasswordException( $password ) {
		$this->password = $password;
	}

}

?>
