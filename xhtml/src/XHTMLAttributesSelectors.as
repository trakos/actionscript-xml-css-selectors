package xhtml.src 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public var XHTMLAttributesSelectors:Dictionary = new Dictionary();
	
	{
		//LEVEL2
		XHTMLAttributesSelectors[""] = function(xml:XML, attributeName:String, value:String):Boolean
		{
			return xml.attribute(attributeName).length() > 0;
		}
		XHTMLAttributesSelectors["="] = function(xml:XML, attributeName:String, value:String):Boolean
		{
			return xml.attribute(attributeName) == value;
		}
		XHTMLAttributesSelectors["~="] = function(xml:XML, attributeName:String, value:String):Boolean
		{
			var test:RegExp = new RegExp("(^| )" + value + "( |$)");
			return test.test(xml.attribute(attributeName));
		}
		XHTMLAttributesSelectors["|="] = function(xml:XML, attributeName:String, value:String):Boolean
		{
			var test:RegExp = new RegExp("^" + value + "(-|$)");
			return test.test(xml.attribute(attributeName));
		}
		//LEVEL3
		XHTMLAttributesSelectors["^="] = function(xml:XML, attributeName:String, value:String):Boolean
		{
			var test:RegExp = new RegExp("^" + value);
			return test.test(xml.attribute(attributeName));
		}
		XHTMLAttributesSelectors["$="] = function(xml:XML, attributeName:String, value:String):Boolean
		{
			var test:RegExp = new RegExp(value + "$");
			return test.test(xml.attribute(attributeName));
		}
		XHTMLAttributesSelectors["*="] = function(xml:XML, attributeName:String, value:String):Boolean
		{
			var test:RegExp = new RegExp(value);
			return test.test(xml.attribute(attributeName));
		}
	}	
};