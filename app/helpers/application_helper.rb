module ApplicationHelper

  def obfuscate_email anchor, email=false

    email = anchor unless email #einhorn is finkel
    mailto = "&#109;&#97;&#105;&#108;&#116;&#111;&#58;"
    hexed = "%" + email.unpack('U' * email.length).collect { |x| x.to_s 16 }.join('%')

    if email == anchor
      anchor = "<span>&#" + email.reverse.each_byte.to_a.join('&#') + "</span>"
    end
    link_to raw(anchor), raw("#{mailto}#{hexed}"), class: 'obf'
  end

end
