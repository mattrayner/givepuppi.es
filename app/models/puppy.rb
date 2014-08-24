class Puppy < ActiveRecord::Base
  has_attached_file :image, :styles => { :xlg => '1200x1200>', :lg => '600x600>', :md => '300x300>', :thmb => '150x150>' }, :default_url => '/puppies/:style/missing.png', :url => '/puppies/:style/:id.:extension', :path => 'puppies/:style/:id.:extension'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :orientation, presence: true

  scope :enabled, -> { where(disabled: false).by_orientation }
  scope :disabled, -> { where(disabled: true).by_orientation }

  scope :horizontal, -> { where(orientation: 'hor') }
  scope :vertical, -> { where(orientation: 'ver') }
  scope :square, -> { where(orientation: 'squ') }

  scope :by_orientation, -> { order(:orientation, :created_at) }

  def enabled?
    !self.disabled?
  end
end
