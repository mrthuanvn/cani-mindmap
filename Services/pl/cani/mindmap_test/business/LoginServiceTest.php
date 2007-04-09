<?php
/*
 * Created on 2007-04-08
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( "../config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/LoginService.php" );
require_once( "simpletest/unit_tester.php" );

class LoginServiceTest extends UnitTestCase {

	private $service = null;

	function LoginServiceTest() {
		parent::__construct();
	}
	
	function setUp() {
		$this->service = new LoginService();
	}
	
	public function testLoginUser() {
		$email = "test@test.pl";
		$password = md5( "testpass" );
		
		$user = $this->service->loginUser( $email, $password );
		$this->assertTrue( $user instanceof UserVO );
	}
	
	public function testLoginUserWrongPassword() {
		$email = "test@test.pl";
		$password = "testpass";
		
		$result = $this->service->loginUser( $email, $password );
		$this->assertTrue( $result instanceof WrongPasswordException );
	}
	
	public function testLoginUserDoesntExist() {
		$email = "testosteron@test.pl";
		$password = "testpass";
		
		$result = $this->service->loginUser( $email, $password );
		$this->assertTrue( $result instanceof UserDoesntExistException );
	}
	
	public function testLoginUserNotActive() {
		$email = "not@active.pl";
		$password = "testpass";
		
		$result = $this->service->loginUser( $email, $password );
		$this->assertTrue( $result instanceof UserNotActivatedException );
	}

}
 
?>
