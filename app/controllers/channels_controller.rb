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
    redirect_to admin_channels_path
  end

  def choose_manager
    @channel = Channel.find(params[:id])
    authorize @channel
  end

  def set_manager
    @channel = Channel.find(params[:channel_id])
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

  def remove_manager
    @channel = Channel.find(params[:channel_id])
    authorize @channel
    user = User.find(params[:manager_id])
    if user.remove_role :manager, @channel
      flash[:notice] = user.name + " is no longer manager of channel " + @channel.name
    else
      flash[:alert] = "Sorry, couldn't remove manager."
    end
    redirect_to admin_channels_path
  end

  def update_display
    @channel = Channel.find(params[:channel_id])
    authorize @channel
    @post = Post.find(params[:post_id])
    @channel.display_id = params[:post_id]
    if @channel.save
      flash[:notice] = "Channel " + @channel.name + " display set to post no. " + params[:post_id].to_s
      unless @channel.standing # Create a Standing record the first time display is set:
        max_rank = Standing.maximum(:rank)
        if max_rank
          Standing.create!(channel_id: @channel.id, rank: max_rank + 1, share: 0.0, count0: 0.0, count1: 0.0)
          flash[:notice] = "Created new row on ballot for this channel."
        else
          Standing.create!(channel_id: @channel.id, rank: 1, share: 0.0, count0: 0.0, count1: 0.0)
          flash[:notice] = "Created first row on ballot, for this channel."
        end
        redirect_to root_path
      end
      redirect_to root_path
    else
      flash[:alert] = "Sorry, couldn't set display. Contact admin?"
      redirect_to about_path
    end
  end

  def unset_display
    @channel = Channel.find(params[:channel_id])
    authorize @channel
    @channel.display_id = nil
    if @channel.save
      flash[:notice] = "Channel " + @channel.name + " display unset."
      if request.referer
        redirect_to :back
      elsif current_user
        redirect_to current_user
      else
        redirect_to root_path
      end
    else
      flash[:alert] = "Sorry, couldn't unset display. Contact admin?"
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
