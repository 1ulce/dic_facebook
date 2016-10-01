class Topic < ActiveRecord::Base
  validates :content, presence: true
  has_many :comments
  belongs_to :user
end
