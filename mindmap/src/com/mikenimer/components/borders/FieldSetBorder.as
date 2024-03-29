/**
 * copyright 2006 Mike Nimer, All rights reserved.
 */
package com.mikenimer.components.borders
{
	import mx.skins.RectangularBorder;
	import mx.core.EdgeMetrics;
	import flash.display.Graphics;
	import mx.controls.Label;
	import com.mikenimer.components.FieldSet;

	public class FieldSetBorder extends RectangularBorder
	{
		public function FieldSetBorder()
		{
			super();
		}
		
		//----------------------------------
		//  borderMetrics
		//----------------------------------
	
		/**
		 *  @private
		 *  Storage for the borderMetrics property.
		 */
		private var _borderMetrics:EdgeMetrics;
	
		/**
		 *  @private
		 */
		override public function get borderMetrics():EdgeMetrics
		{		
			if (_borderMetrics)
				return _borderMetrics;
				
			var borderStyle:String = getStyle("borderStyle");
		
			_borderMetrics = new EdgeMetrics(3, 1, 3, 3);
	 		
			return _borderMetrics;
		}		
			
		/**
		 *  @private
		 *  Draw the background and border.
		 */
		override protected function updateDisplayList(w:Number, h:Number):void
		{	
			super.updateDisplayList(w, h);
	
			var borderAlpha:int = 1.0;
			var borderThickness:int = getStyle("borderThickness");
			var borderStyle:String = getStyle("borderStyle");
			var borderColor:uint = getStyle("borderColor");
			var cornerRadius:Number = getStyle("cornerRadius");
			var backgroundColor:uint = getStyle("backgroundColor");
			var backgroundAlpha:Number= getStyle("backgroundAlpha");
			
			
			var labelWidth:int = 0;
			if( this.parent is FieldSet )
				labelWidth = FieldSet(this.parent).getLabelWidth(); 
	
	
			var g:Graphics = graphics;
			g.clear();
			
			g.lineStyle( borderThickness, borderColor, borderAlpha );							
		    
		    var startX:Number = labelWidth +cornerRadius + 10;
		    var startY:Number = 10;

			if( backgroundColor != 0 )
				g.beginFill(backgroundColor, backgroundAlpha);
				
			g.moveTo( startX, startY );
			g.lineTo( width-cornerRadius, startY );
			g.curveTo(width, startY, width, startY+cornerRadius);	
			g.lineTo( width, height-cornerRadius );	
			g.curveTo(width, height, width-cornerRadius, height);	
			g.lineTo( 0+cornerRadius, height );	
			g.curveTo(0, height, 0, height-cornerRadius);	
			g.lineTo( 0, startY+cornerRadius );	
			g.curveTo(0, startY, cornerRadius, startY);	
			g.lineTo( cornerRadius+0, startY );
			
			if( backgroundColor != 0 )
				g.endFill();
			
			/*
			// border 
			drawRoundRect(
				0, 10, w, h, 3,
				borderColor, backgroundAlpha); 
	
			// top pointer 
			g.beginFill(borderColor, backgroundAlpha);
			g.moveTo(9, 11);
			g.lineTo(15, 0);
			g.lineTo(21, 11);
			g.moveTo(10, 11);
			g.endFill();
			*/
		}
				
	}
}