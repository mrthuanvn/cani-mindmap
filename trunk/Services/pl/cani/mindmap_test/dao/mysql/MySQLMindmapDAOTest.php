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

	function MySQLMindmapDAOTest() {
		parent::__construct();
	}
	
	function setUp() {
		$this->dao = MySQLMindmapDAO::getInstance();
		$this->populateDB();
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

	function tearDown() {
		$this->cleanDB();
	}
	
	private function populateDB() {
		
	}

	private function cleanDB() {
		
	}

}
 
?>
