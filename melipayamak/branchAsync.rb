require 'savon'

class BranchAsync
    def initialize(username, password)
        @username = username
        @password = password
        @client = Savon.client(wsdl: "http://api.payamak-panel.com/post/Actions.asmx?wsdl")
    end
    def get_data
        {
            :username => @username,
            :password => @password
        }
    end
    def execute(method,data)
        response = nil
        t = Thread.new{response = @client.call(method, message:data.merge(get_data))}
        t.join
        response.body
    end
    def get(owner)
        execute(:get_branchs,{
            :owner => owner
        })
    end
    def remove(branchId)
        execute(:remove_branch,{
            :branchId => branchId
        })
    end
    def add(branchName, owner)
        execute(:add_branch,{
            :branchName => branchName,
            :owner => owner
        })
    end
    def add_number(mobileNumbers, branchId)
        execute(:add_number,{
            :mobileNumbers => mobileNumbers,
            :branchId => branchId
        })
    end
    def send_bulk(from, title, message, branch, dateToSend, requestCount, bulkType, rowFrom, rangeFrom, rangeTo)
        execute(:add_bulk,{
            :from => from,
            :title => title,
            :message => message,
            :branch => branch,
            :DateToSend => dateToSend,
            :requestCount => requestCount,
            :bulkType => bulkType,
            :rowFrom => rowFrom,
            :rangeFrom => rangeFrom,
            :rangeTo => rangeTo
        })
    end
    def send_bulk2(from, title, message, branch, dateToSend, requestCount, bulkType, rowFrom, rangeFrom, rangeTo)
        execute(:add_bulk2,{
            :from => from,
            :title => title,
            :message => message,
            :branch => branch,
            :DateToSend => dateToSend,
            :requestCount => requestCount,
            :bulkType => bulkType,
            :rowFrom => rowFrom,
            :rangeFrom => rangeFrom,
            :rangeTo => rangeTo
        })
    end
    def get_bulk_count(branch, rangeFrom, rangeTo)
        execute(:get_bulk_count,{
            :branch => branch,
            :rangeFrom => rangeFrom,
            :rangeTo => rangeTo
        })
    end
    def get_bulk_receptions(bulkId, fromRows)
        execute(:get_bulk_receptions,{
            :bulkId => bulkId,
            :fromRows => fromRows
        })
    end
    def get_bulk_status(bulkId)
        execute(:get_bulk_status,{
            :bulkId => bulkId
        })
    end
    def get_today_sent
        execute(:get_today_sent,{})
    end
    def get_total_sent
        execute(:get_total_sent,{})
    end
    def remove_bulk(bulkId)
        execute(:remove_bulk,{
            :bulkId => bulkId
        })
    end
    def send_multiple_sms(to, from, text, isflash, udh)
        data = {
            :to => to,
            :from => from,
            :text => text,
            :isflash => isflash,
            :udh => udh
        }
        if from.kind_of?(Array)
            execute(:send_multiple_sms2,data)
        else
            execute(:send_multiple_sms,data)
        end
    end
    def update_bulk_delivery(bulkId)
        execute(:update_bulk_delivery,{
            :bulkId => bulkId
        })
    end
end