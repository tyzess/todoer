class TodosController < ApplicationController

  @@backup = nil

  # Passes an empty to-do to the 'new' form
  def new
    @todo = Todo.new
  end

  # Passes an array with all to-dos to list them
  def index
    @todos = Todo.all.sort{ |a,b| a.due_date <=> b.due_date }
  end

  # Passes the to-do that shall be displayed
  def show
    @todo = Todo.find(params[:id])
  end

  # Passes the to-do that shall be edited
  def edit
    @todo = Todo.find(params[:todo])
  end

  # Updates the to-do with the new data if possible, otherwise redirects to the 'edit' form
  def update
    #todo lol, what sense of humor ;)
  end

  # Deletes a to-do with the same id
  def delete
    @todo = Todo.find(params[:id])
    @@backup = @todo.clone
    if @todo.destroy
      flash[:type] = 'success'
      flash[:title] = 'Successfully deleted todo "' + @todo.title + '"'
      flash[:options] = {:content => 'Restore', :class => 'btn btn-small pull-right', :href => restore_todo_path, :method => 'post'}
      redirect_to todos_path
    else
      flash[:type] = 'error'
      flash[:title] = 'Could not delete todo "' + @todo.title + '"'
      redirect_to todos_path
    end
  end

  # Creates the to-do if possible, otherwise it redirects to the creation aka 'new' form
  def create
    @todo = Todo.new
    @todo.title = params[:todo][:title]
    @todo.description = params[:todo][:description]
    @todo.has_due_time = params[:todo][:has_due_time]
    if @todo.has_due_time
      @todo.due_date = DateTime.new(params[:todo]["due_date(1i)"].to_i,
                                    params[:todo]["due_date(2i)"].to_i,
                                    params[:todo]["due_date(3i)"].to_i,
                                    params[:todo]['due_date(4i)'].to_i,
                                    params[:todo]['due_date(5i)'].to_i)
    else
      @todo.due_date = DateTime.new(params[:todo]["due_date(1i)"].to_i,
                                    params[:todo]["due_date(2i)"].to_i,
                                    params[:todo]["due_date(3i)"].to_i)
    end

    if @todo.save
      flash[:type] = 'success'
      flash[:title] = 'Successfully created new todo "' + @todo.title + '"'
      redirect_to todos_path
    else
      flash[:type] = 'error'
      flash[:title] = 'Could not create the todo'
      render :new
    end
  end

  # Restores the latest deleted to-do that has been backup'd in the global backup variable
  def restore
    if @@backup.save
      flash[:type] = 'success'
      flash[:title] = 'Successfully restored todo "' + @@backup.title + '"'
      @@backup = nil
      redirect_to todos_path
    else
      flash[:type] = 'error'
      flash[:title] = 'Could not restore todo, sorry man!'
      redirect_to todos_path
    end
  end

end
