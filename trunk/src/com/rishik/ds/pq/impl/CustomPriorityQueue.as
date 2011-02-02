package com.rishik.ds.pq.impl
{
	public class CustomPriorityQueue implements IPriorityQueue {
		
		private var _priorityList:Vector.<IQueueItemProxy> = new Vector.<IQueueItemProxy>();
		private var _isLocked:Boolean = false;
		
		public function CustomPriorityQueue() {
		}
		
		public function offer(object:IQueueItemProxy):void {
			if(_priorityList.length == 0) {
				_priorityList.push(object);
			} else {
				prioritize(object);
			}
		}
		
		public function retrieve():IQueueItemProxy {
			return _priorityList.pop();
		}
		
		/**
		 * Crude algorithm for inserting elements into the queue, based 
		 * on the precedence and weight. When two items are compared, the
		 * one with the higher precedence is inserted before the the lower
		 * precedence item. If the precedence is same, then the weight is 
		 * compared and one with higher weight comes before the one with 
		 * the lower weight.
		 * 
		 * 
		 * TODO: In future there will be two changes to this method:
		 * -one make this method a plug-in location for alogrithms, 
		 * that prioritize based on precedence|weight tuple.
		 * -two provide for rule based prioritization instead of 
		 * just tuple based priortization.
		 * 
		 * @param incumbent
		 * 
		 */
		private function prioritize(incumbent:IQueueItemProxy):void  {
			var markedIndex:int = 0;
			for each(var proxy:IQueueItemProxy in _priorityList) {
				//If the incumbent is bigger than the current element insert is after the current element.
				if(incumbent.compareTo(proxy) >= 0) {
					markedIndex = _priorityList.indexOf(proxy) + 1;
				} else { // Otherwise insert it before.
					markedIndex = _priorityList.indexOf(proxy);
					break;
				}
			}
			//Check if the marked index for the item incumbent insertion is beyond the current
			//end of the vector, if yes then simply push it, so no out of bound exceptions are thrown.
			if(markedIndex >= _priorityList.length) {
				_priorityList.push(incumbent);	
			} else { // Otherwise, just insert the item on the marke index location.
				_priorityList.splice(markedIndex,0,incumbent)
			}
		}
		
		public function size():int {
			return _priorityList.length;
		}

		public function get priorityList():Vector.<IQueueItemProxy>
		{
			return _priorityList;
		}

		public function requestRefresh():void {
			/*
				Possible Memory Leak candidate, figure out a way to either displose off existing vector,
				before creating new, or clear all the elemens in the current vector, so new doesn't have to be created.
				Can't trust GC, coz we don't know if the objects in the vector are being referenced anywhere,
				and whethere would prevent this Vector from being GCed.
			*/
			var tempList:Vector.<IQueueItemProxy> = _priorityList.slice();
			_priorityList = new Vector.<IQueueItemProxy>();
			
			//TODO Implement the re-prioritization
		}

	}
}