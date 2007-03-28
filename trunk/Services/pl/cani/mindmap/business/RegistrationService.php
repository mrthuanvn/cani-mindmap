<?php

//define( "WebOrbServicesPath", "C:\\Program Files\\xampp\\htdocs\\Services\\" );

require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/UserVO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/UserDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/mysql/MySQLUserDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/UserNotFoundException.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/exceptions/UserAlreadyExistsException.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/EmailService.php" );

class RegistrationService {

	function RegistrationService() {
		
	}
	
	public function registerUser( $user ) {
		$userDao = MySQLUserDAO::getInstance();
		try {
			$userDao->findByEmail( $user->email );
			return new UserAlreadyExistsException( "User already exists", $user );
		} catch ( UserNotFoundException $e ) {
			// TODO: wlaczyc wysylanie maili na serwerze
//			EmailService::sendActivationEmail( $user );
			$userId = $userDao->addUser( $user );
			return $userId;
		}
	}
	
	public function activateUser( $activationKey ) {
		$userDao = MySQLUserDAO::getInstance();
		try {
			$user = $userDao->findByActivationKey( $activationKey );
			$user->isActive = true;
			$userDao->acivateUser( $user->id );
			
			return $user;
		} catch ( UserNotFoundException $e ) {
			return false;
		}
	}
	
}

//$rs = new RegistrationService();
//
//$user = new UserVO();
//$user->forname = "test";
//$user->surname = "user";
//$user->email = "test@test.pl";
//$user->password = "testpass";
//$user->isActive = false;
//$user->activationKey = "activationKey";
//
//$user->id = $rs->registerUser( $user );
//print $user->id;
//
//$userDao = MySQLUserDAO::getInstance();
//$userDao->removeUser( $user->id );

?>
