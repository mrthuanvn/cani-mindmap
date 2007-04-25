<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( "../config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/MindmapService.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/business/MindmapPrivilages.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap_test/business/MockMindmapDAO.php" );

require_once( "simpletest/unit_tester.php" );

class MindmapServiceTest extends UnitTestCase {

	private $service = null;
	
	private $testUserId;
	private $testMindmapId;

	function MindmapServiceTest() {
		parent::__construct();
	}

	function setUp() {
		$this->service = new MindmapService();
		$mindmapDao = new MockMindmapDAO();
		$mindmapDao->mindmaps = $this->createMindmaps();
		$this->service->setMindmapDAO( $mindmapDao );
		
		$this->createTestUser();
		$this->createTestMindmap();
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
	
	public function testSetPrivilagesForUser() {
		$mindmap = new MindmapVO();
		$mindmap->id = $this->testMindmapId;
		
		$user = new UserVO();
		$user->id = $this->testUserId;
		
		$privilages = MindmapPrivilages::READ;

		$this->service->setMindmapDAO( MySQLMindmapDAO::getInstance() );		
		$this->service->setPrivilagesForUser( $mindmap, $user, $privilages );
		
		$db = new CDB();
		$mindmapUsersTbl = DBUtils::createTableName( "mindmap_users" );
		$sql = "SELECT * FROM $mindmapUsersTbl WHERE mindmapId = $mindmap->id " .
				"AND userId = $user->id";
		$db->query( $sql );
		$db->nextRecord();
		
		$this->assertEqual( $privilages, $db->record[ "privilages" ] );
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
	
	private function createTestUser() {
		$db = new CDB();
		$usersTbl = DBUtils::createTableName( "users" );
		$sql = "SELECT * FROM $usersTbl WHERE forname = 'test' AND surname = 'test'";
		$db->query( $sql );
		if ( $db->nextRecord() ) {
			$this->testUserId = $db->record[ "id" ];
			return;
		}
		
		$password = md5( "testpass" );
		$sql = "INSERT INTO $usersTbl ( forname, surname, email, password, isActive ) " .
				"VALUES ( 'test', 'test', 'test@test.pl', '$password', 1 )";
		$db->query( $sql );
		$this->testUserId = $db->lastInsertId();
	}
	
	private function createTestMindmap() {
		$db = new CDB();
		$mindmapsTbl = DBUtils::createTableName( "mindmaps" );
		$sql = "SELECT * FROM $mindmapsTbl WHERE name = 'test mindmap'";
		$db->query( $sql );
		if ( $db->nextRecord() ) {
			$this->testMindmapId = $db->record[ "id" ];
			return;
		}
		
		$sql = "INSERT INTO $mindmapsTbl ( name, ownerId ) " .
				"VALUES ( 'test', 1 )";
		$db->query( $sql );
		$this->testMindmapId = $db->lastInsertId();
	}

}

?>
