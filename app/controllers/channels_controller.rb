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
      flash[:notice] = "Channel created! Edit?"
      redirect_to edit_channel_path(@channel)
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

  def destroy
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
