# Usage #

## Querying using static methods ##

```
var myxml:XML = new XML("<html><body><a class='example'>clickme</a><a class='other'></a></body></html>");
var results:XMLList = xhtml.XHTMLQuery.cssQuery("a.example", new XMLList() + myxml);
//<a class="example">clickme</a>
trace(results.toXMLString());
```

_Note that cssQuery accepts XMLList, so to use an XML object I had to convert it by adding it to empty XMLList_

## Using XHTMLList and XHTMLNode classes ##

### Creating XHTMLNode ###

```
var myxml:XML = new XML("<html><body><a class='example'>clickme</a><a class='other'></a></body></html>");
var test:XHTMLNode = new XHTMLNode(myxml);
```

or directly from string:


```
var test:XHTMLNode = XHTMLNode.createFromString("<html><body><a class='example'>clickme</a><a class='other'></a></body></html>");
// you can access original XML object using xml property:
var xml:XML = test.xml;
```

### Using XHTMLList ###

XHTMLList encapsulates XMLList, not a list of XHTMLNode. Thus:

```
var test:XHTMLList;
// xml property returns XMLList
var xml:XMLList = test.xml;
```


### Querying XHTMLNode ###

```
var test:XHTMLNode = XHTMLNode.createFromString("<html><body><a href='#' class='example'>clickme</a><a href='localhost' class='other'></a></body></html>");
var results:XHTMLList = test.cssQuery("a[href='#']");
//<a href='#' class='example'>
trace(results.xml.toXMLString());
```

### Querying XHTMLList ###

This is probably an easier way, since cssQuery returns the same type as takes in an argument. Static method createFromString simply creates an XHTMLList with only one XML in XMLList.


```
var test:XHTMLList = XHTMLList.createFromString("<html><body><a href='#' class='example'>clickme</a><a href='localhost' class='other'></a></body></html>");
test = test.cssQuery("a");
trace(test.xml.toXMLString());
//2 elements:
//<a href='#' class='example'>clickme</a>
//<a href='localhost' class='other'>

test = test.cssQuery("[href='#']");
trace(test.xml.toXMLString());
//<a href='#' class='example'>clickme</a>
```

_Note that cssQuery for XHTMLList queries in all XMLs on list, and returns concatenated (but distinct) results._