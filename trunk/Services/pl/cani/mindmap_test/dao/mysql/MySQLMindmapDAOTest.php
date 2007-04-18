<?php
/*
 * Created on 2007-04-13
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */
 
require_once( "../../config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/mysql/MySQLMindmapDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/UserVO.php" );

require_once( "simpletest/unit_tester.php" );

class MySQLMindmapDAOTest extends UnitTestCase {

	private $dao;
	
	private $testUserId = 72;

	function MySQLMindmapDAOTest() {
		parent::__construct();
	}
	
	function setUp() {
		$this->dao = MySQLMindmapDAO::getInstance();
//		$this->populateDB();
	}
	
	public function testAddMindmap() {
		$mindmap = new MindmapVO();
		$mindmap->name = "test mindmap";
		$mindmap->requiresPassword = true;
		$mindmap->password = md5( "pass" );
		$owner = new UserVO();
		$owner->id = 1;
		$mindmap->owner = $owner;
		
		$mindmapId = $this->dao->addMindmap( $mindmap );
		
		$this->assertNotNull( $mindmapId );
		
		$db = new CDB();
		$mindmapTbl = DBUtils::createTableName( "mindmaps" );
		$sql = "SELECT * FROM $mindmapTbl WHERE id = $mindmapId";
		$db->query( $sql );
		if ( $db->nextRecord() ) {
			$this->assertEqual( $mindmap->name, $db->record[ "name" ] );
			$this->assertEqual( $mindmap->requiresPassword, $db->record[ "requiresPassword" ] );
			$this->assertEqual( $mindmap->password, $db->record[ "password" ] );
			$this->assertEqual( $mindmap->owner->id, $db->record[ "ownerId" ] );
			
			$sql = "DELETE FROM $mindmapTbl WHERE id = $mindmapId";
			$db->query( $sql );
		} else {
			$this->fail( "Mindmap not added" );
		}
	}
	
	public function testGetMindmapsByOwnerId() {
		$expectedMindmaps = array();
		
		$expectedMindmap1 = new MindmapVO();
		$expectedMindmap1->name = "test mindmap 1";
		array_push( $expectedMindmaps, $expectedMindmap1 );
		
		$expectedMindmap2 = new MindmapVO();
		$expectedMindmap2->name = "test mindmap 2";
		array_push( $expectedMindmaps, $expectedMindmap2 );
		
		$actualMindmaps = $this->dao->getMindmapsByOwnerId( $this->testUserId );

		for ( $i = 0; $i < sizeof( $actualMindmaps ); $i++ ) {
			$actualMindmap = $actualMindmaps[ $i ];
			$expectedMindmap = $expectedMindmaps[ $i ];
			$this->assertEqual( $expectedMindmap->name, $actualMindmap->name, 
				"mindmap $i" );
		}
	}

	function tearDown() {
//		$this->cleanDB();
	}
	
	private function populateDB() {
		$db = new CDB();
		$usersTbl = DBUtils::createTableName( "users" );
		$mindmapsTbl = DBUtils::createTableName( "mindmaps" );
		
		// adding test user
		$sql = "INSERT INTO $usersTbl ( forname ) VALUES ( 'test user' )";
		$db->query( $sql );
		
		$this->testUserId = $db->lastInsertId();
		
		// adding test mindmaps
		$sql = "INSERT INTO $mindmapsTbl ( name, ownerId, requiresPassword, password ) " .
				"VALUES ( '%s', %d, %d, '%s' )";
		$db->query( sprintf( $sql, "test mindmap 1", $this->testUserId, 
			1, md5( "testpass" ) ) );
		$db->query( sprintf( $sql, "test mindmap 2", $this->testUserId, 
			0, "" ) );
	}

	private function cleanDB() {
		$db = new CDB();
		$usersTbl = DBUtils::createTableName( "users" );
		$mindmapsTbl = DBUtils::createTableName( "mindmaps" );
		
		$db->query( "DELETE FROM $usersTbl WHERE id = " . $this->testUserId );
		$db->query( "DELETE FROM $mindmapsTbl WHERE ownerId = " . $this->testUserId );
	}

}
 
?>
