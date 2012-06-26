package xhtml 
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	/**
	 * ...
	 * @author 
	 */
	public class XHTMLNode
	{		
		static public function createFromString(htmlString:String):XHTMLNode
		{
			var xml:XML = new XML(htmlString);
			return new XHTMLNode(xml);
		}
		
		protected var _xmlNode:XML;
		
		public function XHTMLNode(xml:XML) 
		{
			var root:XML = new XML("<root />");
			root.appendChild(xml);
			_xmlNode = root;
		}
		
		public function get xml():XML
		{
			return _xmlNode;
		}
		
		public function cssQuery(query:String):XHTMLList
		{
			return new XHTMLList(XHTMLQuery.cssQuery(query, XMLList(xml)));
		}
		
	}

}