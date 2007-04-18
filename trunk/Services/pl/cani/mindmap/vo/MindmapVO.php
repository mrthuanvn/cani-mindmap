<?php
/*
 * Created on 2007-04-12
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

class MindmapVO {

	public $id;
	public $name;
	
	/**
	 * @var bool requires password
	 */
	public $requiresPassword;
	
	/**
	 * @var string hashed (md5) password
	 */
	public $password;

	/**
	 * @var UserVO mindmap owner
	 */
	public $owner;

	function MindmapVO() {
		
	}
	
	/**
	 * Factory methd
	 * @param Array array array of values to populate new object
	 * @return MindmapVO new object
	 */
	public static function create( Array $array ) {
		$mindmap = new MindmapVO();
		$mindmap->id = $array[ "id" ];
		$mindmap->name = $array[ "name" ];
		$mindmap->requiresPssword = $array[ "requiresPassword" ];
		$mindmap->password = $array[ "password" ];
		return $mindmap;
	}

}

?>
