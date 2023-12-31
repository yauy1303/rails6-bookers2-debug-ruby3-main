class Book < ApplicationRecord

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day)) }, class_name: 'Favorite'

  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

   #検索機能
  def self.looks(search, word)
    if search == 'parfect'
      books = Book.where("title Like?", "#{word}")
    elsif search == 'forward'
      books = Book.where("title Like?", "#{word}%")
    elsif search == 'backward'
      books = Book.where("title Like?", "%#{word}")
    else search == 'partial'
      books = Book.where("title Like?", "%#{word}%")
    end
  end

end
