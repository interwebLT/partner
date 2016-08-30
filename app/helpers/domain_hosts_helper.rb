module DomainHostsHelper
  def nameserver_ip_list ip_list
    if ip_list
      unless ip_list.empty?
        ip_list = JSON.parse ip_list
        ipv4_list = []
        ipv6_list = []
        ip_list["ipv4"].each do |ipv4|
          unless ipv4[1].empty?
            ipv4_list << "#{ipv4[1]} <br/>"
          end
        end

        ip_list["ipv6"].each do |ipv6|
          unless ipv6[1].empty?
            ipv6_list << "#{ipv6[1]} <br/>"
          end
        end
        if ipv4_list.empty? && ipv6_list.empty?
          output = "No IP Address"
        else
          ipv4_list = "<b>IPV4:</b><br/>#{ipv4_list.join('')}"
          ipv6_list = "<b>IPV6:</b><br/>#{ipv6_list.join('')}"
          output = "#{ipv4_list}#{ipv6_list}"
        end
      else
        output = "No IP Address"
      end
    else
      output = "No IP Address"
    end
    return output.html_safe
  end
end
