package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	
	import flash.events.Event;
	
	import mx.collections.XMLListCollection;
	import mx.controls.TextInput;
	
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.model.AppModelLocator;
	import pl.cani.mindmap.view.MindmapCreationPanel;
	import com.mikenimer.components.Debug;


	public class MindmapCreationPanelHelper extends ViewHelper {
		
		private var concreteView : MindmapCreationPanel;
		
		[Bindable]
		public var addBtnEnabled : Boolean = false;
		
		[Bindable]
		public var editBtnsEnabled : Boolean = false;
		
		public function MindmapCreationPanelHelper( view : MindmapCreationPanel ) {
			this.view = concreteView = view;
			
			CairngormEventDispatcher.getInstance().addEventListener(
				MindmapEvent.MINDMAP_STRUCTURE_UPDATED, onMindmapStructureUpdated );
		}
		
		private function onMindmapStructureUpdated( event : MindmapEvent ) : void {
			setButtonsEnabled( true );
		}
		
		public function updateNode() : void {
			var branch : XML = concreteView.tree.selectedItem as XML;
			if ( branch != null ) {
				branch.@name = concreteView.nameTxt.text;
			}
		}
		
		public function addNode() : void {
			var parentBranch : XML = concreteView.tree.selectedItem != null 
				? concreteView.tree.selectedItem as XML
				: ( concreteView.tree.dataProvider as XMLListCollection )
					.source[ 0 ];
			var selectedIndex : uint = concreteView.tree.selectedIndex;
			if  ( concreteView.newItemTxt.text != "" ) {
				var newBranch : XML = <branch />;
				newBranch.@name = concreteView.newItemTxt.text;
				parentBranch.appendChild( newBranch );
				concreteView.newItemTxt.text = "";
			}
		}
		
		public function saveChanges() : void {
			var mindmapEvent : MindmapEvent = new MindmapEvent( 
				MindmapEvent.UPDATE_MINDMAP_STRUCTURE );
			mindmapEvent.mindmap = concreteView.mindmap.mindmapVO;
			mindmapEvent.mindmapStructure = concreteView.mindmap.mindmapData;
			if ( mindmapEvent.mindmapStructure != null ) {
				mindmapEvent.dispatch();
				setButtonsEnabled( false );
			}
		}
		
		private function setButtonsEnabled( enabled : Boolean ) : void {
			concreteView.updateBtn.enabled = enabled;
			concreteView.deleteBtn.enabled = enabled;
			concreteView.addBtn.enabled = enabled;
			concreteView.saveBtn.currentState = enabled ? "" : "disabled";
		}
		
		public function deleteNode() : void {
			var node : XML = concreteView.tree.selectedItem as XML;
            if( node == null ) return;
        
            var children : XMLList = XMLList( node.parent() ).children();
            for ( var i : Number = 0; i < children.length(); i++ ) {
                if ( children[ i ].@name == node.@name ) {
                    delete children[ i ];
                    return;
                }
            }
		}
		
		public function checkInput( event : Event ) : void {
			var txt : TextInput = event.target as TextInput;
			if ( txt == concreteView.newItemTxt ) {
				addBtnEnabled = txt.text != "";
			} else {
				editBtnsEnabled = txt.text != "";
			}
		}
		
	}
	
}