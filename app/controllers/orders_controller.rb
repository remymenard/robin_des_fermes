class OrdersController < ApplicationController
  before_action :skip_authorization
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

  def validation
  end

  private
  def verify_order_owner
    @order = Order.find(params[:id])

    # if order is not owned by this user
    if @order.buyer_id != current_user.id
      flash[:alert] = "Vous n'êtes pas autorisé à voir cette commande."
      return redirect_to root_path
    end
  end
end
