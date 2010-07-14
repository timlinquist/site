class Presentation < ActiveRecord::Base
  belongs_to :video
  belongs_to :presenter
end
