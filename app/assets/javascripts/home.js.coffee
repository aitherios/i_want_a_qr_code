$ ->
  new QrTextArea '#text', '#qrcode', '#download'

class QrTextArea
  constructor: (@textArea, @qrCodeArea, @downloadLink) ->
    @textArea = $ @textArea
    @qrCodeArea = $ @qrCodeArea
    @downloadLink = $ @downloadLink
    @timer = null

    @update()
    @textArea.keydown @keydown

  keydown: =>
    clearTimeout @timer
    @timer = setTimeout @update, 400

  update: =>
    @generateQr()
    @updateLink()

  generateQr: =>
    @qrCodeArea.empty()
    @qrCodeArea.qrcode @textArea.val()

  updateLink: =>
    @downloadLink.attr 'download', "#{@clean(@textArea.val())}.png"
    @downloadLink.attr 'href', @qrCodeArea.find('canvas')[0].toDataURL('image/png')

  clean: (string) =>
    string.replace(/^\w+:\/\//, '').replace(/\//, '_').replace(/:/, '').substring(0, 50)
