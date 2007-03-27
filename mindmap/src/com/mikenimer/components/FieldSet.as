/**
	Copyright (c) 2006. Tapper, Nimer and Associates Inc
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	
	  * Redistributions of source code must retain the above copyright notice,
	    this list of conditions and the following disclaimer.
	  * Redistributions in binary form must reproduce the above copyright notice,
	    this list of conditions and the following disclaimer in the documentation
	    and/or other materials provided with the distribution.
	  * Neither the name of Tapper, Nimer, and Associates nor the names of its
	    contributors may be used to endorse or promote products derived from this
	    software without specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.
	
	@author: Mike Nimer (mikenimer@yahoo.com)
	@ignore
**/
package com.mikenimer.components
{
	import mx.containers.VBox;
	import mx.controls.Label;
	import mx.skins.Border;
	import mx.skins.RectangularBorder;
	import mx.utils.ColorUtil;
	import com.mikenimer.components.borders.FieldSetBorder;

	public class FieldSet extends VBox
	{
		protected var legend:Label;
		
		public function FieldSet()
		{
			super();
			
			this.setStyle("borderSkin", FieldSetBorder); 
		}
		
		public function getLabelWidth():int
		{
			return this.legend.textWidth;
		}
		
		override protected function createChildren():void
		{						
			super.createChildren();
			
			var cr:int = getStyle("cornerRadius");
			legend = new Label();
			legend.text = this.label;
			legend.setStyle("paddingLeft", cr);
			this.addChildAt(legend, 0);
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);	
		}
		
	}
}