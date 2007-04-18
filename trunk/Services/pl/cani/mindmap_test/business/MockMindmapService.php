<?php
/*
 * Created on 2007-04-13
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

class MockMindmapService {

	function MockMindmapService() {
		
	}
	
	public function addMindmap( MindmapVO $mindmap ) {
		return 1;
	}
	
	public function getMindmapsByOwnerId( $ownerId ) {
		return $this->createMindmaps();
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
