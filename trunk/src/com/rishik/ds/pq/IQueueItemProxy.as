package com.pf.lite.api.util.pq
{
	/**
	 * This interface defines the contract for a Queue Item Proxy for items
	 * used in Priority Queues.
	 *  
	 * @author rdhar
	 * 
	 */
	public interface IQueueItemProxy {
		
		function get weight():Number;
		function set weight(wt:Number):void;
		function get precedence():Number;
		function set precedence(prec:Number):void;
		function get rules():Array;
		function set rules(arr:Array):void;
		function get target():Object;
		function set target(obj:Object):void;
		
		function compareTo(rhs:IQueueItemProxy):int;
	}
}