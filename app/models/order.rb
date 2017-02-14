class Order < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	belongs_to :printer
	belongs_to :carrinho
end
