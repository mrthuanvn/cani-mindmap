<?php
/*
 * Created on 2007-04-08
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( "../config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/RegistrationService.php" );
require_once( "simpletest/unit_tester.php" );

class RegistrationServiceTest extends UnitTestCase {

	private $service = null;

	function RegistrationServiceTest() {
		parent::__construct();
	}
	
	function setUp() {
		$this->service = new RegistrationService();
	}
	
}
 
?>
