package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.mikenimer.components.Debug;
	
	import mx.controls.Alert;
	import mx.events.DataGridEvent;
	import mx.events.ListEvent;
	import mx.resources.ResourceBundle;
	
	import pl.cani.mindmap.business.SessionAndPersitentData;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.view.ManagementPanel;
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;
	import pl.cani.mindmap.model.MindmapUserPair;
	import pl.cani.mindmap.model.MindmapPrivilages;
	import pl.cani.mindmap.model.AppModelLocator;
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.controls.DataGrid;

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
			
			var mindmapEvent : MindmapEvent 
				= new MindmapEvent( MindmapEvent.ADD, mindmap );
				
			concreteView.createMindMapBtn.enabled = false;
			concreteView.createMindMapBtn.label = rb.getString( "addingMindmap" );
				
			CairngormEventDispatcher.getInstance().dispatchEvent( mindmapEvent );
		}
		
		public function getSelectedMindmap() : MindmapVO {
			return concreteView.mindmapsCbx.selectedItem as MindmapVO;
		}
		
		private function onMindmapAdded( event : MindmapEvent ) : void {
			concreteView.createMindMapBtn.enabled = true;
			concreteView.createMindMapBtn.label = rb.getString( "saveMindmap" );
		}
		
		public function findMindmapUsers( event : ListEvent ) : void {
			var mindmapEvent : MindmapEvent = new MindmapEvent( 
				MindmapEvent.FIND_MINDMAP_USERS );
				
			AppModelLocator.getInstance().selectedMindmap =
				mindmapEvent.mindmap = event.currentTarget.selectedItem;
			
			CairngormEventDispatcher.getInstance().dispatchEvent( mindmapEvent );
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
			
			var mindmapEvent : MindmapEvent = new MindmapEvent( 
				MindmapEvent.FIND_MINDMAP_USERS );
				
			AppModelLocator.getInstance().selectedMindmap =
				mindmapEvent.mindmap = event.mindmaps[ 0 ];
			
			CairngormEventDispatcher.getInstance().dispatchEvent( mindmapEvent );
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
		
	}

}