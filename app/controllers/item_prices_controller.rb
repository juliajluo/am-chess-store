class ItemPricesController < ApplicationController
  def index
    @active_items = Item.active.alphabetical.to_a
    authorize! :index, @active_items

  end

  def new
    @item_price = ItemPrice.new
    authorize! :new, @item_price

  end

  def create
    @item_price = ItemPrice.new(item_price_params)
    authorize! :create, @item_price
    @item_price.start_date = Date.current
    respond_to do |format|
      if @item_price.save
        format.html { redirect_to @item, notice: 'Item Price was successfully created.'}
        format.json { render action: 'show', status: :created, location: @item_price }
        @item = @item_price.item
        @item_price = @item.item_prices.chronological.to_a
        @price_history = @item.item_prices.chronological.to_a
        format.js

      else
        render action: 'new'
        format.json { render json: @attraction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :category)
  end

end
