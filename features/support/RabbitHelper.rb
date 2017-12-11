#!/usr/bin/env ruby
# encoding: utf-8
class RabbitHelper

    def initialize(host)
        @conn = Bunny.new(host)
        @channel = nil
        @queues = {}
    end

    def openConnection
        @conn.start
    end

    def createQueue(queueName, exchangeName)
        @channel ||= @conn.create_channel
        topic = @channel.topic(exchangeName, :durable => true)
        queue = @channel.queue(queueName).bind(topic)
        @queues[queueName] ||= queue
    end


    def getMessageFromQueue(queueName, &block)
        @queues[queueName].subscribe do |delivery_info, properties, content|
            puts "Consumed a message: #{content}"
            yield content
        end
    end

    def closeConnection
        @conn.close
    end


end