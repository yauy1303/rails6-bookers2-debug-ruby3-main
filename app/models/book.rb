class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

   #検索機能
  def self.looks(search, word)
    if search == 'parfect'
      book = Book.where("title Like?", "#{word}")
    elsif search == 'forward'
      book = Book.where("title Like?", "#{word}%")
    elsif search == 'backward'
      book = Book.where("title Like?", "%#{word}")
    else search == 'partial'
      book = Book.where("title Like?", "%#{word}%")
    end
  end

end
