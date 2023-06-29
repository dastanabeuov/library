class GroupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_group, only: %i[ show edit update destroy ]

  def index
    @groups = Group.all
  end

  def show
    @group_users = User.all.where("group_id == ?", @group.id)
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        format.html { redirect_to group_path(@group), notice: "Группа успешно создана." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_path(@group), notice: "Группа успешно обновлена." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path, notice: "Группа успешно удалена." }
      format.json { head :no_content }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:logo, :name, :group_type, :code, :email, :phone, :active)
  end
end
