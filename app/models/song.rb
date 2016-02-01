class Song < ActiveRecord::Base
  has_paper_trail
  has_magick_columns title: :string, artist: :string, genre: :string

  validates :file, :title, :artist, :user_id, presence: true

  belongs_to :user

  def to_s
    self.title
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : all
  end

  def self.suggested
    all
  end
end
