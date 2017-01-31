module SimpleFile
  include Sinatra
  basepath = './public/files/'
   
  def set_file=(file)
    puts "set_file called"
    raise ArgumentError, "#{file.class} not a file object", caller unless file.kind_of?(File)
    if file.kind_of?(File)
      puts "File passed"
      if File.exist?(file)
        puts "File exists"
        validate_file(file)
         
      else
        raise ArgumentError, 'File does not exist', caller
#        puts "File exist failed"
#        return false, "File does not exist"
      end
    else
      raise ArgumentError, "#{file.class} not a file object", caller
#       puts "File object failed"
#       return false
#       return false
#, "Object passed must be a File. Use File.new, for example"
    end
    puts "Logic all done"
    return "Poopie"
  end

  def get_file
    puts "reusable 2"
  end


  def validate_file(file)
    raise ArgumentError, "#{file.class} not a file object", caller unless file.kind_of?(File)
    require 'digest'
    thisFile = {}
    thisFile[:sha256] = Digest::SHA256.file(file).hexdigest
    thisFile[:filename] = File.basename(file)
    puts thisFile
    return thisFile
  end

  def save_file(file)
    # Assume that the file being saved is the final version (parsed, reduced, whatever)
    # save to folder/hashalogorithym/hashpiece/hashpiece/hash
    # Example: folder/sha356/33/b6/33b69943597a4f992cafe4549d9d879366d9e8c5ebb0487f7975462ab94a00a8 # Following Git; do not use an extension. Also pairs well with having 1 model for data, one for filename/metadata/etc
    # it's redundant, but helpful for portability to store the .json metadata and .cql along side these hashes
      # Since we're decoupling file contents and file name, we should store a redundant copy of the json and cql along side the content, but not use it. Maybe with .unixtime.json/cql or .unixtime.UUID.json/cql to embrace the ability to data to have multiple filenames/folders
    # Are we storing diff by pointing UUID to latest which points to the hash of the latest file? (taking the edit history out of the graph but adding a convenience method), or having a UUID for each hashed file, then doing node.latest = filenode / node.edits << filenode / etc

    # (unused) Idea: Content is stored separate from 'files'. Content is SHA256'd, PARed, and stored in large file storage. ## Left as archive. Large files will come up later.
    # File objects are stored separately so that multiple filenames can point at the same content
      # This also allows for file objects to be inside folders and multiple versions of files (same filename with a different edit date points to different content)
      # Folders are stored in neo4j as a tree
    # Don't forget; we are bringing in 64kbps audio, still-frames, low quality photos, and all text data - Not storing origionals.
      # It's tempting, but would endlessly overrun all storage space and is unneccessary. (We're storing human-scale connections between things, not archival footage)
      # Are we keeping track of original SHA hashes? Yes. It lets us look up to see if a file already exists, and it's connections.
      # The idea is to archive the important bits, and drop all the rest. I don't need an archive of the stock images for a project, just a thumbnail for each meaningful one.
        # And do want to see the kids grow, the good times, etc.
    # Potential issues: Keeping data longer that it's needed by not scanning for unused data blocks

    # Associate to the database
    # thisFileNode.fileSHA = hash
    # thisFileNode.fileSHA.ingested = Date.now().totree
    # thisFileNode.fileSHA.created = parsed.created_at.totree
    # thisFileNode.fileSHA.modified = parsed.modified_at.totree # Maybe do ToTree when the save is successful?
    # thisFileNode.fileSHA.folder = parsed.folder.totree
    # return success

  end

# Getter and a setter   # From http://stackoverflow.com/questions/4370960/what-is-attr-accessor-in-ruby
#
#  def name
#    @name
#  end
#
#  def name=(str)
#    @name = str
#  end
#
#  ## Note: You cannot specify a return value for a module function. You have to raise errors for anything unexpected.
#  def name=(str)
#    raise ArgumentError, 'File does not exist', caller unless str.kind_of?(String)
#    @name = str
#  end

end

