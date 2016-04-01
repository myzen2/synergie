class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates_presence_of   :titre, length: { minimum: 5 }
  validates_presence_of   :contenu
  validates_presence_of   :user_id

  default_scope -> {order('created_at DESC')}
  self.per_page = 5

end
