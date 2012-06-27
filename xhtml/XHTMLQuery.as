package xhtml 
{
	import flash.utils.Dictionary;
	import xhtml.src.XHTMLAttributesSelectors;
	import xhtml.src.XHTMLSelectors;
	/**
	 * ...
	 * @author 
	 */
	public class XHTMLQuery 
	{
		static public var onlyUnique:Boolean = true;
		static protected const WHITESPACE:RegExp = /\s*([\s>+~(),]|^|$)\s*/g;
		static protected const IMPLIED_ALL:RegExp = /([\s>+~,]|[^(]\+|^)([#.:@\[])/g;
		static protected const STANDARD_SELECT:RegExp = /^[^\s>+~\[]/;
		static protected const NAMESPACE:RegExp = /\|/;
		static protected const COMMA:RegExp = /\s*,\s*/;
		//static protected const ATTRIBUTE_SELECTOR:RegExp = /([\w-]+(\|[\w-]+)?)\s*(\W?=)?\s*([^\]]*)/;
		static protected const STREAM_SELECTOR:RegExp = /^[\s#.:>+~()\[\]]|[^\s#.:>+~()\[\]]+/;
		static protected const ATTRIBUTE_SELECTOR:RegExp = /^\[([\w-]+(\|[\w-]+)?)\s*(\W?=)?\s*("(?:[^\\"]|\\.)*"|"(?:[^\\']|\\.)*'|[^\]]*)\]/;
		
		static public function cssQuery(query:String, from:XMLList):XMLList
		{
			// hack: I need a root element always above
			var list:XMLList = from;
			from = new XMLList();
			for each ( var xml:XML in list )
			{
				var root:XML = new XML("<root />");
				root.appendChild(xml);
				from += root;
			}
			// endhack
			var match:XMLList = new XMLList();
			var base:XMLList = from.copy();
			var selectors:Vector.<String> = Vector.<String>(_parseSelector(query).split(COMMA));
			for (var i:int = 0; i < selectors.length; i++)
			{
				var selector:Array = _toStream(selectors[i]);
				from = base.copy();
				// skipping original cssQuery's faster chop for ID, as we don't have any getElementById builtin anyway
				var j:int = 0, token:String, filter:*, otherArguments:String/*, cacheSelector:String = ""*/;
				while ( j < selector.length )
				{
					token = selector[j++];
					filter = j < selector.length ? selector[j++] : "";
					// attribute selector
					if (token == "attribute-selector")
					{
						var attributeData:Object = filter;
						from = _selectByAttribute(from, attributeData.attributeName, attributeData.compareType, attributeData.value);
					}
					else
					{
						otherArguments = "";
						//cacheSelector += token + filter;
						// some pseudo-classes allow arguments to be passed
						//  e.g. nth-child(even)
						if ( j < selector.length && selector[j] == "(" )
						{
							while (selector[j++] != ")" && j < selector.length )
							{
								otherArguments += selector[j];
							}
							otherArguments = otherArguments.slice(0, -1);
							//cacheSelector += "(" + otherArguments + ")";
						}
						// process a token/filter pair - omitted using cached results if possible
						from = _select(from, token, filter, otherArguments);
					}
				}
				match += from;
			}
			if (onlyUnique) match = uniqued(match);
			return match;
		}

		static public function uniqued(list:XMLList):XMLList  
		{
			var filtered:XMLList = new XMLList();
			list.(filtered = _addUniqueValue(valueOf(), filtered));
			return filtered;
		}
		
		static protected function _addUniqueValue(value:XML, list:XMLList):XMLList  
		{  
			if(!list.contains(value))
			{
				list += value;  
			}
			return list;
		}
		
		static protected function _select(from:XMLList, token:String, filter:String, otherArguments:String):XMLList
		{
			if (NAMESPACE.test(filter))
			{
				var splitted:Array = filter.split(NAMESPACE);
				otherArguments = splitted[0];
				filter = splitted[1];
			}
			if (!XHTMLSelectors.hasOwnProperty(token))
			{
				throw new Error("Token '" + token + "' unkown!");
			}
			var selectFunction:Function = XHTMLSelectors[token];
			return selectFunction(from, filter, otherArguments);
		};
		
		static protected function _selectByAttribute(from:XMLList, attributeName:String, compareType:String, value:String):XMLList
		{
			if (compareType == null) compareType = "";
			if (!XHTMLAttributesSelectors.hasOwnProperty(compareType))
			{
				throw new Error("Attribute compare sign '" + compareType + "' unkown!");
			}
			var testFunction:Function = XHTMLAttributesSelectors[compareType];
			return from.(testFunction(valueOf(), attributeName, value));
		};
		
		static protected function _parseSelector(selector:String):String
		{
			// IMPLIED_ALL e.g. ".class1" --> "*.class1"
			return selector.replace(WHITESPACE, "$1").replace(IMPLIED_ALL, "$1*$2");
		}
		
		static protected function _toStream(selector:String):Array
		{
			if (STANDARD_SELECT.test(selector))
			{
				selector = " " + selector;
			}
			var stream:Array = [];
			while (true)
			{
				while (ATTRIBUTE_SELECTOR.test(selector))
				{
					var matches:Array = selector.match(ATTRIBUTE_SELECTOR);
					var attribName:String = matches[1];
					var compareType:String = matches[3];
					var value:String = matches[4];
					if ( value.charAt(0) == '"' || value.charAt(0) == "'" ) value = value.slice(1, -1);
					stream.push("attribute-selector");
					stream.push(new AttributeSelector(attribName, compareType, value));
					selector = selector.replace(ATTRIBUTE_SELECTOR, "");
				}
				if ( STREAM_SELECTOR.test(selector) )
				{
					stream.push(selector.match(STREAM_SELECTOR)[0]);
					selector = selector.replace(STREAM_SELECTOR, "");
				}
				else
				{
					break;
				}
			}
			return stream;
		}
		
	}

}

class AttributeSelector
{
	public var attributeName:String;
	public var compareType:String;
	public var value:String;
	
	public function AttributeSelector($attributeName:String, $compareType:String,$value:String)
	{
		attributeName = $attributeName;
		compareType = $compareType;
		value = $value;
	}
}