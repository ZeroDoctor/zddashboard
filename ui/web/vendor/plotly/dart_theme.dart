import 'plotly.dart';

Template darkTheme = Template(
  data: Data(barpolar: [
    Style(
      marker: Marker(
        line: Line(
          color: 'rgb(17,17,17)',
          width: 0.5,
        ),
        pattern: Pattern(
          fillmode: 'overlay',
          size: 10,
          solidity: 0.2,
        ),
      ),
      type: 'barpolar',
    )
  ], bar: [
    Style(
      error_x: Error(color: '#f2f5fa'),
      error_y: Error(color: '#f2f5fa'),
      marker: Marker(
        line: Line(
          color: 'rgb(17,17,17)',
          width: 0.5,
        ),
        pattern: Pattern(
          fillmode: 'overlay',
          size: 10,
          solidity: 0.2,
        ),
      ),
      type: 'bar',
    )
  ], carpet: [
    Style(
      aaxis: Axis(
        endlinecolor: "#A2B1C6",
        gridcolor: "#506784",
        linecolor: "#506784",
        minorgridcolor: "#506784",
        startlinecolor: "#A2B1C6",
      ),
      baxis: Axis(
        endlinecolor: "#A2B1C6",
        gridcolor: "#506784",
        linecolor: "#506784",
        minorgridcolor: "#506784",
        startlinecolor: "#A2B1C6",
      ),
      type: 'carpet',
    )
  ], choropleth: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      type: 'choropleth',
    )
  ], contourcarpet: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      type: 'contourcarpet',
    )
  ], contour: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      colorscale: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"]
      ],
      type: 'contour',
    ),
  ], heatmapgl: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      colorscale: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"]
      ],
      type: 'heatmapgl',
    ),
  ], heatmap: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      colorscale: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"]
      ],
      type: 'heatmap',
    ),
  ], histogram2dcontour: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      colorscale: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"]
      ],
      type: 'heatmap2dcontour',
    ),
  ], histogram2d: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      colorscale: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"]
      ],
      type: 'histogram2d',
    ),
  ], histogram: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      colorscale: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"]
      ],
      type: 'histogram2d',
    ),
  ], mesh3d: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      type: 'mesh3d',
    ),
  ], parcoords: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      type: 'mesh3d',
    ),
  ], pie: [
    Style(
      automargin: true,
      type: 'pie',
    ),
  ], scatter3d: [
    Style(
      line: Line(
        colorbar: ColorBar(
          outlinewidth: 0,
          ticks: '',
        ),
      ),
      marker: Marker(
        colorbar: ColorBar(
          outlinewidth: 0,
          ticks: '',
        ),
      ),
      type: 'scatter3d',
    ),
  ], scattercarpet: [
    Style(
      marker: Marker(
        colorbar: ColorBar(
          outlinewidth: 0,
          ticks: '',
        ),
      ),
      type: 'scattercarpet',
    ),
  ], scattergeo: [
    Style(
      marker: Marker(
        colorbar: ColorBar(
          outlinewidth: 0,
          ticks: '',
        ),
      ),
      type: 'scattergeo',
    ),
  ], scattergl: [
    Style(
      marker: Marker(
        line: Line(
          color: '#283442',
        ),
      ),
      type: 'scattergl',
    ),
  ], scatterpolargl: [
    Style(
      marker: Marker(
        colorbar: ColorBar(
          outlinewidth: 0,
          ticks: '',
        ),
      ),
      type: 'scatterpolargl',
    ),
  ], scatterpolar: [
    Style(
      marker: Marker(
        colorbar: ColorBar(
          outlinewidth: 0,
          ticks: '',
        ),
      ),
      type: 'scatterpolar',
    ),
  ], scatter: [
    Style(
      marker: Marker(
        line: Line(
          color: '#283442',
        ),
      ),
      type: 'scatter',
    ),
  ], scatterternary: [
    Style(
      marker: Marker(
        colorbar: ColorBar(
          outlinewidth: 0,
          ticks: '',
        ),
      ),
      type: 'scatterternary',
    ),
  ], surface: [
    Style(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
      colorscale: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"]
      ],
      type: 'surface',
    )
  ], table: [
    Style(
      cells: Cell(
        fill: Fill(color: '#506784'),
        line: Line(color: 'rgb(17,17,17)'),
      ),
      header: Header(
        fill: Fill(color: '#2a3f5f'),
        line: Line(color: 'rgb(17,17,17)'),
      ),
      type: 'table',
    ),
  ]),
  layout: Layout(
    annotationdefaults: AnnotationDefaults(
      arrowcolor: '#f2f5fa',
      arrowhead: 0,
      arrowwidth: 1,
    ),
    autotypenumbers: 'strict',
    coloraxis: ColorAxis(
      colorbar: ColorBar(
        outlinewidth: 0,
        ticks: '',
      ),
    ),
    colorscale: ColorScale(
      diverging: [
        [0, "#8e0152"],
        [0.1, "#c51b7d"],
        [0.2, "#de77ae"],
        [0.3, "#f1b6da"],
        [0.4, "#fde0ef"],
        [0.5, "#f7f7f7"],
        [0.6, "#e6f5d0"],
        [0.7, "#b8e186"],
        [0.8, "#7fbc41"],
        [0.9, "#4d9221"],
        [1, "#276419"],
      ],
      sequential: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"],
      ],
      sequentialminus: [
        [0.0, "#0d0887"],
        [0.1111111111111111, "#46039f"],
        [0.2222222222222222, "#7201a8"],
        [0.3333333333333333, "#9c179e"],
        [0.4444444444444444, "#bd3786"],
        [0.5555555555555556, "#d8576b"],
        [0.6666666666666666, "#ed7953"],
        [0.7777777777777778, "#fb9f3a"],
        [0.8888888888888888, "#fdca26"],
        [1.0, "#f0f921"],
      ],
    ),
    colorway: [
      "#636efa",
      "#EF553B",
      "#00cc96",
      "#ab63fa",
      "#FFA15A",
      "#19d3f3",
      "#FF6692",
      "#B6E880",
      "#FF97FF",
      "#FECB52",
    ],
    font: Font(
      color: "#f2f5fa",
    ),
    geo: Geo(
      bgcolor: "rgb(17,17,17)",
      lakecolor: "rgb(17,17,17)",
      landcolor: "rgb(17,17,17)",
      showlakes: true,
      showland: true,
      subunitcolor: "#506784",
    ),
    hoverlabel: HoverLabel(
      align: "left",
    ),
    hovermode: 'closest',
    mapbox: MapBox(
      style: 'dart',
    ),
    paper_bgcolor: 'rgb(17,17,17)',
    plot_bgcolor: 'rgb(17,17,17)',
    polar: Polar(
      angularaxis: Axis(
        gridcolor: "#506784",
        linecolor: "#506784",
        ticks: "",
      ),
      radialaxis: Axis(
        gridcolor: "#506784",
        linecolor: "#506784",
        ticks: "",
      ),
      bgcolor: 'rgb(17,17,17)',
    ),
    scene: Scene(
      xaxis: Axis(
        backgroundcolor: "rgb(17,17,17)",
        gridcolor: "#506784",
        gridwidth: 2,
        linecolor: "#506784",
        showbackground: true,
        ticks: "",
        zerolinecolor: "#C8D4E3",
      ),
      yaxis: Axis(
        backgroundcolor: "rgb(17,17,17)",
        gridcolor: "#506784",
        gridwidth: 2,
        linecolor: "#506784",
        showbackground: true,
        ticks: "",
        zerolinecolor: "#C8D4E3",
      ),
      zaxis: Axis(
        backgroundcolor: "rgb(17,17,17)",
        gridcolor: "#506784",
        gridwidth: 2,
        linecolor: "#506784",
        showbackground: true,
        ticks: "",
        zerolinecolor: "#C8D4E3",
      ),
    ),
    shapedefaults: ShapeDefaults(
      line: Line(
        color: '#f2f5fa',
      ),
    ),
    sliderdefaults: SliderDefaults(
      bgcolor: "#C8D4E3",
      bordercolor: "rgb(17,17,17)",
      borderwidth: 1,
      tickwidth: 0,
    ),
    ternary: Ternary(
      aaxis: Axis(
        gridcolor: "#506784",
        linecolor: "#506784",
        ticks: "",
      ),
      baxis: Axis(
        gridcolor: "#506784",
        linecolor: "#506784",
        ticks: "",
      ),
      caxis: Axis(
        gridcolor: "#506784",
        linecolor: "#506784",
        ticks: "",
      ),
      bgcolor: 'rgb(17, 17, 17)',
    ),
    updatemenudefaults: UpdateMenuDefaults(
      bgcolor: "#506784",
      borderwidth: 0,
    ),
    xaxis: Axis(
      automargin: true,
      gridcolor: "#283442",
      linecolor: "#506784",
      ticks: "",
      title: Title(
        standoff: 15,
      ),
      zerolinecolor: "#283442",
      zerolinewidth: 2,
    ),
    yaxis: Axis(
      automargin: true,
      gridcolor: "#283442",
      linecolor: "#506784",
      ticks: "",
      title: Title(
        standoff: 15,
      ),
      zerolinecolor: "#283442",
      zerolinewidth: 2,
    ),
  ),
);
