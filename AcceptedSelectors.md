# Accepted selectors #

It accepts pretty much the same operators as original cssQuery for javascript:


  * `*`
  * `E`
  * `E F`
  * `E > F`
  * `E + F`
  * `E ~ F`
  * `E.className`
  * `E#idName`
  * `E:link`
  * `E:first-child`
  * `E:last-child`
  * `E:nth-child(n)` _where n can only be a number_
  * `E:nth-last-child(n)` _where n can only be a number_
  * `E:only-child`
  * `E:root`
  * `E:lang(langName)`
  * `E:enabled`
  * `E:disabled`
  * `E:checked`
  * `E:contains(tagName)` _for now only tagName is accepted_
  * `E:not(tagName)` _for now only tagName is accepted_
  * `E[attributeName]`
_Parentheses for attributeValue are optional, though you have to use them if attribute has **`[`** or **`]`** signs in it or starts with **"** or **'** (escaping by \ works only when using apostrophes)_
  * `E[attributeName="attributeValue"]`
  * `E[attributeName~="attributeValue"]`
  * `E[attributeName^="attributeValue"]`
  * `E[attributeName$="attributeValue"]`
  * `E[attributeName*="attributeValue"]`
  * `E[attributeName|="attributeValue"]`

You can combine selectors in any way, e.g. `p > a:first-child + input[type=text] ~ span`