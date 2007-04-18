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
		
		$expectedId = sizeof( $this->createMindmaps() ) + 1;
		$actualId = $this->service->addMindmap( $mindmap );
		
		$this->assertEqual( $expectedId, $actualId );
	}
	
	public function testGetMindmapsByOwnerId() {
		$ownerId = 1;
		$expectedMindmaps = $this->createMindmaps();
		
		$actualMindmaps = $this->service->getMindmapsByOwnerId( $ownerId );
		
		for ( $i = 0; $i < sizeof( $actualMindmaps ); $i++ ) {
			$actualMindmap = $actualMindmaps[ $i ];
			$expectedMindmap = $expectedMindmaps[ $i ];
			$this->assertEqual( $expectedMindmap->name, $actualMindmap->name, 
				"mindmap $i" );
		}
	}
	
	private function createMindmaps() {
		$mindmaps = array();
		
		$owner = new UserVO();
		$owner->id = 1;
		
		$mindmap1 = new MindmapVO();
		$mindmap1->name = "test mindmap 1";
		$mindmap1->owner = $owner;
		array_push( $mindmaps, $mindmap1 );
		
		$mindmap2 = new MindmapVO();
		$mindmap2->owner = $owner;
		$mindmap2->name = "test mindmap 2";
		array_push( $mindmaps, $mindmap2 );
		
		return $mindmaps;
	}

}

?>
