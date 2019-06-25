class ApplicationController < ActionController::API
	connection = Bunny.new(hostname: 'rabbitMQ')
	connection.start
	channel = connection.create_channel
	queue = channel.queue('hello')
	channel.default_exchange.publish('Hello World!', routing_key: queue.name)
	puts " [x] Sent 'Hello World!'"

end
