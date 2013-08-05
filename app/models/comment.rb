class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String
  field :abusive, type: Boolean, default: false
  field :votes, type: Hash

  validates_presence_of :body

  belongs_to :user
  belongs_to :post, index: true


  private 

  def vote(value = 1)
  end
end
