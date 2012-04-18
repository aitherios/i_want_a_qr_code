$ ->
  new QrTextArea '#text', '#qrcode', '#download'

class QrTextArea
  constructor: (@textArea, @qrCodeArea, @downloadLink) ->
    @textArea = $ @textArea
    @qrCodeArea = $ @qrCodeArea
    @downloadLink = $ @downloadLink
    @timer = null

    @loadPathName()
    @update()
    @textArea.keydown @keydown

  keydown: =>
    clearTimeout @timer
    @timer = setTimeout @update, 400

  update: =>
    @generateQr()
    @updateLink()
    @updateURL()

  generateQr: =>
    @qrCodeArea.empty()
    @qrCodeArea.qrcode @textArea.val()

  updateLink: =>
    @downloadLink.attr 'download', "#{@clean(@textArea.val())}.png"
    @downloadLink.attr 'href', @qrCodeArea.find('canvas')[0].toDataURL('image/png')

  updateURL: =>
    window.history.replaceState 'state', @textArea.val(), "/#{@textArea.val()}"

  clean: (string) =>
    string.replace(/^\w+:\/\//, '').replace(/\//, '_').replace(/:/, '').substring(0, 50)

  loadPathName: =>
    @textArea.val window.location.pathname.replace(/^\//, '')
