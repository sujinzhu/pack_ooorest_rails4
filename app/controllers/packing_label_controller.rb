class PackingLabelController < ApplicationController
  def index
    @last = StockQuantPackage.last
  end

  def show
    @id = params[:id]

    @package = StockQuantPackage.find(@id)
  end

  def next
    @id = params[:id]

    @ids = StockQuantPackage.search([['id', '>', @id]])

    if @ids.length > 0
      redirect_to action: "show", id: @ids.first
    end
  end
end
