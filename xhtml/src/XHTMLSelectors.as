package xhtml.src 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public var XHTMLSelectors:Dictionary = new Dictionary();
	
	{
		// LEVEL1
		// descendant selector
		XHTMLSelectors[" "] = function(from:XMLList, tagName:String, $namespace:String):XMLList
		{
			// @todo: cba to make namespace with qname
			if ( tagName == "*" ) return from.descendants().(nodeKind() == "element");
			return from.descendants().(tagName == "*" || tagName == localName()).(nodeKind() == "element");
		};
		
		// ID selector
		// remember: can't use @id as some nodes don't have it defined
		XHTMLSelectors["#"] = function(from:XMLList, id:String, unused:String):XMLList
		{
			return from.(attribute("id") == id);
		};
		
		// class selector
		XHTMLSelectors["."] = function(from:XMLList, className:String, unused:String):XMLList
		{
			var regexp:RegExp = new RegExp("(^|\\s)" + className + "(\\s|$)");
			return from.(regexp.test(attribute("class")));
		};
		
		// pseudo-class selector
		XHTMLSelectors[":"] = function(from:XMLList, pseudoClass:String, otherArguments:String):XMLList
		{
			// retrieve the cssQuery pseudo-class function
			if (!XHTMLPseudoClasses.hasOwnProperty(pseudoClass))
			{
				throw new Error("PseudoClass '" + pseudoClass + "' does not exist!");
			}
			var test:Function = XHTMLPseudoClasses[pseudoClass];
			// if the cssQuery pseudo-class function returns "true" add the element
			return from.(test(valueOf(), otherArguments));
		};
		
		//LEVEL2
		// child selector
		XHTMLSelectors[">"] = function(from:XMLList, tagName:String, $namespace:String):XMLList
		{
			// @todo: cba to make namespace with qname
			return from.children().(tagName == "*" || localName() == tagName).(nodeKind() == "element");
		};

		// next sibling selector
		XHTMLSelectors["+"] = function(from:XMLList, tagName:String, $namespace:String):XMLList
		{
			// @todo: cba to make namespace with qname
			return XHTMLTraverse.nextSibling(from).(tagName == "*" || localName() == tagName);
		};

		//LEVEL3
		// all siblings selector
		XHTMLSelectors["~"] = function(from:XMLList, tagName:String, $namespace:String):XMLList
		{
			// @todo: cba to make namespace with qname
			return XHTMLTraverse.siblings(from).(tagName == "*" || localName() == tagName);
		};
		
		// compared to cssQuery, @ for attributes is not used, and instead they are hard coded into parser now
	}
}
