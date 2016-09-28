class Topic < ActiveRecord::Base
  validates :content, presence: true
  has_many :comments
end
