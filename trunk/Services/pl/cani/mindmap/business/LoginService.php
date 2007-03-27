<?php

//define( "WebOrbServicesPath", "C:\\Program Files\\xampp\\htdocs\\Services\\" );

require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/UserVO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/exceptions/WrongPasswordException.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/exceptions/UserDoesntExistException.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/exceptions/UserNotActivatedException.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/UserDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/mysql/MySQLUserDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/UserNotFoundException.php" );


class LoginService {

	function LoginService() {
		
	}
	
	public function loginUser( $email, $password ) {
		$userDao = MySQLUserDAO::getInstance();
		try {
			$user = $userDao->findByEmail( $email );
			if ( $user->isActive == false ) {
				return new UserNotActivatedException( $email, $user->activationKey );
			} else if ( $user->password == $password ) {
				return $user;
			} else {
				return new WrongPasswordException( $password );
			}
		} catch ( UserNotFoundException $e ) {
			return new UserDoesntExistException( $email );
		}
	}

}

//$service = new LoginService();
//$result = $service->loginUser( "van_jan@o2.pl", "dsa" );
//print_r( get_object_vars( $result ) );

?>
