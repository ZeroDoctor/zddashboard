import 'dart:html';

import 'component.dart';

class Card extends Component {
  final Element _header;
  final Element _title;
  final Element _body;
  final Element _action;
  final String _className;

  Card(this._header, this._title, this._body, this._action,
      [this._className = '']);

  @override
  Future<Element> render() async {
    _title.className += " card-title ";

    return htmlToElements("""
    <div class="card $_className">
      ${_header.outerHtml}
      <div class="card-body">
        ${_title.outerHtml}
        ${_body.outerHtml}
        <div class="card-actions justify-end">
          ${_action.outerHtml}
        </div>
      </div>
    </div>
""");
  }
}
