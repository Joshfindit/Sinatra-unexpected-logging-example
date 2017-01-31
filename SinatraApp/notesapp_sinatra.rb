require 'neo4j'
require 'neo4j/core/cypher_session/adaptors/http'
require 'neo4j/core/cypher_session/adaptors/bolt'
require 'sinatra'
require 'pp'


require 'irb/completion' # For irb autocompletion


# require local:

def loadLocalLibs
  Dir[File.join(File.dirname(__FILE__), 'lib', '**/*.rb')].sort.each do |file|
    require_relative file
  end
end
loadLocalLibs

def loadLocalModels
  Dir[File.join(File.dirname(__FILE__), 'models', '**/*.rb')].sort.each do |file|
    require_relative file
  end
end
loadLocalModels


set :port, ENV['EXTERNAL_PORT']
set :bind, '0.0.0.0'
#set :environment, :production
set :environment, :development
set :logging, true
set :root, File.dirname(__FILE__)
set :static, true
set :public_folder, File.dirname(__FILE__) + '/public'


configure do
  logfile = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  logfile.sync = true
  use Rack::CommonLogger, logfile
  set :logger, Logger.new(logfile)
end


before do
  get_session
  logger.level = Logger::DEBUG
end


error Sinatra::NotFound do
  content_type 'text/plain'
  [404, 'Not Found']
end


#NEO4J_URL = ENV['NEO4J_URL'] || 'http://localhost:7474'
NEO4J_URL = "bolt://neo4j:experimental@neo4j-experimental-logger:7687"

Neo4j::Core::CypherSession::Adaptors::Base.subscribe_to_query(&method(:puts))

def get_session
  neo4j_adaptor = Neo4j::Core::CypherSession::Adaptors::Bolt.new(NEO4J_URL, {wrap_level: :proc}) # BOLT is hard coded. For HTTP use a different URL and Neo4j::Core::CypherSession::Adaptors::HTTP
  Neo4j::ActiveBase.on_establish_session { Neo4j::Core::CypherSession.new(neo4j_adaptor) }
end


get '/artefacts_working/' do
  logger.debug("params: #{params}")
  content_type :json
  return Artefact.all.to_json
end

get '/artefacts_broken/' do
  logger.info("params: #{params}")
  content_type :json
  Artefact.first.return_error_via_log
  return Artefact.all.to_json
end


# for irb:
def show_error
  get_session
  Artefact.first.return_error_via_log
end
