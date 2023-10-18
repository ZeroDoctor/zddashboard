import 'dart:html';

import '../src/components/hero.dart';
import '../src/components/navbar.dart';

Navbar createNavbar() {
  return Navbar(
    AnchorElement()
      ..className = 'text-2xl'
      ..href = '/'
      ..text = 'Dashboard',
    [
      Menu(
        AnchorElement()
          ..href = '/global-food'
          ..text = 'GlobalFood',
        [],
      ),
      Menu(
        AnchorElement()
          ..href = '/hello-world'
          ..text = 'Hello World',
        [],
      ),
      Menu(
        AnchorElement()
          ..href = '/micro'
          ..text = 'Micro',
        [],
      ),
    ],
    DivElement(),
  );
}

Hero createHero() {
  return Hero(
    "Hello there",
    DivElement(),
    backgroundImage:
        "https://free4kwallpapers.com/uploads/originals/2020/06/28/old-stories-wallpaper.jpg",
  );
}

Future<void> buildComponents() async {
  // render elements
  List<Element> responses =
      await Future.wait([createNavbar().render(), createHero().render()]);

  DivElement navbarContainer = querySelector('#navbar') as DivElement;
  navbarContainer.children.add(responses[0]);

  DivElement heroContainer = querySelector('#hero') as DivElement;
  heroContainer.children.add(responses[1]);
}

Future<void> main() async {
  await buildComponents();
}
