class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.chronological.paginate(:page => params[:page]).per_page(10)
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully made'}
        format.json { render action: 'show', status: :created, location: @purchase}
        @item = @purchase.item
        @purchase = @item.item_prices.chronological.to_a
        @price_history = @item.item_prices.chronological.to_a
        format.js

        # redirect_to purchases_path, notice: "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}."
      else
        render action: 'new'
      end
    end
  end

  private
  def purchase_params
    params.require(:purchase).permit(:item_id, :quantity)
  end

end
