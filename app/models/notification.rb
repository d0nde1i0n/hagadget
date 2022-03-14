class Notification < ApplicationRecord
  belongs_to :visitor
  belongs_to :visited
  belongs_to :gadget
  belongs_to :gadget_comment
end
