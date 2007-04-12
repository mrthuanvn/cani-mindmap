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
	
	public function setMindmapDAO( MindmapDAO $mindmapDao ) {
		$this->mindmapDao = $mindmapDao;
	}

}

?>
