class OrderItemsController < ApplicationController
  # def index
  #   @active_items = Item.active.alphabetical.to_a
  # end
  #
  # def new
  #   @item_price = ItemPrice.new
  # end
  #
  # def create
  #   @item_price = ItemPrice.new(item_price_params)
  #   @item_price.start_date = Date.current
  #   if @item_price.save
  #     @item = @item_price.item
  #     redirect_to item_path(@item), notice: "Changed the price of #{@item.name}."
  #   else
  #     render action: 'new'
  #   end
  # end
  #
  def edit
    authorize! :edit, @task
# in case this is a quick complete...
    if !params[:status].nil? && params[:status] == 'completed'
      @task.completed = true
      @task.completed_by = current_user.id
      @task.save!
      flash[:notice] = "#{@task.name} has been marked complete."
      if params[:from] == 'project'
        redirect_to project_path(@task.project)
      else
        redirect_to tasks_path
      end
    end
  end
  # private
  # def item_price_params
  #   params.require(:item_price).permit(:item_id, :price, :category)
  # end

end
