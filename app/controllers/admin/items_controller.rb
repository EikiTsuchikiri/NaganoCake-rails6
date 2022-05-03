class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.includes(:genre)
    end
    @items = all_items.page(params[:page])
    @all_items_count = all_items.count
  end

  def create
    @item = Item.new(item_params)
    @item.save ? (redirect_to admin_item_path(@item)) : (render :new)
  end

  def show
  end

  def edit
  end

  def update
    @item.update(item_params) ? (redirect_to admin_item_path(@item)) : (render :edit)
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :image, :price, :is_active)
  end

  def ensure_item
    @item = Item.find(params[:id])
  end
end
