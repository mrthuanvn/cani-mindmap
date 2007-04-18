package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	
	import mx.controls.Alert;
	
	import pl.cani.mindmap.business.SessionAndPersitentData;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.view.ManagementPanel;
	import pl.cani.mindmap.vo.MindmapVO;

	public class ManagementPanelHelper extends ViewHelper {
		
		private var concreteView : ManagementPanel;
		
		public function ManagementPanelHelper( view : ManagementPanel )	{
			super();
			this.view = this.concreteView = view;
		}
		
		public function createMindmap() : void {
			var mindmap : MindmapVO = new MindmapVO();
			mindmap.name = concreteView.mindmapNameTxt.text;
			mindmap.owner = SessionAndPersitentData.getInstance().getLoggedInUser();
			
			var mindmapEvent : MindmapEvent 
				= new MindmapEvent( MindmapEvent.ADD, mindmap );
				
			CairngormEventDispatcher.getInstance().dispatchEvent( mindmapEvent );
		}
		
	}
}