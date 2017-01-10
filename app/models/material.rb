class Material < ActiveRecord::Base
  belongs_to :printer, inverse_of: :materials
  has_and_belongs_to_many :colors, dependent: :destroy
  validates :name, presence: true
end
