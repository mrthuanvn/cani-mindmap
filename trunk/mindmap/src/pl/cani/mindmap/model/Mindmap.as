package pl.cani.mindmap.model {

	import pl.cani.mindmap.vo.MindmapVO;
	
	[Bindable]
	public class Mindmap {
		
		public var mindmapVO : MindmapVO;
		
		private var _mindmapData : XML;
		
		public function Mindmap( mindmapVO : MindmapVO = null, 
				mindmapData : XML = null ) {
			this.mindmapVO = mindmapVO;
			this.mindmapData = mindmapData;
		}
		
		public function get mindmapData() : XML {
			return _mindmapData;
		}
		
		public function set mindmapData( value : XML ) : void {
			if ( value.localName() == "mindmap" ) {
				_mindmapData = value;
			} else {
				var root : XML = <mindmap />;
				root.@name = mindmapVO.name;
				_mindmapData = root;
			}
		}
		
	}
	
}