package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.view.ViewHelper;
	import pl.cani.mindmap.view.ManagementPanel;

	public class ManagementPanelHelper extends ViewHelper {
		
		private var concreteView : ManagementPanel;
		
		public function ManagementPanelHelper( view : ManagementPanel )	{
			super();
			this.view = this.concreteView = view;
		}
		
		public function createMindmap() : void {
			
		}
		
	}
}