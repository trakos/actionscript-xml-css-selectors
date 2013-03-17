package xhtml.src 
{
	import flash.utils.Dictionary;
	import xhtml.XHTMLQuery;
	/**
	 * ...
	 * @author 
	 */
	public var XHTMLPseudoClasses:Dictionary = new Dictionary();
	
	{
		//LEVEL1
		// obviously those can't work:
		XHTMLPseudoClasses["link"] = function(element:XML, unused:String):Boolean
		{
			throw new Error("Pseudo-class link unimplemented");
		}
		XHTMLPseudoClasses["visited"] = function(element:XML, unused:String):Boolean
		{
			throw new Error("Pseudo-class visited unimplemented");
		}
		//LEVEL2
		XHTMLPseudoClasses["first-child"] = function(element:XML, unused:String):Boolean
		{
			// @todo: is it safe? does empty parent mean root html element, thus being always first? think of situation when sb wants to search in only partial xhtml - not good.
			// we can't simply check childIndex as it counts text, so b in <p>a<b /></p> is not first (which might make sense, but differs from what html users expects)
			// we can be sure that there will be [0] element, as there has to be at least the element in question
			return element.parent() == undefined || XHTMLTraverse.firstSibling(new XMLList() + element)[0] == element;
		}
		XHTMLPseudoClasses["lang"] = function(element:XML, code:String):Boolean
		{
			var regexp:RegExp = new RegExp("^" + escapeRegexChars(code), "i");
			while (element.attribute("lang").length() == 0 && element.parent() != undefined)
			{
				element = element.parent();
			}
			return element.attribute("lang").length() != 0 && regexp.test(element.@lang);
		}
		//LEVEL3
		XHTMLPseudoClasses["contains"] = function(element:XML, code:String):Boolean
		{
			var regexp:RegExp = new RegExp("^" + escapeRegexChars(removeApostrophes(code)) + "$", "i");
			return regexp.test(element.toString());
		}
		XHTMLPseudoClasses["root"] = function(element:XML, code:String):Boolean
		{
			return element.parent() == undefined || element.localName() == "root";
		}
		XHTMLPseudoClasses["empty"] = function(element:XML, code:String):Boolean
		{
			return element.children().(nodeKind() == "element").length() == 0;
		}
		XHTMLPseudoClasses["last-child"] = function(element:XML, code:String):Boolean
		{
			return element.parent() == undefined || XHTMLTraverse.lastSibling(new XMLList() + element)[0] == element;
		}
		XHTMLPseudoClasses["only-child"] = function(element:XML, code:String):Boolean
		{
			return element.parent() == undefined || element.parent().children().(nodeKind() == "element").length() == 1;
		}
		XHTMLPseudoClasses["not"] = function(element:XML, code:String):Boolean
		{
			// @todo practicly unimplemented - problem with parsing - it has to be improved in order to accept a query inside query; for now code can only be a tag
			return !XHTMLQuery.cssQuery(code, new XMLList() + element).contains(element);
		}
		XHTMLPseudoClasses["nth-child"] = function(element:XML, code:String):Boolean
		{
			// @todo: odd, even, equations - for now accepting only numbers
			var k:int = parseInt(code) - 1;
			var siblings:XMLList = XHTMLTraverse.siblings(new XMLList() + element);
			return k < siblings.length() && siblings[k] == element;
		}
		XHTMLPseudoClasses["nth-last-child"] = function(element:XML, code:String):Boolean
		{
			// @todo: odd, even, equations - for now accepting only numbers
			var k:int = parseInt(code);
			var siblings:XMLList = XHTMLTraverse.siblings(new XMLList() + element);
			return k < siblings.length() && siblings[siblings.length() - 1 - k] == element;
		}
		XHTMLPseudoClasses["target"] = function(element:XML, code:String):Boolean
		{
			throw new Error("Pseudo-class target unimplemented");
		}
		// UI element states
		XHTMLPseudoClasses["checked"] = function(element:XML, code:String):Boolean
		{
			return element.attribute("checked").length > 0;
		}
		XHTMLPseudoClasses["enabled"] = function(element:XML, code:String):Boolean
		{
			return element.attribute("disabled").length == 0;
		}
		XHTMLPseudoClasses["disabled"] = function(element:XML, code:String):Boolean
		{
			return element.attribute("disabled").length > 0;
		}
		XHTMLPseudoClasses["indeterminate"] = function(element:XML, code:String):Boolean
		{
			// what does it even mean?
			throw new Error("Pseudo-class indeterminate unimplemented");
		}		
	}

}

function removeApostrophes(s:String):String
{
	if ( s[1] == '"' || s[1] == "'" ) s = s.slice(1, -1);
	return s;
}
function escapeRegexChars(s:String):String
{
	var newString:String = 
		s.replace(
			new RegExp("([{}\(\)\^$&.\*\?\/\+\|\[\\\\]|\]|\-)","g"),
			"\\$1");
	return newString;
}