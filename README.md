# actionscript-xml-css-selectors
Automatically exported from code.google.com/p/actionscript-xml-css-selectors

Library for quering html in ActionScript 3 using css selectors, for example:

```
var value:String = html.cssQuery("#entry_form input[name=id]").xml.attribute("value");
```

Based on cssQuery for javascript: http://dean.edwards.name/my/cssQuery/ , luckily it was lGPL. Rewriten for AS3 with usage of of E4X.

Note: It has nothing to do with CSS styles, only CSS selectors for filtering, e.g. "#id > .class".

Limitations: it does not support namespaces, :not, :nth-child (only for numbers, but no equations) and it shows only distinct results.

It is possible to parse any XML (not limited to XHTML).

See also:

  * [Usage](../wiki/Usage.md)
  * [Accepted selectors](../wiki/AcceptedSelectors.md)
  * [API](../wiki/API.md)
