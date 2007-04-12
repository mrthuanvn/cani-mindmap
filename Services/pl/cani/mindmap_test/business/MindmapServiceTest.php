<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( "../config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/MindmapService.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap_test/business/MockMindmapDAO.php" );

require_once( "simpletest/unit_tester.php" );

class MindmapServiceTest extends UnitTestCase {

	private $service = null;

	function MindmapServiceTest() {
		parent::__construct();
	}

	function setUp() {
		$this->service = new MindmapService();
		$mindmapDao = new MockMindmapDAO();
		$mindmapDao->mindmaps = $this->createMindmaps();
		$this->service->setMindmapDAO( $mindmapDao );
	}

	public function testAddMindmap() {
		$mindmap = new MindmapVO();
//		$mindmap->name = "test mindmap";
//		$owner = new UserVO();
//		$owner->id = 1;
//		$owner->forname = "mietek";
//		$owner->surname = "kraweznik";
//		$mindmap->owner = $owner;
		
		$expectedId = 1;
		$actualId = $this->service->addMindmap( $mindmap );
		
		$this->assertEqual( $expectedId, $actualId );
	}
	
	private function createMindmaps() {
		$mindmaps = array();
		return $mindmaps;
	}

}

?>
