class SubjectsController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in
  before_filter :get_subject_count, only: [:new, :create, :edit, :update]

  def index
    # logger.debug("**Testing out the index method")
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({name: 'Default'})
  end

  def create
    # Create new object, Save object, redirect to index if success else redisplay form.
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = "Subject created successfully."
      redirect_to(subjects_path)
    else
      # Render would just display the template not call the new action again and it would have the form
      # pre populated.
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])

    if @subject.update_attributes(subject_params)
      flash[:notice] = "Subject updated successfully."
      redirect_to(subject_path(@subject)) # show action
    else
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "#{@subject.name} destroyed successfully."
    redirect_to(subjects_path)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def get_subject_count
    @subject_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'update'
      @subject_count += 1
    end
  end
end
