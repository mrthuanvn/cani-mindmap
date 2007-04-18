<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

//require_once( "../../mindmap_test/config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/mysql/MySQLMindmapDAO.php" );

class MindmapService {

	/**
	 * @var MindmapDAO mindmap dao
	 */
	private $mindmapDao;

	function MindmapService() {
		$this->mindmapDao = MySQLMindmapDAO::getInstance();
	}
	
	public function addMindmap( MindmapVO $mindmap ) {
		return $this->mindmapDao->addMindmap( $mindmap );
	}
	
	/**
	 * @param Integer ownerId
	 * @return Array list of MindmapVO's
	 */
	public function getMindmapsByOwnerId( $ownerId ) {
		return $this->mindmapDao->getMindmapsByOwnerId( $ownerId );
	}
	
	public function setMindmapDAO( MindmapDAO $mindmapDao ) {
		$this->mindmapDao = $mindmapDao;
	}

}

?>
