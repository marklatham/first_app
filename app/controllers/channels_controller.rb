class ChannelsController < ApplicationController
  before_action :authenticate_user!

  def new
    @channel = Channel.new
    authorize @channel
  end

  def create
    @channel = Channel.new(channel_params)
    authorize @channel
    if @channel.save
      flash[:notice] = "Channel created!"
      redirect_to admin_channels_path
    else
      flash[:alert] = "Sorry, couldn't create channel. Try again?"
      render 'channels/new'
    end
  end

  def admin
    @channels = Channel.all
    authorize @channels
  end

  def edit
    @channel = Channel.find(params[:id])
    authorize @channel
  end

  def update
    @channel = Channel.find(params[:id])
    authorize @channel
    if @channel.update_attributes(channel_params)
      flash[:notice] = "Channel updated. Edit more?"
    else
      flash[:alert] = "Sorry, couldn't update channel. Try again?"
    end
    redirect_to edit_channel_path(@channel)
  end

  def choose_manager
    @channel = Channel.find(params[:id])
    authorize @channel
  end

  def set_manager
    @channel = Channel.find(params[:format])
    authorize @channel
    user = User.find(params[:manager_id])
    if user.add_role :manager, @channel
      flash[:notice] = "User no. " + params[:manager_id].to_s + 
                       " is now manager of channel " + @channel.name
    else
      flash[:alert] = "Sorry, couldn't set manager."
    end
    redirect_to admin_channels_path
  end

  def update_display
    @channel = Channel.find(params[:channel])
    @post = Post.find(params[:post])
#    authorize @channel  # Needs rolify setup.
    @channel.display_id = params[:post]
    if @channel.save
      flash[:notice] = "Channel " + @channel.name + " display set to post no. " + params[:post].to_s
      redirect_to root_path
    else
      flash[:alert] = "Sorry, couldn't update channel. Contact admin?"
      redirect_to about_path
    end
  end

  def destroy  # Bug: fails as rolify tries to delete related users_roles records.
    @channel = Channel.find(params[:id])
    authorize @channel
    @channel.destroy
    flash[:notice] = "Channel deleted"
    redirect_to admin_channels_path
  end

  private

    def channel_params
      params.require(:channel).permit(:name, :manager_id, :display_id)
    end

end
