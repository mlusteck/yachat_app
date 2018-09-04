class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user).order("created_at ASC")
    if @room
      respond_to do |format|
        format.js   # we want to do this with AJAX
      end
    end
  end

  def show
    @message = Message.find(params[:id])
    if @message
      @room = @message.room
      respond_to do |format|
        format.js   # we want to do this with AJAX
      end
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.html { redirect_to @room, notice: 'Message was created successfully.' }
        format.json { render :show, status: :created, location: @room }
        format.js   # we want to do this with AJAX
      else
        error_text = ""
        @message.errors.full_messages.each do |message|
          error_text += " " + message
        end

        format.html { redirect_to @room, alert: 'Review was not saved successfully.' + error_text }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body)
    end
end
