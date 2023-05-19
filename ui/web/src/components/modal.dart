import 'dart:html';

import '../util/rand.dart';
import 'component.dart';

class Modal extends Component {
  final String _id = randString(12);
  final Element _trigger;
  final Element _body;
  final Element _action;

  final String _className;

  Modal(this._trigger, this._body, this._action, [this._className = '']);

  @override
  Future<Element> render() async {
    _trigger.id = _id;
    return htmlToElements("""
    ${_trigger.outerHtml}
    
    <div class="modal $_className" id="$_id">
      <div class="modal-box">
        ${_body.outerHtml}
      </div>
      <div class="modal-action">
        ${_action.outerHtml}
      </div>
    </div>
""");
  }
}
