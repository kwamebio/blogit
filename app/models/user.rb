class User < ApplicationRecord
    has_secure_password
    has_many :blogs
    has_many :votes
    has_many :blogs_voted_on,
        through: :votes,
        source: :blog
  def to_param
    "#{id}-#{name}"
  end
end
