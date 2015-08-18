#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Portfolio = 
  Models      : {}
  Collections : {}
  Routers     : {}
  Views       : {}
  initialize: =>
    new Portfolio.Routers.Base()
    Backbone.history.start({pushState:true})

# Call on jQuery object.
# Element = SVG element to insert
$.fn.insertSVG = (element) ->
  element = $(element)[0]
  tag = element.tagName
  attributes = element.attributes
  attrList = []
  for attr, index in attributes
    attrList.push attributes[index].nodeName

  svg = document.createElementNS 'http://www.w3.org/2000/svg', tag
  for attr, index in attributes
    svg.setAttribute attributes[index].name, attributes[index].value

  this[0].innerHTML = svg.outerHTML

$ ->
  Portfolio.initialize()

  $(document).on "click", "a:not([data-bypass])", (e) ->
    href = $(this).attr "href"
    protocol = @protocol + "//"
    if href and href.slice(0, protocol.length) != protocol and href.indexOf("javascript:") != 0
      e.preventDefault();
      Backbone.history.navigate(href, true)
