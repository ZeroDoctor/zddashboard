import 'dart:html';

import 'component.dart';

class Carousel extends Component {
  final List<Element> _items;

  final String _className;
  final String _itemClassName;

  Carousel(this._items, [this._className = '', this._itemClassName = '']);

  @override
  Future<Element> render() async {
    String body = '';

    for (int i = 0; i < _items.length; i++) {
      int prev = i - 1;
      if (prev < 0) {
        prev = _items.length - 1;
      }

      int next = i + 1;
      if (next >= _items.length) {
        next = 0;
      }

      body +=
          """
      <div id="slide$i" class="carousel-item $_itemClassName">
        ${_items[i].outerHtml}
        <div class="absolute flex justify-between transform -translate-y-1/2 left-5 right-5 top-1/2">
          <a href="#slide$prev" class="btn btn-circle">&lt;</a>
          <a href="#slide$next" class="btn btn-circle">&gt;</a>
        </div>
      </div>
""";
    }

    return htmlToElements(
        """
    <div class="carousel w-full $_className">
      $body
    </div>
""");
  }
}
