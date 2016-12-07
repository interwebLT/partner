module DomainHostsHelper
  def nameserver_ip_list ip_list
    if ip_list
      unless ip_list.empty?
        ip_list = JSON.parse ip_list
        ipv4_list = []
        ipv6_list = []
        if !ip_list["ipv4"].nil?
          ip_list["ipv4"].each do |ipv4|
            unless ipv4[1].empty?
              ipv4_list << "#{ipv4[1]} <br/>"
            end
          end
        end

        if !ip_list["ipv6"].nil?
          ip_list["ipv6"].each do |ipv6|
            unless ipv6[1].empty?
              ipv6_list << "#{ipv6[1]} <br/>"
            end
          end
        end

        if ipv4_list.empty? && ipv6_list.empty?
          output = ""
        else
          ipv4_list = "#{ipv4_list.join('')}"
          ipv6_list = "#{ipv6_list.join('')}"
          output = "#{ipv4_list}#{ipv6_list}"
        end
      else
        output = ""
      end
    else
      output = ""
    end
    return output.html_safe
  end
end
