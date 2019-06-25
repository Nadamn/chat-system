class ChatController < ApplicationController
	def index
		chats = Chat.all
		render json: chats
  	end

  	def create
	    request_body = JSON.parse(request.raw_post) #{"application_name":"name"}
	    application = Application.where("name = ?", request_body["name"])[0]
    	if application.present?
    		chat = application.chats.create()
    		render json: chat.id
      	else
      		render json: {"message":"application does not exist"}
      	end
	end

	def show
		chat = Chat.where("id = ?", params[:id])
    		if chat
      			render json: chat
    		else
    			render json: {"message":"not exist"}
    		end
    end
end
