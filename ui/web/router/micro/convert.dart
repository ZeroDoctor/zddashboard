import '../../extern/litegraph/litegraph.dart';

class ConvertGraph {
  LGraph graph;

  ConvertGraph(this.graph);

  Map<String, dynamic> toMap() {
    return {
      "name": graph.name,
      "prototype": {
        "add": graph.prototype.add,
        "addGlobalInput": graph.prototype.addGlobalInput,
        "addOutput": graph.prototype.addOutput,
        "arrange": graph.prototype.arrange,
        "changeInputType": graph.prototype.changeInputType,
        "changeOutputType": graph.prototype.changeOutputType,
        "clear": graph.prototype.clear,
        "clearTriggeredSlots": graph.prototype.clearTriggeredSlots,
        "configure": graph.prototype.configure,
        "detachCanvas": graph.prototype.detachCanvas,
        "findNodesByClass": graph.prototype.findNodesByClass,
        "findNodesByTitle": graph.prototype.findNodesByTitle,
        "findNodeByType": graph.prototype.findNodesByType,
        "getAncestors": graph.prototype.getAncestors,
        "getElapsedTime": graph.prototype.getElapsedTime,
        "getFixedTime": graph.prototype.getFixedTime,
        "getGroupOnPos": graph.prototype.getGroupOnPos,
        "getInputData": graph.prototype.getInputData,
        "getNodeById": graph.prototype.getNodeById,
        "getNodeOnPos": graph.prototype.getNodeOnPos,
        "getOutputData": graph.prototype.getOutputData,
        "getTime": graph.prototype.getTime,
        "isLive": graph.prototype.isLive,
        "remove": graph.prototype.remove,
        "removeInput": graph.prototype.removeInput,
        "removeLink": graph.prototype.removeLink,
        "removeOutput": graph.prototype.removeOutput,
        "renameInput": graph.prototype.renameInput,
        "renameOutput": graph.prototype.renameOutput,
        "runStep": graph.prototype.runStep,
        "sendEventToAllNodes": graph.prototype.sendEventToAllNodes,
        "serialize": graph.prototype.serialize,
        "setGlobalInputData": graph.prototype.setGlobalInputData,
        "setOutputData": graph.prototype.setOutputData,
        "start": graph.prototype.start,
        "stopExecution": graph.prototype.stopExecution,
        "updateExecutionOrder": graph.prototype.updateExecutionOrder,
      },
    };
  }
}

class ConvertGraphNode {
  LGraphNode node;

  ConvertGraphNode(this.node);

  Map<String, dynamic> toMap() {
    return {};

    return {
      "name": node.name,
      "prototype": {
        "pos": node.prototype.pos,
        "addConnection": node.prototype.addConnection,
        "addInput": node.prototype.addInput,
        "addInputs": node.prototype.addInputs,
        "addOutput": node.prototype.addOutput,
        "addOutputs": node.prototype.addOutputs,
        "addProperty": node.prototype.addProperty,
        "addWidget": node.prototype.addWidget,
        "clearTriggredSlot": node.prototype.clearTriggeredSlot,
        "collapse": node.prototype.collapse,
        "computeSize": node.prototype.computeSize,
        "configure": node.prototype.configure,
        "connect": node.prototype.connect,
        "disconnectInput": node.prototype.disconnectInput,
        "disconnectOutput": node.prototype.disconnectOutput,
        "findInputSlot": node.prototype.findInputSlot,
        "findOutputSlot": node.prototype.findOutputSlot,
        "getBounding": node.prototype.getBounding,
        "getConnectionPos": node.prototype.getConnectionPos,
        "getInputData": node.prototype.getInputData,
        "getInputDataByName": node.prototype.getInputDataByName,
        "getInputDataType": node.prototype.getInputDataType,
        "getInputInfo": node.prototype.getInputInfo,
        "getInputNode": node.prototype.getInputNode,
        "getInputOrProperty": node.prototype.getInputOrProperty,
        "getOutputData": node.prototype.getOutputData,
        "getOutputInfo": node.prototype.getOutputInfo,
        "getOutputNode": node.prototype.getOutputNode,
        "getSlotInPosition": node.prototype.getSlotInPosition,
        "getTitle": node.prototype.getTitle,
        "isAnyOutputConnected": node.prototype.isAnyOutputConnected,
        "isInputConnected": node.prototype.isInputConnected,
        "isOutputConnected": node.prototype.isOutputConnected,
        "isPointInside": node.prototype.isPointInside,
        "pin": node.prototype.pin,
        "removeInput": node.prototype.removeInput,
        "removeOutput": node.prototype.removeOutput,
        // "serialize": node.prototype.serialize,
        "setOutputData": node.prototype.setOutputData,
        "setOutputDataType": node.prototype.setOutputDataType,
        "setSize": node.prototype.setSize,
        "setValue": node.prototype.setValue,
        "onExecute": node.prototype.onExecute,
        "toString": node.prototype.toString,
        "trigger": node.prototype.trigger,
        "triggerSlot": node.prototype.triggerSlot,
      },
    };
  }
}

abstract interface class ClassConvertMap {
  Map<String, dynamic> toMap();
}

Map<String, dynamic> dartToMap(ClassConvertMap convert) {
  return convert.toMap();
}
