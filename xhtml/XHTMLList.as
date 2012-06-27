package xhtml 
{
	/**
	 * ...
	 * @author 
	 */
	public class XHTMLList 
	{
		static public function createFromString(htmlString:String):XHTMLList
		{
			var xml:XML = new XML(htmlString);
			return new XHTMLList(XMLList(xml));
		}
		
		protected var _xml:XMLList;
			
		public function XHTMLList(nodes:XMLList)
		{
			_xml = nodes;
		}
		
		public function cssQuery(query:String):XHTMLList
		{
			return new XHTMLList(XHTMLQuery.cssQuery(query, xml));
		}
		
		public function get xml():XMLList
		{
			return _xml;
		}
		
	}

}