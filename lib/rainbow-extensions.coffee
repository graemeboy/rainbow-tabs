RainbowExtensionsView = require './rainbow-extensions-view'
{CompositeDisposable} = require 'atom'

module.exports = RainbowExtensions =
  rainbowExtensionsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @rainbowExtensionsView = new RainbowExtensionsView(state.rainbowExtensionsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @rainbowExtensionsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'rainbow-extensions:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @rainbowExtensionsView.destroy()

  serialize: ->
    rainbowExtensionsViewState: @rainbowExtensionsView.serialize()

  toggle: ->
    console.log 'RainbowExtensions was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
