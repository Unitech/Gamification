class Post < ActiveRecord::Base

  ##
  # Validations
  #

  validates :body, :presence => true
  validates :title, :presence => true

  ##
  # Associations
  #

  belongs_to :favorite_comment, :class_name => "Comment"
  belongs_to :typus_user
  has_and_belongs_to_many :categories
  has_many :comments
  has_many :views

  ##
  # Scopes
  #

  scope :draft, where(:status => "draft")
  scope :published, where(:status => "published")

  ##
  # Class Methods
  #

  def self.statuses
    { "Draft" => "draft",
      "Published" => "published",
      "Unpublished" => "unpublished",
      "<div class=''>Something special</div>".html_safe => "special" }
  end

  def self.numeric_statuses
    0.upto(5)
  end

  def self.array_selector
    %w(item1 item2)
  end

  def self.array_hash_selector
    [["Draft", "draft"],
     ["Custom Status", "custom"]]
  end

  def to_label
    title
  end

end
