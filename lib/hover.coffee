class Hover extends HTMLElement
  marker: null

  createdCallback: ->
    @classList.add 'lazy-motion-hover'
    this

  show: (editor, match, @textContent) ->
    @reset()
    @classList.remove('first', 'last')
    @classList.add(match.getClassList()...)
    @createOverlay editor, match.range

  createOverlay: (editor, range) ->
    @marker = editor.markBufferRange range,
      invalidate: "never",
      persistent: false

    editor.decorateMarker @marker,
      type: 'overlay'
      item: this
      position: 'head'

  reset: ->
    @marker?.destroy()
    @marker = null

  destroy: ->
    @reset()
    @remove()

Hover = document.registerElement 'lazy-motion-hover',
  prototype: Hover.prototype
  extends:   'div'

module.exports = Hover