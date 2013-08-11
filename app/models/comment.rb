class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String
  field :abusive, type: Boolean, default: false
  field :votes, type: Array

  validates_presence_of :body

  embeds_one :user
  belongs_to :post, index: true

  scope :default, order_by(:created_at => :desc)

  before_create :set_votes

  def set_votes
    self.votes = []
  end

  def vote_up(user)
    vote user
  end

  def vote_down(user)
    vote(user, -1)
  end

  def karma
    votes.inject(0){|sum, n| sum + n['value'].to_i}
  end

  def voter?(user)
    voted_users = votes.map{|v| v['uid'] }
    voted_users.include? user.id
  end

  private 

  def vote(user = nil, value = 1)
    return false if user.nil? || voter?(user)
    votes << {:uid => user.id, :value => value}
    self.abusive = karma <= -3 
    save
  end
end
