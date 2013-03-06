class Todo
  include Mongoid::Document

  field :title, type: String
  field :due_date, type: DateTime
  field :has_due_time, type: Boolean
  field :description, type: String


  validates :title, :due_date, :has_due_time, :presence => true

  # Checks if the due_date (and if existing due_time) is already past
  def overdue?
    due_date.past?
  end

  def due
    if has_due_time
      due_date.inspect
    else
      due_date.inspect
    end
  end

  def description_with_size(size)
    if description.length > size
      description.first(size) + '...'
    else
      description.first(size)
    end
  end


end
