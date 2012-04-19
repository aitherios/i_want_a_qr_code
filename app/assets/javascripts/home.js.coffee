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
    @textArea.keydown @setTimer
    @textArea.change @setTimer

  setTimer: =>
    clearTimeout @timer
    @timer = setTimeout @update, 250

  update: =>
    @updateURL()
    @generateQr()
    @updateLink()

  generateQr: =>
    @qrCodeArea.empty()
    @qrCodeArea.qrcode
      text: @textArea.val()
      correctLevel: QRErrorCorrectLevel.L

  updateLink: =>
    @downloadLink.attr 'download', "#{@clean(@textArea.val()) || 'qrcode'}.png"
    @downloadLink.attr 'href', @qrCodeArea.find('canvas')[0].toDataURL('image/png')

  updateURL: =>
    window.history.replaceState 'state', @textArea.val(), "/#{@textArea.val()}"

  clean: (string) =>
    string.replace(/^\w+:\/\//, '').replace(/\//, '_').replace(/:/, '').substring(0, 50)

  loadPathName: =>
    @textArea.val unescape(window.location.pathname.replace(/^\//, ''))
