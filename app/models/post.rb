class Post < ActiveRecord::Base
  acts_as_votable
  scope :starts_with, -> (caption) { where("caption like ?", "#{caption}%")}
  #searchkick autocomplete: ['caption']
  validates :attachment, presence: true
  mount_uploader :attachment, AttachmentUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_and_belongs_to_many :types

  validates :user_id, presence: true
  validates :image, presence: true
  validates :caption, length: { minimum: 1, maximum: 300 }

  has_attached_file :image, styles: { :medium => "640x", :thumb => '273x182#' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  scope :of_followed_users, -> (following_users) { where user_id: following_users }  

end
