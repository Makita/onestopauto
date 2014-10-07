class Staff < ActiveRecord::Base
  has_attached_file :image, styles: { cropped: { processors: [:resizer] } }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :image, attachment_presence: true

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :crop_arg

  def cropping?
    crop_x && crop_y && crop_w && crop_h && crop_w.to_i > 0 && crop_h.to_i > 0
  end

  def geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style)) rescue Paperclip::Geometry.new(0, 0)
  end

  def crop
    self.crop_arg = crop_arg_join(crop_x, crop_y, crop_w, crop_h) if cropping?
    image.reprocess!
  end

  def crop_arg_join(x, y, w, h)
    "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
  end
  

  def crop_arg_split(arg)
    match = arg.match(/(\d+)x(\d+)\+(\d+)\+(\d+)/i)

    raise 'Expected a valid crop arg.' unless match

    w, h, x, y = match.captures
    [x.to_i, y.to_i, w.to_i, h.to_i]
  end

  def crop_select
    default_size = ([geometry.width, geometry.height].min) / 5
    default_tl_x  = (geometry.width - default_size) / 2
    default_tl_y  = (geometry.height - default_size) / 2
    default = [default_tl_x, default_tl_y, default_size, default_size]
    result = if crop_arg
              crop_arg_split(crop_arg)
            else
              default
            end rescue default
    result
  end
end
