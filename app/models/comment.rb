class Comment < ActiveRecord::Base
  belongs_to :article 
  belongs_to :user

  default_scope {order('created_at DESC')}

  #validates_presence_of :user_id, :article_id


end
