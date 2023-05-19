import 'dart:html';

import 'component.dart';

class Collapse extends Component {

  final Element _header;
  final Element _body;
  final String _className;

  Collapse(this._header, this._body, [this._className = '']);

  @override
  Future<Element> render() async {
    return htmlToElements("""
<div class="collapse collapse-plus rounded-box $_className">
  <input type="checkbox" class="peer" />
  <div class="collapse-title border-base-500 bg-base-300 text-primary-content peer-checked:bg-secondary peer-checked:text-secondary-content">
    ${_header.outerHtml}
  </div>

  <div class="collapse-content border-base-500 bg-base-300 text-primary-content peer-checked:bg-secondary peer-checked:text-secondary-content">
    ${_body.outerHtml}
  </div>
</div>
""");
  }
}
