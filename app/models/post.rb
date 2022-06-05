class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many_attached :post_images

  validates :title, presence: true
  validates :body, presence: true
  validates :post_images, presence: true
  validates :address, presence: true
  validates :tag_list, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validate :validate_number_of_files
  
  #投稿にユーザーがいいねをしているかを確認するための
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  private
  #投稿画像の枚数制限のためのメソッド
  def validate_number_of_files
    return if post_images.length <= 5
    errors.add(:post_images, "に添付できる画像は5枚までです。")
  end

  #タグ情報を保存する
  acts_as_taggable
end
