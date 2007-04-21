<?php

interface UserDAO {

	public function findByEmail( $email );
	
	public function findByActivationKey( $activationKey );
	
	public function findUsersByFornameSurnameOrEmail( $queryStr );
	
	public function addUser( UserVO $user );
	
}

?>