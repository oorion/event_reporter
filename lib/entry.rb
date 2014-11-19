class Entry
  def initialize(entry)
    @entry = format(entry)
  end

  def format(entry)
    entry.each do |key, val|
      case key
      when :_
        entry.delete(key)
      when :regdate
        entry.delete(key)
      when :first_name
        entry[key] = normalize(val)
      when :last_name
        entry[key] = normalize(val)
      when :email_address
        entry[key] = normalize(val)
      when :homephone
        entry[key] = normalize_phone(val)
      when :street
        entry[key] = normalize(val)
      when :city
        entry[key] = normalize(val)
      when :state
        entry[key] = normalize(val)
      when :zipcode
        entry[key] = normalize(val)
      end
    end
  end

  def normalize(name)
    name.strip.downcase
  end

  def normalize_zip(zip)
    zip.to_s.rjust(5,"0")[0..4]
  end

  def normalize_phone(phone)
    clean_phone = phone.gsub(/[() .-]+/, '')
    "#{clean_phone[0..2]}-#{clean_phone[3..5]}-#{clean_phone[6..9]}"
  end
end
