class Todo
  include Mongoid::Document

  field :title, type: String
  field :due_date, type: Date
  field :due_time?, type: Boolean
  field :due_time, type: Time
  field :description, type: String


  validates :title, :due_date, :due_time?, :presence => true

  # Checks if the due_date (and if existing due_time) is already past
  def overdue?
    if due_time?
      due_date.past? and due_time.past?
    else
      due_date.past?
    end
  end

  def due
    if due_time?
      due_date.inspect + due_time.inspect
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
