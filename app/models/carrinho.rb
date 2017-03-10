class Carrinho < ActiveRecord::Base
	belongs_to :user
	has_many :orders, dependent: :destroy
	has_many :car_comments, dependent: :destroy
end
