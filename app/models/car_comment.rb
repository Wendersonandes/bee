class CarComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :carrinho
end
