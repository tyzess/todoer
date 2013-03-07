class TodosController < ApplicationController

  @@backup = nil


  def new
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
    #todo not yet done
  end

  # Deletes a to-do with the same id
  def delete
    @todo = Todo.find(params[:id])
    @@backup = @todo.clone
    if @todo.destroy
      flash[:type] = 'success'
      flash[:title] = t(:successful_delete_todo, :todo => @todo.title)
      #todo that ain't clean! v
      flash[:options] = {:content => t(:restore_button), :class => 'btn btn-small pull-right', :href => restore_todo_path, :method => 'post'}
      redirect_to todos_path
    else
      flash[:type] = 'error'
      flash[:title] = t(:unsuccessful_delete_todo, :todo => @todo.title)
      redirect_to todos_path
    end
  end

  # Creates the to-do if possible, otherwise it redirects to the creation aka 'new' form
  def create
    @new_todo = Todo.new
    @new_todo.title = params[:todo][:title]
    @new_todo.description = params[:todo][:description]
    @new_todo.has_due_time = params[:todo][:has_due_time]
    if @new_todo.has_due_time
      @new_todo.due_date = DateTime.new(params[:todo]['due_date(1i)'].to_i,
                                    params[:todo]['due_date(2i)'].to_i,
                                    params[:todo]['due_date(3i)'].to_i,
                                    params[:todo]['due_time(4i)'].to_i,
                                    params[:todo]['due_time(5i)'].to_i)
    else
      @new_todo.due_date = DateTime.new(params[:todo]['due_date(1i)'].to_i,
                                    params[:todo]['due_date(2i)'].to_i,
                                    params[:todo]['due_date(3i)'].to_i)
    end

    if @new_todo.save
      flash[:type] = 'success'
      flash[:title] = t(:successful_create_todo, :todo => @new_todo.title)
      redirect_to todos_path
    else
      flash[:type] = 'error'
      flash[:title] = t(:unsuccessful_create_todo)
      render :new
    end
    # ---------------DEV NOTICE------------------
    # im html wird das Symbol :to-do (ohne -) verwendet.  (folglich immer ohne - ;))
    # hier verwende ich @new_todo
    # würde ich auch hier @to-do verwenden, so würde bei einem 'render :new' die vorher eingegebenen formulardaten
    # wiederverwendet werden. das ist aber nicht möglich da ich vom Model unterschiedliche felder im Formular verwende
    # deshalb würde ich einen error erhalten und verzichte vorerst auf die formularwiederherstellung durch
    # verwendung von @new_to-do statt @to-do
  end

  # Restores the latest deleted to-do that has been backup'd in the global backup variable
  def restore
    if @@backup.save
      flash[:type] = 'success'
      flash[:title] = t(:successful_restore_todo, :todo => @@backup.title)
      @@backup = nil
      redirect_to todos_path
    else
      flash[:type] = 'error'
      flash[:title] = t(:unsuccessful_restore_todo)
      redirect_to todos_path
    end
  end

end
