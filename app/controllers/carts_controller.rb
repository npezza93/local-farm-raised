# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end
end
