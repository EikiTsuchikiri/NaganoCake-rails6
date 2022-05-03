class Public::HomesController < ApplicationController
  def top
    @genres = Genre.only_active.includes(:items)
    @items = Item.recommended
  end
end
