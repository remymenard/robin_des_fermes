class OrdersController < ApplicationController

  def create
    order = Order.create!(price_cents: 700, buyer: current_user, seller: User.first)
    redirect_to new_order_payment_path order

    authorize @order
  end

  def show
    @order = Order.find(params[:id])

    # if order is not owned by this user
    if @order.buyer_id != current_user.id
      flash[:alert] = "You are not authorized to view this order."
      return redirect_to root_path
    end

    authorize @order
  end
end
