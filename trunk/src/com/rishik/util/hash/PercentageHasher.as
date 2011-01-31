package com.pf.lite.api.util.hash
{
	import com.adobe.crypto.SHA256;

	public class PercentageHasher
	{
		public function PercentageHasher()
		{
		}
		
		public static function getHashPercentage(input:String):Number {
			
			var hexEncoded:String = SHA256.hash(input) ;                // returns something like 'd0be2dc421be4fcd0172e5afceea3970e2f3d940'
			var sevenHexes:String = hexEncoded.substr(-10, 7);  // grab 7 hex numbers from sha1 key... in this starting from last 10
			var decimalRep:Number = parseInt(hex2dec(sevenHexes));  // convert the 7 hex numbers into a decimal rep (will be positive)
			var result:Number = decimalRep % 100;                 // get the mod from a div of 100:  should be values 0 through 99
			return result;
		}
		
		private static function hex2dec( hex:String ) : String {
			var bytes:Array = [];
			while( hex.length > 2 ) {
				var byte:String = hex.substr( -2 );
				hex = hex.substr(0, hex.length-2 );
				bytes.splice( 0, 0, int("0x"+byte) );
			}
			return bytes.join(" ");
		}
		
		private static function d2h( d:int ) : String {
			var c:Array = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' ];
			if( d > 255 ) d = 255;
			var l:int = d / 16;
			var r:int = d % 16;
			return c[l]+c[r];
		}
		
		public static function dec2hex( dec:String ) : String {
			var hex:String = "0x";
			var bytes:Array = dec.split(" ");
			for( var i:int = 0; i < bytes.length; i++ )
				hex += d2h( int(bytes[i]) );
			return hex;
		}
	}
}