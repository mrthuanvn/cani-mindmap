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

}

?>
