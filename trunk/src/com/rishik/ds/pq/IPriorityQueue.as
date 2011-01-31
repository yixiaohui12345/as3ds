package com.pf.lite.api.util.pq
{
	
	/**
	 * Priority Queue contract defining interface.
	 *  
	 * @author rdhar
	 * 
	 */
	public interface IPriorityQueue
	{
		function offer(object:IQueueItemProxy):void;		// - adds a new item to the queue
		function retrieve():IQueueItemProxy;				// - removes an item from the queue
		function size():int;
		function requestRefresh():void;
		function get priorityList():Vector.<IQueueItemProxy>;
	}
}