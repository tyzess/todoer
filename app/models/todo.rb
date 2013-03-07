class Todo
  include Mongoid::Document

  field :title, type: String
  field :due_date, type: DateTime
  field :has_due_time, type: Boolean
  field :description, type: String


  validates :title, :due_date, :presence => true

  # Checks if the due_date (and if existing due_time) is already past
  def overdue?
    due_date.past?
  end

  def datetime
    if has_due_time
      self.date + " " + self.time
    else
      self.date
    end
  end

  def date
    I18n.localize(due_date.to_date)
  end

  def time
    I18n.localize(due_date, :format => :'time')
  end

  def description_with_size(size)
    if description.length > size
      description.first(size) + '...'
    else
      description.first(size)
    end
  end


end
