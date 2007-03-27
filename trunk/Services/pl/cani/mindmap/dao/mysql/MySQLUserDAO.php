<?php

//require_once( "../../config.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/db/Database.inc" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/UserDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/UserVO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/utils/DBUtils.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/utils/ActivationKey.php" );

class MySQLUserDAO implements UserDAO {
	
	private $users = array();

	private $instance;
	
	private $usersTbl;
	
	private function MySQLUserDAO() {
//		$this->users = $this->createUsers();
		$this->usersTbl = DBUtils::createTableName( "users" );
	}
	
	public static function getInstance() {
		if ( isset( $instance ) == false ) {
			$instance = new MySQLUserDAO();
		}
		return $instance;
	}
	
	function findByEmail( $email ) {
		$result = null;
		
		$sql = sprintf( "SELECT * FROM %s WHERE email = '%s'", 
				$this->usersTbl, $email );
				
		$db = new CDB();
		$db->query( $sql );
		if ( $db->nextRecord() ) {
			$result = $this->createUserFromRecord( $db->record );
		} else {
			throw new UserNotFoundException( $email );
		}
		
		return $result;
	}
	
	public function findByActivationKey( $activationKey ) {
		$sql = sprintf( "SELECT * FROM %s WHERE activationKey = '%s'",
				$this->usersTbl, $activationKey );
		$db = new CDB();
		$db->query( $sql );
		if ( $db->nextRecord() ) {
			$user = $this->createUserFromRecord( $db->record );
			return $user;
		} else {
			throw new UserNotFoundException();
		}
	}
	
	public function acivateUser( $id ) {
		$sql = sprintf( "UPDATE %s SET isActive = 1, activationKey = '' " .
				"WHERE id = %d", 
				$this->usersTbl, $id );
		$db = new CDB();
		$db->query( $sql );
	}
	
	public function addUser( $user ) {
		if ( ( $user instanceof UserVO ) == false ) {
			throw new Exception( "it's not an instance of UserVO" );
		}
		$activationKey = ActivationKey::generate( $user );
		$sql = sprintf( "INSERT INTO %s ( forname, surname, email, password, " .
				"isActive, activationKey ) " .
				"VALUES ( '%s', '%s', '%s', '%s', %d, '%s' )", 
				$this->usersTbl, $user->forname, $user->surname, $user->email, 
				md5( $user->password ), 0, $activationKey );
		
		$db = new CDB();
		$db->query( $sql );
		
		return $db->lastInsertId();
	}
	
	public function removeUser( $id ) {
		$sql = sprintf( "DELETE FORM %s WHERE id = %d",
				$this->usersTbl, $id );
		$db = new CDB();
		$db->query( $sql );
	}
	
	private function createUserFromRecord( $record ) {
		$user = new UserVO();
		
		$user->id = $record[ "id" ];
		$user->forname = $record[ "forname" ];
		$user->surname = $record[ "surname" ];
		$user->email = $record[ "email" ];
		$user->password = $record[ "password" ];
		$user->isActive = $record[ "isActive" ] == 1;
		$user->activationKey = $record[ "activationKey" ];
		
		return $user;
	}
	
	private function createUsers() {
		$users = array();
		
//		$db =& MDB2::connect( "mysql://root@localhost/test" );
//		
//		$res =& $db->query( "SELECT * FROM users" );
//		while ( $row = $res->fetchRow() ) {
//			$user = new User();
//			$user->id = $row[ "id" ];
//			$user->login = $row[ "login" ];
//			$user->password = $row[ "password" ];
//			
//			array_push( $users, $user );
//		}

		$db = new CDB();
		$sql = "SELECT * FROM users";
		$db->query( $sql );
		while ( $db->nextRecord() ) {
			$user = new User();
			$user->id = $db->record[ "id" ];
			$user->login = $db->record[ "login" ];
			$user->password = $db->record[ "password" ];
			
			array_push( $users, $user );
		}
		
		return $users;
	}
	
}


?>