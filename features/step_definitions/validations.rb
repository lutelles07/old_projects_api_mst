# enconding: utf-8

Então(/^será retornado página de "([^"]*)"$/) do |erro|
	expect(@response.body).to include(erro)
end


Então(/^seja retornado página de "([^"]*)"$/) do |erro|
	expect(@response.body).to include(erro)
end

Então(/^será retornado código "([^"]*)" e "([^"]*)" seja "([^"]*)"$/) do |code, node, msg|
  # puts @response

	expect(@response.code).to eq(code.to_i)
	#TODO
	# expect(@response.parsed_response[node].to_s).to include(msg)
end

Então(/^será retornado código "([^"]*)"$/) do |code|
	expect(@response.code).to eq(code.to_i)
end

Dado(/^seja retornado código "([^"]*)"$/) do |code|
  expect(@response.code).to eq(code.to_i)
end

Então(/^será postado uma mensagem na fila com o id do seller$/) do
  @RabbitHelper.getMessageFromQueue(ENVIRONMENT['rabbit']['queueName']) do |message|
  	puts message if DEBUG
  	expect(message.to_s).to include (@response.parsed_response['id'])
  end
end

Então(/^o campo "([^"]*)" possua valor$/) do |campo|
  puts @response if DEBUG
	expect(@response.parsed_response[campo]).to_not be_nil
	expect(@response.parsed_response[campo]).to_not eq([])
end
