class Song < ActiveRecord::Base
  has_paper_trail

  validates :file, :title, :artist, :user_id, presence: true

  belongs_to :user

  def to_s
    self.title
  end
end
