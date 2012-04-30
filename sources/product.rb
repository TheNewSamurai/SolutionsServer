require 'rubygems'
require 'json'
require 'rest_client'

class Product < SourceAdapter
    def initialize(source) 
      @base = 'http://gentle-day-3024.herokuapp.com/products'
      super(source)
    end
   
    def login
      # TODO: Login to your data source here if necessary
    end
   
    def query(params=nil)
      # TODO: Query your backend data source and assign the records 
      # to a nested hash structure called @result. For example:
      # @result = { 
      #   "1"=>{"name"=>"Acme", "industry"=>"Electronics"},
      #   "2"=>{"name"=>"Best", "industry"=>"Software"}
      # }
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!PROCEEDING QUERY!!!!!!!!!!!!!!!!!!!!!!!"
      rest_result = RestClient.get("#{@base}.json").body
       
      if rest_result.code != 200
        raise SourceAdapterException.new("Error Connecting")
      end
      
      #puts rest_result
      parsed = JSON.parse(rest_result)
  
      @result={}
      parsed.each do |item|               #This is hacked together, there is a better way to do this but this works for now.....
        @result[item["id"].to_s] = {"upc" => item["upc"], "name" => item["name"], "model" => item["model"], "quantity" => item["quantity"]}
      end if parsed
    end
   
    def sync
      # Manipulate @result before it is saved, or save it 
      # yourself using the Rhoconnect::Store interface.
      # By default, super is called below which simply saves @result
      super
    end
   
    def create(create_hash)
      # TODO: Create a new record in your backend data source
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!PROCEEDING CREATE!!!!!!!!!!!!!!!!!!!!!!!"
      @result = {"upc" => create_hash["upc"], "name" => create_hash["name"], "model" => create_hash["model"], "quantity" => create_hash["quantity"]}
      res = RestClient.post(@base, create_hash.to_json, :content_type => :json, :accept => :json)                                       
      #if rest_result.code != 200
      #   raise SourceAdapterException.new("Error creating record.")
      #end
      puts "#{res.headers[:location]}.json"
      JSON.parse(RestClient.get("#{res.headers[:location]}.json").body)["id"]                  
    end
   
    def update(update_hash)
      # TODO: Update an existing record in your backend data source
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!PROCEEDING UPDATE!!!!!!!!!!!!!!!!!!!!!!!"
      obj_id = update_hash['id']
      #puts update_hash
        update_hash.delete('id')
      puts "#{@base}/#{obj_id}"
        RestClient.put("#{@base}/#{obj_id}", update_hash.to_json, :content_type => :json, :accept => :json)
          #:product => update_hash)                                 
      puts "2"
    end
   
    def delete(delete_hash)
      # TODO: write some code here if applicable
      # be sure to have a hash key and value for "object"
      # for now, we'll say that its OK to not have a delete operation
      # raise "Please provide some code to delete a single object in the backend application using the object_id"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!DELETING AN ENTRY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts delete_hash['id']
      #puts "#{@base}/#{delete_hash['id']}"
      rest_result = RestClient.delete("#{@base}/#{delete_hash['id']}.json")
      #if rest_result.code != 200
      #  raise SourceAdapterException.new("Error deleting record.")
      #end
    end
   
    def logoff
      # TODO: Logout from the data source if necessary
    end
  end