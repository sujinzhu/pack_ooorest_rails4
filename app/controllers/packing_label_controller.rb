class PackingLabelController < ApplicationController
  def index
    @last = StockQuantPackage.last
  end
end
