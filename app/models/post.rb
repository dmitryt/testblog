class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false
  field :tags, type: String

  validates_presence_of :body, :title

  has_many :comments, :dependent => :destroy
  belongs_to :user

  accepts_nested_attributes_for :comments, :reject_if => proc { |attrs| attrs['body'].blank?  }

  default_scope ne(archived: true)

  def archive!
    update_attribute :archived, true
  end

  def tags_array
    tags.split(',').map &:strip if tags
  end

end
