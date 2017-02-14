class Carrinho < ActiveRecord::Base
	belongs_to :user
	has_many :orders, dependent: :destroy
end
