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

  def update_display # This method is under construction!
    @channel = Channel.find(params[:id])
    authorize @channel
    if params[:commit] == 'Cancel unsaved changes'
      flash[:notice] = "Unsaved changes cancelled."
      redirect_to @channel and return
    elsif @channel.update_attributes(display_params)
      update_response(@channel, params); return if performed?
    else
      flash[:alert] = "Sorry, couldn't update channel. Try again?"
    end
    redirect_to @channel
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

    def display_params
      params.require(:channel).permit(:display_id)
    end

    def update_response(channel, params) # This method is under construction!
      if params[:commit] == 'Save & edit more'
        flash[:notice] = "Channel saved."
        redirect_to edit_channel_path(channel) and return
      elsif params[:commit] == 'Convert this channel to html editing'
        channel.custom = true
        channel.save
        flash[:notice] = "Channel converted."
        redirect_to edit_channel_path(channel) and return
      elsif params[:commit] == 'Dump custom html editing'
        channel.custom = false
        channel.save
        flash[:alert] = "Custom html dumped."
        redirect_to edit_channel_path(channel) and return
      else
        flash[:notice] = "Channel updated."
      end
    end
end
