// docs: https://github.com/jagenjo/litegraph.js/wiki/First-Project
// docs: https://htmlpreview.github.io/?https://raw.githubusercontent.com/jagenjo/litegraph.js/master/doc/classes/ContextMenu.html#api-classes

// ignore_for_file: non_constant_identifier_names

library litegraph.js;

import 'dart:html';

import 'package:js/js.dart';

@JS('LiteGraph.ContextMenu.prototype')
class ContextMenuProto {
  external List<dynamic> get values;
  external dynamic get options;
}

@JS('LiteGraph.ContextMenu')
class ContextMenu extends ContextMenuProto {
  external ContextMenuProto prototype;

  external ContextMenu([
    List<dynamic> values,
    dynamic options,
  ]);
}

@JS()
@anonymous
interface class INodeSlot {
  external String? name;
  external String? type;
  external String? label;
  external dynamic dir;
  external String? colorOn;
  external String? colorOff;
  external dynamic slotShape;
  external bool? locked;
  external bool? nameLocked;
}

@JS()
@anonymous
interface class INodeInputSlot extends INodeSlot {
  external LLink? link;
}

@JS()
@anonymous
interface class INodeOutputSlot extends INodeSlot {
  external List<LLink>? links;
}

typedef WidgetCallback<T extends IWidget<TValue, TOptions>, TValue, TOptions>
    = void Function(
  T t,
  TValue value,
  LGraphCanvas graphCanvas,
  LGraphNode node,
  List<num> pos,
  MouseEvent? event,
);

@JS()
@anonymous
interface class IWidget<TValue, TOptions> {
  external String? name;
  external TValue? value;
  external TOptions? options;
  external dynamic type;
  external num? y;
  external String? property;
  external num? lastY;
  external bool? clicked;
  external bool? marker;
  external WidgetCallback? callback;

  external void draw(
    CanvasRenderingContext2D ctx,
    LGraphNode node,
    num width,
    num posY,
    num height,
  );

  external bool mouse(
    MouseEvent event,
    List<num> pos,
    LGraphNode node,
  );

  external List<num> computeSize(
    num width,
  );
}

@JS()
@anonymous
interface class IButtonWidget extends IWidget<void, Object> {}

class ToggleOptions {
  String? on;
  String? off;
}

@JS()
@anonymous
interface class IToggleWidget extends IWidget<bool, ToggleOptions> {}

class SliderOptions {
  num? max;
  num? min;
}

@JS()
@anonymous
interface class ISliderWidget extends IWidget<num, SliderOptions> {}

class NumberOptions {
  num precision = 0.0;
}

@JS()
@anonymous
interface class INumberWidget extends IWidget<num, NumberOptions> {}

class ComboOptions {
  dynamic values;
}

@JS()
@anonymous
interface class IComboWidget extends IWidget<List<String>, ComboOptions> {}

@JS()
@anonymous
interface class ITextWidget extends IWidget<String, Object> {}

class SerializedLLink {
  num id = 0;
  String type = "";
  num originId = 0;
  num originSlot = 0;
  num targetId = 0;
  num targetSlot = 0;

  SerializedLLink(
    id,
    type,
    originId,
    originSlot,
    targetId,
    targetSlot,
  );

  SerializedLLink.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        type = json["type"],
        originId = json["origin_id"],
        originSlot = json["origin_slot"],
        targetId = json["target_id"],
        targetSlot = json["target_slot"];

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'origin_id': originId,
        'origin_slot': originSlot,
        'target_id': targetId,
        'target_slot': targetSlot
      };
}

@JS()
@anonymous
class LLinkProto {
  external num? id;
  external String? type;
  external num? originID;
  external num? originSlot;
  external num? targetID;
  external num? targetSlot;

  external void configure(dynamic o);
  external SerializedLLink serialize();
}

@JS('LiteGraph.LLink')
class LLink extends LLinkProto {
  external String name;
  external LLinkProto prototype;

  external LLink([
    num id,
    String type,
    num originID,
    num originSlot,
    num targetID,
    num targetSlot,
  ]);
}

class SerializedLGraphNode<T extends LGraphNode> {
  num id = 0;
  String title = "";
  String? type = "";
  List<num> pos = [];
  List<num> size = [];
  dynamic flags = {};
  int mode = 0;
  List<INodeInputSlot>? inputs;
  List<INodeOutputSlot>? outputs;
  Record properties = ();

  SerializedLGraphNode(
    id,
    title,
    type,
    pos,
    size,
    flags,
    mode,
    inputs,
    outputs,
    properties,
  );

  SerializedLGraphNode.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        type = json["type"],
        pos = json["pos"],
        size = json["size"],
        flags = json["flags"],
        mode = json["mode"],
        inputs = json["inputs"],
        outputs = json["outputs"],
        properties = json["properites"];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type,
        'pos': pos,
        'size': size,
        'flags': flags,
        'mode': mode,
        'inputs': inputs,
        'outputs': outputs,
        'properites': properties,
      };
}

class SubMenu {
  List<ContextMenuItem>? options;
}

mixin MenuMixin on SubMenu, IContextMenuOptions {}

interface class IContextMenuItem {
  String content = "";
  ContextMenuEventListener? callback;
  String? title;
  bool? disabled;
  bool? hasSubmenu;
  MenuMixin? subMenu;
  String? className;
}

interface class IContextMenuOptions {
  ContextMenuEventListener? callback;
  bool? ignoreItemCallbacks;
  dynamic event; // MouseEvent | CustomEvent;
  ContextMenu? parentMenu;
  bool? autoopen;
  String? title;
  dynamic extra;
}

typedef ContextMenuItem = IContextMenuItem?;
typedef ContextMenuEventListener = bool? Function(
  ContextMenuItem value,
  IContextMenuOptions options,
  MouseEvent event,
  ContextMenu? parentMenu,
  LGraphNode node,
);

class SerializedLGraphGroup {
  String title = "";
  LGraphGroup? bounding;
  LGraphGroup? color;
  LGraphGroup? font;

  SerializedLGraphGroup(
    title,
    bounding,
    color,
    font,
  );

  SerializedLGraphGroup.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        bounding = json["bounding"],
        color = json["color"],
        font = json["font"];

  Map<String, dynamic> toJson() => {
        'title': title,
        'bounding': bounding,
        'color': color,
        'font': font,
      };
}

@JS()
@anonymous
class LGraphGroup {
  external String title;
  external List<num> bounding;
  external String color;
  external String font;

  external void configure(SerializedLGraphGroup o);
  external SerializedLGraphGroup serialize();
  external void move(num deltaX, num deltaY, bool? ignoreNodes);
  external void recomputeInsideNodes();
  external bool Function(num x, num y) isPointInside;
}

@JS('LiteGraph.DragAndScale.prototype')
class DragAndScaleProto {
  external void bindEvents(HtmlElement element);
  external void computeVisibleArea();
  external void onMouse(MouseEvent e);
  external void toCanvasContext(CanvasRenderingContext2D ctx);
  external List<num> convertOffsetToCanvas(List<num> pos);
  external List<num> convertCanvasToOffset(List<num> pos);
  external void mouseDrag(num x, num y);
  external void changeScale(num value, List<num> zoomingCenter);
  external void changeDeltaScale(num value, List<num> zoomingCenter);
  external void reset();
}

@JS('LiteGraph.DragAndScale')
class DragAndScale extends DragAndScaleProto {
  external String name;
  external DragAndScaleProto prototype;

  external DragAndScale([
    HtmlElement element,
    bool skipEvents,
  ]);
}

@JS('LiteGraph')
external LiteGraph liteGraph;

@JS('LiteGraph')
@anonymous
class LiteGraph {
  external bool debug;
  external num VERSION;

  external LGraph lGraph;
  external LGraphCanvas lGraphCanvas;
  external LGraphNode lGraphNode;

  external void addNodeMethod(Function() func);
  external LGraphNode createNode([String? type, String? name, dynamic options]);
  external dynamic getNodeType(String type);
  external List<dynamic> getNodeTypeCategories();
  external void registerNodeType(String type, dynamic baseClass);
  external void wrapFunctionAsNode(String name, Function() func,
      List<dynamic> paramTypes, String returnType, dynamic properties);
}

@JS('LiteGraph.LGraph.prototype')
abstract class LGraphProto {
  external void add(dynamic node);
  external void addGlobalInput(String name, String type, dynamic value);
  external void addOutput(String name, String type, dynamic value);
  external void arrange();
  external void changeInputType(String name, String type);
  external void changeOutputType(String name, String type);
  external void clear();
  external void clearTriggeredSlots();
  external bool? configure(String str, bool returns);
  external void detachCanvas(LGraphCanvas graphCanvas);
  external List<LGraphNode> findNodesByClass(dynamic classObject);
  external List<LGraphNode> findNodesByTitle(String name);
  external List<LGraphNode> findNodesByType(String type);
  external List<LGraphNode> getAncestors(LGraphNode node);
  external num getElapsedTime();
  external num getFixedTime();
  external LGraphGroup getGroupOnPos(num x, num y);
  external dynamic getInputData(String name);
  external LGraphNode getNodeById(dynamic id);
  external LGraphNode getNodeOnPos(num x, num y, List<dynamic> nodesList);
  external void getOutputData(String name);
  external num getTime();
  external void isLive();
  external void remove(LGraphNode node);
  external bool removeInput(String name, String type);
  external void removeLink(num linkId);
  external void removeOutput(String name);
  external void renameInput(String oldName, String newName);
  external void renameOutput(oldName, newName);
  external void runStep(num num);
  external void sendEventToAllNodes(String eventName, List<dynamic> params);
  external dynamic serialize();
  external void setGlobalInputData(String name, dynamic data);
  external void setOutputData(String name, String value);
  external void start([num? interval]);
  external void stopExecution();
  external void updateExecutionOrder();
}

@JS('LiteGraph.LGraph')
class LGraph extends LGraphProto {
  external String name;
  external LGraphProto prototype;

  external LGraph([dynamic o]);
}

@JS('LiteGraph.LGraphCanvas.prototype')
class LGraphCanvasProto {
  external void clear();
  external void setGraph(LGraph graph, bool skipClear);
  external void openSubgraph(LGraph graph);
  external void closeSubgraph();
  external void setCanvas(CanvasElement canvas, bool skipEvents);
  external void bindEvents();
  external void unbindEvents();
  external void enableWebGL();
  external void setDirty(bool fg, bool bg);
  external Window getCanvasWindow();
  external void startRendering();
  external void stopRendering();
  external bool processMouseDown(MouseEvent e);
  external bool processMouseMove(MouseEvent e);
  external bool processMouseUp(MouseEvent e);
  external bool processMouseWheel(MouseEvent e);
  external bool isOverNodeBox(LGraphNode node, num canvasX, num canvasY);
  external bool isOverNodeInput(
      LGraphNode node, num canvasX, num canvasY, List<num> slotPos);
  external bool processKey(KeyboardEvent e);
  external void copyToClipboard();
  external void pasteFromClipboard();
  external void processDrop(MouseEvent e);
  external void checkDropItem(MouseEvent e);
  external void processNodeDblClicked(LGraphNode n);
  external void processNodeSelected(LGraphNode n, MouseEvent e);
  external void processNodeDeselected(LGraphNode node);
  external void selectNode(LGraphNode node, bool add);
  external void selectNodes(List<LGraphNode> nodes, bool add);
  external void deselectAllNodes();
  external void deleteSelectedNodes();
  external void centerOnNode(LGraphNode node);
  external void setZoom(num value, List<num> center);
  external void bringToFront(LGraphNode node);
  external void sendToBack(LGraphNode node);
  external List<LGraphNode> computeVisibleNodes(List<LGraphNode> nodes);
  external void draw(bool forceFG, bool forceBG);
  external void drawFrontCanvas();
  external void renderInfo(CanvasRenderingContext2D ctx, num x, num y);
  external void drawBackCanvas();
  external void drawNode(LGraphNode node, CanvasRenderingContext2D ctx);
  external void drawSlotGraphic(
      CanvasRenderingContext2D ctx, List<num> pos, num shape, bool horizontal);
  external void drawNodeShape(
      LGraphNode node,
      CanvasRenderingContext2D ctx,
      List<num> size,
      String fgColor,
      String bgColor,
      bool selected,
      bool mouseOver);
  external void drawConnections(CanvasRenderingContext2D ctx);
  external void renderLink(
      List<num> a,
      List<num> b,
      dynamic link,
      bool skipBorder,
      bool flow,
      String color,
      num startDir,
      num endDir,
      num numSublines);
  external void computeConnectionPoint(
      List<num> a, List<num> b, num t, num startDir, num endDir);
  external void drawExecutionOrder(CanvasRenderingContext2D ctx);
  external void drawNodeWidgets(LGraphNode node, num posY,
      CanvasRenderingContext2D ctx, dynamic activeWidget);
  external void processNodeWidgets(
      LGraphNode node, List<num> pos, Event event, dynamic activeWidget);
  external void drawGroups(dynamic canvas, CanvasRenderingContext2D ctx);
  external void adjustNodesSize();
  external void resize(num width, num height);
  external void switchLiveMode(bool transition);
  external void onNodeSelectionChange();
  external void touchHandler(TouchEvent event);
  external bool showLinkMenu(); // link LLink, dynamic e
  external DivElement prompt(
      String title, dynamic value, Function callback, dynamic event);
  external void showSearchBox(MouseEvent event);
  external void showEditPropertyValue(
      LGraphNode node, dynamic property, dynamic options);
  external void createDialog(String html, dynamic options);
  external List<num> convertEventToCanvasOffset(MouseEvent e);
  external void adjustMouseEvent(MouseEvent e);
  external List<ContextMenu> getCanvasMenuOptions();
}

@JS('LiteGraph.LGraphCanvas')
class LGraphCanvas extends LGraphCanvasProto {
  external String name;
  external LGraphCanvasProto prototype;

  external LGraphCanvas([
    dynamic canvas,
    LGraph? graph,
    dynamic options,
  ]);
}

@JS('LiteGraph.LGraphNode.prototype')
class LGraphNodeProto {
  external List<num> pos;

  external void addConnection(
      String name, String type, List<num> pos, String direction);
  external void addInput(String name, String type, [dynamic extraInfo]);
  external void addInputs(List<dynamic> array);
  external void addOutput(String name, String type, dynamic extraInfo);
  external void addOutputs(List<dynamic> array);
  external void addProperty(
      String name, dynamic defaultValue, String type, dynamic extraInfo);
  external dynamic addWidget();
  external void clearTriggeredSlot(num slot, num linkID);
  external void collapse();
  external num computeSize(num minHeight);
  external void configure(SerializedLGraphNode info);
  external T? connect<T, Y>(T slot, LGraphNode node, Y targetSlot);
  external bool disconnectInput<T>(T slot);
  external bool disconnectOutput<T>(T slot, LGraphNode targetNode);
  external num findInputSlot(dynamic name);
  external num findOutputSlot(dynamic name);
  external List<num> getBounding();
  external List<num> getConnectionPos<T>(bool isInput, T slot, List<num> out);
  external dynamic getInputData([num slot, bool forceUpdate]);
  external dynamic getInputDataByName(String slotName, bool forceUpdate);
  external String getInputDataType(num slot);
  external LGraphNode getInputInfo(num slot);
  external LGraphNode getInputNode(num slot);
  external dynamic getInputOrProperty(String name);
  external dynamic getOutputData(num slot);
  external dynamic getOutputInfo(num slot);
  external List<LGraphNode> getOutputNode(num slot);
  external dynamic getSlotInPosition(num x, num y);
  external String getTitle();
  external bool isAnyOutputConnected();
  external bool isInputConnected(num slot);
  external bool isOutputConnected(num slot);
  external bool isPointInside(num x, num y);
  external void pin();
  external void removeInput(num slot);
  external void removeOutput(num slot);
  external LGraphNode serialize();
  external void setOutputData(num slot, dynamic data);
  external void setOutputDataType(num slot, String datatype);
  external void setSize(List<num> size);
  external void setValue(num value);
  external void onExecute();
  @override
  external String toString();
  external void trigger(String event, dynamic param);
  external void triggerSlot(num slot, dynamic param, num linkID);
}

@JS('LiteGraph.LGraphNode')
class LGraphNode extends LGraphNodeProto {
  external String name;
  external LGraphNodeProto prototype;

  external LGraphNode([
    String? title,
  ]);
}
