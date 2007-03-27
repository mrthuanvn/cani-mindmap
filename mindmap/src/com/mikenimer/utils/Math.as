package com.mikenimer.utils
{
	public class Math
	{
		
		public function randRange(s:Number,e:Number):Number
		{
			return Math.round(s +(Math.random() * e));
		}
 
	}
}