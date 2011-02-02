package com.rishik.ds.pq
{
	/**
	 * Interface defininig the contract for the Custom Queue Manager.
	 *  
	 * @author rdhar
	 * 
	 */
	public interface IQueueManager{
		/**
		 * The objective of this method is to add items to the queue. The argument passed is
		 * any object that needs to be prioritized. The object class needs to have a metadata
		 * tag defined for if Precence, Weight and Rules for prioirtization.
		 * 
		 * @see
		 * QueueItemProxy
		 * 
		 * @param object
		 * 
		 */
		function addToQueue(object:Object):void;
		function dequeue():Object;
		function refresh():void;							
		function persist():void;							
	}
}