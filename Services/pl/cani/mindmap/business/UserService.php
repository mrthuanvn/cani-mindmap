<?php
/*
 * Created on 2007-04-20
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/UserDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/mysql/MySQLUserDAO.php" );

class UserService {

	private $userDAO;

	function UserService() {
		$this->userDAO = MySQLUserDAO::getInstance(); 
	}
	
	/**
	 * @param String queryStr
	 * @return Array list of users matching the <code>queryStr</code>
	 */
	public function findUsers( $queryStr ) {
		return $this->userDAO->findUsersByFornameSurnameOrEmail( $queryStr );
	}
	
	public function setUserDAO( UserDAO $userDAO ) {
		$this->userDAO = $userDAO;
	}

}

?>
