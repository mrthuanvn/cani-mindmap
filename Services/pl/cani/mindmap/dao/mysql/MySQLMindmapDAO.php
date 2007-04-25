<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

//require_once( "../../../mindmap_test/config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/base/Exception.inc" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/MindmapDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/db/Database.inc" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/db/Database_MySQL.inc" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/utils/DBUtils.php" );

class MySQLMindmapDAO implements MindmapDAO {

	private static $instance;
	
	private $mindmapsTbl;
	private $mindmapUsersTbl;
	
	private function MySQLMindmapDAO() {
		$this->mindmapsTbl = DBUtils::createTableName( "mindmaps" );
		$this->mindmapUsersTbl = DBUtils::createTableName( "mindmap_users" );
	}
	
	public static function getInstance() {
		if ( isset( $instance ) == false ) {
			$instance = new MySQLMindmapDAO();
		}
		return $instance;
	}

	/**
	 * @param MindmapVo mindmap
	 * @return int insert id
	 */
	public function addMindmap( MindmapVO $mindmap ) {
		$sql = sprintf( 
			"INSERT INTO %s ( `name`, `ownerId`, `requiresPassword`, `password` ) " .
			"VALUES ( '%s', %d, %d, '%s' )",
			$this->mindmapsTbl,
			$mindmap->name, $mindmap->owner->id, $mindmap->requiresPassword,
			$mindmap->password );
		
		$db = new CDB();
		$db->query( $sql );
		
		return $db->lastInsertId(); 		
	}
	
	/**
	 * @see pl.cani.mindmap.dao.MindmapDAO#getMindmapsByOwnerId
	 */
	public function getMindmapsByOwnerId( $ownerId ) {
		$mindmaps = array();
		
		$db = new CDB();
		$sql = sprintf( "SELECT * FROM %s WHERE ownerId = %d",
			$this->mindmapsTbl, $ownerId );

		$db->query( $sql );

		while ( $db->nextRecord() ) {
			$mindmap = MindmapVO::create( $db->record );
			array_push( $mindmaps, $mindmap );
		}
		
		return $mindmaps;
	}
	
	/**
	 * @see pl.cani.mindmap.dao.MindmapDAO#setPrivilagesForUser
	 */
	public function setPrivilagesForUser( $mindmapId, $userId, $privilages ) {
		$sql = sprintf( 
			"SELECT * FROM %s WHERE mindmapId = $mindmapId AND userId = $userId",
			$this->mindmapUsersTbl );
		
		$db = new CDB();
		$db->query( $sql );
	
		$sql = $db->nextRecord() 
			? sprintf( "UPDATE %s SET privilages = $privilages " .
					"WHERE mindmapId = $mindmapId AND userId = $userId", 
					$this->mindmapUsersTbl )
			: sprintf( "INSERT INTO %s ( mindmapId, userId, privilages ) " .
					"VALUES( $mindmapId, $userId, $privilages )", 
					$this->mindmapUsersTbl );
	
		$db->query( $sql );
	}

}

?>
