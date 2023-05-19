import 'dart:html';

void main() {
  BodyElement body = querySelector('#output') as BodyElement;

  body.innerText = "Hello, world!";
}
