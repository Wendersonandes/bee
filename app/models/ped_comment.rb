class PedComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :pedido
end
