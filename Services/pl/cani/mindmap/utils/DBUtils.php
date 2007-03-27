<?php
/*
 * Created on 2006-11-23
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
global $g_config;
require_once( WebOrbServicesPath . "pl/cani/mindmap/config.php" );
 
class DBUtils {

	function createTableName( $tableName ) {
		global $g_config;
		return $g_config[ "dbPrefix" ] . $tableName; 
	}

}
 
?>
