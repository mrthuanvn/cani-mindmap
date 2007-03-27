package {
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.text.*;
    import mx.styles.CSSStyleDeclaration;
    import mx.controls.Alert;
    
    public class TextRendererExample extends Sprite {
        [Embed(source="file:///c:/windows/fonts/verdana.ttf", fontFamily="Verdana")]
        private var verdana:String;
        private var fontFamily:String = "Verdana";
        private var gutter:int = 10;

        public function TextRendererExample() {
            Alert.show( "WTF?!" );
            
            var label1:TextField = createLabel(24);
            label1.name = "label-24";
            var label2:TextField = createLabel(48);
            label2.name = "label-48";
            label1.addEventListener(MouseEvent.CLICK, clickHandler);
            label2.addEventListener(MouseEvent.CLICK, clickHandler);
        }
        
        public function clickHandler(event:Event):void {
            trace("clickHandler target: " + event.target.name);
            var antiAliasEntry:CSMSettings;
            if(event.target.name == "label-24") {
                 antiAliasEntry = {fontSize:24, insideCutOff:1.61, outsideCutOff:-3.43} as CSMSettings;
            } else if(event.target.name == "label-48") {
                antiAliasEntry = {fontSize:48, insideCutOff:0.8, outsideCutOff:-0.8} as CSMSettings;
            }
            var verdanaTable:Array = new Array(antiAliasEntry);
            TextRenderer.setAdvancedAntiAliasingTable(fontFamily, FontStyle.REGULAR, TextColorType.DARK_COLOR, verdanaTable);
        }
    
        private function createLabel(fontSize:Number):TextField {
            var label:TextField = new TextField();
            label.embedFonts = true;
            label.border = true;
            label.autoSize = TextFieldAutoSize.LEFT;
            label.antiAliasType = AntiAliasType.ADVANCED;
            label.defaultTextFormat = getTextFormat(fontSize);
            label.selectable = false;
            label.mouseEnabled = true;
            label.text = "Hello World";
            if(numChildren > 0) {
                var sibling:DisplayObject = getChildAt(numChildren - 1);
                label.y = sibling.y + sibling.height + gutter;
            }
            addChild(label);
            return label;
        }
        
        private function getTextFormat(fontSize:Number):TextFormat {
            var format:TextFormat = new TextFormat();
            format.color = 0xFFFFFF;
            format.align = TextFormatAlign.CENTER;
            format.size = fontSize;
            format.font = fontFamily;
            return format;
        }
    }
}