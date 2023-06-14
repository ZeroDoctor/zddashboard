import 'dart:html';

import 'component.dart';

class Hero extends Component {
  final String _title;
  final Element _body;
  final Element? action;
  final String backgroundImage;
  final String className;

  Hero(
    this._title,
    this._body, {
    this.action,
    this.backgroundImage = '',
    this.className = '',
  });

  @override
  Future<Element> render() async {
    String backgroundImage = '';
    String overlay = '';
    if (this.backgroundImage.isNotEmpty) {
      backgroundImage =
          'style="background-image: url(${this.backgroundImage})"';
      overlay = '<div class="hero-overlay bg-opacity-60"></div>';
    }

    String action = this.action?.outerHtml ?? "";

    return htmlToElements("""
    <div class="hero min-h-screen $className" $backgroundImage>
      $overlay
      <div class="hero-content flex-col lg:flex-row">
        <div class="text-center lg:text-left">
          <h1 class="text-5xl font-bold">$_title</h1>
          ${_body.outerHtml}
        </div>
        $action
      </div>
    </div> 
    """);
  }
}
