## xhtml.src.XHTMLQuery ##

```
// query: string containg selectors
// from: list to search in
// returns XMLList with all results (can be an empty XMLList)
static public function cssQuery(query:String, from:XMLList):XMLList;

// indicates whether to return distinct results
// without it, "div a" for <div><div><a /><a /></div></div> will return <a> two times
// (in contrary to "div > a ")
// on the other side, when set to true, will return only one <a>,
// because they are exactly the same
// affects all queries, including those done through other classes
static public var onlyUnique:Boolean = true;
```

## xhtml.XHTMLNode ##
```

static public function createFromString(htmlString:String):XHTMLNode; //convenient initialization
public function XHTMLNode(xml:XML); //constructor
public function cssQuery(query:String):XHTMLList; //wraps static method of XHTMLQuery
public function get xml():XML; // getter for underlying XML element
```

## xhtml.XHTMLList ##
```
static public function createFromString(htmlString:String):XHTMLList; //convenient initialization
public function XHTMLList(nodes:XMLList);
public function cssQuery(query:String):XHTMLList;//wraps static method of XHTMLQuery
public function get xml():XMLList; // getter for underlying XMLList element
```static public function createFromString(htmlString:String):XHTMLList; //convenient initialization
public function XHTMLList(nodes:XMLList);
public function cssQuery(query:String):XHTMLList;//wraps static method of XHTMLQuery
public function get xml():XMLList; // getter for underlying XMLList element
}}}```