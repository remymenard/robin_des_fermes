class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :add_product ]

  def show
    @order = Order.find(params[:id])

    # if order is not owned by this user
    if @order.buyer_id != current_user.id
      flash[:alert] = "You are not authorized to view this order."
      return redirect_to root_path
    end
  end
end
