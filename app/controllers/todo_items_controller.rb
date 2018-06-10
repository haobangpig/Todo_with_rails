class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, only: [:destroy, :complete, :redo]

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      msg = ["A new item has been created.", "Please finish it as possible as you can"]
      flash[:notice] = msg.join(" ").html_safe
    else
      flash[:notice] = @todo_item.errors.full_messages.join("<br/>").html_safe
    end
    redirect_to @todo_list
  end

  def destroy
    if @todo_item.destroy
      redirect_to @todo_list, notice: "Todo list item was deteted"
    else
      redirect_to @todo_list, notice: "Todo list item can't be deteted"
    end
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    flash[:notice] = "'#{@todo_item.content}' has been completed! Good Job!"
    redirect_to @todo_list
  end

  def redo
    @todo_item.update_attribute(:completed_at, nil)
    flash[:notice] ="'#{@todo_item.content}'has been reset! Try to do it harder!"
    redirect_to @todo_list
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
