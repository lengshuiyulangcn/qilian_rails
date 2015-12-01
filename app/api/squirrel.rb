module Squirrel
  class API < Grape::API
    format :json
    get "zip/:zip_code" do
       address = ZipCodeJp.find params[:zip_code]
       if address
         {data: address.prefecture+address.city+address.town}
       else
         {data: "error"}
       end 
    end 
  end
end
