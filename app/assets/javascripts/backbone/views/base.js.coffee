class Portfolio.Views.Index extends Backbone.View
  template: JST["backbone/templates/index"]
  tagName: "section"

  getImages: =>
    arr = @getImageUrls()

    @images = arr

  getImageUrls: =>
    arr = []
    $("[js-images]").find("span").each ->
      path = $(this).text()
      arr.push $(this).text()

    arr

  createCircles: (count, width) =>
    options = {
      viewBox: 1800
      gutter: width / 5
      width: width
    }

    circleGroup = document.createElementNS "http://www.w3.org/2000/svg", "svg:svg"
    circleGroup.setAttributeNS null, "viewBox", "0 0 #{options.viewBox} #{options.viewBox}"
    circleGroup.setAttributeNS null, "id", "circles"

    context = this
    for index in [count...0]
      group = document.createElementNS "http://www.w3.org/2000/svg", "g"
      radius = index * width * 2 + width
      circleGroup.appendChild context.createCircle(group, radius, options, index, count)
    
    circleGroup

  createCircle: (group, radius, options, index, count) =>
    circle = document.createElementNS "http://www.w3.org/2000/svg", "circle"
    circleRadius = options.gutter + radius
    
    circle.setAttributeNS null, "r", circleRadius
    circle.setAttribute "style", "fill: url('#img#{index}');"
    group.appendChild(circle)

    group.appendChild @createPattern(group, index)
    @createWedge group, radius, options.gutter, options.width, options.viewBox, index, count

  createWedge: (group, radius, gutter, width, viewBox, index, count) =>
    size = radius + gutter
    path = document.createElementNS "http://www.w3.org/2000/svg", "path"
    unit = Math.PI * .02
    start = viewBox / 2
    startAngle = @randomInt(1, 100) * .01
    endAngle = @randomInt(40, 50) * unit
    x1 = size * Math.sin(startAngle) + start
    y1 = -size * Math.cos(startAngle) + start
    x2 = size * Math.sin(endAngle) + start
    y2 = -size * Math.cos(endAngle) + start
    big = 0
    if endAngle - startAngle > Math.PI
        big = 1
    # Start at half of viewbox
    d = "M#{start} #{start} #{start},#{start}" + " L " + x1 + "," + y1 + " A " + size + "," + size +
        " 0 " + big + " 1 " + x2 + "," + y2 +
        " Z"

    path.setAttribute "d", d # Set this path 
    path.setAttribute "style",
      "animation-duration: #{@randomInt(count - index + 5, 50)}s;
      transform-origin: #{ viewBox / 2 }px #{ viewBox / 2 }px 0;
      fill: #{$('body').css("background-color")};"
    group.appendChild path # Add wedge to chart

    @createGutter group, radius, gutter, width

  createGutter: (group, radius, gutter, width) =>
    circle = document.createElementNS "http://www.w3.org/2000/svg", "circle"
    circleRadius = radius - width * 2 + gutter * 2
    
    circle.setAttributeNS null, "r", circleRadius
    group.appendChild(circle)
    
    @randomInt 1, 10
    group

  createPattern: (group, index) =>
    defs = document.createElementNS "http://www.w3.org/2000/svg", "defs"
    
    pattern = document.createElementNS "http://www.w3.org/2000/svg", "pattern"
    pattern.setAttributeNS null, "patternUnits", "userSpaceOnUse"
    pattern.setAttributeNS null, "width", "3000"
    pattern.setAttributeNS null, "height", "3000"
    pattern.setAttributeNS null, "id", "img#{index}"

    image = document.createElementNS "http://www.w3.org/2000/svg", "image"
    imageUrl = @images[Math.floor(Math.random() * @images.length)]
    image.setAttributeNS 'http://www.w3.org/1999/xlink', 'xlink:href', imageUrl
    image.setAttribute "xlink:href", imageUrl
    image.setAttributeNS null, "x", "-500"
    image.setAttributeNS null, "y", "-500"
    image.setAttributeNS null, "width", "3000"
    image.setAttributeNS null, "height", "3000"

    pattern.appendChild image
    defs.appendChild pattern

    defs

  # Outputs random integer between 0 and 100
  randomInt: (minimum, maximum) =>
    int = Math.round(Math.random() * 100)
    
    if int < minimum or int > maximum
      @randomInt minimum, maximum
    else
      int

  render: =>
    @getImages()

    @$el[0].innerHTML = @template()
    
    @$el.find(".circles-container")[0].appendChild @createCircles 4, 60

    this
