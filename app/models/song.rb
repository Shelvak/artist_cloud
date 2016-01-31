class Song < ActiveRecord::Base
  has_paper_trail

  validates :file, :title, :artist, :user_id, presence: true
end
