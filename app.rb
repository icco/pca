require "rubygems"
require "bundler"
Bundler.require(:default, ENV["RACK_ENV"] || :development)

Stripe.api_key = ENV["STRIPE_API_PRIVATE_KEY"]

get "/" do
  erb :form
end

post "/pay" do
  value = (params[:amount].to_f * 100).to_i
  if value >= 100
    @charge = Stripe::Charge.create(
      :amount => value,
      :currency => "usd",
      :card => params[:stripeToken],
      :description => "test payment")
    erb :thanks
  else
    redirect "/"
  end
end
