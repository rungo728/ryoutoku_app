class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    # # 自分が参加しているメッセージルーム情報を取得する
    # @currentUserEntry = Entry.where(user_id: current_user.id)
    # #選択したユーザのメッセージルーム情報を取得する
    # @userEntry = Entry.where(event_id: event.id).where('user_id!=?',@user.id)
    # binding.pry
    # #current_userと選択したユーザ間に共通のメッセージルームが存在すればフラグを立てる
    # unless @user.id == current_user.id
    #   @currentUserEntry.each do |cu|
    #     @userEntry.each do |u|
    #       if cu.event_id == u.event_id then
    #         @isEvent = true
    #         @eventId = cu.event_id

    #       end
    #     end
    #   end
    #   #存在しなければ作る
    #   unless @isEvent
    #     binding.pry
    @event = Event.new
    @entry = Entry.new
    #   end
    # end
  end
end
