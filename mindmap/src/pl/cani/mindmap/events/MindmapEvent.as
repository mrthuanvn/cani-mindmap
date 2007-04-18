package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import pl.cani.mindmap.vo.MindmapVO;

	public class MindmapEvent extends CairngormEvent {
		
		public static const ADD : String = "add";
		
		public var mindmap : MindmapVO;

		
		public function MindmapEvent( type : String, mindmap : MindmapVO ) {
			super( type );
			this.mindmap = mindmap;
		}
		
	}
}