require 'rubygems'
require 'json'
require 'rest-client'

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
      rest_result = RestClient.get("#{@base}.json").body
       
      if rest_result.code != 200
        raise SourceAdapterException new("Error Connecting")
      end
      
      # puts rest_result
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
      res = RestClient.post(@base,:product => create_hash)                                           
      
      JSON.parse(
        RestClient.get("#{res.headers[:location]}.json").body)["id"]                      
    end
   
    def update(update_hash)
      # TODO: Update an existing record in your backend data source
      obj_id = update_hash['id']
        update_hash.delete('id')
        RestClient.put("#{@base}/#{obj_id}",:product => update_hash)                                 
    end
   
    def delete(delete_hash)
      # TODO: write some code here if applicable
      # be sure to have a hash key and value for "object"
      # for now, we'll say that its OK to not have a delete operation
      # raise "Please provide some code to delete a single object in the backend application using the object_id"
      RestClient.delete("#{@base}/#{delete_hash['id']}")
    end
   
    def logoff
      # TODO: Logout from the data source if necessary
    end
  end