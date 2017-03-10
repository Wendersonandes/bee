class Pedido < ActiveRecord::Base
	belongs_to :user
	has_many :ped_comments, dependent: :destroy
end
