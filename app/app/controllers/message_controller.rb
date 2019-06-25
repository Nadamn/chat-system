class MessageController < ApplicationController
	def index
		messages = Message.all
		render json: messages
  	end

  	def create
	    request_body = JSON.parse(request.raw_post) #{"application_token":"name", "chat_id": "id", "text":"text"}
	    application = Application.where("token = ?", request_body["application_token"])[0]
	    chat = application.chats.find(request_body["chat_id"])
    	if chat.present?
    		message = chat.messages.create({"text":request_body["text"]})
    		render json: message
      	else
      		render json: {"message":"chat does not exist"}
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
