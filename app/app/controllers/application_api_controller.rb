class ApplicationApiController < ApplicationController
	
	def index
		@applications = Application.all
		render json: @applications
  	end

  	def create
	    request_body = JSON.parse(request.raw_post) #{"name":"name"}
	    application = Application.where("name = ?", request_body["name"]).select("id")
    	if application.present?
    		render json: {"message":"application with the same name exists"}
      	else
      		random_token = SecureRandom.urlsafe_base64(nil, false)
        	application = Application.new( :name => request_body["name"], :token => random_token)
        	if application.save
        		render json: application
        	else
        		render json: {"message":"couldn't create application"}
        	end
      	end
	end

	def show
		application = Application.where("name = ?", params[:id])
    		if application
      			render json: application
    		else
    			render json: {"message":"not exist"}
    		end
    end
end
