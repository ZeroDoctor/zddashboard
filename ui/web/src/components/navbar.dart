import 'dart:html';

import '../util/stack.dart';
import '../util/svg.dart';
import 'component.dart';

class Menu {
  final Element element;
  final List<Menu> subMenus;

  Menu(this.element, this.subMenus);
}

class Navbar extends Component {
  final Element _startElement;
  final List<Menu> _menus;
  final Element _endElement;
  final String _className;

  Navbar(this._startElement, this._menus, this._endElement,
      [this._className = '']);

  @override
  Future<Element> render() async {
    StringBuffer menuBuffer = StringBuffer();

    Stack<List<Menu>> listMenuStack = Stack<List<Menu>>();

    for (var menu in _menus) {
      LIElement rootLi = LIElement();
      rootLi.children.add(menu.element);
      if (menu.subMenus.isNotEmpty) {
        menu.element.children.add(htmlToElements(svgDropArrow));
        rootLi.setAttribute("tabindex", "0");
        listMenuStack.push(menu.subMenus);
      }

      while (listMenuStack.isNotEmpty) {
        UListElement ul = UListElement();
        ul.className = "p-2 z-50";

        for (var menu in listMenuStack.pop()) {
          LIElement li = LIElement();
          li.children.add(menu.element);
          if (menu.subMenus.isNotEmpty) {
            menu.element.children.add(htmlToElements(svgDropArrow));
            li.setAttribute("tabindex", "0");

            UListElement ul = UListElement();
            listMenuStack.push(menu.subMenus);
            li.children.add(ul);
          }

          ul.children.add(li);
        }

        rootLi.children.add(ul);
      }

      menuBuffer.write(rootLi.outerHtml);
    }

    return htmlToElements("""
<div class="navbar bg-base-100 z-50 $_className">
  <div class="navbar-start">
    <div class="dropdown">
      <label tabindex="0" class="btn btn-ghost lg:hidden">
        $svgMenu
      </label>
      <ul tabindex="0" class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52">
        ${menuBuffer.toString()}
      </ul>
    </div>

    ${_startElement.outerHtml}
  </div>

  <div class="navbar-center hidden lg:flex">
    <ul class="menu menu-horizontal px-1">
      ${menuBuffer.toString()}
    </ul>
  </div>

  <div class="navbar-end">
    ${_endElement.outerHtml}
  </div>
</div>
""");
  }
}
