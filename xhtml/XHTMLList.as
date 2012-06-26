package xhtml 
{
	/**
	 * ...
	 * @author 
	 */
	public class XHTMLList 
	{		
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