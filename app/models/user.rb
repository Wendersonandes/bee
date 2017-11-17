class User < ActiveRecord::Base
  acts_as_voter
  scope :starts_with, -> (completo) { where("lower(completo) like ?", "%#{completo.downcase}%")}
  #searchkick autocomplete: ['completo']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #validates :name, presence: true, length: {minimum: 2, maximum: 16}
  #validates :sobrenome, presence: true, length: {minimum: 2, maximum: 16}

  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable,  :rememberable, :trackable, :validatable, :omniauthable

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      #user.email = auth.info.email
      user.name = auth.extra.raw_info.first_name
      user.sobrenome = auth.extra.raw_info.last_name
      user.completo = "#{user.name} #{user.sobrenome}"
      user.uid = auth.uid
      user.provider = auth.provider
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image
    end
    Follow.where(follower_id: user.id, following_id: user.id).first_or_create
    return user
  end

  has_many :posts, dependent: :destroy
  has_many :printers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :carrinhos, dependent: :destroy
  has_many :car_comments, dependent: :destroy
  has_many :ped_comments, dependent: :destroy
  has_many :pedidos, dependent: :destroy

  validates :name, presence: true
  validates :sobrenome, presence: true
  validates :email, presence: true
  
  has_attached_file :avatar, styles: { medium: '150x150#', :thumb => "100x100" }, :default_url => "/images/:style/missing.png",:s3_protocol => :https
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  def follow(user_id)  
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end
end
