class Track < ActiveRecord::Base
  attr_accessible :name, :album_id
  validates :name, :album_id, presence: true

  belongs_to(
  :album,
  :class_name => 'Album',
  :primary_key => :id,
  :foreign_key => :album_id
  )
end
