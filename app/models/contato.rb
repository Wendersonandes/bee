class Contato < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true
	validates :mensagem, presence: true
end