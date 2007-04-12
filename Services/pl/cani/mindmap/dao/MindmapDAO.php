<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/MindmapVO.php" );
 
interface MindmapDAO {

	public function addMindmap( MindmapVO $mindmap );
	
}
 
?>
