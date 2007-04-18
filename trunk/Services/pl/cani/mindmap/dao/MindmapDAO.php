<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/MindmapVO.php" );
 
interface MindmapDAO {

	/**
	 * @param MindmapVo mindmap
	 * @return Integer mindmap id
	 */
	public function addMindmap( MindmapVO $mindmap );
	
	/**
	 * @param Integer ownerId
	 * @return Array list of MindmapVO's
	 */
	public function getMindmapsByOwnerId( $ownerId );
	
}
 
?>
