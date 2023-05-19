import 'dart:html';

Element htmlStringToElement(String html) {
  DomParser parser = DomParser();
  Document doc = parser.parseFromString(html, "text/html");
  return doc.documentElement?.children[1].children[0] ?? Element.div();
}
