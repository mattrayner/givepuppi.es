class Puppy < ActiveRecord::Base
  has_attached_file :image, :styles => { :xlarge => "900x900>", :large => "600x600>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :orientation, presence: true

  scope :enabled, -> { where(disabled: false).by_orientation }
  scope :disabled, -> { where(disabled: true).by_orientation }

  scope :horizontal, -> { where(orientation: 'hor') }
  scope :vertical, -> { where(orientation: 'ver') }
  scope :square, -> { where(orientation: 'squ') }

  scope :by_orientation, -> { order(:orientation, :created_at) }
end
