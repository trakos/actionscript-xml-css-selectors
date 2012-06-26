package xhtml.src 
{
	/**
	 * ...
	 * @author 
	 */
	public class XHTMLTraverse 
	{
		static public function siblings(list:XMLList):XMLList
		{
			var returnList:XMLList = new XMLList();
			for each (var xml:XML in list)
			{
				if (xml.parent() != undefined)
				{
					returnList += xml.parent().children().(nodeKind() == "element");
				}
			}
			return returnList;
		}
		
		static public function nextSibling(list:XMLList):XMLList
		{
			var returnList:XMLList = new XMLList();
			for each (var xml:XML in list)
			{
				if (xml.parent() != undefined)
				{
					var siblings:XMLList = siblings(new XMLList() + xml);
					for (var k:int = 0; siblings[k] != xml; k++) { }
					if (k + 1 < siblings.length())
					{
						returnList += siblings[k + 1];
					}
				}
			}
			return returnList;
		}
		
		static public function prevSibling(list:XMLList):XMLList
		{
			var returnList:XMLList = new XMLList();
			for each (var xml:XML in list)
			{
				if (xml.parent() != undefined)
				{
					var siblings:XMLList = siblings(new XMLList() + xml);
					for (var k:int = 0; siblings[k] != xml; k++) { }
					if (k > 0)
					{
						returnList += siblings[k - 1];
					}
				}
			}
			return returnList;
		}
		
		static public function lastSibling(list:XMLList):XMLList
		{
			var returnList:XMLList = new XMLList();
			for each (var xml:XML in list)
			{
				if (xml.parent() != undefined)
				{
					var siblings:XMLList = siblings(new XMLList() + xml);
					returnList += siblings[siblings.length() - 1];
				}
			}
			return returnList;
		}
		
		static public function firstSibling(list:XMLList):XMLList
		{
			var returnList:XMLList = new XMLList();
			for each (var xml:XML in list)
			{
				if (xml.parent() != undefined)
				{
					var siblings:XMLList = siblings(new XMLList() + xml);
					returnList += siblings[0];
				}
			}
			return returnList;
		}
		
	}

}