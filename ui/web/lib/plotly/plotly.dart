// docs: https://plotly.com/javascript/

@JS('Plotly')
library plotly.js;

import 'package:js/js.dart';

external dynamic newPlot(
    String id, List<Data> data, Layout layout, Config config);

@JS()
@anonymous
class Data {
  external List<num> get x;
  external List<num> get y;
  external List<String> get labels;
  external String get type;
  external String get mode;
  external String get name;
  external Line get line;
  external List<Style> get barpolar;
  external List<Style> get bar;
  external List<Style> get carpet;
  external List<Style> get choropleth;
  external List<Style> get contourcarpet;
  external List<Style> get contour;
  external List<Style> get heatmapgl;
  external List<Style> get heatmap;
  external List<Style> get histogram2dcontour;
  external List<Style> get histogram2d;
  external List<Style> get histogram;
  external List<Style> get mesh3d;
  external List<Style> get parcoords;
  external List<Style> get pie;
  external List<Style> get scatter3d;
  external List<Style> get scattercarpet;
  external List<Style> get scattergeo;
  external List<Style> get scattergl;
  external List<Style> get scattermapbox;
  external List<Style> get scatterpolargl;
  external List<Style> get scatterpolar;
  external List<Style> get scatter;
  external List<Style> get scatterternary;
  external List<Style> get surface;
  external List<Style> get table;

  external factory Data({
    List<dynamic> x,
    List<dynamic> y,
    List<String> labels,
    String type,
    String mode,
    String name,
    Line line,
    List<Style> barpolar,
    List<Style> bar,
    List<Style> carpet,
    List<Style> choropleth,
    List<Style> contourcarpet,
    List<Style> contour,
    List<Style> heatmapgl,
    List<Style> heatmap,
    List<Style> histogram2dcontour,
    List<Style> histogram2d,
    List<Style> histogram,
    List<Style> mesh3d,
    List<Style> parcoords,
    List<Style> pie,
    List<Style> scatter3d,
    List<Style> scattercarpet,
    List<Style> scattergeo,
    List<Style> scattergl,
    List<Style> scattermapbox,
    List<Style> scatterpolargl,
    List<Style> scatterpolar,
    List<Style> scatter,
    List<Style> scatterternary,
    List<Style> surface,
    List<Style> table,
  });
}

@JS()
@anonymous
class Line {
  external String get color;
  external String get shape;
  external ColorBar get colorbar;
  external double get width;

  external factory Line({
    String color,
    String shape,
    ColorBar colorbar,
    double width,
  });
}

@JS()
@anonymous
class Fill {
  external String get color;

  external factory Fill({
    String color,
  });
}

@JS()
@anonymous
class Cell {
  external Fill get fill;
  external Line get line;

  external factory Cell({
    Fill fill,
    Line line,
  });
}

@JS()
@anonymous
class Header {
  external Fill get fill;
  external Line get line;

  external factory Header({
    Fill fill,
    Line line,
  });
}

@JS()
@anonymous
class Pattern {
  external String get fillmode;
  external int get size;
  external double get solidity;

  external factory Pattern({
    String fillmode,
    int size,
    double solidity,
  });
}

@JS()
@anonymous
class Error {
  external String get color;

  external factory Error({
    String color,
  });
}

@JS()
@anonymous
class Marker {
  external Line get line;
  external Pattern get pattern;
  external ColorBar get colorbar;

  external factory Marker({
    Line line,
    Pattern pattern,
    ColorBar colorbar,
  });
}

@JS()
@anonymous
class Style {
  external Marker get marker;
  external String get type;
  external Error get error_x;
  external Error get error_y;
  external ColorBar get colorbar;
  external List<List<dynamic>> get colorscale;
  external Cell get cells;
  external Header get header;
  external bool get automargin;
  external Axis get aaxis;
  external Axis get baxis;
  external Line get line;

  external factory Style({
    Marker marker,
    String type,
    Error error_x,
    Error error_y,
    ColorBar colorbar,
    List<List<dynamic>> colorscale,
    Cell cells,
    Header header,
    bool automargin,
    Axis aaxis,
    Axis baxis,
    Line line,
  });
}

@JS()
@anonymous
class Margin {
  external int get l;
  external int get r;
  external int get b;
  external int get t;
  external int get pad;

  external factory Margin({
    int l,
    int r,
    int b,
    int t,
    int pad,
  });
}

@JS()
@anonymous
class Layout {
  external String get title;
  external Template get template;
  external bool get showlegend;
  external bool get modebardisplay;
  external AnnotationDefaults get annotationdefaults;
  external String get autotypenumbers;
  external ColorAxis get coloraxis;
  external ColorScale get colorscale;
  external List<String> get colorway;
  external Font get font;
  external Geo get geo;
  external HoverLabel get hoverlabel;
  external String get hovermode;
  external MapBox get mapbox;
  external String get plot_bgcolor;
  external String get paper_bgcolor;
  external Polar get polar;
  external Scene get scene;
  external ShapeDefaults get shapedefaults;
  external SliderDefaults get sliderdefaults;
  external Ternary get ternary;
  external UpdateMenuDefaults get updatemenudefaults;
  external Axis get xaxis;
  external Axis get yaxis;
  external bool get autosize;
  external int get width;
  external int get height;
  external Margin get margin;

  external factory Layout({
    String title,
    bool showlegend,
    bool modebardisplay,
    Template template,
    AnnotationDefaults annotationdefaults,
    String autotypenumbers,
    ColorAxis coloraxis,
    ColorScale colorscale,
    List<String> colorway,
    Font font,
    Geo geo,
    HoverLabel hoverlabel,
    String hovermode,
    MapBox mapbox,
    String paper_bgcolor,
    String plot_bgcolor,
    Polar polar,
    Scene scene,
    ShapeDefaults shapedefaults,
    SliderDefaults sliderdefaults,
    Ternary ternary,
    UpdateMenuDefaults updatemenudefaults,
    Axis xaxis,
    Axis yaxis,
    bool autosize,
    int width,
    int height,
    Margin margin,
  });
}

@JS()
@anonymous
class AnnotationDefaults {
  external String get arrowcolor;
  external int get arrowhead;
  external int get arrowwidth;

  external factory AnnotationDefaults({
    String arrowcolor,
    int arrowhead,
    int arrowwidth,
  });
}

@JS()
@anonymous
class ColorAxis {
  external ColorBar get colorbar;

  external factory ColorAxis({
    ColorBar colorbar,
  });
}

@JS()
@anonymous
class ColorBar {
  external int get outlinewidth;
  external String get ticks;

  external factory ColorBar({
    int outlinewidth,
    String ticks,
  });
}

@JS()
@anonymous
class ColorScale {
  external List<List<dynamic>> get diverging;
  external List<List<dynamic>> get sequential;
  external List<List<dynamic>> get sequentialminus;

  external factory ColorScale({
    List<List<dynamic>> diverging,
    List<List<dynamic>> sequential,
    List<List<dynamic>> sequentialminus,
  });
}

@JS()
@anonymous
class Font {
  external String get color;

  external factory Font({
    String color,
  });
}

@JS()
@anonymous
class Geo {
  external String get bgcolor;
  external String get lakecolor;
  external String get landcolor;
  external bool get showlakes;
  external bool get showland;
  external String get subunitcolor;

  external factory Geo({
    String bgcolor,
    String lakecolor,
    String landcolor,
    bool showlakes,
    bool showland,
    String subunitcolor,
  });
}

@JS()
@anonymous
class HoverLabel {
  external String get align;

  external factory HoverLabel({
    String align,
  });
}

@JS()
@anonymous
class MapBox {
  external String get style;

  external factory MapBox({
    String style,
  });
}

@JS()
@anonymous
class Polar {
  external Axis get angularaxis;
  external String get bgcolor;
  external Axis get radialaxis;

  external factory Polar({
    Axis angularaxis,
    String bgcolor,
    Axis radialaxis,
  });
}

@JS()
@anonymous
class Axis {
  external bool get automargin;
  external String get backgroundcolor;
  external String get gridcolor;
  external String get minorgridcolor;
  external int get gridwidth;
  external String get linecolor;
  external bool get showbackground;
  external String get startlinecolor;
  external String get endlinecolor;
  external String get zerolinecolor;
  external int get zerolinewidth;
  external String get ticks;
  external Title get title;

  external factory Axis({
    bool automargin,
    String backgroundcolor,
    String gridcolor,
    String minorgridcolor,
    int gridwidth,
    String linecolor,
    bool showbackground,
    String startlinecolor,
    String endlinecolor,
    String zerolinecolor,
    int zerolinewidth,
    String ticks,
    Title title,
  });
}

@JS()
@anonymous
class Scene {
  external Axis get xaxis;
  external Axis get yaxis;
  external Axis get zaxis;

  external factory Scene({
    Axis xaxis,
    Axis yaxis,
    Axis zaxis,
  });
}

@JS()
@anonymous
class ShapeDefaults {
  external Line get line;

  external factory ShapeDefaults({
    Line line,
  });
}

@JS()
@anonymous
class SliderDefaults {
  external String get bgcolor;
  external String get bordercolor;
  external int get borderwidth;
  external int get tickwidth;

  external factory SliderDefaults({
    String bgcolor,
    String bordercolor,
    int borderwidth,
    int tickwidth,
  });
}

@JS()
@anonymous
class Ternary {
  external Axis get aaxis;
  external Axis get baxis;
  external Axis get caxis;
  external String get bgcolor;

  external factory Ternary({
    Axis aaxis,
    Axis baxis,
    Axis caxis,
    String bgcolor,
  });
}

@JS()
@anonymous
class Title {
  external double get x;
  external int get standoff;

  external factory Title({
    double x,
    int standoff,
  });
}

@JS()
@anonymous
class UpdateMenuDefaults {
  external String get bgcolor;
  external int get borderwidth;

  external factory UpdateMenuDefaults({
    String bgcolor,
    int borderwidth,
  });
}

@JS()
@anonymous
class Template {
  external Layout get layout;
  external Data get data;

  external factory Template({
    Layout layout,
    Data data,
  });
}

@JS()
@anonymous
class Config {
  external bool get displayModeBar;
  external bool get staticPlot;
  external bool get editable;
  external bool get scrollZoom;
  external bool get displayLogo;
  external bool get responsive;
  external ButtonConfig get toImageButtonOptions;

  external factory Config({
    bool displayModeBar,
    bool staticPlot,
    bool editable,
    bool scrollZoom,
    bool displayLogo,
    bool responsive,
    ButtonConfig toImageButtonOptions,
  });
}

@JS()
@anonymous
class ButtonConfig {
  external String get format; // png, svg, jpeg, webp
  external String get filename;
  external int get height;
  external int get width;
  external int get scale;
}
