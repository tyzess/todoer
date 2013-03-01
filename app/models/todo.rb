class Todo
  include Mongoid::Document

  field :title, type: String
  field :due, type: Date
  field :description, type: String

end
