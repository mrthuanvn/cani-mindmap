<?php
/*
 * Created on 2007-04-20
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */

require_once( "../../config_test.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/dao/mysql/MySQLUserDAO.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/UserVO.php" );

require_once( "simpletest/unit_tester.php" );

class MySQLUserDAOTest extends UnitTestCase {

	private $dao;
	
	function MySQLUserDAOTest() {
		parent::__construct();		
	}
	
	function setUp() {
		$this->dao = MySQLUserDAO::getInstance();
//		$this->populateDB();
	}
	
	public function testFindUsersByFornameSurnameOrEmail() {
		$this->dao->usersTbl = DBUtils::createTableName( "test_users" );		
		
		$queryStr = "jan";
		$expectedUsers = $this->createExpectedUsersForJan();
		$actualUsers = $this->dao->findUsersByFornameSurnameOrEmail( $queryStr );
		for ( $i = 0; $i < sizeof( $expectedUsers ); $i++ ) {
			$expectedUser = $expectedUsers[ $i ];
			$actualUser = $actualUsers[ $i ];
			$this->assertEqual( $expectedUser->forname, $actualUser->forname, "user $i" );
			$this->assertEqual( $expectedUser->surname, $actualUser->surname, "user $i" );
			$this->assertEqual( $expectedUser->email, $actualUser->email, "user $i" );
		}
		
		$queryStr = "janek";
		$expectedUsers = $this->createExpectedUsersForJanek();
		$actualUsers = $this->dao->findUsersByFornameSurnameOrEmail( $queryStr );
		for ( $i = 0; $i < sizeof( $expectedUsers ); $i++ ) {
			$expectedUser = $expectedUsers[ $i ];
			$actualUser = $actualUsers[ $i ];
			$this->assertEqual( $expectedUser->forname, $actualUser->forname, "user $i" );
			$this->assertEqual( $expectedUser->surname, $actualUser->surname, "user $i" );
			$this->assertEqual( $expectedUser->email, $actualUser->email, "user $i" );
		}
	}
	
	private function createExpectedUsersForJan() {
		$users = array();
		
		$user1 = new UserVO();
		$user1->forname = "Jan";
		$user1->surname = "Kowalski";
		$user1->email = "jan@kowalski.pl";
		array_push( $users, $user1 );
		
		$user2 = new UserVO();
		$user2->forname = "Janek";
		$user2->surname = "Franek";
		$user2->email = "janek@franek.pl";
		array_push( $users, $user2 );
		
		$user3 = new UserVO();
		$user3->forname = "Janusz";
		$user3->surname = "Duszczyk";
		$user3->email = "janusz@duszczyk.pl";
		array_push( $users, $user3 );
		
		$user4 = new UserVO();
		$user4->forname = "Staszek";
		$user4->surname = "Kowalski";
		$user4->email = "staszek@janek.pl";
		array_push( $users, $user4 );
		
		return $users;
	}
	
	private function createExpectedUsersForJanek() {
		$users = array();
		
		$user2 = new UserVO();
		$user2->forname = "Janek";
		$user2->surname = "Franek";
		$user2->email = "janek@franek.pl";
		array_push( $users, $user2 );
		
		$user4 = new UserVO();
		$user4->forname = "Staszek";
		$user4->surname = "Kowalski";
		$user4->email = "staszek@janek.pl";
		array_push( $users, $user4 );
		
		return $users;
	}
	
	private function populateDB() {
		$db = new CDB();
	
		$usersTbl = DBUtils::createTableName( "test_users" );

		$sql = "INSERT INTO $usersTbl ( forname, surname, email )" .
				"VALUES ( '%s', '%s', '%s' )";
				
		$db->query( sprintf( $sql, "Jan", "Kowalski", "jan@kowalski.pl" ) );
		$db->query( sprintf( $sql, "Janek", "Franek", "janek@franek.pl" ) );
		$db->query( sprintf( $sql, "Janusz", "Duszczyk", "janusz@duszczyk.pl" ) );
		$db->query( sprintf( $sql, "Staszek", "Kowalski", "staszek@janek.pl" ) );		
	}

}

?>
