import 'dart:html';

import '../../src/util/html.dart';

void main() {
  BodyElement body = querySelector('#output') as BodyElement;

  body.children.add(htmlStringToElement("""
    <div class="container mx-auto h-screen flex flex-col justify-center items-center prose prose-lg">
      <div>
        <h2>Hello, world!</h2>
      </div>

      <div>
        <a href="/">Home Page</a>
      </div>
    </div>
"""));
}
