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


  private 

  def vote(value = 1)
    voted_users = votes.map{|v| v.uid }
  end
end
