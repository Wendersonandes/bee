class Printer < ActiveRecord::Base
	belongs_to :user
	has_many :orders
	has_many :materials, inverse_of: :printer, dependent: :destroy
	accepts_nested_attributes_for :materials, reject_if: :all_blank, allow_destroy: true
	validates :name, presence: true
	validates :marca, presence: true
	validates :modelo, presence: true
end
