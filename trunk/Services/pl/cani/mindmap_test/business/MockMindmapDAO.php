<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( "../config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/MindmapDAO.php" );
//require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/MindmapVO.php" );

class MockMindmapDAO implements MindmapDAO {

	public $mindmaps = array();

	function MockMindmapDAO() {
		
	}
	
	public function addMindmap( MindmapVO $mindmap ) {
		array_push( $this->mindmaps, $mindmap );
		return sizeof( $this->mindmaps );
	}
	
	public function getMindmapsByOwnerId( $ownerId ) {
		return $this->mindmaps;
	}

}

//$dao = new MockMindmapDAO();
//print $dao->addMindmap( new MindmapVO() );

?>
