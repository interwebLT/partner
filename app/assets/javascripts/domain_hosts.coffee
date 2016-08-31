$(document).ready ->
  validateIPFields = () ->
    $('input.domain-host-ipv4-field').each ->
      $(this).rules 'add', {
        required:
          depends: (element) ->
            $(".domain-host-ipv6-field").eq(0).val() == ""
        validIPv4:
          depends: (element) ->
            $(".domain-host-ipv6-field").eq(0).val() == ""
      }
    $('input.domain-host-ipv6-field').each ->
      $(this).rules 'add', {
        required:
          depends: (element) ->
            $(".domain-host-ipv4-field").eq(0).val() == ""
        validIPv6:
          depends: (element) ->
            $(".domain-host-ipv4-field").eq(0).val() == ""
      }

  getDomain = (domain_host) ->
    domainHostArray = domain_host.split('.')
    valid_2nd_extensions = ["com", "net", "org"]

    if $.inArray("ph", domainHostArray) > -1
      phNS = true

    for extension in valid_2nd_extensions
      if $.inArray(extension, domainHostArray) > -1
        valid_2nd_extension = true
    if valid_2nd_extension and phNS
      domain_name = domainHostArray[domainHostArray.length - 3] + "." + domainHostArray[domainHostArray.length - 2] + "." + domainHostArray[domainHostArray.length - 1]
    else
      domain_name = domainHostArray[domainHostArray.length - 2] + "." + domainHostArray[domainHostArray.length - 1]
    return domain_name

  $.validator.addMethod 'validIPv4', ((value, element) ->
    valid_ipv4 = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
    valid_ipv4.test value
  ), 'It should be a valid IPv4 Format.'

  $.validator.addMethod 'validIPv6', ((value, element) ->
    valid_ipv6 = /(^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$)/
    valid_ipv6.test value
  ), 'It should be a valid IPv6 Format.'

  $.validator.addMethod 'validNameserver', ((value, element) ->
    valid_nameserver = /^(([a-zA-Z0-9-_\.]{1})|([a-zA-Z0-9-_\.]{1}[a-zA-Z0-9-_\.]{1})|([a-zA-Z0-9-_\.]{1}[0-9]{1})|([0-9]{1}[a-zA-Z0-9-_\.]{1})|([a-zA-Z0-90-9-_\.][a-zA-Z0-9-0-9-_\.]{1,61}[a-zA-Z0-9-\.]))\.([a-zA-Z]{2,6}|[a-zA-Z0-9-]{2,30}\.[a-zA-Z]{2,3})$/
    valid_nameserver.test value
  ), 'It should be a valid Nameserver.'

  $.validator.addMethod 'notAlreadyUsedNS', ((value, element) ->
    host_name = value.toLowerCase()
    new_ns = $("#domain_host_name").data("newnameserver")
    hosts = $("#domain_host_name").data("hosts").toLowerCase().split(' ')
    if !new_ns
      hosts.splice(hosts.indexOf(host_name),1)
    if $.inArray(host_name, hosts) > -1
      existed = true
    existed != true
  ), 'Nameserver already in used!'

  $(".btn-add-domain-host-ipv4").click ->
    array = $('.domain-host-ipv4-field').length
    row =  "<label class='ipv4_" + array + "'></label>
            <div class='ipv4_" + array + "'>
              <div class='form-group'>
                <input type='text' name='ipv4[" + array + "]' id='ipv4_" + array + "' class='form-control domain-host-ipv4-field' placeholder='Enter IP Address'>
              </div>
              <a class='btn btn-default btn-sm btn-remove-domain-host-ipv4'>
                <i class='fa fa-close'></i>
                <span class='sr-only'>Delete</span>
              </a>
            </div>"
    $(".moreIPV4").append(row)
    $('input.domain-host-ipv4-field').each ->
    validateIPFields()

  $(".btn-add-domain-host-ipv6").click ->
    array = $('.domain-host-ipv6-field').length
    row =  "<label class='ipv6_" + array + "'></label>
            <div class='ipv6_" + array + "'>
              <div class='form-group'>
                <input type='text' name='ipv6[" + array + "]' id='ipv6_" + array + "' class='form-control domain-host-ipv6-field' placeholder='Enter IP Address'>
              </div>
              <a class='btn btn-default btn-sm btn-remove-domain-host-ipv6'>
                <i class='fa fa-close'></i>
                <span class='sr-only'>Delete</span>
              </a>
            </div>"
    $(".moreIPV6").append(row)
    $('input.domain-host-ipv6-field').each ->
    validateIPFields()

  $(".moreIPV6").on "click", ".btn-remove-domain-host-ipv6", ->
    thisParentClass = $(this).parent().prop('className')
    $('.' + thisParentClass).remove()
    return

  $(".moreIPV4").on "click", ".btn-remove-domain-host-ipv4", ->
    thisParentClass = $(this).parent().prop('className')
    $('.' + thisParentClass).remove()
    return

  $("#domain_host_name").blur ->
    domainName = $(this).data("domain")
    glue_record_requirement = "." + domainName
    if $(this).val().indexOf(glue_record_requirement) >= 0
      $(".nameserver-ipv4, .nameserver-ipv6, .moreIPV4, .moreIPV6").show()
      validateIPFields()
    else
      $(".nameserver-ipv4, .nameserver-ipv6, .moreIPV4, .moreIPV6").find('input:text').val('');
      $(".nameserver-ipv4, .nameserver-ipv6, .moreIPV4, .moreIPV6").hide()

    $(".domain_host_form").validate
      errorPlacement: (label, element) ->
        label.addClass('error-validator-label-simple')
        element.addClass('has-input-error')
        label.insertAfter(element)
      rules:
        "domain_host[name]":
          required: true,
          validNameserver: true,
          notAlreadyUsedNS: true,
          remote:
            url: "/domains/check_ns_authorization",
            data:
              domain: ->
                return getDomain($("#domain_host_name").val())
              host: ->
                return $("#domain_host_name").val()
    return

  $(".ns-form-submit").mouseenter ->
    $("#domain_host_name").trigger("blur")
    return

  $("#domain_host_name").trigger("blur")