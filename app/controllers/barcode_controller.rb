require 'barby'
require 'barby/barcode/code_128'
require 'barby/barcode/qr_code'
require 'barby/outputter/svg_outputter'
require 'barby/outputter/html_outputter'
require 'barby/outputter/png_outputter'

class BarcodeController < ApplicationController
  Mime::Type.register "image/png", :png
  Mime::Type.register "image/svg+xml", :svg
  layout false

  def show
    content = params[:name]
    code = params[:code]

    case code
    when 'qr'
      @barcode = Barby::QrCode.new(content)
    else
      @barcode = Barby::Code128B.new(content)
    end

    respond_to do |format|
      format.html
      format.png
      format.svg
    end
  end
end
