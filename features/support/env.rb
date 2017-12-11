require 'httparty'
require 'json'
require 'faker'
require 'cpf_faker'
# require 'pry-byebug'
require 'bunny'
require 'pry'

require_relative "../../fixtures/factories/sellercontractfactory.rb"


OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# Environment definitions
DEBUG = ENV['DEBUG'] || false
ENV['ENV'] = 'qa' unless ENV.has_key?'ENV'
####
ENVIRONMENT = (YAML.load_file('./config/environment.yml'))[ENV['ENV']]
AUTH = (YAML.load_file('./config/authentication.yml'))[ENV['ENV']]
####
SELLER_JSON = (YAML.load_file('./fixtures/seller.yml'))
COMMISSION_JSON = (YAML.load_file('./fixtures/commission.yml'))
ACCOUNTS_JSON = (YAML.load_file('./fixtures/accounts.yml'))
BRANCHES_JSON = (YAML.load_file('./fixtures/branches.yml'))
PLATFORMS_JSON = (YAML.load_file('./fixtures/platforms.yml'))
POLICIES_JSON = (YAML.load_file('./fixtures/policies.yml'))
SELLER_COMPLETE = (YAML.load_file('./fixtures/seller_complete.yml'))
DATA = (YAML.load_file('./fixtures/data_file.yml'))
