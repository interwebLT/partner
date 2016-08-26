module DomainHostsHelper
  def nameserver_ip_list ip_list
    if ip_list
      unless ip_list.empty?
        ip_list = JSON.parse ip_list
        ipv4_list = []
        ipv6_list = []

        ip_list["ipv4"].each do |ipv4|
          ipv4_list << ipv4[1]
        end

        ip_list["ipv6"].each do |ipv6|
          ipv6_list << ipv6[1]
        end
        ipv4_list = "IPV4: #{ipv4_list.join(', ')}".truncate(30)
        ipv6_list = "IPV6: #{ipv6_list.join(', ')}".truncate(30)

        output = "#{ipv4_list}\n#{ipv6_list}"
      else
        output = "No IP Address"
      end
    else
      output = "No IP Address"
    end
    return output
  end
end
