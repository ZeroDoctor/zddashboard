import 'dart:html';

final NodeValidatorBuilder _htmlValidator = NodeValidatorBuilder.common()
  ..allowElement('a', attributes: ['data-target', 'data-toggle'])
  ..allowElement('button', attributes: ['data-target', 'data-toggle'])
  ..allowElement('ul', attributes: ['tabindex'])
  ..allowElement('li', attributes: ['tabindex'])
  ..allowElement('label', attributes: ['tabindex'])
  ..allowSvg()
  ;

Element htmlToElements(String html) {
    TemplateElement template = TemplateElement();
    template.setInnerHtml(html, validator: _htmlValidator);
    return template.content?.children[0] ?? DivElement();
}

abstract class Component {
  Future<Element> render() async {
    throw Error();
  }
}
