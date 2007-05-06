package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.adobe.cairngorm.view.ViewLocator;
	import com.mikenimer.components.Debug;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.events.CollectionEvent;
	import mx.events.DataGridEvent;
	import mx.events.DragEvent;
	import mx.events.ListEvent;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceBundle;
	
	import pl.cani.mindmap.business.SessionAndPersitentData;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.model.AppModelLocator;
	import pl.cani.mindmap.model.Mindmap;
	import pl.cani.mindmap.model.MindmapPrivilages;
	import pl.cani.mindmap.model.MindmapUserPair;
	import pl.cani.mindmap.view.ManagementPanel;
	import pl.cani.mindmap.view.PrivilagesWindow;
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;
	import com.adobe.crypto.MD5;

	public class ManagementPanelHelper extends ViewHelper {
		
		private var concreteView : ManagementPanel;
		
		[ResourceBundle( "ManagementPanel" )]
		private var rb : ResourceBundle;
		
		public function ManagementPanelHelper( view : ManagementPanel )	{
			super();
			this.view = this.concreteView = view;
			
			CairngormEventDispatcher.getInstance().addEventListener(
				MindmapEvent.ADDED, onMindmapAdded );
				
			CairngormEventDispatcher.getInstance().addEventListener(
				MindmapEvent.MINDMAP_USERS_FOUND, onMindmapUsersFound );
				
			CairngormEventDispatcher.getInstance().addEventListener(
				MindmapEvent.MINDMAPS_FOUND, onMindmapsFound );
		}
		
		public function createMindmap() : void {
			var mindmap : MindmapVO = new MindmapVO();
			mindmap.name = concreteView.mindmapNameTxt.text;
			mindmap.owner = SessionAndPersitentData.getInstance().getLoggedInUser();
			mindmap.requiresPassword = concreteView.requiresPasswordCheckBox.selected;
			mindmap.password = MD5.hash( concreteView.passwordTxt.text );
			
			var mindmapEvent : MindmapEvent 
				= new MindmapEvent( MindmapEvent.ADD, mindmap );
				
			concreteView.addMindmapBtn.currentState = "disabled";
				
			CairngormEventDispatcher.getInstance().dispatchEvent( mindmapEvent );
		}
		
		public function getSelectedMindmap() : MindmapVO {
			return concreteView.mindmapsCbx.selectedItem as MindmapVO;
		}
		
		private function onMindmapAdded( event : MindmapEvent ) : void {
			concreteView.addMindmapBtn.currentState = "";
		}
		
		public function findMindmapUsers( mindmapVO : MindmapVO ) : void {
			var mindmapEvent : MindmapEvent = new MindmapEvent( 
				MindmapEvent.FIND_MINDMAP_USERS );
				
			AppModelLocator.getInstance().mindmap.mindmapVO =
				mindmapEvent.mindmap = mindmapVO;
				
			mindmapEvent.dispatch();
		}
		
		private function onMindmapUsersFound( event : MindmapEvent ) : void {
			concreteView.mindmapUsersDataGrid.dataProvider
				= event.mindmapUserPairs;
		}
		
		public function findMindmaps() : void {
			var mindmapEvent : MindmapEvent 
				= new MindmapEvent( MindmapEvent.GET_BY_OWNER_ID );
				
			var userId : uint = SessionAndPersitentData.getInstance()
				.getLoggedInUser().id;
			mindmapEvent.ownerId = userId;

			CairngormEventDispatcher.getInstance().dispatchEvent( mindmapEvent );
		}
		
		private function onMindmapsFound( event : MindmapEvent ) : void {
			CairngormEventDispatcher.getInstance().removeEventListener(
				MindmapEvent.MINDMAPS_FOUND, onMindmapsFound );
			
			var firstMindmapVO : MindmapVO = event.mindmaps[ 0 ];
			AppModelLocator.getInstance().selectedMindmap = firstMindmapVO;
			
			var mindmap : Mindmap = new Mindmap( firstMindmapVO );
			AppModelLocator.getInstance().mindmap = mindmap;
			
			findMindmapUsers( firstMindmapVO );
			getMindmapStructure( firstMindmapVO );
		}
		
		public function convertToPairs( users : Array ) : Array {
			var pairs : Array = new Array();

			var mindmap : MindmapVO = getSelectedMindmap();

			for ( var i : uint = 0; i < users.length; i++ ) {
				var user : UserVO = users[ i ] as UserVO;

				var pair : MindmapUserPair = new MindmapUserPair( mindmap, user,
					MindmapPrivilages.READ );

				pairs.push( pair );
			}

			return pairs;
		}
		
		public function getMindmapUsersDataGrid() : DataGrid {
			return concreteView.mindmapUsersDataGrid;
		}
		
		public function popUpPrivilagesWindow( event : DragEvent ) : void {
			var privilagesWindow : PrivilagesWindow = new PrivilagesWindow();

			var pairs : Array = convertToPairs( 
					event.dragSource.dataForFormat( "items" ) as Array );

			privilagesWindow.dataProvider = pairs;
			event.dragSource.addData( pairs, "items" );

			PopUpManager.addPopUp( privilagesWindow, 
				AppModelLocator.getInstance().mainView, true );
			PopUpManager.centerPopUp( privilagesWindow );
			
			var privilagesHelper : PrivilagesPanelHelper 
				= ViewLocator.getInstance().getViewHelper( ViewNames.PRIVILAGES )
				as PrivilagesPanelHelper;
				
			privilagesHelper.resetInfo();
		}
		
		public function deleteSelectedUser() : void {
			var selectedIndex : uint 
				= concreteView.mindmapUsersDataGrid.selectedIndex;

			ArrayCollection( concreteView.mindmapUsersDataGrid.dataProvider )
			.removeItemAt( selectedIndex );
		}
		
		public function getMindmapStructure( mindmapVO : MindmapVO ) : void {
			var event : MindmapEvent = new MindmapEvent(
				MindmapEvent.GET_MINDMAP_STRUCTURE );
			event.mindmap = mindmapVO;
			event.dispatch();
		}

		public function loadMindmapData( event : ListEvent ) : void {
			var mindmapVO : MindmapVO = event.target.selectedItem as MindmapVO;
			findMindmapUsers( mindmapVO );
			getMindmapStructure( mindmapVO );
		}
		
	}

}