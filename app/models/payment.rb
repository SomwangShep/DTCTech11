class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
  belongs_to :chef

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1]}
  end
  
  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end
  
  def process_payment
    # Somwang - absolutely, positively make sure that when you get an actual API key, you DO NOT put it here. 
    # Put it in an initilaizer and load it from an environment variable
    # If you are lost on that email me when you get that far and have a key and are testing actual credit cards
    Stripe.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"
    
    customer = Stripe::Customer.create email: email
    puts "="*100
    puts customer.inspect
    card_token = Stripe::Token.create(card: {number: card_number,
                             exp_month: card_expires_month,
                             exp_year: card_expires_year,
                             cvc: card_cvv})
    puts card_token.inspect
    source = customer.sources.create(source: card_token.id)
    puts source.inspect
    charge = Stripe::Charge.create customer: customer.id,
                          amount: 1000,
                          description: 'Premium',
                          currency: 'usd'
    puts charge.inspect
    puts "="*100
  end
  
end
