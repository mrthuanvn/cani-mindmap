<?php

interface UserDAO {

	public function findByEmail( $email );
	
	public function findByActivationKey( $activationKey );
	
	public function addUser( $user );
	
}

?>