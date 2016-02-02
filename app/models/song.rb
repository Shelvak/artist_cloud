class Song < ActiveRecord::Base
  has_paper_trail
  has_magick_columns title: :string, artist: :string, genre: :string
  mount_uploader :file, AudioUploader

  scope :default_order, -> { order(artist: :asc, album: :asc, track: :asc) }

  validates :title, :artist, :user_id, presence: true
  validate :file_presence

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

  def file_presence
    if file.blank?
      self.errors.add :file, :blank
      false
    end
  end
end
