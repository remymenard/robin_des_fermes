class Basket::MixpanelController < ApplicationController
  skip_before_action :authenticate_user!
  def open_basket
    skip_authorization
    order = current_order
    $tracker.track(session[:mixpanel_id], 'Open Basket', {
      'Order Price' => order.price.to_s,
      'Order Price Currency' => order.price_currency,
      'Farms Name' => order.farms.pluck(:name),
      'Products Name' => order.products.pluck(:name),
      'Products Count' => order.products.count
    })
  end
end
