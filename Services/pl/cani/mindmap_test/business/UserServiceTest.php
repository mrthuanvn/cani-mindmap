<?php
/*
 * Created on 2007-04-20
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( "../config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/UserService.php" );

require_once( "simpletest/unit_tester.php" );

class UserServiceTest extends UnitTestCase {

	private $service;

	function UserServiceTest() {
		parent::__construct();
	}
	
	function setUp() {
		$this->service = new UserService();
	}
	
	public function testFindUsers() {
		
	}

}

?>
