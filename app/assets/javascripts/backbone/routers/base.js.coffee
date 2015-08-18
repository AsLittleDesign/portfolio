class Portfolio.Routers.Base extends Backbone.Router
  routes:
    ""      : "index"

  index: =>
    view = new Portfolio.Views.Index()
    $("body")[0].appendChild(view.render().$el[0])
