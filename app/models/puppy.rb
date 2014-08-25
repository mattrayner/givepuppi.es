class Puppy < ActiveRecord::Base
  has_attached_file :image, :styles => { :xlg => '1200x1200>', :lg => '600x600>', :md => '300x300>', :sm => '200x200>', :thmb => '150x150>' }, :default_url => '/puppies/:style/missing.png', :url => '/puppies/:style/:id.:extension', :path => 'public/puppies/:style/:id.:extension'
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

  def get_orientation_of_image
    if self.image.queued_for_write[:original].nil?
      flash[:alert] = 'Unable to complete the request as the image provided is invalid or was not present. Please try again.'
      return nil
    else
      geometry = Paperclip::Geometry.from_file(self.image.queued_for_write[:original])

      orientation = nil
      if geometry.width.to_i > geometry.height.to_i
        orientation = 'hor'
      elsif geometry.height.to_i > geometry.width.to_i
        orientation = 'ver'
      elsif geometry.width.to_i == geometry.height.to_i
        orientation = 'squ'
      end

      raise 'Unsupported dimensions of image. This should not happen, let us know if it does.' if orientation.nil?

      orientation
    end
  end
end
