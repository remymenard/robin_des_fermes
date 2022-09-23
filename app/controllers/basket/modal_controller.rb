module Basket
  class ModalController < ApplicationController
    skip_before_action :authenticate_user!

    def update_modal
      @test = "yes"
      render partial: 'shared/cart_modal'
    end

  end
end
