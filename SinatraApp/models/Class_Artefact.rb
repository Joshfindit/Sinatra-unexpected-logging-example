class Artefact
  include Neo4j::ActiveNode

  property :name, type: String
  property :description, type: String

  def return_error_via_log
    logger.error = "ERROR!"
  end
end
