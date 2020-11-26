class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :payment_webhook ]
  skip_before_action :verify_authenticity_token, only: [ :payment_webhook ]

  def show
    @order = Order.find(params[:id])
    if @order.buyer_id != current_user.id
      # if order is not owned by this user
      flash[:alert] = "You are not authorized to view this order."
      return redirect_to root_path
    end
    if @order.status == "waiting"
      @transaction_id = DatatransService.new.create_transaction(@order)
    end
  end

  def payment_webhook
    @datatrans = DatatransService.new
    return @datatrans.permission_denied unless @datatrans.datatrans_ip? request
    order = Order.find_by(transaction_id: params["transactionId"])
    if params["status"] == "settled"
      order.update(status: "paid")
    end
  end

  def payment_success
    payment_redirection(:success, 'payment.success')
  end

  def payment_cancel
    payment_redirection(:alert, 'payment.cancel')
  end

  def payment_error
    payment_redirection(:alert, 'payment.error')
  end

  private
  def payment_redirection(flash_type, flash_message)
    order = Order.find_by(transaction_id: params["datatransTrxId"])
    flash[flash_type] = t flash_message
    redirect_to order_path(order)
  end
end
