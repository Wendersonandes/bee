class Post < ActiveRecord::Base
  acts_as_votable
  scope :starts_with, -> (caption) { where("lower(caption) like ?", "%#{caption.downcase}%")}
  #searchkick autocomplete: ['caption']
  validates :attachment, presence: true
  mount_uploader :attachment, AttachmentUploader

  has_many :orders, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_and_belongs_to_many :types

  validates :user_id, presence: true
  validates :caption, length: { minimum: 1, maximum: 300 }
  validates :volume, presence: true
  validates :x, presence: true
  validates :y, presence: true
  validates :z, presence: true

  has_attached_file :image, styles: { :medium => "640x420#", :thumb => '273x182#' }, :default_url => "/images/:style/drogon.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  scope :of_followed_users, -> (following_users) { where user_id: following_users }  

end
