package com.rishik.ds.pq.impl
{
	import flash.utils.describeType;
	
	import mx.utils.ObjectUtil;
	import com.pf.lite.api.util.pq.IQueueItemProxy;

	/**
	 * <p>
	 * Accepts any objects and wraps it up with the properties viz. 
	 * Precedence, Weight and Rules. If the metadata is defined in the class 
	 * it is used otherwise default values are applied. 
	 * </p>
	 * <p>
	 * The "Weight" and "Precedence" tuple has an "either/or" relationship with "Rules"
	 * which implies that a class either needs the tuple or the "Rules" property defined for it to
	 * be prioritized.
	 * </p>
	 * <p>
	 * "Rules" property takes the names of the rules which are defined in the rules base,
	 * using a game's Data Definition mechanism viz. GameData.xml.
	 * </p>
	 * <b>Note:</b>"Rules" feature will not be complete in the 1.0 release but would be released soon after.
	 * <p>
	 * See the example below to know how to defined Priority metadata for a class, that
	 * needs to be prioritized.
	 * </p>
	 * </p>
	 * <b>Example:</b><br>
	 *  <p>
	 * 	For static prioritization config, use the Precedence and Weight properties.<br>
	 * 	<br>
	 * 	[Priority("Precedence"=20,"Weight"=15)]<br>
	 * 	public class EnergyPopUp {<br>
	 * 		...<br>
	 * 	}<br>
	 * 	<br>
	 *  For rules driven dynamic config, use the Rules property.<br>
	 * 	<br>
	 * 	[Priority("Rules"="systemLevel,userAction")]<br>
	 * 	public class EnergyPopUp {<br>
	 * 		...<br>
	 * 	}<br>
	 * 	</p>
	 * 
	 * @author rdhar
	 * 
	 */
	public class QueueItemProxy extends Object implements IQueueItemProxy {
		private var _precedence:Number;
		private var _weight:Number;
		private var _rules:Array;
		private var _target:Object;
		
		public function QueueItemProxy(object:Object) {
			super();
			setPriorityRules(object);
			_target = object;
		}
		
		private function setPriorityRules(object:Object) : void {
			//TODO This is a potential memory leak point, keep a check on it.
			var xml:XML = describeType(object); 
			for each(var xmi:XML in xml.metadata) {
				if(xmi.attribute("name")== "Priority") {
					for each(var xmr:XML in xmi.arg) {
						if(xmr.attribute("key")=="Precedence") {
							precedence = Number(xmr.attribute("value"));
						}
						if(xmr.attribute("key")=="Weight") {
							weight = Number(xmr.attribute("value"));
						}
						if(xmr.attribute("key")=="Rules") {
							rules = String(xmr.attribute("value")).split(",");
						}
					}
				}
			}
			
			//Apply Defaults
			if(!precedence || precedence == 0) {
				precedence = 1;
			}
			if(!weight || weight == 0) {
				weight = 30; 
			}
		}

		public function get weight():Number
		{
			return _weight;
		}
		
		public function set weight(value:Number):void
		{
			_weight = value;
		}

		public function get precedence():Number
		{
			return _precedence;
		}

		public function set precedence(value:Number):void
		{
			_precedence = value;
		}

		public function get rules():Array
		{
			return _rules;
		}

		public function set rules(value:Array):void
		{
			_rules = value;
		}

		public function get target():Object
		{
			return _target;
		}

		public function set target(value:Object):void
		{
			_target = value;
		}
		
		public function compareTo(rhs:IQueueItemProxy):int {
			//If Right Hand Side (rhs) is null, then I am bigger.
			if(rhs==null) {
				return 1;
			}
			//If (rhs) is strict equal of me, then we are equal.
			if(this ===  rhs) {
				return 0;
			}
			//If rhs has same precedence as me, then check weights.
			if(this.precedence == rhs.precedence ){
				//If rhs has same weight as me, then we are equal.
				if(this.weight == rhs.weight ) {
					return 0;
				} else if(this.weight > rhs.weight ) { //If my weight is more than rhs weight, then I am bigger.
					return 1;
				} else { //If my weight is less than rhs weight, then rhs is bigger.
					return -1;
				}
			} else if (this.precedence > rhs.precedence ){//If my precedence is more than rhs precedence, then I am bigger.
				return 1;
			} else { //If my precedence is less than rhs precedence, then rhs is bigger.
				return -1;
			}
		}
	}
}