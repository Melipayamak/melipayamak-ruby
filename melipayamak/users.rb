require 'savon'

class Users
    def initialize(username, password)
        @username = username
        @password = password
        @client = Savon.client(wsdl: "http://api.payamak-panel.com/post/users.asmx?wsdl")
    end
    def get_data
        {
            :username => @username,
            :password => @password
        }
    end
    def execute(method,data)
        response = @client.call(method, message:data.merge(get_data))
        response.body
    end
    def add_payment(options)
        execute(:add_payment,options)
    end
    def add(options)
        execute(:add_user,options)
    end
    def add_complete(options)
        execute(:add_user_complete,options)
    end
    def add_with_location(options)
        execute(:add_user_with_location,options)
    end
    def authenticate
        execute(:authenticate_user,{})
    end
    def change_credit(amount, description, targetUsername, getTax)
        execute(:change_user_credit,{
            :amount => amount,
            :description => description,
            :targetUsername => targetUsername,
            :GetTax => getTax

        })
    end
    def forgot_password(mobileNumber, emailAddress, targetUsername)
        execute(:forgot_password,{
            :mobileNumber => mobileNumber,
            :emailAddress => emailAddress,
            :targetUsername => targetUsername
        })
    end
    def get_base_price(targetUsername)
        execute(:get_user_base_price,{
            :targetUsername => targetUsername
        })
    end
    def remove(targetUsername)
        execute(:remove_user,{
            :targetUsername => targetUsername
        })
    end
    def get_credit(targetUsername)
        execute(:get_user_credit,{
            :targetUsername => targetUsername
        })
    end
    def get_details(targetUsername)
        execute(:get_user_details,{
            :targetUsername => targetUsername
        })
    end
    def get_numbers
        execute(:get_user_numbers,{})
    end
    def get_provinces
        execute(:get_provinces,{})
    end
    def get_cities(provinceId)
        execute(:get_cities,{
            :provinceId => provinceId
        })
    end
    def get_expire_date
        execute(:get_expire_date,{})
    end
    def get_transactions(targetUsername, creditType, dateFrom, dateTo, keyword)
        execute(:get_user_transactions,{
            :creditType => creditType,
            :dateFrom => dateFrom,
            :targetUsername => targetUsername,
            :dateTo => dateTo,
            :keyword => keyword
        })
    end
    def get
        execute(:get_users,{})
    end
    def has_filter(text)
        execute(:has_filter,{
            :text => text
        })
    end
end