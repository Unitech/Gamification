class Admin::ReadOnlyEntriesController < Admin::ResourcesController

  def new
    item_params = params.dup
    item_params.delete_if { |k, v| !@resource.columns.map(&:name).include?(k) }
    @item = @resource.new(item_params)

    @item.title = "What day is today?"
    @item.content = "Today is #{Date.today}."

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @item }
    end
  end

end
