class PackingLabelController < ApplicationController
  def index
    @last = StockQuantPackage.last
  end

  def show
    @id = params[:id]

    @package = StockQuantPackage.find(@id)
  end
end
