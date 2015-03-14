It has nothing to do with CSS styles, only CSS selectors for filtering, e.g. "#id > .class".

Based on cssQuery for javascript: http://dean.edwards.name/my/cssQuery/ , luckily it was lGPL. Rewriten for AS3 with usage of of E4X.

Limitations: it does not support namespaces, :not, :nth-child (only for numbers, but no equations) and it shows only distinct results.

After all, isn't

```
var value:String = html.cssQuery("#entry_form input[name=id]").xml.attribute("value");
```

simple and elegant? :)

It is possible to parse any XML, not only XHTML.

  * [Usage](Usage.md)
  * [Accepted selectors](AcceptedSelectors.md)
  * [API](API.md)