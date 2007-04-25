<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

//require_once( "../../mindmap_test/config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/mysql/MySQLMindmapDAO.php" );

require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/MindmapVO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/UserVO.php" );

class MindmapService {

	/**
	 * @var MindmapDAO mindmap data access object
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
	
	/**
	 * @param MindmapVO mindmap
	 * @param UserVO user
	 * @param Integer prirvilages defined as MindmapPrivilages constants
	 */
	public function setPrivilagesForUser( MindmapVO $mindmap, UserVO $user, 
		$privilages ) {
		
		$this->mindmapDao->setPrivilagesForUser( $mindmap->id, $user->id, 
			$privilages );
	}
	
	public function setMindmapDAO( MindmapDAO $mindmapDao ) {
		$this->mindmapDao = $mindmapDao;
	}

}

?>
