class Blog < ApplicationRecord
  after_create :create_initial_vote
    validates :name, :link, presence: true
    has_many :votes

    scope :upcoming, -> { where("votes_count < 5").order("id DESC") }
    scope :popular, -> { where("votes_count >= 5").order("id DESC")}

    def latest
        order('id DESC').limit(3)
    end
  protected
    def create_initial_vote
        votes.create user_id: user_id
    end 
end
