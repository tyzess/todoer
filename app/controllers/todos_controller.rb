class TodosController < ApplicationController

  @@backup = nil

  # Passes an empty to-do to the 'new' form
  def new
    @todo = Todo.new
  end

  # Passes an array with all to-dos to list them
  def index
    @todos = Todo.all
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

  def delete
    @todo = Todo.find(params[:id])
    @@backup = @todo.clone
    if @todo.destroy
      flash[:undo_file] = true
      redirect_to todos_path, notice: 'Successfully deleted todo'
    else
      redirect_to todos_path, error: 'Could not delete todo'
    end
  end

  # Creates the to-do if possible, otherwise it redirects to the creation aka 'new' form
  def create
    @todo = Todo.new(params[:todo])
    @todo.due_date = DateTime.new(params[:todo]["due_date(1i)"].to_i, params[:todo]["due_date(2i)"].to_i, params[:todo]["due_date(3i)"].to_i)
    if @todo.save
      redirect_to todos_path, notice: 'Successfully created new todo'
    else
      flash[:error] = 'Could not create the todo'
      render :new
    end
  end

  def restore
    if @@backup.save
     redirect_to todos_path, notice: 'Successfully restored todo'
    else
      redirect_to todos_path, notice: 'Could not restore todo, sorry man!'
    end
  end

end
