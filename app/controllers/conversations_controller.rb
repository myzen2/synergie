class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :empty_trash]
  before_action :get_box, only: [:index]

  def show
  end

  def index
    @conversations = if @box.eql? 'inbox'
                       @mailbox.inbox
                     elsif @box.eql? 'sent'
                       @mailbox.sentbox
                     else
                       @mailbox.trash
    end
    @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Réponse envoyée'
    redirect_to conversation_path(@conversation)
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Votre corbeille a été vidée !'
    redirect_to conversations_path
  end

  def mark_as_read
    @conversations.mark_as_read(current_user)
    flash[:success] = 'La conversation a été marquée comme lue'
    redirect_to conversations_path
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_box
    if params[:box].blank? || !%w(inbox sent trash).include?(params[:box])
      params[:box] = 'inbox'
    end
    @box = params[:box]
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end
end
