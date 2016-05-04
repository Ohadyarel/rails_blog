class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	validates :blog_title, :name, :email, :password, presence: true
end
