class OrdersController < ApplicationController
  before_action :verify_order_owner, except: [:create]

  def create
    order = Order.create!(price_cents: 700, buyer: current_user, seller: User.first)
    redirect_to new_order_payment_path order

    authorize order
  end

  def show
  end

  def review
  end

  def delivery
  end

  private
  def verify_order_owner
    @order = Order.find(params[:id])
    authorize @order
  end
end
