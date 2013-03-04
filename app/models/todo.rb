class Todo
  include Mongoid::Document

  field :title, type: String
  field :due_date, type: Date
  field :description, type: String


  validates :title, :due_date, :presence => true

end
