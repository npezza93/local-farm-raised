class Subscription < ActiveRecord::Base

  def save_plan(amount, interval, name)
    Stripe::Plan.create(
      :amount => (amount.to_f*100).to_i,
      :interval => interval,
      :name => name,
      :currency => "usd",
      :id => plan_id
    )
    self.save!
  end
end
