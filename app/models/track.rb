class Track < ActiveRecord::Base
  TRACK_TYPES = ["Regular", "Bonus"]

  attr_accessible :name, :album_id, :track_type, :lyrics
  validates :name, :album_id, :track_type, :lyrics, presence: true
  validates :track_type, inclusion: TRACK_TYPES

  belongs_to(
  :album,
  :class_name => 'Album',
  :primary_key => :id,
  :foreign_key => :album_id
  )

  has_many(
  :notes,
  :class_name => "Note",
  :primary_key => :id,
  :foreign_key => :track_id
  )
end
