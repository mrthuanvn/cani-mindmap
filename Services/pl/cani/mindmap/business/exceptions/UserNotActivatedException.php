<?php

class UserNotActivatedException {

	public $email;
	public $activationKey;

	function UserNotActivatedException( $email, $activationKey ) {
		$this->email = $email;
		$this->activationKey = $activationKey;
	}

}

?>
